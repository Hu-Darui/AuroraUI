import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Button {
    id: root

    property string variant: "primary"
    property string size: "md"
    property bool loading: false

    readonly property int _h:    size === "sm" ? 24 : size === "lg" ? 36 : 28
    readonly property int _padH: size === "sm" ? 10 : size === "lg" ? 20 : 14
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13

    implicitHeight: _h
    implicitWidth:  contentItem.implicitWidth + _padH * 2

    readonly property color _bgColor:
        !enabled         ? (Theme.isDark ? "#2A2A2C" : "#F0F0F0") :
        variant === "primary"     ? (Theme.isDark ? "#0A84FF" : "#0071E3") :
        variant === "secondary"   ? (Theme.isDark ? "#3A3A3C" : "#FFFFFF") :
        variant === "tinted"      ? (Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.18) : Qt.rgba(0, 0.44, 0.89, 0.10)) :
        variant === "destructive" ? (Theme.isDark ? "#FF453A" : "#FF3B30") :
                                    "transparent"

    readonly property color _fgColor:
        !enabled                  ? (Theme.isDark ? "#4A4A4E" : "#AAAAAA") :
        variant === "primary"     ? "#FFFFFF" :
        variant === "secondary"   ? Theme.text :
        variant === "tinted"      ? (Theme.isDark ? "#0A84FF" : "#0071E3") :
        variant === "destructive" ? "#FFFFFF" :
                                    (Theme.isDark ? "#0A84FF" : "#0071E3")

    background: Rectangle {
        radius: root._r
        color:  root._bgColor

        Behavior on color { ColorAnimation { duration: Theme.durationFast } }

        Rectangle {
            visible: root.variant === "secondary" || root.variant === "primary"
                  || root.variant === "destructive"
            anchors { top: parent.top; left: parent.left; right: parent.right }
            anchors.topMargin: 0.5
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            height: 1
            radius: root._r
            color: Qt.rgba(1, 1, 1, root.variant === "secondary" ? 0.85 : 0.22)
        }

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: root.pressed ? Qt.rgba(0, 0, 0, 0.08) : "transparent"
            Behavior on color { ColorAnimation { duration: 60 } }
        }

        Rectangle {
            visible: root.variant === "secondary" || root.variant === "ghost"
                  || root.variant === "tinted"
            anchors.fill: parent
            radius: parent.radius
            color: root.hovered && !root.pressed
                   ? Qt.rgba(0, 0, 0, Theme.isDark ? 0.06 : 0.04)
                   : "transparent"
            Behavior on color { ColorAnimation { duration: 100 } }
        }

        border.color: root.variant === "secondary"
                      ? (Theme.isDark ? "#48484A" : "#D1D1D6")
                      : root.variant === "ghost"
                        ? (Theme.isDark ? "#0A84FF" : "#0071E3")
                        : "transparent"
        border.width: root.variant === "secondary" || root.variant === "ghost" ? 0.5 : 0

        layer.enabled: root.variant === "primary" || root.variant === "secondary"
                    || root.variant === "destructive"
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor:   Qt.rgba(0, 0, 0, Theme.isDark ? 0.35 : 0.15)
            shadowBlur:    0.3
            shadowVerticalOffset: 1
        }
    }

    contentItem: Row {
        spacing: 5
        anchors.centerIn: parent

        Rectangle {
            visible: root.loading
            width: 12; height: 12
            radius: 6
            color: "transparent"
            border.color: root._fgColor
            border.width: 1.5
            anchors.verticalCenter: parent.verticalCenter

            RotationAnimator on rotation {
                running:  root.loading
                from: 0; to: 360
                duration: 800
                loops: Animation.Infinite
            }
        }

        Text {
            text:               root.text
            color:              root._fgColor
            font.pixelSize:     root._fs
            font.weight:        Font.Medium
            font.family:        Theme.fontFamily
            font.letterSpacing: -0.15
            renderType:         Text.NativeRendering
            anchors.verticalCenter: parent.verticalCenter

            Behavior on color { ColorAnimation { duration: Theme.durationFast } }
        }
    }

    scale: pressed ? 0.97 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
    }

    focusPolicy: Qt.NoFocus
}