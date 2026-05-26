import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property string title: ""
    property int elevation: 0
    property bool flat: false

    default property alias content: inner.data

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    padding: 20

    background: Rectangle {
        radius: Theme.radiusLg
        color: root.flat ? "transparent" : Theme.elevated
        border.color: root.flat ? "transparent" : Qt.rgba(0, 0, 0, 0.06)
        border.width: root.flat ? 0 : 0.5

        Rectangle {
            visible: !root.flat && root._isNeu
            anchors { fill: parent; topMargin: -8; leftMargin: -8 }
            radius: parent.radius + 8; color: Theme.neuLightShadow
        }
        Rectangle {
            visible: !root.flat && root._isNeu
            anchors { fill: parent; bottomMargin: -8; rightMargin: -8 }
            radius: parent.radius + 8; color: Theme.neuDarkShadow
        }

        Rectangle {
            visible: !root.flat && root._isGls
            anchors { top: parent.top; left: parent.left; leftMargin: 1; right: parent.right; rightMargin: 1 }
            height: 1.5; radius: parent.radius; color: Theme.gmBorderHighlight
        }

        layer.enabled: !root.flat && (root._isGls || root._isLiq) && root.elevation >= 1
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: root._isGls ? Theme.gmDropShadow : Qt.rgba(0,0,0,0.3)
            shadowBlur: root._isGls ? Theme.gmShadowBlur * 0.5 : 0.6
            shadowVerticalOffset: root._isGls ? Theme.gmShadowOffset : 5
        }
    }

    contentItem: Column {
        spacing: 12

        Text {
            visible: root.title !== ""
            text: root.title
            font.pixelSize: 16; font.weight: Theme.weightSemiBold
            font.family: Theme.fontFamily; color: Theme.text
        }

        Item {
            id: inner
            width: parent.width
            implicitHeight: childrenRect.height
        }
    }
}
