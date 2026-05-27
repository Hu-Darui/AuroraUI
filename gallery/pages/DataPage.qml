import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: "transparent"
    anchors.fill: parent

    readonly property var _listModel: [
        { label: "Dashboard",    subtitle: "Overview & analytics" },
        { label: "Messages",     subtitle: "3 unread messages" },
        { label: "Calendar",     subtitle: "Upcoming events" },
        { label: "Tasks",        subtitle: "5 pending tasks" },
        { label: "Documents",    subtitle: "Recent files" },
        { label: "Settings",     subtitle: "Preferences & account" }
    ]

    readonly property var _tableColumns: [
        { label: "Name", width: 140 },
        { label: "Role", width: 100 },
        { label: "Status", width: 90 },
        { label: "Date", width: 110 }
    ]

    readonly property var _tableRows: [
        ["Alice Chen",    "Designer",  "Active", "2026-05-12"],
        ["Bob Wang",      "Developer", "Active", "2026-05-10"],
        ["Carol Liu",     "PM",        "Away",   "2026-05-08"],
        ["David Zhang",   "Engineer",  "Active", "2026-05-05"],
        ["Eva Wu",        "Designer",  "Active", "2026-05-01"],
        ["Frank Li",      "Developer", "Off",    "2026-04-28"],
        ["Grace Zhao",    "Manager",   "Active", "2026-04-25"]
    ]

    property int _page: 1

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
                    text: "Data"
                    font.pixelSize: 28; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "AListView · ATableView · APagination"
                    font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                }
            }

            // ── AListView ──
            ACard {
                title: "AListView"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 10; width: parent.width
                    AListView {
                        id: listView
                        model: root._listModel
                        implicitHeight: 260
                        width: parent.width - 20

                        rowDelegate: Component {
                            Item {
                                Row {
                                    anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                                    spacing: 12
                                    Rectangle {
                                        width: 34; height: 34; radius: 8
                                        color: Theme.primary; opacity: 0.7
                                        anchors.verticalCenter: parent.verticalCenter
                                        Text {
                                            anchors.centerIn: parent
                                            text: itemData.label.charAt(0)
                                            font.pixelSize: 14; font.weight: Font.Bold
                                            font.family: Theme.fontFamily; color: "#FFFFFF"
                                        }
                                    }
                                    Column {
                                        anchors.verticalCenter: parent.verticalCenter; spacing: 1
                                        Text {
                                            text: itemData.label
                                            font.pixelSize: 13; font.weight: Theme.weightSemiBold
                                            font.family: Theme.fontFamily; color: Theme.text
                                        }
                                        Text {
                                            text: itemData.subtitle
                                            font.pixelSize: 11; font.family: Theme.fontFamily; color: Theme.textSecondary
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Text {
                        anchors { left: parent.left; leftMargin: 8 }
                        text: "Selected: " + (listView.currentIndex >= 0 && root._listModel[listView.currentIndex]
                            ? root._listModel[listView.currentIndex].label : "none")
                        font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                    }
                }
            }

            // ── ATableView ──
            ACard {
                title: "ATableView"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 10; width: parent.width
                    ATableView {
                        id: tableView
                        columns: root._tableColumns
                        rows: root._tableRows
                        implicitHeight: 300
                        width: parent.width - 20
                    }

                    Text {
                        anchors { left: parent.left; leftMargin: 8 }
                        text: "Selected row: " + (tableView.currentRow >= 0 && root._tableRows[tableView.currentRow]
                            ? root._tableRows[tableView.currentRow][0] : "none")
                        font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                    }
                }
            }

            // ── APagination ──
            ACard {
                title: "APagination"
                width: 520
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 14; width: parent.width
                    APagination {
                        id: pag1
                        currentPage: root._page
                        totalPages: 10
                        visiblePages: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        onPageChanged: function(p) { root._page = p }
                    }

                    APagination {
                        id: pag2
                        currentPage: 1
                        totalPages: 3
                        visiblePages: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Current page: " + root._page + " / 10"
                        font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                    }
                }
            }
        }
    }
}
