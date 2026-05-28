import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property var model: []
    property int currentIndex: -1
    property bool alternating: true
    property real rowHeight: 42

    // delegate receives: modelData, index, selected, hovered
    property Component rowDelegate: defaultDelegate

    signal itemClicked(int index, var itemData)
    signal itemDoubleClicked(int index, var itemData)

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property color _rowEven: "transparent"
    readonly property color _rowOdd: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Qt.rgba(1,1,1,0.02)
        return Theme.isDark ? Qt.rgba(1,1,1,0.02) : Qt.rgba(0,0,0,0.02)
    }
    readonly property color _rowHover: {
        if (_isNeu) return Qt.rgba(0.49,0.51,1,0.08)
        if (_isLiq) return Qt.rgba(1,1,1,0.06)
        return Theme.isDark ? Qt.rgba(0.04,0.52,1,0.10) : Qt.rgba(0,0.44,0.89,0.06)
    }
    readonly property color _rowSelected: {
        if (_isNeu) return Qt.rgba(0.49,0.51,1,0.15)
        if (_isLiq) return Qt.rgba(0.65,0.55,0.95,0.15)
        return Theme.isDark ? Qt.rgba(0.04,0.52,1,0.18) : Qt.rgba(0,0.44,0.89,0.10)
    }
    readonly property color _divider: Theme.isDark ? Qt.rgba(1,1,1,0.04) : Qt.rgba(0,0,0,0.04)

    implicitWidth: 360
    implicitHeight: 300

    Component {
        id: defaultDelegate
        Item {
            width: listView.width
            height: root.rowHeight

            Text {
                anchors { left: parent.left; leftMargin: 16; verticalCenter: parent.verticalCenter }
                text: modelData && modelData.label !== undefined ? modelData.label : (modelData ? String(modelData) : "")
                font.pixelSize: 13; font.family: Theme.fontFamily; color: Theme.text
            }
        }
    }

    background: Rectangle {
        radius: Theme.radiusLg
        color: Theme.elevated
        border.color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06)
        border.width: 0.5

        // Neumorphism
        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; topMargin: -6; leftMargin: -6 }
            radius: parent.radius + 6; color: Theme.neuLightShadow
        }
        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; bottomMargin: -6; rightMargin: -6 }
            radius: parent.radius + 6; color: Theme.neuDarkShadow
        }

    }

    contentItem: ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: 1
        clip: true
        model: root.model

        delegate: Item {
            id: rowItem
            width: listView.width
            height: root.rowHeight
            property bool _hovered: rowMa.containsMouse
            property bool _selected: index === root.currentIndex

            Rectangle {
                anchors { fill: parent; leftMargin: 4; rightMargin: 4; topMargin: 1; bottomMargin: 1 }
                radius: Theme.radiusSm
                color: rowItem._selected ? root._rowSelected
                    : rowItem._hovered ? root._rowHover
                    : (root.alternating && index % 2 === 1) ? root._rowOdd : root._rowEven

                Behavior on color { ColorAnimation { duration: 100 } }

                Loader {
                    anchors.fill: parent
                    sourceComponent: root.rowDelegate
                    property var itemData: modelData
                    property int itemIndex: index
                    property bool itemSelected: rowItem._selected
                    property bool itemHovered: rowItem._hovered
                }
            }

            Rectangle {
                visible: index < (root.model ? root.model.length - 1 : 0)
                anchors { left: parent.left; leftMargin: 8; right: parent.right; rightMargin: 8; bottom: parent.bottom }
                height: 0.5; color: root._divider
            }

            MouseArea {
                id: rowMa
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    root.currentIndex = index
                    root.itemClicked(index, modelData)
                }
                onDoubleClicked: root.itemDoubleClicked(index, modelData)
            }
        }
    }
}
