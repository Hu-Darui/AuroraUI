import QtQuick
import QtQuick.Controls
import aurora 1.0

Control {
    id: root

    // model: [{ label: "Tab" }]
    property var model: []
    property int currentIndex: 0
    property bool scrollable: true

    signal tabClicked(int index, var tabData)

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    implicitWidth: 400
    implicitHeight: 44

    background: Rectangle {
        color: Theme.elevated

        Rectangle {
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: 0.5
            color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(0, 0, 0, 0.06)
        }
    }

    contentItem: ListView {
        id: tabList
        anchors.fill: parent
        orientation: ListView.Horizontal
        clip: true
        interactive: root.scrollable
        currentIndex: root.currentIndex
        boundsBehavior: Flickable.StopAtBounds

        model: root.model

        delegate: Item {
            width: Math.max(tabLabel.implicitWidth + 32, 80)
            height: tabList.height

            Rectangle {
                id: tabBg
                anchors { fill: parent; bottomMargin: 2 }
                color: root.currentIndex === index
                    ? (root._isNeu ? Theme.background
                        : root._isLiq ? Qt.rgba(1, 1, 1, 0.06)
                        : root._isGls ? Qt.rgba(1, 1, 1, 0.05)
                        : Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.10) : Qt.rgba(0, 0.44, 0.89, 0.05))
                    : "transparent"
                Behavior on color { ColorAnimation { duration: Theme.durationFast } }
            }

            // Active underline
            Rectangle {
                anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter }
                width: tabLabel.implicitWidth + 8; height: 2.5
                radius: 2
                color: root.currentIndex === index ? Theme.primary : "transparent"
                Behavior on color { ColorAnimation { duration: Theme.durationFast } }
            }

            Text {
                id: tabLabel
                anchors.centerIn: parent
                text: modelData.label || ""
                font.pixelSize: 13
                font.weight: root.currentIndex === index ? Theme.weightSemiBold : Theme.weightRegular
                font.family: Theme.fontFamily
                color: root.currentIndex === index ? Theme.primary : Theme.textSecondary
                Behavior on color { ColorAnimation { duration: Theme.durationFast } }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    root.currentIndex = index
                    root.tabClicked(index, modelData)
                }
            }
        }
    }
}
