import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Button {
    id: root

    property string size: "md"

    checkable: true

    onToggled: {}

    readonly property int _h:    size === "sm" ? 24 : size === "lg" ? 36 : 28
    readonly property int _padH: size === "sm" ? 10 : size === "lg" ? 20 : 14
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13

    implicitHeight: _h
    implicitWidth:  contentItem.implicitWidth + _padH * 2

    readonly property color _bgColor:
        !enabled ? (Theme.isDark ? "#2A2A2C" : "#F0F0F0") :
        checked  ? (Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.22) : Qt.rgba(0, 0.44, 0.89, 0.12)) :
                   (Theme.isDark ? "#3A3A3C" : "#FFFFFF")

    readonly property color _fgColor:
        !enabled ? (Theme.isDark ? "#4A4A4E" : "#AAAAAA") :
        checked  ? (Theme.isDark ? "#0A84FF" : "#0071E3") :
                   Theme.text

    readonly property color _borderColor:
        checked ? (Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.5) : Qt.rgba(0, 0.44, 0.89, 0.35))
                : (Theme.isDark ? "#48484A" : "#D1D1D6")

    background: Rectangle {
        radius: root._r
        color:  root._bgColor
        border.color: root._borderColor
        border.width: 0.5

        Behavior on color        { ColorAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        Rectangle {
            visible: !root.checked
            anchors { top: parent.top; left: parent.left; right: parent.right }
            anchors.topMargin:   0.5
            anchors.leftMargin:  1
            anchors.rightMargin: 1
            height: 1
            radius: root._r
            color: Qt.rgba(1, 1, 1, Theme.isDark ? 0.08 : 0.85)
        }

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: root.pressed ? Qt.rgba(0, 0, 0, 0.08) : "transparent"
            Behavior on color { ColorAnimation { duration: 60 } }
        }
    }

    contentItem: Text {
        text:               root.text
        color:              root._fgColor
        font.pixelSize:     root._fs
        font.weight: root.checked ? Theme.weightSemiBold : Theme.weightMedium
        font.family:        Theme.fontFamily
        font.letterSpacing: -0.15
        renderType:         Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment:   Text.AlignVCenter

        Behavior on color { ColorAnimation { duration: Theme.durationFast } }
    }

    scale: pressed ? 0.97 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
    }

    focusPolicy: Qt.NoFocus
}