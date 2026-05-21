import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Button {
    id: root

    property string variant: "secondary"  // secondary | primary | ghost | destructive
    property string size: "md"            // sm | md | lg
    property string iconSource: ""        // SVG 图标路径，留给图标系统
    property int    iconSize: _iconSz

    readonly property int _sz:     size === "sm" ? 28 : size === "lg" ? 40 : 32
    readonly property int _r:      size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _iconSz: size === "sm" ? 14 : size === "lg" ? 20 : 16

    implicitWidth:  _sz
    implicitHeight: _sz
    text: ""  // IconButton 没有文字

    readonly property color _bgColor: {
        if (!enabled) return Theme.isDark ? "#2A2A2C" : "#F0F0F0"
        switch (variant) {
            case "primary":     return Theme.isDark ? "#0A84FF" : "#0071E3"
            case "ghost":       return "transparent"
            case "destructive": return Theme.isDark ? "#FF453A" : "#FF3B30"
            default:            return Theme.isDark ? "#3A3A3C" : "#FFFFFF"
        }
    }

    readonly property color _fgColor: {
        if (!enabled) return Theme.isDark ? "#4A4A4E" : "#AAAAAA"
        switch (variant) {
            case "primary":     return "#FFFFFF"
            case "ghost":       return Theme.isDark ? "#0A84FF" : "#0071E3"
            case "destructive": return "#FFFFFF"
            default:            return Theme.text
        }
    }

    background: Rectangle {
        radius: root._r
        color:  root._bgColor
        border.color: root.variant === "secondary"
                      ? (Theme.isDark ? "#48484A" : "#D1D1D6")
                      : "transparent"
        border.width: root.variant === "secondary" ? 0.5 : 0

        Behavior on color { ColorAnimation { duration: Theme.durationFast } }

        Rectangle {
            visible: root.variant === "secondary"
            anchors { top: parent.top; left: parent.left; right: parent.right }
            anchors.topMargin: 0.5; anchors.leftMargin: 1; anchors.rightMargin: 1
            height: 1; radius: root._r
            color: Qt.rgba(1, 1, 1, Theme.isDark ? 0.08 : 0.85)
        }

        Rectangle {
            anchors.fill: parent; radius: parent.radius
            color: root.pressed ? Qt.rgba(0, 0, 0, 0.08)
                 : root.hovered && root.variant === "ghost"
                   ? Qt.rgba(0, 0.44, 0.89, 0.08) : "transparent"
            Behavior on color { ColorAnimation { duration: 60 } }
        }

        layer.enabled: root.variant === "primary" || root.variant === "secondary"
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor:   Qt.rgba(0, 0, 0, Theme.isDark ? 0.35 : 0.12)
            shadowBlur:    0.3
            shadowVerticalOffset: 1
        }
    }

    contentItem: Item {
        // 图标槽：等图标系统完成后替换为 AIcon
        Rectangle {
            anchors.centerIn: parent
            width:  root._iconSz
            height: root._iconSz
            radius: 2
            color:  root._fgColor
            opacity: 0.85
        }
    }

    scale: pressed ? 0.97 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
    }

    focusPolicy: Qt.NoFocus
}