import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: Theme.background
    anchors.fill: parent

    // ── 风格元数据 ──
    readonly property var _meta: ({
        "0": { name: "Default",       desc: "Original macOS-inspired Design System" },
        "1": { name: "Neumorphism",   desc: "Soft UI · Extruded & Inset Shadows" },
        "2": { name: "Liquid Glass",  desc: "Translucent · Adaptive · Content-first" },
        "3": { name: "Glassmorphism", desc: "Frosted Glass · Backdrop Blur · Vibrant Backgrounds" }
    }[String(Theme.style)])

    // ── 背景装饰 ──
    Rectangle {
        visible: Theme.style === Theme.styleGlassmorphism
        anchors.fill: parent; z: -1
        Rectangle { x: parent.width * 0.1; y: -80; width: 260;  height: 260;  radius: 130; color: Theme.gmBgGradientA; opacity: 0.55 }
        Rectangle { x: parent.width * 0.55; y: parent.height * 0.15; width: 300;  height: 300;  radius: 150; color: Theme.gmBgGradientB; opacity: 0.45 }
        Rectangle { x: parent.width * 0.25; y: parent.height * 0.55; width: 240;  height: 240;  radius: 120; color: Theme.gmBgGradientC; opacity: 0.4 }
        layer.enabled: true
        layer.effect: MultiEffect { blurEnabled: true; blurMax: 64; blur: 1.0 }
    }

    // ── LiquidGlass: macOS 风格壁纸 ──
    Rectangle {
        visible: Theme.style === Theme.styleLiquidGlass
        anchors.fill: parent; z: -1
        color: Theme.isDark ? "#0A0A2E" : "#E8E4F0"

        Repeater {
            model: [
                { cx: 0.12, cy: 0.15, s: 0.28, c: Theme.isDark ? "#7722FF" : "#A0A0FF" },
                { cx: 0.72, cy: 0.28, s: 0.24, c: Theme.isDark ? "#0055FF" : "#A0C8FF" },
                { cx: 0.20, cy: 0.60, s: 0.22, c: Theme.isDark ? "#FF0077" : "#FFA0C0" },
                { cx: 0.80, cy: 0.10, s: 0.18, c: Theme.isDark ? "#00AAFF" : "#80D0FF" },
                { cx: 0.48, cy: 0.70, s: 0.16, c: Theme.isDark ? "#AA00FF" : "#C8A0FF" }
            ]
            delegate: Rectangle {
                x: modelData.cx * parent.width - modelData.s * parent.width / 2
                y: modelData.cy * parent.height - modelData.s * parent.width / 2
                width: modelData.s * parent.width
                height: width
                radius: width / 2
                color: modelData.c
                opacity: Theme.isDark ? 0.28 : 0.22
                layer.enabled: true
                layer.effect: MultiEffect { blurEnabled: true; blur: 1.0; blurMax: 80 }
            }
        }

        Repeater {
            visible: Theme.isDark
            model: 40
            delegate: Rectangle {
                property real rndX: Math.random()
                property real rndY: Math.random()
                property real rndS: Math.random()
                property real rndD: Math.random()
                x: rndX * parent.width
                y: rndY * parent.height
                width: rndS * 1.5 + 0.5
                height: width
                radius: width / 2
                color: "white"
                opacity: rndS * 0.5 + 0.1
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.05; duration: rndD * 2000 + 1200; easing.type: Easing.InOutSine }
                    NumberAnimation { to: 0.75; duration: rndD * 2000 + 1200; easing.type: Easing.InOutSine }
                }
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        anchors.topMargin: 20
        contentWidth: availableWidth
        contentHeight: contentColumn.implicitHeight + 60

        Column {
            id: contentColumn
            width: parent.width
            spacing: 24
            anchors.horizontalCenter: parent.horizontalCenter

            // ── 标题 ──
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                topPadding: 20
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: _meta.name
                    font.pixelSize: 32; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: _meta ? _meta.desc : ""
                    font.pixelSize: 14; font.family: Theme.fontFamily
                    color: Theme.textSecondary
                }
            }

            // ═══════════════════════════════════════
            // 🔘 Buttons
            // ═══════════════════════════════════════
            ACard {
                title: "Buttons"
                width: 420
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: 12
                    Flow { width: parent.width; spacing: 14
                        AButton { text: "Primary";     variant: "primary" }
                        AButton { text: "Secondary";   variant: "secondary" }
                        AButton { text: "Tinted";      variant: "tinted" }
                        AButton { text: "Ghost";       variant: "ghost" }
                        AButton { text: "Destructive"; variant: "destructive" }
                        AButton { text: "Disabled";    enabled: false }
                        AButton { text: "Loading";     loading: true }
                    }
                    Row { spacing: 12
                        AButton { text: "Small";  size: "sm" }
                        AButton { text: "Medium"; size: "md"; variant: "primary" }
                        AButton { text: "Large";  size: "lg"; variant: "secondary" }
                    }
                }
            }

            // ═══════════════════════════════════════
            // 🔘 Switches
            // ═══════════════════════════════════════
            ACard {
                title: "Switches"
                width: 420
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 24
                    Column { spacing: 4
                        ASwitch { id: sw1 }
                        Label { text: sw1.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 4
                        ASwitch { id: sw2; checked: true }
                        Label { text: sw2.checked ? "ON" : "OFF"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                    Column { spacing: 4
                        ASwitch { id: sw3; enabled: false }
                        Label { text: "Disabled"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                }
            }

            // ═══════════════════════════════════════
            // 📋 Inputs
            // ═══════════════════════════════════════
            ACard {
                title: "Inputs"
                width: 420
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 12; width: parent.width
                    Row { spacing: 12
                        Column { spacing: 4
                            Text { text: "ATextBox"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ATextBox { placeholderText: "Enter text..."; implicitWidth: 180 }
                        }
                        Column { spacing: 4
                            Text { text: "APasswordBox"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            APasswordBox { placeholderText: "Password"; implicitWidth: 180 }
                        }
                    }

                    Column { spacing: 4; width: parent.width
                        Text { text: "ATextArea"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        ATextArea { placeholderText: "Multi-line text..."; implicitWidth: parent.width }
                    }

                    Row { spacing: 12
                        Column { spacing: 4
                            Text { text: "AComboBox"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            AComboBox { model: ["Option A", "Option B", "Option C"]; implicitWidth: 180 }
                        }
                        Column { spacing: 4
                            Text { text: "ASpinBox"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                            ASpinBox { from: 0; to: 100; value: 42 }
                        }
                    }

                    Column { spacing: 4
                        Text { text: "ATextField"; font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary }
                        Row { spacing: 12
                            ATextField { label: "Name"; placeholderText: "Your name"; implicitWidth: 180 }
                            ATextField { label: "Email"; placeholderText: "user@mail.com"; errorText: "Invalid email"; implicitWidth: 180 }
                        }
                    }
                }
            }

            // ═══════════════════════════════════════
            // 💬 Dialogs
            // ═══════════════════════════════════════
            ACard {
                title: "Dialogs"
                width: 420
                anchors.horizontalCenter: parent.horizontalCenter

                Row { spacing: 12
                    AButton { text: "Message"; variant: "secondary"; onClicked: msgLoader.active = true }
                    AButton { text: "Confirm"; variant: "secondary"; onClicked: confirmLoader.active = true }
                    AButton { text: "Content"; variant: "secondary"; onClicked: contentLoader.active = true }
                    AButton { text: "Input";   variant: "secondary"; onClicked: inputLoader.active = true }
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
            Text {
                text: "Any QML content can go here.\n\nUse this for custom forms, settings, or information displays."
                font.pixelSize: 14; font.family: Theme.fontFamily
                color: Theme.text; wrapMode: Text.WordWrap
                width: parent.width
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
