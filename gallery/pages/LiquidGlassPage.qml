import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: Theme.background
    anchors.fill: parent

    // ── macOS 风格壁纸 ──
    Rectangle {
        anchors.fill: parent; z: -1
        color: Theme.isDark ? "#0A0A2E" : "#E8E4F0"

        Repeater {
            model: [
                { cx: 0.12, cy: 0.15, s: 0.28, c: Theme.isDark ? "#7722FF" : "#A0A0FF" },
                { cx: 0.72, cy: 0.28, s: 0.24, c: Theme.isDark ? "#0055FF" : "#A0C8FF" },
                { cx: 0.20, cy: 0.60, s: 0.22, c: Theme.isDark ? "#FF0077" : "#FFA0C0" },
                { cx: 0.80, cy: 0.10, s: 0.18, c: Theme.isDark ? "#00AAFF" : "#80D0FF" },
                { cx: 0.48, cy: 0.70, s: 0.16, c: Theme.isDark ? "#AA00FF" : "#C8A0FF" }
            ]
            delegate: Rectangle {
                x: modelData.cx * parent.width - modelData.s * parent.width / 2
                y: modelData.cy * parent.height - modelData.s * parent.width / 2
                width: modelData.s * parent.width
                height: width
                radius: width / 2
                color: modelData.c
                opacity: Theme.isDark ? 0.28 : 0.22
                layer.enabled: true
                layer.effect: MultiEffect { blurEnabled: true; blur: 1.0; blurMax: 80 }
            }
        }

        Repeater {
            visible: Theme.isDark
            model: 40
            delegate: Rectangle {
                property real rndX: Math.random()
                property real rndY: Math.random()
                property real rndS: Math.random()
                property real rndD: Math.random()
                x: rndX * parent.width
                y: rndY * parent.height
                width: rndS * 1.5 + 0.5
                height: width
                radius: width / 2
                color: "white"
                opacity: rndS * 0.5 + 0.1
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.05; duration: rndD * 2000 + 1200; easing.type: Easing.InOutSine }
                    NumberAnimation { to: 0.75; duration: rndD * 2000 + 1200; easing.type: Easing.InOutSine }
                }
            }
        }
    }

    // ── 玻璃卡片 ──
    ScrollView {
        anchors { top: parent.top; topMargin: 24; bottom: parent.bottom; left: parent.left; right: parent.right }
        contentWidth: availableWidth
        contentHeight: contentColumn.implicitHeight + 40

        Column {
            id: contentColumn
            width: parent.width
            spacing: 24
            topPadding: 20

            ACard {
                title: "Liquid Glass Card"
                width: 440
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 12; width: parent.width
                    Row { spacing: 12
                        AButton { text: "Primary"; variant: "primary" }
                        AButton { text: "Secondary"; variant: "secondary" }
                        AButton { text: "Ghost"; variant: "ghost" }
                    }
                }
            }

            ACard {
                title: "Input Components"
                width: 440
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 12; width: parent.width
                    Row { spacing: 12
                        ATextBox { placeholderText: "Enter text..."; implicitWidth: 200 }
                        APasswordBox { placeholderText: "Password"; implicitWidth: 200 }
                    }
                    ATextArea { placeholderText: "Multi-line text..."; implicitWidth: parent.width }
                }
            }

            ACard {
                title: "Switches"
                width: 440
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
