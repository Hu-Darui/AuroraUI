import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property int lines: 1
    property real lineHeight: 14
    property real lineSpacing: 8
    property real widthVariance: 0.3

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    readonly property color _base: {
        if (_isNeu) return Theme.elevated
        if (_isLiq) return Qt.rgba(1, 1, 1, 0.04)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.06)
        return Theme.isDark ? Qt.rgba(1, 1, 1, 0.07) : Qt.rgba(0, 0, 0, 0.05)
    }

    readonly property color _highlight: {
        if (_isNeu) return Qt.rgba(1, 1, 1, 0.35)
        if (_isLiq) return Qt.rgba(1, 1, 1, 0.14)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.12)
        return Theme.isDark ? Qt.rgba(1, 1, 1, 0.13) : Qt.rgba(1, 1, 1, 0.55)
    }

    implicitWidth: 200
    implicitHeight: lines * (lineHeight + lineSpacing) - lineSpacing

    contentItem: Column {
        spacing: root.lineSpacing

        Repeater {
            model: root.lines

            Rectangle {
                width: parent.width * (1.0 - Math.random() * root.widthVariance)
                height: root.lineHeight
                radius: root.lineHeight / 2
                clip: true

                // Base
                Rectangle {
                    anchors.fill: parent; radius: parent.radius
                    color: root._base
                }

                // ── Neumorphism: 凹陷骨架 ──
                Rectangle {
                    visible: root._isNeu
                    anchors.fill: parent; radius: parent.radius; color: "transparent"
                    border.color: Theme.neuInsetDark; border.width: 0.8
                }

                // ── Glassmorphism: 边框 ──
                Rectangle {
                    visible: root._isGls
                    anchors.fill: parent; radius: parent.radius; color: "transparent"
                    border.color: Qt.rgba(1, 1, 1, 0.06); border.width: 0.5
                }

                // Shimmer sweep
                Rectangle {
                    width: parent.width * 2
                    anchors { top: parent.top; bottom: parent.bottom }
                    radius: parent.radius

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "transparent" }
                        GradientStop { position: 0.5; color: root._highlight }
                        GradientStop { position: 1.0; color: "transparent" }
                    }

                    x: -parent.width

                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        NumberAnimation {
                            from: -parent.width * 1.5; to: parent.width * 1.5
                            duration: 1400 + index * 200; easing.type: Easing.InOutSine
                        }
                        PauseAnimation { duration: 400 + index * 100 }
                    }
                }

            }
        }
    }
}
