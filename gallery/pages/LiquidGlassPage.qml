import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: Theme.background
    anchors.fill: parent

    // ── Timer 驱动的浮动光斑（替代 Date.now() 绑定） ──
    property real _time: 0

    Timer {
        interval: 50; running: root.visible; repeat: true
        onTriggered: root._time += 0.05
    }

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

    // ── 浮动光斑（用 _time 驱动，不可见时不跑 Timer） ──
    Repeater {
        model: 4
        Rectangle {
            x: Math.sin(root._time / (2.0 + index * 0.6) + index * 1.5) * 120 + parent.width * (0.2 + index * 0.2) - 60
            y: Math.cos(root._time / (2.2 + index * 0.5) + index) * 80 + parent.height * 0.3
            width: 80 + index * 20; height: width
            radius: width / 2
            color: Qt.rgba(1, 1, 1, 0.03 + index * 0.01)
            Behavior on x { NumberAnimation { duration: 300; easing.type: Easing.InOutSine } }
            Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.InOutSine } }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        contentHeight: contentColumn.implicitHeight + 60

        Column {
            id: contentColumn
            width: parent.width
            spacing: 28
            topPadding: 40

            // ── 标题 ──
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 4
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Liquid Glass"
                    font.pixelSize: 28; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Chromatic Iridescence · Fluid Morphing · Ethereal Glow"
                    font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                }
            }

            // ── 按钮展示 ──
            ACard {
                title: "Buttons"
                width: 420
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 12
                    Flow { width: parent.width; spacing: 14
                        AButton { text: "Primary"; variant: "primary" }
                        AButton { text: "Secondary"; variant: "secondary" }
                        AButton { text: "Ghost"; variant: "ghost" }
                        AButton { text: "Destructive"; variant: "destructive" }
                        AButton { text: "Disabled"; enabled: false }
                        AButton { text: "Loading"; loading: true }
                    }
                    Row { spacing: 12
                        AButton { text: "Small"; size: "sm" }
                        AButton { text: "Medium"; size: "md"; variant: "primary" }
                        AButton { text: "Large"; size: "lg" }
                    }
                }
            }

            // ── 液态玻璃专属输入框 ──
            ACard {
                title: "Liquid Glass Surface"
                width: 420
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    width: parent.width - 20; height: 40; radius: Theme.radiusMd
                    color: Theme.surface
                    border.width: 1.2
                    border.color: Theme.border

                    Rectangle {
                        anchors.fill: parent; radius: parent.radius
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: Theme.lgShimmerHigh }
                            GradientStop { position: 0.5; color: Theme.lgShimmerHigh }
                            GradientStop { position: 0.6; color: "transparent" }
                            GradientStop { position: 1.0; color: "transparent" }
                        }
                    }

                    TextInput {
                        anchors { fill: parent; leftMargin: 16; rightMargin: 16 }
                        text: "Search..."
                        font.pixelSize: 13; font.family: Theme.fontFamily
                        color: Theme.textSecondary
                        verticalAlignment: TextInput.AlignVCenter
                    }
                }
            }

            // ── Switches ──
            ACard {
                title: "Switches"
                width: 420
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 24
                    Column { spacing: 4
                        ASwitch { id: sw1 }
                        Text { text: sw1.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 4
                        ASwitch { id: sw2; checked: true }
                        Text { text: sw2.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 4
                        ASwitch { id: sw3; enabled: false }
                        Text { text: "Disabled"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                }
            }
        }
    }
}
