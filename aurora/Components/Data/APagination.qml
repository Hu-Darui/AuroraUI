import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property int currentPage: 1
    property int totalPages: 10
    property int visiblePages: 5   // max page buttons to show

    signal pageChanged(int page)

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    implicitWidth: 400
    implicitHeight: 36

    function _pageNumbers() {
        var half = Math.floor(visiblePages / 2)
        var start = Math.max(1, currentPage - half)
        var end = Math.min(totalPages, start + visiblePages - 1)
        if (end - start < visiblePages - 1) start = Math.max(1, end - visiblePages + 1)
        var pages = []
        for (var i = start; i <= end; i++) pages.push(i)
        return pages
    }

    readonly property color _btnBg: {
        if (_isNeu) return Theme.background
        return "transparent"
    }
    readonly property color _btnActiveBg: {
        if (_isNeu) return Theme.primary
        if (_isLiq) return Qt.rgba(0.65,0.55,0.95,0.30)
        if (_isGls) return Qt.rgba(0.39,0.33,0.95,0.25)
        return Theme.primary
    }
    readonly property color _btnHoverBg: {
        if (_isNeu) return Qt.rgba(0.49,0.51,1,0.08)
        if (_isLiq) return Qt.rgba(1,1,1,0.06)
        if (_isGls) return Qt.rgba(1,1,1,0.05)
        return Theme.isDark ? Qt.rgba(1,1,1,0.06) : Qt.rgba(0,0,0,0.04)
    }

    readonly property color _btnFg: Theme.textSecondary
    readonly property color _btnActiveFg: {
        if (_isNeu) return "#FFFFFF"
        return Theme.text
    }

    contentItem: Row {
        anchors.centerIn: parent
        spacing: 2

        // Prev
        Rectangle {
            width: 36; height: 36; radius: Theme.radiusSm
            color: prevMa.containsMouse ? root._btnHoverBg
                : (root._isNeu ? root._btnBg : "transparent")
            opacity: root.currentPage <= 1 ? 0.35 : 1.0
            Behavior on color { ColorAnimation { duration: 100 } }

            Text {
                anchors.centerIn: parent
                text: "⟨"
                font.pixelSize: 16; font.family: Theme.fontFamily
                color: root.currentPage <= 1 ? Theme.textSecondary : Theme.text
            }

            MouseArea {
                id: prevMa; anchors.fill: parent; hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                enabled: root.currentPage > 1
                onClicked: {
                    root.currentPage = Math.max(1, root.currentPage - 1)
                    root.pageChanged(root.currentPage)
                }
            }
        }

        // Page buttons
        Repeater {
            model: root._pageNumbers()

            Rectangle {
                width: 36; height: 36; radius: Theme.radiusSm
                color: modelData === root.currentPage ? root._btnActiveBg
                    : pageMa.containsMouse ? root._btnHoverBg
                    : (root._isNeu ? root._btnBg : "transparent")
                Behavior on color { ColorAnimation { duration: 100 } }

                // Neumorphism active: raised
                Rectangle {
                    visible: root._isNeu && modelData === root.currentPage
                    anchors { fill: parent; topMargin: -1; leftMargin: -1 }
                    radius: parent.radius + 1; color: Theme.neuLightShadow
                }
                Rectangle {
                    visible: root._isNeu && modelData === root.currentPage
                    anchors { fill: parent; bottomMargin: -1; rightMargin: -1 }
                    radius: parent.radius + 1; color: Theme.neuDarkShadow
                }

                // Glassmorphism: active top highlight
                Rectangle {
                    visible: root._isGls && modelData === root.currentPage
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: 0.8; radius: parent.radius; color: Theme.gmBorderHighlight
                }


                Text {
                    anchors.centerIn: parent
                    text: String(modelData)
                    font.pixelSize: 13
                    font.weight: modelData === root.currentPage ? Theme.weightSemiBold : Theme.weightRegular
                    font.family: Theme.fontFamily
                    color: modelData === root.currentPage ? root._btnActiveFg : root._btnFg
                }

                MouseArea {
                    id: pageMa; anchors.fill: parent; hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.currentPage = modelData
                        root.pageChanged(modelData)
                    }
                }
            }
        }

        // Next
        Rectangle {
            width: 36; height: 36; radius: Theme.radiusSm
            color: nextMa.containsMouse ? root._btnHoverBg
                : (root._isNeu ? root._btnBg : "transparent")
            opacity: root.currentPage >= root.totalPages ? 0.35 : 1.0
            Behavior on color { ColorAnimation { duration: 100 } }

            Text {
                anchors.centerIn: parent
                text: "⟩"
                font.pixelSize: 16; font.family: Theme.fontFamily
                color: root.currentPage >= root.totalPages ? Theme.textSecondary : Theme.text
            }

            MouseArea {
                id: nextMa; anchors.fill: parent; hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                enabled: root.currentPage < root.totalPages
                onClicked: {
                    root.currentPage = Math.min(root.totalPages, root.currentPage + 1)
                    root.pageChanged(root.currentPage)
                }
            }
        }
    }
}
