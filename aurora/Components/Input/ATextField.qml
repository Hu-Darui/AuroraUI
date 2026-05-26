import QtQuick
import QtQuick.Controls
import aurora 1.0

Control {
    id: root

    property alias label: labelText.text
    property alias placeholderText: textBox.placeholderText
    property alias text: textBox.text
    property alias readOnly: textBox.readOnly
    property alias echoMode: textBox.echoMode
    property string helperText: ""
    property string errorText: ""
    property string size: "md"
    default property alias _content: textBox

    readonly property int _fs: size === "sm" ? 11 : size === "lg" ? 13 : 12
    readonly property int _gap: size === "sm" ? 4  : size === "lg" ? 8  : 6

    implicitHeight: col.implicitHeight
    implicitWidth: 180

    padding: 0

    readonly property bool _hasHelper: helperText !== "" && errorText === ""
    readonly property bool _hasError:  errorText !== ""

    contentItem: Column {
        id: col
        spacing: root._gap

        Text {
            id: labelText
            visible: text !== ""
            font.pixelSize: root._fs; font.family: Theme.fontFamily
            font.weight: Theme.weightMedium
            color: root._hasError ? Theme.danger : Theme.text
        }

        ATextBox {
            id: textBox
            size: root.size
            hasError: root._hasError
            implicitWidth: root.implicitWidth
        }

        Text {
            visible: root._hasHelper || root._hasError
            font.pixelSize: root._fs - 1; font.family: Theme.fontFamily
            color: root._hasError ? Theme.danger : Theme.textSecondary
            text: root._hasError ? root.errorText : root.helperText
        }
    }
}
