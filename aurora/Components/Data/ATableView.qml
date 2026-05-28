import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    // columns: [{ label: "Name", width: 120 }]
    property var columns: []
    // rows: [[cell0, cell1, ...], ...]
    property var rows: []
    property int currentRow: -1
    property real rowHeight: 40
    property real headerHeight: 40

    signal rowClicked(int index, var rowData)

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property color _headerBg: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Qt.rgba(1,1,1,0.04)
        return Theme.isDark ? Qt.rgba(1,1,1,0.04) : Qt.rgba(0,0,0,0.03)
    }
    readonly property color _rowEven: "transparent"
    readonly property color _rowOdd: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Qt.rgba(1,1,1,0.015)
        return Theme.isDark ? Qt.rgba(1,1,1,0.015) : Qt.rgba(0,0,0,0.015)
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

    implicitWidth: 480
    implicitHeight: Math.min(rows.length * rowHeight + headerHeight + 8, 400)

    function _colWidth(idx) {
        if (!columns || idx >= columns.length) return 100
        return columns[idx].width || 100
    }
    function _totalWidth() {
        var w = 0
        for (var i = 0; i < (columns ? columns.length : 0); i++) w += _colWidth(i)
        return Math.max(w, root.width - 8)
    }

    background: Rectangle {
        radius: Theme.radiusLg
        color: Theme.elevated
        border.color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06)
        border.width: 0.5

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

    contentItem: ScrollView {
        anchors.fill: parent
        anchors.margins: 4
        clip: true
        contentWidth: Math.max(availableWidth, root._totalWidth())
        contentHeight: headerRow.implicitHeight + tableData.implicitHeight

        Column {
            id: tableContent
            width: parent.width

            // Header
            Rectangle {
                id: headerRow
                width: root._totalWidth()
                height: root.headerHeight
                radius: Theme.radiusSm
                color: root._headerBg

                Row {
                    anchors.fill: parent
                    Repeater {
                        model: root.columns
                        Rectangle {
                            width: root._colWidth(index); height: parent.height
                            color: "transparent"
                            Text {
                                anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                                text: modelData.label || ""
                                font.pixelSize: 12; font.weight: Theme.weightSemiBold
                                font.family: Theme.fontFamily; color: Theme.textSecondary
                            }
                        }
                    }
                }

                Rectangle {
                    anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
                    height: 0.5; color: root._divider
                }
            }

            // Data rows
            Column {
                id: tableData
                width: root._totalWidth()

                Repeater {
                    model: root.rows

                    Rectangle {
                        id: dataRow
                        width: tableData.width
                        height: root.rowHeight
                        property bool _hovered: rowMa.containsMouse
                        property bool _selected: index === root.currentRow

                        color: _selected ? root._rowSelected
                            : _hovered ? root._rowHover
                            : (index % 2 === 1) ? root._rowOdd : root._rowEven

                        Behavior on color { ColorAnimation { duration: 100 } }

                        Row {
                            anchors.fill: parent
                            Repeater {
                                model: root.rows[index] || []
                                Item {
                                    width: root._colWidth(index); height: parent.height
                                    Text {
                                        anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                                        text: root.rows[dataRow.Repeater.index] ? String(root.rows[dataRow.Repeater.index][index] || "") : ""
                                        font.pixelSize: 13; font.family: Theme.fontFamily; color: Theme.text
                                        elide: Text.ElideRight
                                        clip: true; width: parent.width - 24
                                    }
                                }
                            }
                        }

                        Rectangle {
                            anchors { left: parent.left; leftMargin: 6; right: parent.right; rightMargin: 6; bottom: parent.bottom }
                            height: 0.5; color: root._divider
                        }

                        MouseArea {
                            id: rowMa
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.currentRow = index
                                root.rowClicked(index, root.rows[index])
                            }
                        }
                    }
                }
            }
        }
    }
}
