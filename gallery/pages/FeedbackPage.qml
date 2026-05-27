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

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 4
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Feedback"
                    font.pixelSize: 28; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "AProgressBar · AProgressCircle · ABadge · ATooltip · ASkeleton"
                    font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                }
            }

            // ── AProgressBar ──
            ACard {
                title: "AProgressBar"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    Row { spacing: 20
                        Text { text: "0%"; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.verticalCenter: parent.verticalCenter }
                        AProgressBar { value: 0; width: 300 }
                    }
                    Row { spacing: 20
                        Text { text: "45%"; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.verticalCenter: parent.verticalCenter }
                        AProgressBar { value: 45; width: 300 }
                    }
                    Row { spacing: 20
                        Text { text: "100%"; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.verticalCenter: parent.verticalCenter }
                        AProgressBar { value: 100; width: 300 }
                    }
                    Row { spacing: 20
                        Text { text: "Loading"; font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.verticalCenter: parent.verticalCenter }
                        AProgressBar { indeterminate: true; width: 300 }
                    }
                }
            }

            // ── AProgressCircle ──
            ACard {
                title: "AProgressCircle"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 32
                    Column { spacing: 8
                        AProgressCircle { value: 0; size: "sm" }
                        Text { text: "0% sm"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 8
                        AProgressCircle { value: 65; size: "md" }
                        Text { text: "65% md"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 8
                        AProgressCircle { value: 88; size: "lg" }
                        Text { text: "88% lg"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 8
                        AProgressCircle { value: 100; size: "md" }
                        Text { text: "100%"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                }
            }

            // ── ABadge ──
            ACard {
                title: "ABadge"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 12
                    ABadge { text: "Primary" }
                    ABadge { text: "Success"; variant: "success" }
                    ABadge { text: "Warning"; variant: "warning" }
                    ABadge { text: "Danger"; variant: "danger" }
                    ABadge { text: "Neutral"; variant: "neutral" }
                }
            }

            // ── ATooltip ──
            ACard {
                title: "ATooltip (hover the buttons)"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 12
                    AButton {
                        text: "Hover me"
                        variant: "secondary"

                        ATooltip {
                            visible: parent.hovered
                            text: "This is a tooltip with helpful information"
                        }
                    }

                    AButton {
                        text: "Primary"
                        variant: "primary"

                        ATooltip {
                            visible: parent.hovered
                            text: "Variant: primary\nClick to submit the form"
                            variant: "dark"
                        }
                    }

                    ABadge {
                        text: "Badge"

                        ATooltip {
                            visible: parent.hovered
                            text: "Badge tooltip: you can attach tooltips to any item"
                        }
                    }
                }
            }

            // ── ASkeleton ──
            ACard {
                title: "ASkeleton"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 16; width: parent.width
                    ASkeleton { lines: 3; width: 350 }

                    // Simulated card skeleton
                    Rectangle {
                        width: 350; height: 120; radius: Theme.radiusMd
                        color: Theme.isDark ? Qt.rgba(1,1,1,0.03) : Qt.rgba(0,0,0,0.02)
                        border.color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06)

                        Column {
                            anchors { left: parent.left; top: parent.top; margins: 16 }
                            spacing: 10
                            ASkeleton { lines: 1; lineHeight: 18; width: 200; widthVariance: 0 }
                            ASkeleton { lines: 1; lineHeight: 12; width: 300; widthVariance: 0 }
                            ASkeleton { lines: 1; lineHeight: 12; width: 250; widthVariance: 0 }
                            ASkeleton { lines: 1; lineHeight: 12; width: 180; widthVariance: 0 }
                        }
                    }
                }
            }
        }
    }
}
