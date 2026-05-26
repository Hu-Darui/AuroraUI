import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: Theme.background
    anchors.fill: parent

    // ── 背景 vibrant 渐变 ──
    Rectangle {
        anchors.fill: parent
        z: -1

        // 三个圆形渐变斑点
        Rectangle {
            x: parent.width * 0.1; y: -80
            width: 260; height: 260; radius: 130
            color: Theme.gmBgGradientA
            opacity: 0.55
        }
        Rectangle {
            x: parent.width * 0.55; y: parent.height * 0.15
            width: 300; height: 300; radius: 150
            color: Theme.gmBgGradientB
            opacity: 0.45
        }
        Rectangle {
            x: parent.width * 0.25; y: parent.height * 0.55
            width: 240; height: 240; radius: 120
            color: Theme.gmBgGradientC
            opacity: 0.4
        }

        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: true
            blurMax: 64
            blur: 1.0
        }
    }

    // ── 标题 ──
    Text {
        anchors { top: parent.top; topMargin: 40; horizontalCenter: parent.horizontalCenter }
        text: "Glassmorphism"
        font.pixelSize: 32
        font.weight: Theme.weightBold
        font.family: Theme.fontFamily
        color: Theme.text
    }
    Text {
        anchors { top: parent.top; topMargin: 78; horizontalCenter: parent.horizontalCenter }
        text: "Frosted Glass · Backdrop Blur · Vibrant Backgrounds"
        font.pixelSize: 14
        font.family: Theme.fontFamily
        color: Theme.textSecondary
    }

    // ── 主题切换 ──
    Row {
        anchors { top: parent.top; topMargin: 110; horizontalCenter: parent.horizontalCenter }
        spacing: 12

        AButton {
            text: "☀ Light"
            variant: Theme.isDark ? "ghost" : "primary"
            onClicked: Theme.isDark = false
        }
        AButton {
            text: "☾ Dark"
            variant: Theme.isDark ? "primary" : "ghost"
            onClicked: Theme.isDark = true
        }
        
    }

    // ── 玻璃卡片：按钮 ──
    Rectangle {
        id: card1
        anchors {
            top: parent.top; topMargin: 170
            horizontalCenter: parent.horizontalCenter
        }
        width: 420; height: 310
        radius: Theme.radiusLg
        color: Theme.surface

        // 顶部高光边框
        Rectangle {
            anchors { top: parent.top; left: parent.left; leftMargin: 1; right: parent.right; rightMargin: 1 }
            height: 1.5
            radius: parent.radius
            color: Theme.gmBorderHighlight
        }

        // 左侧高光
        Rectangle {
            anchors { top: parent.top; left: parent.left; bottom: parent.bottom }
            width: 1.5; radius: parent.radius
            color: Qt.rgba(1, 1, 1, Theme.isDark ? 0.04 : 0.35)
        }

        // 阴影
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Theme.gmDropShadow
            shadowBlur: Theme.gmShadowBlur * 0.5
            shadowVerticalOffset: Theme.gmShadowOffset
        }

        Text {
            anchors { top: parent.top; topMargin: 20; left: parent.left; leftMargin: 24 }
            text: "Buttons"
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Flow {
            anchors { top: parent.top; topMargin: 56; left: parent.left; leftMargin: 24; right: parent.right; rightMargin: 24 }
            spacing: 14

            AButton { text: "Primary"; variant: "primary" }
            AButton { text: "Secondary"; variant: "secondary" }
            AButton { text: "Ghost"; variant: "ghost" }
            AButton { text: "Destructive"; variant: "destructive" }
            AButton { text: "Disabled"; enabled: false }
            AButton { text: "Loading"; loading: true }
        }

        Text {
            anchors { top: parent.top; topMargin: 155; left: parent.left; leftMargin: 24 }
            text: "Sizes"
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Row {
            anchors { top: parent.top; topMargin: 190; left: parent.left; leftMargin: 24 }
            spacing: 12
            AButton { text: "Small"; size: "sm" }
            AButton { text: "Medium"; size: "md"; variant: "primary" }
            AButton { text: "Large"; size: "lg" }
        }

        // ── 输入框 ──
        Text {
            anchors { top: parent.top; topMargin: 240; left: parent.left; leftMargin: 24 }
            text: "Glass Input"
            font.pixelSize: 14; font.family: Theme.fontFamily
            color: Theme.textSecondary
        }

        Rectangle {
            anchors { top: parent.top; topMargin: 264; left: parent.left; leftMargin: 24; right: parent.right; rightMargin: 24 }
            height: 36; radius: 8
            color: Qt.rgba(1, 1, 1, 0.10)

            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: 0.5; radius: 8
                color: Qt.rgba(1, 1, 1, 0.25)
            }

            TextInput {
                anchors { fill: parent; leftMargin: 12; rightMargin: 12 }
                text: "Search..."
                font.pixelSize: 13; font.family: Theme.fontFamily
                color: Theme.textSecondary
                verticalAlignment: TextInput.AlignVCenter
            }
        }
    }

    // ── 第二张玻璃卡 ──
    Rectangle {
        id: card2
        anchors {
            top: card1.bottom; topMargin: 24
            horizontalCenter: parent.horizontalCenter
        }
        width: 420; height: 80
        radius: Theme.radiusMd
        color: Theme.surface

        Rectangle {
            anchors { top: parent.top; left: parent.left; leftMargin: 1; right: parent.right; rightMargin: 1 }
            height: 1.2; radius: parent.radius
            color: Theme.gmBorderHighlight
        }

        layer.effect: MultiEffect {
            shadowEnabled: true; shadowColor: Theme.gmDropShadow
            shadowBlur: Theme.gmShadowBlur * 0.4; shadowVerticalOffset: Theme.gmShadowOffset * 0.7
        }

        Row {
            anchors { centerIn: parent }
            spacing: 20

            Text {
                text: "Transparency"
                font.pixelSize: 14; font.family: Theme.fontFamily
                color: Theme.text; anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 80; height: 8; radius: 4
                color: Qt.rgba(1, 1, 1, 0.20)
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: parent.width * 0.22; height: parent.height
                    radius: parent.radius; color: Theme.primary
                }
            }

            Text {
                text: "{ }"
                font.pixelSize: 14; font.family: Theme.fontFamily
                color: Theme.textSecondary; anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
