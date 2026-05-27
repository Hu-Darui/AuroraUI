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
                    text: "Inputs"
                    font.pixelSize: 28; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ATextBox · APasswordBox · ATextArea · AComboBox · ASpinBox · ATextField · AInput"
                    font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                }
            }

            // ── ATextBox ──
            ACard {
                title: "ATextBox"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Row { spacing: 16
                        Column { spacing: 4
                            Text { text: "Default"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ATextBox { placeholderText: "Enter text..."; implicitWidth: 220 }
                        }
                        Column { spacing: 4
                            Text { text: "With text"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ATextBox { text: "Hello World"; implicitWidth: 220 }
                        }
                    }
                    Row { spacing: 16
                        Column { spacing: 4
                            Text { text: "Disabled"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ATextBox { placeholderText: "Disabled..."; enabled: false; implicitWidth: 220 }
                        }
                        Column { spacing: 4
                            Text { text: "Error"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.danger }
                            ATextBox { text: "Invalid input"; hasError: true; implicitWidth: 220 }
                        }
                    }
                    Row { spacing: 16
                        Column { spacing: 4
                            Text { text: "Small"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ATextBox { placeholderText: "Small input"; size: "sm"; implicitWidth: 220 }
                        }
                        Column { spacing: 4
                            Text { text: "Large"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ATextBox { placeholderText: "Large input"; size: "lg"; implicitWidth: 220 }
                        }
                    }
                }
            }

            // ── APasswordBox ──
            ACard {
                title: "APasswordBox"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 16
                    Column { spacing: 4
                        Text { text: "Password"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        APasswordBox { placeholderText: "Enter password..."; implicitWidth: 240 }
                    }
                }
            }

            // ── ATextArea ──
            ACard {
                title: "ATextArea"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Column { spacing: 4
                        Text { text: "Multi-line"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        ATextArea { placeholderText: "Type your message here..."; implicitWidth: parent.width - 40 }
                    }
                    Column { spacing: 4
                        Text { text: "Large + Read-only"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        ATextArea {
                            text: "This is read-only content.\nMultiple lines of text\ndisplayed here."
                            readOnly: true; size: "lg"
                            implicitWidth: parent.width - 40
                        }
                    }
                }
            }

            // ── AComboBox ──
            ACard {
                title: "AComboBox"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 16
                    Column { spacing: 4
                        Text { text: "Select"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        AComboBox { model: ["Option A", "Option B", "Option C", "Option D"]; implicitWidth: 220 }
                    }
                    Column { spacing: 4
                        Text { text: "Small"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        AComboBox { model: ["Small A", "Small B", "Small C"]; size: "sm"; implicitWidth: 180 }
                    }
                }
            }

            // ── ASpinBox ──
            ACard {
                title: "ASpinBox"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 32
                    Column { spacing: 4
                        Text { text: "0–100"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        ASpinBox { from: 0; to: 100; value: 42; implicitWidth: 120 }
                    }
                    Column { spacing: 4
                        Text { text: "Percentage"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        ASpinBox { from: 0; to: 100; value: 75; stepSize: 5; implicitWidth: 120 }
                    }
                }
            }

            // ── ATextField ──
            ACard {
                title: "ATextField (with Label / Error)"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Row { spacing: 16
                        Column { spacing: 4
                            Text { text: "Name"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ATextField { label: "Name"; placeholderText: "Your name"; implicitWidth: 220 }
                        }
                        Column { spacing: 4
                            Text { text: "Email — Error"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.danger }
                            ATextField { label: "Email"; placeholderText: "user@mail.com"; errorText: "Invalid email format"; implicitWidth: 220 }
                        }
                    }
                }
            }
        }
    }
}
