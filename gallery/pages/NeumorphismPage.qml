import QtQuick
import QtQuick.Controls
import aurora 1.0

Rectangle {
    id: root
    color: Theme.background
    anchors.fill: parent

    // ── 标题 ──
    Text {
        anchors { top: parent.top; topMargin: 40; horizontalCenter: parent.horizontalCenter }
        text: "Neumorphism"
        font.pixelSize: 32
        font.weight: Theme.weightBold
        font.family: Theme.fontFamily
        color: Theme.text
    }
    Text {
        anchors { top: parent.top; topMargin: 78; horizontalCenter: parent.horizontalCenter }
        text: "Soft UI · Extruded & Inset Shadows"
        font.pixelSize: 14
        font.family: Theme.fontFamily
        color: Theme.textSecondary
    }

    // ── 颜色模式切换 ──
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

    // ── 卡片：按钮展示 ──
    Rectangle {
        id: card1
        anchors {
            top: parent.top; topMargin: 170
            horizontalCenter: parent.horizontalCenter
        }
        width: 420; height: 320
        radius: Theme.radiusLg
        color: Theme.elevated

        // Neumorphism 卡片自身阴影（纯色矩形，利用颜色自身的 alpha 产生软影）
        Rectangle {
            anchors { fill: parent; topMargin: -8; leftMargin: -8 }
            radius: parent.radius + 8
            color: Theme.neuLightShadow
        }
        Rectangle {
            anchors { fill: parent; bottomMargin: -8; rightMargin: -8 }
            radius: parent.radius + 8
            color: Theme.neuDarkShadow
        }

        Text {
            anchors { top: parent.top; topMargin: 20; left: parent.left; leftMargin: 24 }
            text: "Buttons"
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Flow {
            anchors { top: parent.top; topMargin: 56; left: parent.left; leftMargin: 24; right: parent.right; rightMargin: 24 }
            spacing: 14

            AButton { text: "Primary"; variant: "primary" }
            AButton { text: "Secondary"; variant: "secondary" }
            AButton { text: "Ghost"; variant: "ghost" }
            AButton { text: "Destructive"; variant: "destructive" }
            AButton { text: "Disabled"; enabled: false }
            AButton { text: "Loading"; loading: true }
        }

        Text {
            anchors { top: parent.top; topMargin: 160; left: parent.left; leftMargin: 24 }
            text: "Sizes"
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Row {
            anchors { top: parent.top; topMargin: 195; left: parent.left; leftMargin: 24 }
            spacing: 12
            AButton { text: "Small"; size: "sm" }
            AButton { text: "Medium"; size: "md"; variant: "primary" }
            AButton { text: "Large"; size: "lg"; variant: "secondary" }
        }
    }

    // ── 卡片：下压展示（inset） ──
    Rectangle {
        id: card2
        anchors {
            top: card1.bottom; topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        width: 420; height: 150
        radius: Theme.radiusLg
        color: Theme.elevated

        Rectangle {
            anchors { fill: parent; topMargin: -6; leftMargin: -6 }
            radius: parent.radius + 6
            color: Theme.neuInsetDark
        }
        Rectangle {
            anchors { fill: parent; bottomMargin: -5; rightMargin: -5 }
            radius: parent.radius + 5
            color: Theme.neuInsetLight
        }

        // ── 凹陷输入框模拟 ──
        Rectangle {
            anchors { centerIn: parent; margins: 30 }
            width: parent.width - 60; height: 44
            radius: Theme.radiusMd
            color: Theme.background
            border.color: Qt.rgba(0.59, 0.61, 0.66, 0.12)
            border.width: 0.5

            TextInput {
                anchors { fill: parent; leftMargin: 16; rightMargin: 16 }
                text: "Inset input field — type here"
                font.pixelSize: 14; font.family: Theme.fontFamily
                color: Theme.textSecondary
                verticalAlignment: TextInput.AlignVCenter
            }
        }
    }
}
