#include "pageController.h"

#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
    #include <QGuiApplication>
#else
    #include <QApplication>
#endif

#ifdef Q_OS_ANDROID
    #include "../../platforms/android/androidutils.h"
    #include <QJniObject>
#endif
#if defined Q_OS_MAC
    #include "ui/macos_util.h"
#endif

PageController::PageController(const QSharedPointer<ServersModel> &serversModel,
                               const std::shared_ptr<Settings> &settings, QObject *parent)
    : QObject(parent), m_serversModel(serversModel), m_settings(settings)
{
#ifdef Q_OS_ANDROID
    // Change color of navigation and status bar's
    auto initialPageNavigationBarColor = getInitialPageNavigationBarColor();
    AndroidUtils::runOnAndroidThreadSync([&initialPageNavigationBarColor]() {
        QJniObject activity = AndroidUtils::getActivity();
        QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
        if (window.isValid()) {
            window.callMethod<void>("addFlags", "(I)V", 0x80000000);
            window.callMethod<void>("clearFlags", "(I)V", 0x04000000);
            window.callMethod<void>("setStatusBarColor", "(I)V", 0xFF0E0E11);
            window.callMethod<void>("setNavigationBarColor", "(I)V", initialPageNavigationBarColor);
        }
    });
#endif

#if defined Q_OS_MACX
    connect(this, &PageController::raiseMainWindow, []() { setDockIconVisible(true); });
    connect(this, &PageController::hideMainWindow, []() { setDockIconVisible(false); });
#endif
}

QString PageController::getInitialPage()
{
    if (m_serversModel->getServersCount()) {
        if (m_serversModel->getDefaultServerIndex() < 0) {
            auto defaultServerIndex = m_serversModel->index(0);
            m_serversModel->setData(defaultServerIndex, true, ServersModel::Roles::IsDefaultRole);
        }
        return getPagePath(PageLoader::PageEnum::PageStart);
    } else {
        return getPagePath(PageLoader::PageEnum::PageSetupWizardStart);
    }
}

QString PageController::getPagePath(PageLoader::PageEnum page)
{
    QMetaEnum metaEnum = QMetaEnum::fromType<PageLoader::PageEnum>();
    QString pageName = metaEnum.valueToKey(static_cast<int>(page));
    return "qrc:/ui/qml/Pages2/" + pageName + ".qml";
}

void PageController::closeWindow()
{
#ifdef Q_OS_ANDROID
    qApp->quit();
#else
    if (m_serversModel->getServersCount() == 0) {
        qApp->quit();
    } else {
        emit hideMainWindow();
    }
#endif
}

void PageController::keyPressEvent(Qt::Key key)
{
    switch (key) {
    case Qt::Key_Back: emit closePage();
    default: return;
    }
}

unsigned int PageController::getInitialPageNavigationBarColor()
{
    if (m_serversModel->getServersCount()) {
        return 0xFF1C1D21;
    } else {
        return 0xFF0E0E11;
    }
}

void PageController::updateNavigationBarColor(const int color)
{
#ifdef Q_OS_ANDROID
    // Change color of navigation bar
    AndroidUtils::runOnAndroidThreadSync([&color]() {
        QJniObject activity = AndroidUtils::getActivity();
        QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
        if (window.isValid()) {
            window.callMethod<void>("setNavigationBarColor", "(I)V", color);
        }
    });
#endif
}

void PageController::showOnStartup()
{
    if (!m_settings->isStartMinimized()) {
        emit raiseMainWindow();
    } else {
#ifdef Q_OS_WIN
        emit hideMainWindow();
#elif defined Q_OS_MACX
        setDockIconVisible(false);
#endif
    }
}

void PageController::updateDrawerRootPage(PageLoader::PageEnum page)
{
    m_drwaerLayer = 0;
    m_currentRootPage = page;
}

void PageController::goToDrawerRootPage()
{

    m_drwaerLayer = 0;

    emit showTopCloseButton(false);
    emit forceCloseDrawer();
}

void PageController::drawerOpen()
{
    m_drwaerLayer = m_drwaerLayer + 1;
    emit showTopCloseButton(true);
}

void PageController::drawerClose()
{
    m_drwaerLayer = m_drwaerLayer -1;
    if (m_drwaerLayer <= 0) {
        emit showTopCloseButton(false);
        m_drwaerLayer = 0;
    }
}
