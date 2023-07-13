import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import SortFilterProxyModel 0.2

import PageEnum 1.0

import "./"
import "../Controls2"
import "../Controls2/TextTypes"
import "../Config"
import "../Components"

PageType {
    id: root

    Connections {
        target: InstallController

        function onInstallationErrorOccurred(errorMessage) {
            PageController.showErrorMessage(errorMessage)
        }

        function onUpdateContainerFinished() {
            //todo change to notification
            PageController.showErrorMessage(qsTr("Settings updated successfully"))
        }
    }

    ColumnLayout {
        id: backButton

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 20

        BackButtonType {
        }
    }

    FlickableType {
        id: fl
        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom
        contentHeight: content.implicitHeight

        Column {
            id: content

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            ListView {
                id: listview

                width: parent.width
                height: listview.contentItem.height

                clip: true
                interactive: false

                model: OpenVpnConfigModel

                delegate: Item {
                    implicitWidth: listview.width
                    implicitHeight: col.implicitHeight

                    ColumnLayout {
                        id: col

                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right

                        anchors.leftMargin: 16
                        anchors.rightMargin: 16

                        spacing: 0

                        HeaderType {
                            Layout.fillWidth: true

                            headerText: qsTr("OpenVPN settings")
                        }

                        TextFieldWithHeaderType {
                            Layout.fillWidth: true
                            Layout.topMargin: 32

                            headerText: qsTr("VPN Addresses Subnet")
                            textFieldText: subnetAddress

                            textField.onEditingFinished: {
                                if (textFieldText !== subnetAddress) {
                                    subnetAddress = textFieldText
                                }
                            }
                        }

                        ParagraphTextType {
                            Layout.fillWidth: true
                            Layout.topMargin: 32

                            text: qsTr("Network protocol")
                        }

                        TransportProtoSelector {
                            Layout.fillWidth: true
                            Layout.topMargin: 16
                            rootWidth: root.width

                            enabled: isTransportProtoEditable

                            currentIndex: {
                                return transportProto === "tcp" ? 1 : 0
                            }

                            onCurrentIndexChanged: {
                                if (transportProto === "tcp" && currentIndex === 0) {
                                    transportProto = "udp"
                                } else if (transportProto === "udp" && currentIndex === 1) {
                                    transportProto = "tcp"
                                }
                            }
                        }

                        TextFieldWithHeaderType {
                            Layout.fillWidth: true
                            Layout.topMargin: 40

                            enabled: isPortEditable

                            headerText: qsTr("Port")
                            textFieldText: port

                            textField.onEditingFinished: {
                                if (textFieldText !== port) {
                                    port = textFieldText
                                }
                            }
                        }

                        SwitcherType {
                            id: autoNegotiateEncryprionSwitcher

                            Layout.fillWidth: true
                            Layout.topMargin: 24

                            text: qsTr("Auto-negotiate encryption")
                            checked: autoNegotiateEncryprion

                            onCheckedChanged: {
                                if (checked !== autoNegotiateEncryprion) {
                                    autoNegotiateEncryprion = checked
                                }
                            }
                        }

                        DropDownType {
                            id: hashDropDown
                            Layout.fillWidth: true
                            Layout.topMargin: 20
                            implicitHeight: 74

                            enabled: !autoNegotiateEncryprionSwitcher.checked

                            descriptionText: qsTr("Hash")
                            headerText: qsTr("Hash")

                            listView: ListViewType {
                                id: hashListView

                                rootWidth: root.width

                                model: ListModel {
                                    ListElement { name : qsTr("SHA512") }
                                    ListElement { name : qsTr("SHA384") }
                                    ListElement { name : qsTr("SHA256") }
                                    ListElement { name : qsTr("SHA3-512") }
                                    ListElement { name : qsTr("SHA3-384") }
                                    ListElement { name : qsTr("SHA3-256") }
                                    ListElement { name : qsTr("whirlpool") }
                                    ListElement { name : qsTr("BLAKE2b512") }
                                    ListElement { name : qsTr("BLAKE2s256") }
                                    ListElement { name : qsTr("SHA1") }
                                }

                                clickedFunction: function() {
                                    hashDropDown.text = selectedText
                                    hash = hashDropDown.text
                                    hashDropDown.menuVisible = false
                                }

                                Component.onCompleted: {
                                    hashDropDown.text = hash

                                    for (var i = 0; i < hashListView.model.count; i++) {
                                        if (hashListView.model.get(i).name === hashDropDown.text) {
                                            currentIndex = i
                                        }
                                    }
                                }
                            }
                        }

                        DropDownType {
                            id: cipherDropDown
                            Layout.fillWidth: true
                            Layout.topMargin: 16
                            implicitHeight: 74

                            enabled: !autoNegotiateEncryprionSwitcher.checked

                            descriptionText: qsTr("Cipher")
                            headerText: qsTr("Cipher")

                            listView: ListViewType {
                                id: cipherListView

                                rootWidth: root.width

                                model: ListModel {
                                    ListElement { name : qsTr("AES-256-GCM") }
                                    ListElement { name : qsTr("AES-192-GCM") }
                                    ListElement { name : qsTr("AES-128-GCM") }
                                    ListElement { name : qsTr("AES-256-CBC") }
                                    ListElement { name : qsTr("AES-192-CBC") }
                                    ListElement { name : qsTr("AES-128-CBC") }
                                    ListElement { name : qsTr("ChaCha20-Poly1305") }
                                    ListElement { name : qsTr("ARIA-256-CBC") }
                                    ListElement { name : qsTr("CAMELLIA-256-CBC") }
                                    ListElement { name : qsTr("none") }
                                }

                                clickedFunction: function() {
                                    cipherDropDown.text = selectedText
                                    cipher = cipherDropDown.text
                                    cipherDropDown.menuVisible = false
                                }

                                Component.onCompleted: {
                                    cipherDropDown.text = cipher

                                    for (var i = 0; i < cipherListView.model.count; i++) {
                                        if (cipherListView.model.get(i).name === cipherDropDown.text) {
                                            currentIndex = i
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.topMargin: 32
                            Layout.preferredHeight: checkboxLayout.implicitHeight
                            color: "#1C1D21"
                            radius: 16

                            ColumnLayout {
                                id: checkboxLayout
                                CheckBoxType {
                                    Layout.fillWidth: true

                                    text: qsTr("TLS auth")
                                    checked: tlsAuth

                                    onCheckedChanged: {
                                        if (checked !== tlsAuth) {
                                            tlsAuth = checked
                                        }
                                    }
                                }

                                DividerType {}

                                CheckBoxType {
                                    Layout.fillWidth: true

                                    text: qsTr("Block DNS requests outside of VPN")
                                    checked: blockDns

                                    onCheckedChanged: {
                                        if (checked !== blockDns) {
                                            blockDns = checked
                                        }
                                    }
                                }
                            }
                        }

                        SwitcherType {
                            id: additionalClientCommandsSwitcher
                            Layout.fillWidth: true
                            Layout.topMargin: 32

                            checked: additionalClientCommands !== ""

                            text: qsTr("Additional client configuration commands")
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.topMargin: 16

                            height: 148
                            color: "#1C1D21"
                            border.width: 1
                            border.color: "#2C2D30"
                            radius: 16
                            visible: additionalClientCommandsSwitcher.checked

                            FlickableType {
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                contentHeight: additionalClientCommandsTextArea.implicitHeight
                                TextArea {
                                    id: additionalClientCommandsTextArea

                                    width: parent.width
                                    anchors.topMargin: 16
                                    anchors.bottomMargin: 16

                                    topPadding: 16
                                    leftPadding: 16

                                    color: "#D7D8DB"
                                    selectionColor:  "#412102"
                                    selectedTextColor: "#D7D8DB"
                                    placeholderTextColor: "#878B91"

                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    font.family: "PT Root UI VF"

                                    placeholderText: qsTr("Commands:")
                                    text: additionalClientCommands

                                    wrapMode: Text.Wrap

                                    onEditingFinished: {
                                        if (additionalClientCommands !== text) {
                                            additionalClientCommands = text
                                        }
                                    }
                                }
                            }
                        }

                        SwitcherType {
                            id: additionalServerCommandsSwitcher
                            Layout.fillWidth: true
                            Layout.topMargin: 16

                            checked: additionalServerCommands !== ""

                            text: qsTr("Additional server configuration commands")
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.topMargin: 16

                            height: 148
                            color: "#1C1D21"
                            border.width: 1
                            border.color: "#2C2D30"
                            radius: 16
                            visible: additionalServerCommandsSwitcher.checked

                            FlickableType {
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                contentHeight: additionalServerCommandsTextArea.implicitHeight
                                TextArea {
                                    id: additionalServerCommandsTextArea

                                    width: parent.width
                                    anchors.topMargin: 16
                                    anchors.bottomMargin: 16

                                    topPadding: 16
                                    leftPadding: 16

                                    color: "#D7D8DB"
                                    selectionColor:  "#412102"
                                    selectedTextColor: "#D7D8DB"
                                    placeholderTextColor: "#878B91"

                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    font.family: "PT Root UI VF"

                                    placeholderText: qsTr("Commands:")
                                    text: additionalServerCommands

                                    wrapMode: Text.Wrap

                                    onEditingFinished: {
                                        if (additionalServerCommands !== text) {
                                            additionalServerCommands = text
                                        }
                                    }
                                }
                            }
                        }

                        BasicButtonType {
                            Layout.topMargin: 24

                            defaultColor: "transparent"
                            hoveredColor: Qt.rgba(1, 1, 1, 0.08)
                            pressedColor: Qt.rgba(1, 1, 1, 0.12)
                            textColor: "#EB5757"

                            text: qsTr("Remove OpenVPN")

                            onClicked: {
                                questionDrawer.headerText = qsTr("Remove OpenVpn from server?")
//                                questionDrawer.descriptionText = qsTr("")
                                questionDrawer.yesButtonText = qsTr("Continue")
                                questionDrawer.noButtonText = qsTr("Cancel")

                                questionDrawer.yesButtonFunction = function() {
                                    questionDrawer.visible = false
                                    goToPage(PageEnum.PageDeinstalling)
                                    ContainersModel.removeCurrentlyProcessedContainer()
                                    closePage()
                                    closePage() //todo auto close to deinstall page?
                                }
                                questionDrawer.noButtonFunction = function() {
                                    questionDrawer.visible = false
                                }
                                questionDrawer.visible = true
                            }
                        }

                        BasicButtonType {
                            Layout.fillWidth: true
                            Layout.topMargin: 24
                            Layout.bottomMargin: 24

                            text: qsTr("Save and Restart Amnesia")

                            onClicked: {
                                forceActiveFocus()
                                PageController.showBusyIndicator(true)
                                InstallController.updateContainer(OpenVpnConfigModel.getConfig())
                                PageController.showBusyIndicator(false)
                            }
                        }
                    }
                }
            }
        }

        QuestionDrawer {
            id: questionDrawer
        }
    }
}
