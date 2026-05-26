import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Item {
    id: root

    property bool checked: false
    property string size: "md"
    property bool enabled: true

    signal toggled(bool checked)

    // ── 尺寸 ──
    readonly property int _kw: size === "sm" ? 16 : size === "lg" ? 24 : 20
    readonly property int _tw: size === "sm" ? 36 : size === "lg" ? 52 : 44
    readonly property int _th: size === "sm" ? 20 : size === "lg" ? 28 : 24
    readonly property int _pad: size === "sm" ? 2  : size === "lg" ? 3  : 2

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    implicitWidth: _tw
    implicitHeight: _th

    // ── 轨道颜色 ──
    readonly property color _trackOn: {
        if (_isNeu) return Theme.primary
        if (_isLiq) return Qt.rgba(0.65, 0.55, 0.95, 0.8)
        if (_isGls) return Qt.rgba(0.39, 0.33, 0.95, 0.65)
        return Theme.isDark ? "#0A84FF" : "#0071E3"
    }
    readonly property color _trackOff: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Qt.rgba(1, 1, 1, 0.12)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.10)
        return Theme.isDark ? "#3A3A3C" : "#E0E0E0"
    }

    // ── 旋钮颜色 ──
    readonly property color _knobColor: {
        if (_isNeu) return Theme.elevated
        if (_isLiq) return Qt.rgba(1, 1, 1, 0.95)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.92)
        return Theme.isDark ? "#F0F0F0" : "#FFFFFF"
    }

    // ── 轨道 ──
    Rectangle {
        id: track
        anchors.fill: parent
        radius: _th / 2
        color: root.checked ? _trackOn : _trackOff

        Behavior on color { ColorAnimation { duration: Theme.durationFast } }

        // Neumorphism off: 凹陷感
        Rectangle {
            visible: _isNeu && !root.checked
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.color: Theme.neuInsetDark
            border.width: 1
            Rectangle {
                anchors { fill: parent; topMargin: 0.5; leftMargin: 0.5 }
                radius: parent.radius
                color: "transparent"
                border.color: Theme.neuInsetLight
                border.width: 0.5
            }
        }

        // Neumorphism on: 凸起感
        Rectangle {
            visible: _isNeu && root.checked
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.color: Theme.neuLightShadow
            border.width: 1
        }

        // Glassmorphism: 高光边框
        Rectangle {
            visible: _isGls
            anchors { top: parent.top; left: parent.left; right: parent.right }
            height: 1.2
            radius: parent.radius
            color: root.checked ? Qt.rgba(1, 1, 1, 0.3) : Qt.rgba(1, 1, 1, 0.08)
        }

        // Liquid Glass: 渐变覆盖
        Rectangle {
            visible: _isLiq && root.checked
            anchors.fill: parent
            radius: parent.radius
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.lgGradientA }
                GradientStop { position: 1.0; color: Theme.lgGradientC }
            }
            opacity: 0.5
        }
    }

    // ── 旋钮 ──
    Rectangle {
        id: knob
        width: _kw
        height: _kw
        radius: _kw / 2
        color: _knobColor
        y: _pad
        x: root.checked ? _tw - _kw - _pad : _pad

        Behavior on x {
            NumberAnimation { duration: Theme.durationFast; easing.type: Easing.InOutCubic }
        }

        // Neumorphism: 旋钮凸起
        Rectangle {
            visible: _isNeu
            anchors { fill: parent; topMargin: -1.5; leftMargin: -1.5 }
            radius: parent.radius + 1.5
            color: Theme.neuLightShadow
        }
        Rectangle {
            visible: _isNeu
            anchors { fill: parent; bottomMargin: -1.5; rightMargin: -1.5 }
            radius: parent.radius + 1.5
            color: Theme.neuDarkShadow
        }

        // Default: 微投影
        layer.enabled: !_isNeu
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: _isGls || _isLiq
                ? Qt.rgba(0, 0, 0, 0.22)
                : Qt.rgba(0, 0, 0, Theme.isDark ? 0.4 : 0.15)
            shadowBlur: 0.3
            shadowVerticalOffset: 1
        }
    }

    // ── 点击 ──
    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        onClicked: {
            root.checked = !root.checked
            root.toggled(root.checked)
        }
    }

    HoverHandler {
        enabled: root.enabled && !_isNeu
        cursorShape: Qt.PointingHandCursor
    }
}
