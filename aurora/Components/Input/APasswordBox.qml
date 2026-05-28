import QtQuick
import QtQuick.Controls
import aurora 1.0

TextField {
    id: root

    property string size: "md"
    property bool showPassword: false
    property bool hasError: false

    readonly property int _h:    size === "sm" ? 24 : size === "lg" ? 36 : 28
    readonly property int _padH: size === "sm" ?  8 : size === "lg" ? 14 : 10
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13
    readonly property int _btnW: size === "sm" ? 20 : size === "lg" ? 28 : 24

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass

    implicitHeight: _h
    implicitWidth:  160
    leftPadding: _padH; rightPadding: _btnW + 4
    verticalAlignment: TextInput.AlignVCenter
    echoMode: showPassword ? TextInput.Normal : TextInput.Password

    font.pixelSize: _fs; font.family: Theme.fontFamily
    color: enabled ? Theme.text : Theme.textSecondary
    selectionColor: Qt.rgba(0, 0.44, 0.89, 0.25)
    selectedTextColor: Theme.text

    readonly property color _bg: {
        if (!enabled) return Theme.isDark ? "#222224" : "#F5F5F5"
        if (_isNeu)  return Theme.background
        if (_isLiq)  return Qt.rgba(1, 1, 1, 0.08)
        return Theme.isDark ? "#1C1C1E" : "#FFFFFF"
    }

    readonly property color _border: {
        if (hasError)       return Theme.danger
        if (activeFocus)    return Theme.primary
        if (_isNeu)         return "transparent"
        if (_isLiq)         return Theme.border
        return Theme.isDark ? "#48484A" : "#D1D1D6"
    }

    placeholderTextColor: Theme.textSecondary

    background: Rectangle {
        radius: root._r
        color: root._bg
        border.color: root._border
        border.width: root._isNeu ? 0 : 0.5

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

        // 显示/隐藏按钮
        Rectangle {
            id: toggleBtn
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
            width: root._btnW
            radius: root._r
            color: "transparent"

            Text {
                anchors.centerIn: parent
                text: root.showPassword ? "◉" : "○"
                font.pixelSize: root._fs * 0.85
                font.family: Theme.fontFamily
                color: Theme.textSecondary
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.showPassword = !root.showPassword
            }
        }
    }
}
