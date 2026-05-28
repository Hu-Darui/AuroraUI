import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property string position: "left"
    property var model: []
    property int currentIndex: 0

    signal itemClicked(int index, var itemData)

    readonly property bool _horiz: position === "top" || position === "bottom"
    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass

    readonly property color _bg: {
        if (_isLiq) return Theme.isDark ? Qt.rgba(1,1,1,0.05) : Qt.rgba(1,1,1,0.30)
        return Theme.elevated
    }

    implicitWidth: _horiz ? 400 : 72
    implicitHeight: _horiz ? 48 : 400

    background: Rectangle {
        color: root._bg
        radius: _horiz ? 0 : Theme.radiusLg

        // Neumorphism shadow
        Rectangle {
            visible: root._isNeu && !root._horiz
            anchors { fill: parent; topMargin: -5; leftMargin: -5 }
            radius: parent.radius + 5; color: Theme.neuLightShadow
        }
        Rectangle {
            visible: root._isNeu && !root._horiz
            anchors { fill: parent; bottomMargin: -5; rightMargin: -5 }
            radius: parent.radius + 5; color: Theme.neuDarkShadow
        }

        // LiquidGlass: 顶部高光
        Rectangle {
            visible: root._isLiq
            anchors { top: parent.top; topMargin: 0.5; horizontalCenter: parent.horizontalCenter }
            width: parent.width * 0.5; height: 0.8
            radius: 1
            opacity: Theme.isDark ? 0.35 : 0.30
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: "white" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        // LiquidGlass: 底部边框
        Rectangle {
            visible: root._isLiq && root._horiz
            anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
            height: 0.5
            color: Theme.isDark ? Qt.rgba(1,1,1,0.12) : Qt.rgba(0,0,0,0.08)
        }
    }

    contentItem: ListView {
        id: listView
        orientation: root._horiz ? ListView.Horizontal : ListView.Vertical
        anchors.fill: parent
        anchors.margins: root._horiz ? 4 : 6
        spacing: root._horiz ? 0 : 2
        model: root.model
        interactive: false
        currentIndex: root.currentIndex

        delegate: Item {
            width: root._horiz ? Math.max(72, listView.width / Math.max(1, root.model.length)) : listView.width
            height: root._horiz ? listView.height : 44

            Rectangle {
                id: itemBg
                anchors { fill: parent; margins: root._horiz ? 2 : 3 }
                radius: Theme.radiusMd
                color: {
                    if (root.currentIndex === index) {
                        if (root._isNeu) return Theme.background
                        if (root._isLiq) return Theme.isDark ? Qt.rgba(1,1,1,0.12) : Qt.rgba(1,1,1,0.55)
                        return Theme.isDark ? Qt.rgba(0.04,0.52,1,0.18) : Qt.rgba(0,0.44,0.89,0.08)
                    }
                    return "transparent"
                }
                Behavior on color { ColorAnimation { duration: Theme.durationFast } }

                // LiquidGlass active: 顶部高光
                Rectangle {
                    visible: root._isLiq && root.currentIndex === index
                    anchors { top: parent.top; topMargin: 1; horizontalCenter: parent.horizontalCenter }
                    width: parent.width * 0.5; height: 0.5
                    radius: 1
                    opacity: 0.40
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "transparent" }
                        GradientStop { position: 0.5; color: "white" }
                        GradientStop { position: 1.0; color: "transparent" }
                    }
                }

                // Active indicator
                Rectangle {
                    visible: root.currentIndex === index && !root._isNeu && !root._isLiq
                    anchors {
                        left: root._horiz ? undefined : parent.left
                        bottom: root._horiz ? parent.bottom : undefined
                        top: root._horiz ? undefined : parent.top
                        right: root._horiz ? undefined : undefined
                    }
                    width: root._horiz ? parent.width - 24 : 3
                    height: root._horiz ? 2.5 : parent.height - 12
                    x: root._horiz ? 12 : 0
                    y: root._horiz ? 0 : 6
                    radius: 2
                    color: Theme.primary
                }

                // LiquidGlass active: 侧边指示条
                Rectangle {
                    visible: root._isLiq && root.currentIndex === index
                    anchors { left: parent.left; top: parent.top; bottom: parent.bottom; topMargin: 8; bottomMargin: 8 }
                    width: 2.5; radius: 2
                    color: Theme.primary
                }

                Row {
                    anchors.centerIn: parent
                    spacing: root._horiz ? 6 : 10

                    Text {
                        text: modelData.icon || ""
                        font.pixelSize: root._horiz ? 16 : 14
                        color: root.currentIndex === index ? Theme.primary : Theme.textSecondary
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: modelData.label || ""
                        font.pixelSize: root._horiz ? 12 : 13
                        font.weight: root.currentIndex === index ? Theme.weightSemiBold : Theme.weightRegular
                        font.family: Theme.fontFamily
                        color: root.currentIndex === index ? Theme.text : Theme.textSecondary
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle {
                        visible: (modelData.badge || 0) > 0
                        width: 18; height: 18; radius: 9
                        color: Theme.danger
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            anchors.centerIn: parent
                            text: String(Math.min(modelData.badge || 0, 99))
                            font.pixelSize: 10; font.family: Theme.fontFamily
                            color: "#FFFFFF"
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    root.currentIndex = index
                    root.itemClicked(index, modelData)
                }
            }
        }
    }
}
