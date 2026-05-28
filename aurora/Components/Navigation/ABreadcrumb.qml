import QtQuick
import QtQuick.Controls
import aurora 1.0

Control {
    id: root

    // model: [{ label: "Home" }, { label: "Page" }, { label: "Current" }]
    // last item is treated as "current" (non-clickable, bold)
    property var model: []
    property string separator: "/"

    signal itemClicked(int index, var itemData)

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass

    implicitWidth: 200
    implicitHeight: 28

    contentItem: Row {
        spacing: 0

        Repeater {
            model: root.model

            Row {
                spacing: 6

                Text {
                    text: modelData.label || ""
                    font.pixelSize: 13
                    font.weight: index === root.model.length - 1 ? Theme.weightSemiBold : Theme.weightRegular
                    font.family: Theme.fontFamily
                    color: index === root.model.length - 1
                        ? Theme.text
                        : Theme.primary
                    opacity: index === root.model.length - 1 ? 1.0 : 0.85
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        id: bcMa
                        anchors.fill: parent
                        enabled: index < root.model.length - 1
                        cursorShape: index < root.model.length - 1 ? Qt.PointingHandCursor : Qt.ArrowCursor
                        hoverEnabled: index < root.model.length - 1
                        onClicked: root.itemClicked(index, modelData)
                    }

                    Rectangle {
                        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter }
                        visible: index < root.model.length - 1 && bcMa.containsMouse
                        width: parent.implicitWidth; height: 1
                        color: Theme.primary; opacity: 0.5
                    }
                }

                Text {
                    visible: index < root.model.length - 1
                    text: root.separator
                    font.pixelSize: 13
                    font.family: Theme.fontFamily
                    color: Theme.textSecondary
                    opacity: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
