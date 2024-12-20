# Amnezia VPN

### _Лучший клиент для создания VPN на собственном сервере_

[![Build Status](https://github.com/amnezia-vpn/amnezia-client/actions/workflows/deploy.yml/badge.svg?branch=dev)](https://github.com/amnezia-vpn/amnezia-client/actions/workflows/deploy.yml?query=branch:dev)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/amnezia-vpn/amnezia-client)

### [English](https://github.com/amnezia-vpn/amnezia-client/blob/dev/README.md) | Русский
[AmneziaVPN](https://amnezia.org) — это open sourse VPN-клиент, ключевая особенность которого заключается в возможности развернуть собственный VPN на вашем сервере.

[![Image](https://github.com/amnezia-vpn/amnezia-client/blob/dev/metadata/img-readme/uipic4.png)](https://amnezia.org)

### [Сайт](https://amnezia.org) | [Зеркало на сайт](https://storage.googleapis.com/kldscp/amnezia.org) | [Документация](https://docs.amnezia.org) | [Решение проблем](https://docs.amnezia.org/troubleshooting)

> [!TIP]
> Если [сайт Amnezia](https://amnezia.org) заблокирован в вашем регионе, вы можете воспользоваться [ссылкой на зеркало](https://storage.googleapis.com/kldscp/amnezia.org).

<a href="https://storage.googleapis.com/kldscp/amnezia.org/downloads"><img src="https://github.com/amnezia-vpn/amnezia-client/blob/dev/metadata/img-readme/download-website-ru.svg" width="150" style="max-width: 100%; margin-right: 10px"></a>


[Все релизы](https://github.com/amnezia-vpn/amnezia-client/releases)

<br/>

<a href="https://www.testiny.io"><img src="https://github.com/amnezia-vpn/amnezia-client/blob/dev/metadata/img-readme/testiny.png" height="28px"></a>

## Особенности

- Простой в использовании — введите IP-адрес, SSH-логин и пароль, и Amnezia автоматически установит VPN-контейнеры Docker на ваш сервер и подключится к VPN.
- Классические VPN-протоколы: OpenVPN, WireGuard и IKEv2.
- Протоколы с маскировкой трафика (обфускацией): OpenVPN с плагином [Cloak](https://github.com/cbeuw/Cloak), Shadowsocks (OpenVPN over Shadowsocks), [AmneziaWG](https://docs.amnezia.org/documentation/amnezia-wg/) and XRay.
- Поддержка Split Tunneling — добавляйте любые сайты или приложения в список, чтобы включить VPN только для них.
- Поддерживает платформы: Windows, MacOS, Linux, Android, iOS.
- Поддержка конфигурации протокола AmneziaWG на [бета-прошивке Keenetic](https://docs.keenetic.com/ua/air/kn-1611/en/6319-latest-development-release.html#UUID-186c4108-5afd-c10b-f38a-cdff6c17fab3_section-idm33192196168192-improved).

## Ссылки

- [https://amnezia.org](https://amnezia.org) - Веб-сайт проекта | [Альтернативная ссылка (зеркало)](https://storage.googleapis.com/kldscp/amnezia.org)
- [https://docs.amnezia.org](https://docs.amnezia.org) - Документация
- [https://www.reddit.com/r/AmneziaVPN](https://www.reddit.com/r/AmneziaVPN) - Reddit  
- [https://t.me/amnezia_vpn_en](https://t.me/amnezia_vpn_en) - Канал поддржки в Telegram (Английский)
- [https://t.me/amnezia_vpn_ir](https://t.me/amnezia_vpn_ir) - Канал поддржки в Telegram (Фарси)
- [https://t.me/amnezia_vpn_mm](https://t.me/amnezia_vpn_mm) - Канал поддржки в Telegram (Мьянма) 
- [https://t.me/amnezia_vpn](https://t.me/amnezia_vpn) - Канал поддржки в Telegram  (Русский)
- [https://vpnpay.io/en/amnezia-premium/](https://vpnpay.io/en/amnezia-premium/) - Amnezia Premium | [Зеркало](https://storage.googleapis.com/kldscp/vpnpay.io/ru/amnezia-premium\)

## Технологии

AmneziaVPN использует несколько проектов с открытым исходным кодом:

- [OpenSSL](https://www.openssl.org/)
- [OpenVPN](https://openvpn.net/)
- [Shadowsocks](https://shadowsocks.org/)
- [Qt](https://www.qt.io/)
- [LibSsh](https://libssh.org)
- и другие...

## Лицензия

GPL v3.0

## Донаты

Patreon: [https://www.patreon.com/amneziavpn](https://www.patreon.com/amneziavpn)

Bitcoin: bc1q26eevjcg9j0wuyywd2e3uc9cs2w58lpkpjxq6p <br>
USDT BEP20: 0x6abD576765a826f87D1D95183438f9408C901bE4 <br>
USDT TRC20: TELAitazF1MZGmiNjTcnxDjEiH5oe7LC9d <br>
XMR: 48spms39jt1L2L5vyw2RQW6CXD6odUd4jFu19GZcDyKKQV9U88wsJVjSbL4CfRys37jVMdoaWVPSvezCQPhHXUW5UKLqUp3 <br> 
TON: UQDpU1CyKRmg7L8mNScKk9FRc2SlESuI7N-Hby4nX-CcVmns

## Благодарности

Этот проект тестируется с помощью BrowserStack.
Мы выражаем благодарность [BrowserStack](https://www.browserstack.com) за поддержку нашего проекта.
