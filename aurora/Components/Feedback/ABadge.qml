import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property string text: ""
    property string variant: "primary"

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    readonly property color _bg: {
        if (_isNeu) {
            switch (variant) {
                case "success": return Theme.success
                case "warning": return Theme.warning
                case "danger":  return Theme.danger
                case "neutral": return Theme.elevated
                default:        return Theme.primary
            }
        }
        switch (variant) {
            case "success": return Theme.isDark ? Qt.rgba(0.20, 0.80, 0.45, 0.20) : Qt.rgba(0.20, 0.80, 0.45, 0.12)
            case "warning": return Theme.isDark ? Qt.rgba(0.95, 0.60, 0.10, 0.20) : Qt.rgba(0.95, 0.60, 0.10, 0.12)
            case "danger":  return Theme.isDark ? Qt.rgba(0.90, 0.20, 0.18, 0.20) : Qt.rgba(0.90, 0.20, 0.18, 0.12)
            case "neutral": return Theme.isDark ? Qt.rgba(1, 1, 1, 0.10) : Qt.rgba(0, 0, 0, 0.06)
            default:        return Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.20) : Qt.rgba(0, 0.44, 0.89, 0.12)
        }
    }

    readonly property color _fg: {
        if (_isNeu) return "#FFFFFF"
        switch (variant) {
            case "success": return Theme.success
            case "warning": return Theme.warning
            case "danger":  return Theme.danger
            case "neutral": return Theme.textSecondary
            default:        return Theme.primary
        }
    }

    implicitWidth: label.implicitWidth + 14
    implicitHeight: 22

    background: Item {
        // ── Neumorphism: 凸起药丸 ──
        Rectangle {
            visible: root._isNeu && root.variant !== "neutral"
            anchors { fill: parent; topMargin: -2; leftMargin: -2 }
            radius: parent.height / 2 + 2; color: Theme.neuLightShadow
        }
        Rectangle {
            visible: root._isNeu && root.variant !== "neutral"
            anchors { fill: parent; bottomMargin: -2; rightMargin: -2 }
            radius: parent.height / 2 + 2; color: Theme.neuDarkShadow
        }

        Rectangle {
            id: badgeBg
            anchors.fill: parent
            radius: height / 2
            color: root._bg

            Behavior on color { ColorAnimation { duration: Theme.durationFast } }

            Rectangle {
                visible: root._isGls
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: 0.8; radius: parent.radius
                color: Theme.gmBorderHighlight
            }

            // ── Glassmorphism: shadow ──
            layer.enabled: root._isGls
            layer.effect: MultiEffect {
                shadowEnabled: true; shadowColor: Theme.gmDropShadow
                shadowBlur: Theme.gmShadowBlur * 0.2; shadowVerticalOffset: Theme.gmShadowOffset * 0.3
            }
        }
    }

    contentItem: Text {
        id: label
        text: root.text
        font.pixelSize: 11
        font.weight: Font.Medium
        font.family: Theme.fontFamily
        color: root._fg
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
