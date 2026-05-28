import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Slider {
    id: root

    property string size: "md"

    readonly property int _th:  size === "sm" ? 3 : size === "lg" ? 6 : 4
    readonly property int _kh:  size === "sm" ? 14 : size === "lg" ? 24 : 18
    readonly property real _r: size === "sm" ? 1.5 : size === "lg" ? 3 : 2

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    implicitHeight: Math.max(_th, _kh)

    readonly property color _trackColor: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Theme.isDark ? Qt.rgba(1, 1, 1, 0.10) : Qt.rgba(0, 0, 0, 0.08)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.10)
        return Theme.isDark ? "#3A3A3C" : "#E0E0E0"
    }

    readonly property color _fillColor: {
        if (_isNeu) return Theme.primary
        if (_isLiq) return Theme.primary
        if (_isGls) return "#818CF8"
        return Theme.primary
    }

    readonly property color _handleColor: {
        if (_isNeu) return Theme.elevated
        if (_isLiq) return Theme.isDark ? Qt.rgba(1, 1, 1, 0.90) : Qt.rgba(1, 1, 1, 0.95)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.92)
        return Theme.isDark ? "#F0F0F0" : "#FFFFFF"
    }

    background: Item {
        implicitWidth: 200
        implicitHeight: root.implicitHeight

        // Track
        Rectangle {
            anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right }
            height: root._th
            radius: root._r
            color: root._trackColor

            // Neumorphism: inset track
            Rectangle {
                visible: root._isNeu
                anchors.fill: parent; radius: parent.radius; color: "transparent"
                border.color: Theme.neuInsetDark; border.width: 1
            }

            // Fill
            Rectangle {
                width: parent.width * root.position
                height: parent.height
                radius: parent.radius
                color: root._fillColor

                // Glassmorphism: fill highlight
                Rectangle {
                    visible: root._isGls
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: 0.6; radius: parent.radius; color: Theme.gmBorderHighlight
                }
            }
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        width: root._kh
        height: root._kh
        radius: width / 2
        color: root._handleColor

        // Neumorphism: raised handle
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

        // Drop shadow
        layer.enabled: !root._isNeu
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: root._isGls || root._isLiq
                ? Qt.rgba(0, 0, 0, 0.22)
                : Qt.rgba(0, 0, 0, Theme.isDark ? 0.4 : 0.15)
            shadowBlur: 0.3
            shadowVerticalOffset: 1
        }
    }
}
