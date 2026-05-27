import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1200
    height: 820
    minimumWidth: 900
    minimumHeight: 640
    title: "AuroraUI — Design Styles Gallery  |  Developed by Hu-Darui"
    color: Theme.background
    flags: Qt.FramelessWindowHint | Qt.Window

    // ═══════════════════════════════════════
    // 数据模型
    // ═══════════════════════════════════════
    readonly property var _styles: [
        { key: Theme.styleDefault,       name: "Default",        icon: "◈", desc: "macOS-inspired Design" },
        { key: Theme.styleNeumorphism,   name: "Neumorphism",    icon: "◉", desc: "Soft UI · Extruded Shadows" },
        { key: Theme.styleLiquidGlass,   name: "Liquid Glass",   icon: "◊", desc: "Chromatic · Fluid · Ethereal" },
        { key: Theme.styleGlassmorphism, name: "Glassmorphism",  icon: "◇", desc: "Frosted Glass · Backdrop Blur" }
    ]

    readonly property var _navItems: [
        { name: "Overview", page: "pages/GalleryPage.qml",   icon: "▤" },
        { name: "Buttons",  page: "pages/ButtonsPage.qml",   icon: "◎" },
        { name: "Inputs",   page: "pages/InputsPage.qml",    icon: "▦" },
        { name: "Dialogs",    page: "pages/DialogsPage.qml",    icon: "◰" },
        { name: "Navigation", page: "pages/NavigationPage.qml", icon: "☰" },
        { name: "Feedback",   page: "pages/FeedbackPage.qml",   icon: "◎" },
        { name: "Data",       page: "pages/DataPage.qml",       icon: "▤" }
    ]

    property int _currentNav: 0

    function _styleName() {
        for (var i = 0; i < _styles.length; i++) {
            if (_styles[i].key === Theme.style) return _styles[i].name
        }
        return "Default"
    }

    // ═══════════════════════════════════════
    // 背景装饰
    // ═══════════════════════════════════════
    Item {
        anchors.fill: parent
        z: -1

        Rectangle {
            visible: Theme.style === Theme.styleGlassmorphism
            anchors.fill: parent
            Rectangle { x: parent.width * 0.55; y: -120; width: 340; height: 340; radius: 170; color: Theme.gmBgGradientA; opacity: 0.5 }
            Rectangle { x: parent.width * 0.75; y: parent.height * 0.2; width: 280; height: 280; radius: 140; color: Theme.gmBgGradientB; opacity: 0.4 }
            Rectangle { x: parent.width * 0.45; y: parent.height * 0.6; width: 300; height: 300; radius: 150; color: Theme.gmBgGradientC; opacity: 0.35 }
            layer.enabled: true
            layer.effect: MultiEffect { blurEnabled: true; blurMax: 64; blur: 1.0 }
        }

        Rectangle {
            visible: Theme.style === Theme.styleLiquidGlass
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.lgGradientA }
                GradientStop { position: 0.3; color: Theme.lgGradientB }
                GradientStop { position: 0.7; color: Theme.lgGradientC }
                GradientStop { position: 1.0; color: Theme.lgGradientD }
            }
        }
    }

    // ═══════════════════════════════════════
    // 自定义标题栏
    // ═══════════════════════════════════════
    Rectangle {
        id: titleBar
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: 38
        color: Theme.elevated
        z: 100

        Rectangle {
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: 0.5
            color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(0, 0, 0, 0.06)
        }

        // 拖拽区域（系统级移动，无抖动）
        MouseArea {
            anchors.fill: parent
            onPressed: window.startSystemMove()
        }

        Row {
            anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
            spacing: 8

            Image {
                source: "qrc:/qt/qml/gallery/resources/icon.png"
                width: 18; height: 18
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                smooth: true
            }
            Text {
                text: "AuroraUI Gallery"
                font.pixelSize: 13; font.weight: Theme.weightSemiBold
                font.family: Theme.fontFamily; color: Theme.text
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // ── 窗口控制按钮 ──
        Row {
            anchors { right: parent.right; rightMargin: 4; verticalCenter: parent.verticalCenter }
            spacing: 2

            // Minimize
            Rectangle {
                id: btnMin
                width: 38; height: 28; radius: Theme.radiusSm
                color: btnMinMa.containsMouse
                    ? (Theme.isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.05))
                    : "transparent"
                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "—"
                    font.pixelSize: 12; font.weight: Font.Bold
                    font.family: Theme.fontFamily; color: Theme.textSecondary
                }

                MouseArea {
                    id: btnMinMa
                    anchors.fill: parent; hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: window.showMinimized()
                }
            }

            // Maximize
            Rectangle {
                id: btnMax
                width: 38; height: 28; radius: Theme.radiusSm
                color: btnMaxMa.containsMouse
                    ? (Theme.isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.05))
                    : "transparent"
                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: window.visibility === Window.Maximized ? "◱" : "□"
                    font.pixelSize: window.visibility === Window.Maximized ? 11 : 13
                    font.family: Theme.fontFamily; color: Theme.textSecondary
                }

                MouseArea {
                    id: btnMaxMa
                    anchors.fill: parent; hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (window.visibility === Window.Maximized)
                            window.showNormal()
                        else
                            window.showMaximized()
                    }
                }
            }

            // Close
            Rectangle {
                id: btnClose
                width: 38; height: 28; radius: Theme.radiusSm
                color: btnCloseMa.containsMouse
                    ? (btnCloseMa.pressed ? Qt.rgba(0.90, 0.20, 0.18, 0.85) : Qt.rgba(0.90, 0.20, 0.18, 0.75))
                    : "transparent"
                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "✕"
                    font.pixelSize: 12
                    font.family: Theme.fontFamily
                    color: btnCloseMa.containsMouse ? "#FFFFFF" : Theme.textSecondary
                }

                MouseArea {
                    id: btnCloseMa
                    anchors.fill: parent; hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: window.close()
                }
            }
        }
    }

    // ═══════════════════════════════════════
    // 左侧边栏
    // ═══════════════════════════════════════
    Rectangle {
        id: sidebar
        anchors {
            top: titleBar.bottom; bottom: statusBar.top
            left: parent.left
        }
        width: 240
        color: Theme.elevated
        z: 10

        Rectangle {
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
            width: 0.5
            color: Theme.style === Theme.styleNeumorphism
                ? "transparent"
                : Theme.isDark ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(0, 0, 0, 0.06)
        }

        Rectangle {
            visible: Theme.style === Theme.styleNeumorphism
            anchors { fill: parent; topMargin: -6; leftMargin: -6 }
            color: Theme.neuLightShadow
        }
        Rectangle {
            visible: Theme.style === Theme.styleNeumorphism
            anchors { fill: parent; bottomMargin: -6; rightMargin: -6 }
            color: Theme.neuDarkShadow
        }

        // ── LiquidGlass: 毛玻璃效果 ──
        Rectangle {
            visible: Theme.style === Theme.styleLiquidGlass
            anchors { fill: parent; margins: 3 }
            radius: Theme.radiusLg
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.lgGradientA }
                GradientStop { position: 0.3; color: Theme.lgGradientB }
                GradientStop { position: 0.7; color: Theme.lgGradientC }
                GradientStop { position: 1.0; color: Theme.lgGradientD }
            }
            opacity: 0.3
            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true; blurMax: Theme.lgBlurAmount
                blur: 0.7
            }
        }

        // ── LiquidGlass: 顶部光泽 ──
        Rectangle {
            visible: Theme.style === Theme.styleLiquidGlass
            anchors { top: parent.top; left: parent.left; leftMargin: 2; right: parent.right; rightMargin: 2 }
            height: parent.height * 0.4; radius: Theme.radiusLg
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.lgShimmerHigh }
                GradientStop { position: 0.6; color: Theme.lgShimmerHigh }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        // ── 固定 Logo ──
        Item {
            id: logoArea
            anchors { top: parent.top; left: parent.left; right: parent.right }
            height: 60
            Row {
                anchors { left: parent.left; leftMargin: 20; verticalCenter: parent.verticalCenter }
                spacing: 10
                Image {
                    source: "qrc:/qt/qml/gallery/resources/icon.png"
                    width: 28; height: 28
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
                Column {
                    anchors.verticalCenter: parent.verticalCenter; spacing: 0
                    Text { text: "AuroraUI"; font.pixelSize: 14; font.weight: Theme.weightBold; font.family: Theme.fontFamily; color: Theme.text }
                    Text { text: "Design Gallery"; font.pixelSize: 10; font.family: Theme.fontFamily; color: Theme.textSecondary }
                }
            }
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 0.5
                color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06)
            }
        }

        // ── 可滚动内容 ──
        ScrollView {
            anchors { top: logoArea.bottom; bottom: parent.bottom; bottomMargin: 30; left: parent.left; right: parent.right }
            contentWidth: availableWidth
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AsNeeded

            Column {
                width: parent.width
                spacing: 0

            // ── 风格选择 ──
            Column {
                width: parent.width; topPadding: 16; bottomPadding: 10
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20
                    text: "STYLE"; font.pixelSize: 10; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.textSecondary
                    font.letterSpacing: 1.2; opacity: 0.6
                }
                Column {
                    anchors { left: parent.left; right: parent.right; margins: 8 }
                    topPadding: 8; spacing: 2

                    Repeater {
                        model: _styles
                        Rectangle {
                            width: sidebar.width - 16; height: 34
                            radius: Theme.radiusMd
                            color: {
                                if (Theme.style === modelData.key) {
                                    if (Theme.style === Theme.styleNeumorphism) return Theme.background
                                    if (Theme.style === Theme.styleLiquidGlass) return Qt.rgba(1,1,1,0.08)
                                    if (Theme.style === Theme.styleGlassmorphism) return Qt.rgba(1,1,1,0.07)
                                    return Theme.isDark ? Qt.rgba(0.04,0.52,1,0.18) : Qt.rgba(0,0.44,0.89,0.08)
                                }
                                return "transparent"
                            }

                            Rectangle {
                                visible: Theme.style === modelData.key && Theme.style === Theme.styleNeumorphism
                                anchors.fill: parent; radius: parent.radius; color: "transparent"
                                border.color: Theme.primary; border.width: 1.5; opacity: 0.5
                            }
                            Rectangle {
                                visible: Theme.style === modelData.key && Theme.style !== Theme.styleNeumorphism
                                anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                                width: 3; radius: 2; color: Theme.primary
                            }

                            Row {
                                anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
                                spacing: 10
                                Text {
                                    text: modelData.icon; font.pixelSize: 12
                                    color: Theme.style === modelData.key ? Theme.primary : Theme.textSecondary
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Column {
                                    anchors.verticalCenter: parent.verticalCenter; spacing: 0
                                    Text {
                                        text: modelData.name; font.pixelSize: 12
                                        font.weight: Theme.style === modelData.key ? Theme.weightSemiBold : Theme.weightRegular
                                        font.family: Theme.fontFamily
                                        color: Theme.style === modelData.key ? Theme.text : Theme.textSecondary
                                    }
                                    Text {
                                        text: modelData.desc; font.pixelSize: 9
                                        font.family: Theme.fontFamily; color: Theme.textSecondary; opacity: 0.5
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                onClicked: Theme.style = modelData.key
                            }
                        }
                    }
                }
            }

            Rectangle { width: parent.width - 32; anchors.horizontalCenter: parent.horizontalCenter; height: 0.5; color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06) }

            // ── 主题切换 ──
            Item {
                width: parent.width; height: 46
                Row {
                    anchors { left: parent.left; leftMargin: 16; verticalCenter: parent.verticalCenter }
                    spacing: 8
                    Text { text: Theme.isDark ? "☾" : "☀"; font.pixelSize: 14; color: Theme.text; anchors.verticalCenter: parent.verticalCenter }
                    Text {
                        text: Theme.isDark ? "Dark Mode" : "Light Mode"
                        font.pixelSize: 12; font.weight: Theme.weightMedium
                        font.family: Theme.fontFamily; color: Theme.text
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    anchors { right: parent.right; rightMargin: 16; verticalCenter: parent.verticalCenter }
                    width: 40; height: 24; radius: 12
                    color: Theme.isDark
                        ? (Theme.style === Theme.styleNeumorphism ? Theme.primary : "#0A84FF")
                        : (Theme.style === Theme.styleNeumorphism ? Theme.background : "#D1D1D6")
                    Behavior on color { ColorAnimation { duration: Theme.durationFast } }

                    Rectangle {
                        width: 18; height: 18; radius: 9
                        color: Theme.style === Theme.styleNeumorphism ? Theme.elevated : "#FFFFFF"
                        x: Theme.isDark ? 19 : 3
                        anchors.verticalCenter: parent.verticalCenter
                        Behavior on x { NumberAnimation { duration: Theme.durationFast; easing.type: Easing.InOutCubic } }
                        layer.enabled: Theme.style !== Theme.styleNeumorphism
                        layer.effect: MultiEffect {
                            shadowEnabled: true; shadowColor: Qt.rgba(0,0,0,0.15)
                            shadowBlur: 0.3; shadowVerticalOffset: 1
                        }
                    }

                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: Theme.toggleTheme()
                    }
                }
            }

            Rectangle { width: parent.width - 32; anchors.horizontalCenter: parent.horizontalCenter; height: 0.5; color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06) }

            // ── 组件导航 ──
            Column {
                width: parent.width; topPadding: 14
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20
                    text: "COMPONENTS"; font.pixelSize: 10; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.textSecondary
                    font.letterSpacing: 1.2; opacity: 0.6
                }
                Column {
                    anchors { left: parent.left; right: parent.right; margins: 8 }
                    topPadding: 8; spacing: 1

                    Repeater {
                        model: _navItems
                        Rectangle {
                            width: sidebar.width - 16; height: 32; radius: Theme.radiusMd
                            color: {
                                if (window._currentNav === index) {
                                    if (Theme.style === Theme.styleNeumorphism) return Theme.background
                                    if (Theme.style === Theme.styleLiquidGlass) return Qt.rgba(1,1,1,0.08)
                                    if (Theme.style === Theme.styleGlassmorphism) return Qt.rgba(1,1,1,0.07)
                                    return Theme.isDark ? Qt.rgba(0.04,0.52,1,0.18) : Qt.rgba(0,0.44,0.89,0.08)
                                }
                                return "transparent"
                            }

                            Rectangle {
                                visible: window._currentNav === index && Theme.style !== Theme.styleNeumorphism
                                anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                                width: 3; radius: 2; color: Theme.primary
                            }

                            Row {
                                anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
                                spacing: 10
                                Text {
                                    text: modelData.icon; font.pixelSize: 12
                                    color: window._currentNav === index ? Theme.primary : Theme.textSecondary
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text {
                                    text: modelData.name; font.pixelSize: 12
                                    font.weight: window._currentNav === index ? Theme.weightSemiBold : Theme.weightRegular
                                    font.family: Theme.fontFamily
                                    color: window._currentNav === index ? Theme.text : Theme.textSecondary
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            MouseArea {
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                onClicked: window.navigateTo(index)
                            }
                        }
                    }
                }
            }
        } // inner Column
        } // ScrollView
    }

    // 侧边栏底部版本
    Text {
        id: versionText
        anchors { bottom: sidebar.bottom; bottomMargin: 10; left: sidebar.left; leftMargin: 20 }
        text: "AuroraUI v1.0  ·  Qt 6.8\nby Hu-Darui"
        font.pixelSize: 10; font.family: Theme.fontFamily
        color: Theme.textSecondary; opacity: 0.5; z: 11
        horizontalAlignment: Text.AlignLeft
    }

    // ═══════════════════════════════════════
    // 底部状态栏
    // ═══════════════════════════════════════
    Rectangle {
        id: statusBar
        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
        height: 26; color: Theme.elevated; z: 10

        Rectangle {
            anchors { left: parent.left; right: parent.right; top: parent.top }
            height: 0.5
            color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06)
        }

        Row {
            anchors { left: parent.left; leftMargin: 16; verticalCenter: parent.verticalCenter }
            spacing: 20
            Text { text: "Style: " + _styleName(); font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
            Text { text: "Theme: " + (Theme.isDark ? "Dark" : "Light"); font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
            Text { text: "Page: " + _navItems[window._currentNav].name; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
        }

        Text {
            anchors { right: parent.right; rightMargin: 16; verticalCenter: parent.verticalCenter }
            text: "Developed by Hu-Darui  |  AuroraUI v1.0"; font.pixelSize: 11
            font.family: Theme.fontFamily; color: Theme.textSecondary; opacity: 0.6
        }
    }

    // ═══════════════════════════════════════
    // 主内容区（预加载全部，仅显隐切换）
    // ═══════════════════════════════════════
    Item {
        id: contentArea
        anchors {
            top: titleBar.bottom; bottom: statusBar.top
            left: sidebar.right; right: parent.right
        }

        Repeater {
            model: _navItems

            Loader {
                anchors.fill: parent
                asynchronous: true
                active: true
                source: modelData.page
                visible: window._currentNav === index
                z: window._currentNav === index ? 1 : 0
            }
        }
    }

    function navigateTo(index) {
        if (index === _currentNav) return
        _currentNav = index
    }
}
