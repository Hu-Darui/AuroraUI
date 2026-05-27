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
                    text: "Buttons"
                    font.pixelSize: 28; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "AButton · AIconButton · AToggleButton · AToggleIconButton · ASplitButton · FAB · ARadioButton"
                    font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                }
            }

            // ── AButton Variants ──
            ACard {
                title: "AButton — Variants"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Flow { width: parent.width; spacing: 14
                        AButton { text: "Primary";     variant: "primary" }
                        AButton { text: "Secondary";   variant: "secondary" }
                        AButton { text: "Tinted";      variant: "tinted" }
                        AButton { text: "Ghost";       variant: "ghost" }
                        AButton { text: "Destructive"; variant: "destructive" }
                        AButton { text: "Disabled";    enabled: false }
                        AButton { text: "Loading";     loading: true }
                    }
                }
            }

            // ── AButton Sizes ──
            ACard {
                title: "AButton — Sizes"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Row { spacing: 12
                        AButton { text: "Small";  size: "sm" }
                        AButton { text: "Small Primary"; size: "sm"; variant: "primary" }
                        AButton { text: "Small Ghost"; size: "sm"; variant: "ghost" }
                    }
                    Row { spacing: 12
                        AButton { text: "Medium"; size: "md" }
                        AButton { text: "Medium Primary"; size: "md"; variant: "primary" }
                        AButton { text: "Medium Ghost"; size: "md"; variant: "ghost" }
                    }
                    Row { spacing: 12
                        AButton { text: "Large";  size: "lg" }
                        AButton { text: "Large Primary"; size: "lg"; variant: "primary" }
                        AButton { text: "Large Ghost"; size: "lg"; variant: "ghost" }
                    }
                }
            }

            // ── AIconButton ──
            ACard {
                title: "AIconButton"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Flow { width: parent.width; spacing: 10
                        AIconButton { variant: "secondary"; size: "sm" }
                        AIconButton { variant: "secondary"; size: "md" }
                        AIconButton { variant: "secondary"; size: "lg" }
                        AIconButton { variant: "primary"; size: "md" }
                        AIconButton { variant: "ghost"; size: "md" }
                        AIconButton { variant: "destructive"; size: "md" }
                    }
                }
            }

            // ── AToggleButton ──
            ACard {
                title: "AToggleButton"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Row { spacing: 12
                        AToggleButton { text: "Toggle" }
                        AToggleButton { text: "Active"; checked: true }
                        AToggleButton { text: "Disabled"; enabled: false }
                    }
                }
            }

            // ── ASwitch ──
            ACard {
                title: "ASwitch"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 32
                    Column { spacing: 6
                        ASwitch { id: sw1 }
                        Text { text: sw1.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 6
                        ASwitch { id: sw2; checked: true }
                        Text { text: sw2.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 6
                        ASwitch { id: sw3; enabled: false }
                        Text { text: "Disabled"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 6
                        ASwitch { id: sw4; size: "sm"; checked: true }
                        Text { text: "Small"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 6
                        ASwitch { id: sw5; size: "lg" }
                        Text { text: "Large"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                }
            }

            // ── ARadioButton ──
            ACard {
                title: "ARadioButton"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 8
                    ARadioButton { text: "Option A" }
                    ARadioButton { text: "Option B"; checked: true }
                    ARadioButton { text: "Option C (disabled)"; enabled: false }
                }
            }

            // ── FABButton ──
            ACard {
                title: "FABButton"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 16
                    FABButton { variant: "primary" }
                    FABButton { variant: "secondary" }
                    FABButton { variant: "tertiary" }
                }
            }
        }
    }
}
