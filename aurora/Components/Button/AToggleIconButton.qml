import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Button {
    id: root

    property string size: "md"
    property string iconSource: ""      // 图标路径，暂用占位矩形
    property int    iconSize:   _iconSz

    checkable: true

    readonly property int _sz:     size === "sm" ? 28 : size === "lg" ? 40 : 32
    readonly property int _r:      size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _iconSz: size === "sm" ? 14 : size === "lg" ? 20 : 16

    implicitWidth:  _sz
    implicitHeight: _sz

    readonly property color _bgColor:
        !enabled ? (Theme.isDark ? "#2A2A2C" : "#F0F0F0") :
        checked  ? (Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.22) : Qt.rgba(0, 0.44, 0.89, 0.12)) :
        hovered  ? (Theme.isDark ? "#3A3A3C" : "#F0F0F0") :
                   "transparent"

    readonly property color _fgColor:
        !enabled ? (Theme.isDark ? "#4A4A4E" : "#AAAAAA") :
        checked  ? (Theme.isDark ? "#0A84FF" : "#0071E3") :
                   Theme.textSecondary

    readonly property color _borderColor:
        checked ? (Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.5) : Qt.rgba(0, 0.44, 0.89, 0.35))
                : "transparent"

    background: Rectangle {
        radius: root._r
        color:  root._bgColor
        border.color: root._borderColor
        border.width: 0.5

        Behavior on color        { ColorAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: root.pressed ? Qt.rgba(0, 0, 0, 0.08) : "transparent"
            Behavior on color { ColorAnimation { duration: 60 } }
        }
    }

    contentItem: Item {
        // 图标占位，等图标系统完成后替换为 AIcon { }
        Rectangle {
            anchors.centerIn: parent
            width:  root._iconSz
            height: root._iconSz
            radius: 3
            color:  root._fgColor

            Behavior on color { ColorAnimation { duration: 150 } }
        }
    }

    scale: pressed ? 0.97 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
    }

    focusPolicy: Qt.NoFocus
}