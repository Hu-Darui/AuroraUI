import QtQuick
import QtQuick.Controls
import aurora 1.0

SpinBox {
    id: root

    property string size: "md"

    readonly property int _h:    size === "sm" ? 24 : size === "lg" ? 36 : 28
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13
    readonly property int _btnW: size === "sm" ? 22 : size === "lg" ? 32 : 26

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    implicitHeight: _h
    implicitWidth:  120
    editable: true

    font.pixelSize: _fs; font.family: Theme.fontFamily

    readonly property color _bg: {
        if (!enabled) return Theme.isDark ? "#222224" : "#F5F5F5"
        if (_isNeu)  return Theme.background
        if (_isLiq)  return Qt.rgba(1, 1, 1, 0.08)
        if (_isGls)  return Qt.rgba(1, 1, 1, 0.07)
        return Theme.isDark ? "#1C1C1E" : "#FFFFFF"
    }

    readonly property color _border: {
        if (activeFocus)    return Theme.primary
        if (_isNeu)         return "transparent"
        if (_isLiq)         return Theme.border
        if (_isGls)         return Qt.rgba(1, 1, 1, 0.10)
        return Theme.isDark ? "#48484A" : "#D1D1D6"
    }

    readonly property color _btnBg: {
        if (_isLiq) return Qt.rgba(1, 1, 1, 0.06)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.04)
        return Theme.isDark ? "#2A2A2E" : "#F0F0F0"
    }

    contentItem: TextInput {
        text: root.displayText
        font: root.font
        color: enabled ? Theme.text : Theme.textSecondary
        selectionColor: Qt.rgba(0, 0.44, 0.89, 0.25)
        selectedTextColor: Theme.text
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        readOnly: !root.editable
        validator: root.validator
        inputMethodHints: root.inputMethodHints
    }

    background: Rectangle {
        radius: root._r
        color: root._bg
        border.color: root._border
        border.width: root._isNeu ? 0 : root._isGls ? 0.8 : 0.5

        Behavior on border.color { ColorAnimation { duration: 80 } }

        Rectangle {
            visible: root._isNeu && !root.activeFocus
            anchors.fill: parent; radius: parent.radius; color: "transparent"
            border.color: Theme.neuInsetDark; border.width: 1
            Rectangle {
                anchors { fill: parent; topMargin: 0.5; leftMargin: 0.5 }
                radius: parent.radius; color: "transparent"
                border.color: Theme.neuInsetLight; border.width: 0.5
            }
        }

        Rectangle {
            visible: root._isGls
            anchors { top: parent.top; left: parent.left; right: parent.right }
            height: 1; radius: parent.radius
            color: root.activeFocus ? Qt.rgba(1,1,1,0.25) : Qt.rgba(1,1,1,0.06)
        }
    }

    // ── 自定义增减按钮 ──
    up.indicator: Rectangle {
        x: parent.width - width - 1
        y: 1
        width: root._btnW; height: parent.height / 2 - 1
        radius: root._r
        color: root.up.pressed ? Qt.rgba(0, 0, 0, 0.08) : root._btnBg

        Text {
            anchors.centerIn: parent
            text: "▴"; font.pixelSize: root._fs * 0.65
            font.family: Theme.fontFamily; color: Theme.textSecondary
        }

        Rectangle {
            anchors { top: parent.top; right: parent.right; bottom: parent.bottom }
            width: root._r; color: parent.color
        }
    }

    down.indicator: Rectangle {
        x: parent.width - width - 1
        y: parent.height / 2
        width: root._btnW; height: parent.height / 2 - 1
        radius: root._r
        color: root.down.pressed ? Qt.rgba(0, 0, 0, 0.08) : root._btnBg

        Text {
            anchors.centerIn: parent
            text: "▾"; font.pixelSize: root._fs * 0.65
            font.family: Theme.fontFamily; color: Theme.textSecondary
        }

        Rectangle {
            anchors { top: parent.top; right: parent.right; bottom: parent.bottom }
            width: root._r; color: parent.color
        }
    }
}
