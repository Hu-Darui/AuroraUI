import QtQuick
import QtQuick.Controls
import aurora 1.0

Rectangle {
    id: root
    color: Theme.background
    anchors.fill: parent

    Text {
        anchors { top: parent.top; topMargin: 40; horizontalCenter: parent.horizontalCenter }
        text: "AuroraUI Default"
        font.pixelSize: 32
        font.weight: Theme.weightBold
        font.family: Theme.fontFamily
        color: Theme.text
    }
    Text {
        anchors { top: parent.top; topMargin: 78; horizontalCenter: parent.horizontalCenter }
        text: "Original macOS-inspired Design System"
        font.pixelSize: 14
        font.family: Theme.fontFamily
        color: Theme.textSecondary
    }

    Row {
        anchors { top: parent.top; topMargin: 110; horizontalCenter: parent.horizontalCenter }
        spacing: 12

        AButton {
            text: "☀ Light"
            variant: Theme.isDark ? "ghost" : "primary"
            onClicked: Theme.isDark = false
        }
        AButton {
            text: "☾ Dark"
            variant: Theme.isDark ? "primary" : "ghost"
            onClicked: Theme.isDark = true
        }
    }

    Rectangle {
        anchors {
            top: parent.top; topMargin: 170
            horizontalCenter: parent.horizontalCenter
        }
        width: 420; height: 280
        radius: 12
        color: Theme.elevated
        border.color: Qt.rgba(0, 0, 0, 0.08)
        border.width: 0.5

        Text {
            anchors { top: parent.top; topMargin: 20; left: parent.left; leftMargin: 24 }
            text: "All Button Variants"
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Flow {
            anchors { top: parent.top; topMargin: 56; left: parent.left; leftMargin: 24; right: parent.right; rightMargin: 24 }
            spacing: 14

            AButton { text: "Primary"; variant: "primary" }
            AButton { text: "Secondary"; variant: "secondary" }
            AButton { text: "Tinted"; variant: "tinted" }
            AButton { text: "Ghost"; variant: "ghost" }
            AButton { text: "Destructive"; variant: "destructive" }
            AButton { text: "Disabled"; enabled: false }
            AButton { text: "Loading"; loading: true }
        }

        Text {
            anchors { top: parent.top; topMargin: 155; left: parent.left; leftMargin: 24 }
            text: "Sizes"
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Row {
            anchors { top: parent.top; topMargin: 190; left: parent.left; leftMargin: 24 }
            spacing: 12
            AButton { text: "Small"; size: "sm" }
            AButton { text: "Medium"; size: "md"; variant: "primary" }
            AButton { text: "Large"; size: "lg"; variant: "secondary" }
        }
    }

    // ── Switch 卡片 ──
    Rectangle {
        anchors {
            top: parent.top; topMargin: 470
            horizontalCenter: parent.horizontalCenter
        }
        width: 420; height: 110
        radius: 12
        color: Theme.elevated
        border.color: Qt.rgba(0, 0, 0, 0.08)
        border.width: 0.5

        Text {
            anchors { top: parent.top; topMargin: 20; left: parent.left; leftMargin: 24 }
            text: "Switches"
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Row {
            anchors { top: parent.top; topMargin: 56; left: parent.left; leftMargin: 24 }
            spacing: 24

            Column { spacing: 4
                ASwitch { id: sw1 }
                Text { text: sw1.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
            }
            Column { spacing: 4
                ASwitch { id: sw2; checked: true }
                Text { text: sw2.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
            }
            Column { spacing: 4
                ASwitch { id: sw3; enabled: false }
                Text { text: "Disabled"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
            }
        }
    }
}
