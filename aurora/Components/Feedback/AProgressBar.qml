import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property real value: 0
    property bool indeterminate: false

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    implicitWidth: 200
    implicitHeight: _isNeu ? 12 : _isLiq ? 8 : 6

    readonly property color _trackColor: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Qt.rgba(1, 1, 1, 0.06)
        return Theme.isDark ? "#3A3A3C" : "#E5E5EA"
    }

    readonly property color _fillColor: {
        if (_isNeu) return Theme.primary
        if (_isLiq) return "#A78BFA"
        return Theme.primary
    }

    background: Item {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight

        // Track
        Rectangle {
            id: track
            anchors.fill: parent
            radius: height / 2
            color: root._trackColor
            clip: true

            // Neumorphism: inset track
            Rectangle {
                visible: root._isNeu
                anchors.fill: parent; radius: parent.radius; color: "transparent"
                border.color: Theme.neuInsetDark; border.width: 1
            }

            // Fill
            Rectangle {
                id: fill
                width: root.indeterminate ? parent.width * 0.35 : parent.width * Math.min(root.value / 100, 1.0)
                height: parent.height
                radius: parent.radius
                color: root._fillColor
                visible: root.value > 0 || root.indeterminate

                Behavior on width { NumberAnimation { duration: Theme.durationNormal; easing.type: Easing.OutCubic } }

                // ── Neumorphism: 凸起填充 ──
                Rectangle {
                    visible: root._isNeu
                    anchors { fill: parent; topMargin: -2; leftMargin: -2 }
                    radius: parent.radius + 2; color: Theme.neuLightShadow
                }
                Rectangle {
                    visible: root._isNeu
                    anchors { fill: parent; bottomMargin: -2; rightMargin: -2 }
                    radius: parent.radius + 2; color: Theme.neuDarkShadow
                }

                // Indeterminate animation
                SequentialAnimation on x {
                    running: root.indeterminate
                    loops: Animation.Infinite
                    NumberAnimation { from: -fill.width; to: track.width; duration: 1100; easing.type: Easing.InOutCubic }
                    PauseAnimation { duration: 300 }
                }
            }
        }

    }
}
