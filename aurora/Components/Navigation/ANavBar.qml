import QtQuick
import QtQuick.Controls
import aurora 1.0

Control {
    id: root

    // position: "top" | "bottom" | "left" | "right"
    property string position: "left"
    // model: [{ icon: "", label: "", badge: 0 }]
    property var model: []
    property int currentIndex: 0

    signal itemClicked(int index, var itemData)

    readonly property bool _horiz: position === "top" || position === "bottom"
    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    readonly property color _bg: {
        if (_isNeu) return Theme.elevated
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

        // Glassmorphism top highlight
        Rectangle {
            visible: root._isGls && root._horiz && root.position === "top"
            anchors { top: parent.top; left: parent.left; right: parent.right }
            height: 0.8; color: Theme.gmBorderHighlight
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
                        if (root._isLiq) return Qt.rgba(1, 1, 1, 0.10)
                        if (root._isGls) return Qt.rgba(1, 1, 1, 0.08)
                        return Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.18) : Qt.rgba(0, 0.44, 0.89, 0.08)
                    }
                    return "transparent"
                }

                // Active indicator
                Rectangle {
                    visible: root.currentIndex === index && !root._isNeu
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
