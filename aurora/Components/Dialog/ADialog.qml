import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Dialog {
    id: root

    property string dialogType: "message"
    property string message: ""
    property alias inputText: inputField.text
    property alias inputPlaceholder: inputField.placeholderText
    default property alias dialogContent: contentArea.data

    signal inputConfirmed(string text)

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass

    modal: true
    closePolicy: Popup.CloseOnEscape
    implicitWidth: 400
    topPadding: 0; bottomPadding: 0; leftPadding: 0; rightPadding: 0
    implicitHeight: contentCol.implicitHeight

    readonly property color _bg: {
        if (_isLiq) return Qt.rgba(1, 1, 1, Theme.isDark ? 0.10 : 0.92)
        return Theme.isDark ? "#2C2C30" : "#FFFFFF"
    }

    readonly property color _iconBg: {
        switch (dialogType) {
            case "message":      return Qt.rgba(0, 0.44, 0.89, 0.10)
            case "confirmation": return Qt.rgba(0.95, 0.60, 0.10, 0.10)
            case "input":        return Qt.rgba(0.20, 0.80, 0.45, 0.10)
            default:             return "transparent"
        }
    }
    readonly property color _iconFg: {
        switch (dialogType) {
            case "message":      return Theme.primary
            case "confirmation": return Theme.warning
            case "input":        return Theme.success
            default:             return Theme.text
        }
    }
    readonly property string _iconText: {
        switch (dialogType) {
            case "message":      return "i"
            case "confirmation": return "!"
            case "input":        return "?"
            default:             return ""
        }
    }

    background: Rectangle {
        radius: Theme.radiusLg
        color: root._bg

        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; topMargin: -6; leftMargin: -6 }
            radius: parent.radius + 6; color: Theme.neuLightShadow
        }
        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; bottomMargin: -6; rightMargin: -6 }
            radius: parent.radius + 6; color: Theme.neuDarkShadow
        }
        layer.enabled: !root._isNeu
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Qt.rgba(0, 0, 0, Theme.isDark ? 0.5 : 0.18)
            shadowBlur: 0.6
            shadowVerticalOffset: 8
        }
    }

    Overlay.modal: Rectangle {
        color: Qt.rgba(0, 0, 0, 0.35)
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    contentItem: Column {
        id: contentCol
        spacing: 0

        // ── 头部 ──
        Row {
            spacing: 14
            padding: 24

            Rectangle {
                visible: root._iconBg !== "transparent"
                width: 36; height: 36; radius: 18
                color: root._iconBg
                Text {
                    anchors.centerIn: parent
                    text: root._iconText
                    font.pixelSize: 17; font.weight: Font.Bold
                    font.family: Theme.fontFamily; color: root._iconFg
                }
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2
                Text {
                    text: root.title
                    font.pixelSize: 17; font.weight: Theme.weightSemiBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    visible: root.message !== ""
                    text: root.message
                    font.pixelSize: 13; font.family: Theme.fontFamily
                    color: Theme.textSecondary; width: 280
                    wrapMode: Text.WordWrap; maximumLineCount: 2; elide: Text.ElideRight
                }
            }
        }

        // ── 输入 / 内容区 ──
        Item {
            visible: root.dialogType === "input" || root.dialogType === "content"
            width: parent.width
            implicitHeight: Math.max(inputField.implicitHeight, contentArea.implicitHeight) + 8

            ATextBox {
                id: inputField
                visible: root.dialogType === "input"
                anchors { left: parent.left; leftMargin: 24; right: parent.right; rightMargin: 24 }
                y: 4
                placeholderText: "Enter text..."
                onAccepted: root.inputConfirmed(text)
            }

            Item {
                id: contentArea
                visible: root.dialogType === "content"
                anchors { left: parent.left; leftMargin: 24; right: parent.right; rightMargin: 24 }
                y: 4
                implicitHeight: childrenRect.height
            }
        }

        // ── 分隔线 ──
        Rectangle {
            width: parent.width; height: 0.5
            color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(0, 0, 0, 0.06)
        }

        // ── 底部按钮 ──
        Item {
            visible: root.dialogType !== "content"
            width: parent.width
            implicitHeight: 52

            Row {
                anchors { right: parent.right; rightMargin: 16; verticalCenter: parent.verticalCenter }
                spacing: 8
                layoutDirection: Qt.RightToLeft

                AButton {
                    text: root.dialogType === "confirmation" || root.dialogType === "input" ? "Cancel" : "OK"
                    variant: root.dialogType === "message" ? "primary" : "secondary"
                    size: "sm"
                    onClicked: { root.accept(); root.close() }
                }

                AButton {
                    visible: root.dialogType === "confirmation"
                    text: "Confirm"; variant: "primary"; size: "sm"
                    onClicked: { root.accept(); root.close() }
                }

                AButton {
                    visible: root.dialogType === "input"
                    text: "Submit"; variant: "primary"; size: "sm"
                    onClicked: { root.inputConfirmed(root.inputText); root.close() }
                }
            }
        }
    }
}
