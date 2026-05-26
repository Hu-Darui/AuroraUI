import QtQuick
import QtQuick.Controls
import aurora 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 760
    title: "AuroraUI — Design Styles Gallery"
    color: Theme.background

    // ═══════════════════════════════════════
    // 顶部风格切换栏
    // ═══════════════════════════════════════
    Rectangle {
        id: toolbar
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: 50
        color: Theme.surface
        z: 10

        Rectangle {
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: 0.5
            color: Theme.textSecondary
            opacity: 0.15
        }

        Row {
            anchors { left: parent.left; leftMargin: 20; verticalCenter: parent.verticalCenter }
            spacing: 4

            // 风格标签
            Repeater {
                model: [
                    { name: "Default",       style: Theme.styleDefault },
                    { name: "Neumorphism",   style: Theme.styleNeumorphism },
                    { name: "Liquid Glass",  style: Theme.styleLiquidGlass },
                    { name: "Glassmorphism", style: Theme.styleGlassmorphism }
                ]

                Rectangle {
                    width: label.implicitWidth + 24
                    height: 30
                    radius: 6
                    color: Theme.style === modelData.style
                           ? (Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.20) : Qt.rgba(0, 0.44, 0.89, 0.10))
                           : "transparent"

                    Text {
                        id: label
                        anchors.centerIn: parent
                        text: modelData.name
                        font.pixelSize: 13
                        font.weight: Theme.style === modelData.style ? Theme.weightSemiBold : Theme.weightRegular
                        font.family: Theme.fontFamily
                        color: Theme.text
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Theme.style = modelData.style
                    }
                }
            }
        }

        // 暗色切换
        Rectangle {
            anchors { right: parent.right; rightMargin: 20; verticalCenter: parent.verticalCenter }
            width: darkLabel.implicitWidth + 20
            height: 30; radius: 6
            color: Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.15) : "transparent"

            Text {
                id: darkLabel
                anchors.centerIn: parent
                text: Theme.isDark ? "☾ Dark" : "☀ Light"
                font.pixelSize: 13; font.family: Theme.fontFamily; color: Theme.text
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Theme.toggleTheme()
            }
        }
    }

    // ═══════════════════════════════════════
    // 页面内容（按 style 切换）
    // ═══════════════════════════════════════
    Loader {
        anchors { top: toolbar.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
        source: "pages/GalleryPage.qml"
    }

    // ── 底部状态栏 ──
    Rectangle {
        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
        height: 28
        color: Theme.surface
        z: 10

        Rectangle {
            anchors { left: parent.left; right: parent.right; top: parent.top }
            height: 0.5
            color: Theme.textSecondary
            opacity: 0.12
        }

        Text {
            anchors { left: parent.left; leftMargin: 16; verticalCenter: parent.verticalCenter }
            text: "Style: " + ["Default", "Neumorphism", "Liquid Glass", "Glassmorphism"][Theme.style]
                  + "  |  Theme: " + (Theme.isDark ? "Dark" : "Light")
                  + "  |  AuroraUI v1.0"
            font.pixelSize: 11
            font.family: Theme.fontFamily
            color: Theme.textSecondary
        }
    }
}
