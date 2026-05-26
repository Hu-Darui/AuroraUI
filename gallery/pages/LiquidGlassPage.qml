import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: Theme.background
    anchors.fill: parent

    // ── 背景动态渐变 ──
    Rectangle {
        anchors.fill: parent
        z: -1
        gradient: Gradient {
            GradientStop { position: 0.0; color: Theme.lgGradientA }
            GradientStop { position: 0.3; color: Theme.lgGradientB }
            GradientStop { position: 0.7; color: Theme.lgGradientC }
            GradientStop { position: 1.0; color: Theme.lgGradientD }
        }
    }

    // ── 浮动光斑装饰 ──
    Repeater {
        model: 4
        Rectangle {
            x: Math.sin(Date.now() / (2000 + index * 600) + index * 1.5) * 120 + parent.width * (0.2 + index * 0.2) - 60
            y: Math.cos(Date.now() / (2200 + index * 500) + index) * 80 + parent.height * 0.3
            width: 80 + index * 20; height: width
            radius: width / 2
            color: Qt.rgba(1, 1, 1, 0.03 + index * 0.01)
            Behavior on x { NumberAnimation { duration: 2000; easing.type: Easing.InOutSine } }
            Behavior on y { NumberAnimation { duration: 2000; easing.type: Easing.InOutSine } }
        }
    }

    // ── 标题 ──
    Text {
        anchors { top: parent.top; topMargin: 40; horizontalCenter: parent.horizontalCenter }
        text: "Liquid Glass"
        font.pixelSize: 32
        font.weight: Theme.weightBold
        font.family: Theme.fontFamily
        color: Theme.text
    }
    Text {
        anchors { top: parent.top; topMargin: 78; horizontalCenter: parent.horizontalCenter }
        text: "Chromatic Iridescence · Fluid Morphing · Ethereal Glow"
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

    // ── 液态玻璃卡片：按钮 ──
    Rectangle {
        id: card1
        anchors {
            top: parent.top; topMargin: 170
            horizontalCenter: parent.horizontalCenter
        }
        width: 420; height: 300
        radius: Theme.radiusLg
        color: Theme.surface

        // 渐变边框
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.width: 1.2
            border.color: Theme.border
        }

        // 内部光泽
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.lgShimmerHigh }
                GradientStop { position: 0.45; color: Theme.lgShimmerHigh }
                GradientStop { position: 0.55; color: "transparent" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Qt.rgba(0, 0, 0, 0.3)
            shadowBlur: 0.6
            shadowVerticalOffset: 5
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
    }
}
