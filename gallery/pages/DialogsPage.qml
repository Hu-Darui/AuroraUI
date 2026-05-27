import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: "transparent"
    anchors.fill: parent

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        contentHeight: contentColumn.implicitHeight + 60

        Column {
            id: contentColumn
            width: parent.width
            spacing: 28
            topPadding: 40

            // ── 页头 ──
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 4
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Dialogs"
                    font.pixelSize: 28; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ADialog — Message · Confirmation · Content · Input"
                    font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                }
            }

            // ── ADialog Types ──
            ACard {
                title: "ADialog — Open Examples"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 12; width: parent.width
                    Text {
                        text: "Click a button to open the corresponding dialog."
                        font.pixelSize: 13; font.family: Theme.fontFamily; color: Theme.textSecondary
                        wrapMode: Text.WordWrap
                    }

                    Row { spacing: 12
                        AButton { text: "Message"; variant: "primary"; onClicked: msgLoader.active = true }
                        AButton { text: "Confirmation"; variant: "secondary"; onClicked: confirmLoader.active = true }
                        AButton { text: "Custom Content"; variant: "secondary"; onClicked: contentLoader.active = true }
                        AButton { text: "Input Prompt"; variant: "secondary"; onClicked: inputLoader.active = true }
                    }
                }
            }

            // ── 对话框使用说明 ──
            ACard {
                title: "Dialog Types"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 14; width: parent.width
                    Row { spacing: 14
                        Rectangle {
                            width: 36; height: 36; radius: 18
                            color: Qt.rgba(0, 0.44, 0.89, 0.10)
                            Text { anchors.centerIn: parent; text: "i"; font.pixelSize: 17; font.weight: Font.Bold; font.family: Theme.fontFamily; color: Theme.primary }
                        }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2
                            Text { text: "Message"; font.pixelSize: 14; font.weight: Theme.weightSemiBold; font.family: Theme.fontFamily; color: Theme.text }
                            Text { text: "Simple informational dialog with an OK button."; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        }
                    }
                    Row { spacing: 14
                        Rectangle {
                            width: 36; height: 36; radius: 18
                            color: Qt.rgba(0.95, 0.60, 0.10, 0.10)
                            Text { anchors.centerIn: parent; text: "!"; font.pixelSize: 17; font.weight: Font.Bold; font.family: Theme.fontFamily; color: Theme.warning }
                        }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2
                            Text { text: "Confirmation"; font.pixelSize: 14; font.weight: Theme.weightSemiBold; font.family: Theme.fontFamily; color: Theme.text }
                            Text { text: "Confirm/Cancel dialog with accepted/rejected signals."; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        }
                    }
                    Row { spacing: 14
                        Rectangle {
                            width: 36; height: 36; radius: 18
                            color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.05)
                            Text { anchors.centerIn: parent; text: "◰"; font.pixelSize: 17; font.weight: Font.Bold; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2
                            Text { text: "Content"; font.pixelSize: 14; font.weight: Theme.weightSemiBold; font.family: Theme.fontFamily; color: Theme.text }
                            Text { text: "Fully customizable dialog body with any QML content."; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        }
                    }
                    Row { spacing: 14
                        Rectangle {
                            width: 36; height: 36; radius: 18
                            color: Qt.rgba(0.20, 0.80, 0.45, 0.10)
                            Text { anchors.centerIn: parent; text: "?"; font.pixelSize: 17; font.weight: Font.Bold; font.family: Theme.fontFamily; color: Theme.success }
                        }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2
                            Text { text: "Input"; font.pixelSize: 14; font.weight: Theme.weightSemiBold; font.family: Theme.fontFamily; color: Theme.text }
                            Text { text: "Prompt with text input, emits inputConfirmed(text)."; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        }
                    }
                }
            }
        }
    }

    // ═══════════════════════════════════════
    // Dialog Loaders
    // ═══════════════════════════════════════
    Loader {
        id: msgLoader
        active: false
        sourceComponent: ADialog {
            dialogType: "message"
            title: "Information"
            message: "Your changes have been saved successfully."
            onClosed: msgLoader.active = false
        }
        onLoaded: item.open()
    }

    Loader {
        id: confirmLoader
        active: false
        sourceComponent: ADialog {
            dialogType: "confirmation"
            title: "Confirm Action"
            message: "Are you sure you want to delete this item? This action cannot be undone."
            onAccepted: console.log("Confirmed")
            onRejected: console.log("Cancelled")
            onClosed: confirmLoader.active = false
        }
        onLoaded: item.open()
    }

    Loader {
        id: contentLoader
        active: false
        sourceComponent: ADialog {
            dialogType: "content"
            title: "Custom Content"

            Column {
                spacing: 12
                Text {
                    text: "Any QML content can go here."
                    font.pixelSize: 14; font.family: Theme.fontFamily
                    color: Theme.text; wrapMode: Text.WordWrap; width: parent.width
                }
                Text {
                    text: "Use this for custom forms, settings, or information displays."
                    font.pixelSize: 13; font.family: Theme.fontFamily
                    color: Theme.textSecondary; wrapMode: Text.WordWrap; width: parent.width
                }
                Rectangle {
                    width: parent.width; height: 1
                    color: Theme.isDark ? Qt.rgba(1,1,1,0.08) : Qt.rgba(0,0,0,0.06)
                }
                Row { spacing: 8
                    Text { text: "Status:"; font.pixelSize: 13; font.family: Theme.fontFamily; color: Theme.text }
                    Text { text: "Connected"; font.pixelSize: 13; font.family: Theme.fontFamily; color: Theme.success; font.weight: Font.Medium }
                }
            }
        }
        onLoaded: item.open()
    }

    Loader {
        id: inputLoader
        active: false
        sourceComponent: ADialog {
            dialogType: "input"
            title: "Rename Item"
            message: "Enter a new name for this item:"
            inputPlaceholder: "New name..."
            onInputConfirmed: function(text) { console.log("New name:", text) }
            onClosed: inputLoader.active = false
        }
        onLoaded: item.open()
    }
}
