import QtQuick
import QtQuick.Controls
import aurora 1.0

ScrollView {
    id: root

    property alias text: textArea.text
    property alias placeholderText: textArea.placeholderText
    property alias readOnly: textArea.readOnly
    property string size: "md"
    property bool hasError: false
    property int minLines: 3

    readonly property int _h:    size === "sm" ? 72 : size === "lg" ? 108 : 84
    readonly property int _pad:  size === "sm" ?  8 : size === "lg" ? 14 : 10
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    implicitHeight: _h
    implicitWidth:  160

    TextArea {
        id: textArea
        leftPadding: root._pad; rightPadding: root._pad
        topPadding: root._pad;  bottomPadding: root._pad
        wrapMode: TextArea.Wrap

        font.pixelSize: root._fs; font.family: Theme.fontFamily
        color: enabled ? Theme.text : Theme.textSecondary
        selectionColor: Qt.rgba(0, 0.44, 0.89, 0.25)
        selectedTextColor: Theme.text

        placeholderTextColor: Theme.textSecondary

        readonly property color _bg: {
            if (!enabled) return Theme.isDark ? "#222224" : "#F5F5F5"
            if (root._isNeu)  return Theme.background
            if (root._isLiq)  return Qt.rgba(1, 1, 1, 0.08)
            if (root._isGls)  return Qt.rgba(1, 1, 1, 0.07)
            return Theme.isDark ? "#1C1C1E" : "#FFFFFF"
        }

        readonly property color _border: {
            if (root.hasError)    return Theme.danger
            if (activeFocus)      return Theme.primary
            if (root._isNeu)      return "transparent"
            if (root._isLiq)      return Theme.border
            if (root._isGls)      return Qt.rgba(1, 1, 1, 0.10)
            return Theme.isDark ? "#48484A" : "#D1D1D6"
        }

        background: Rectangle {
            radius: root._r
            color: textArea._bg
            border.color: textArea._border
            border.width: root._isNeu ? 0 : root._isGls ? 0.8 : 0.5

            Behavior on border.color { ColorAnimation { duration: 80 } }

            Rectangle {
                visible: root._isNeu && !textArea.activeFocus
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
                color: textArea.activeFocus ? Qt.rgba(1,1,1,0.25) : Qt.rgba(1,1,1,0.06)
            }
        }
    }
}
