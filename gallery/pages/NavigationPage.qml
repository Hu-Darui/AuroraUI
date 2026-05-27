import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root
    color: "transparent"
    anchors.fill: parent

    readonly property var _navModel: [
        { icon: "▤", label: "Dashboard", badge: 0 },
        { icon: "◎", label: "Messages", badge: 3 },
        { icon: "▦", label: "Settings", badge: 0 },
        { icon: "◰", label: "Profile", badge: 0 }
    ]

    readonly property var _tabModel: [
        { label: "All" },
        { label: "Recent" },
        { label: "Favorites" },
        { label: "Archived" },
        { label: "Shared" }
    ]

    readonly property var _breadcrumbModel: [
        { label: "Home" },
        { label: "Components" },
        { label: "Navigation" }
    ]

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
                    text: "Navigation"
                    font.pixelSize: 28; font.weight: Theme.weightBold
                    font.family: Theme.fontFamily; color: Theme.text
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ANavBar · ATabBar · ABreadcrumb"
                    font.pixelSize: 12; font.family: Theme.fontFamily; color: Theme.textSecondary
                }
            }

            // ── ANavBar — Top ──
            ACard {
                title: "ANavBar — Top Navigation"
                width: 540
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 0; width: parent.width
                    ANavBar {
                        id: navTop
                        position: "top"
                        model: root._navModel
                        width: parent.width - 20
                    }
                    Rectangle {
                        width: parent.width - 20; height: 140; radius: 0
                        color: Theme.surface
                        Rectangle {
                            anchors { left: parent.left; right: parent.right; top: parent.top }
                            height: 0.5
                            color: Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.06)
                        }
                        Text {
                            anchors.centerIn: parent
                            text: "Content Area\n\nActive: " + root._navModel[navTop.currentIndex].label
                            font.pixelSize: 14; font.family: Theme.fontFamily
                            color: Theme.textSecondary; horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            // ── ATabBar ──
            ACard {
                title: "ATabBar"
                width: 540
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 8; width: parent.width
                    ATabBar {
                        id: tabBar
                        model: root._tabModel
                        width: parent.width - 20
                    }
                    Text {
                        anchors { left: parent.left; leftMargin: 8 }
                        text: "Active tab: " + root._tabModel[tabBar.currentIndex].label
                        font.pixelSize: 13; font.family: Theme.fontFamily; color: Theme.textSecondary
                    }
                }
            }

            // ── ABreadcrumb ──
            ACard {
                title: "ABreadcrumb"
                width: 540
                anchors.horizontalCenter: parent.horizontalCenter

                Column { spacing: 12; width: parent.width
                    ABreadcrumb {
                        model: root._breadcrumbModel
                        onItemClicked: function(idx, data) { console.log("Breadcrumb:", data.label) }
                    }

                    ABreadcrumb {
                        model: [
                            { label: "Projects" },
                            { label: "AuroraUI" },
                            { label: "Components" },
                            { label: "ANavBar" }
                        ]
                        separator: ">"
                        onItemClicked: function(idx, data) { console.log("Breadcrumb:", data.label) }
                    }
                }
            }
        }
    }
}
