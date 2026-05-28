import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

ToolTip {
    id: root

    property string variant: "dark"

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    delay: 500
    timeout: 3000

    readonly property color _bg: {
        if (_isNeu) return Theme.elevated
        if (_isLiq) return Qt.rgba(0.15, 0.15, 0.25, 0.92)
        if (_isGls) return Qt.rgba(0.20, 0.20, 0.28, 0.90)
        if (variant === "dark") return Theme.isDark ? "#3A3A3C" : "#2C2C30"
        return Theme.isDark ? "#E8E8F0" : "#FFFFFF"
    }

    readonly property color _fg: {
        if (variant === "dark") return "#FFFFFF"
        return Theme.isDark ? "#1A1A2E" : "#2C2C30"
    }

    background: Rectangle {
        id: tbBg
        radius: Theme.radiusSm
        color: root._bg

        // ── Neumorphism: 凸起 ──
        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; topMargin: -3; leftMargin: -3 }
            radius: parent.radius + 3; color: Theme.neuLightShadow
        }
        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; bottomMargin: -3; rightMargin: -3 }
            radius: parent.radius + 3; color: Theme.neuDarkShadow
        }

        Rectangle {
            visible: root._isGls
            anchors { top: parent.top; left: parent.left; right: parent.right }
            height: 1; radius: parent.radius; color: Theme.gmBorderHighlight
        }
        layer.enabled: root._isGls
        layer.effect: MultiEffect {
            shadowEnabled: true; shadowColor: Theme.gmDropShadow
            shadowBlur: Theme.gmShadowBlur * 0.4; shadowVerticalOffset: Theme.gmShadowOffset * 0.6
        }
    }

    contentItem: Text {
        text: root.text
        font.pixelSize: 12
        font.family: Theme.fontFamily
        color: root._fg
        wrapMode: Text.WordWrap
        leftPadding: 10; rightPadding: 10
        topPadding: 6; bottomPadding: 6
    }
}
