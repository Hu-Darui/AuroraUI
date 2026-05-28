import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

ComboBox {
    id: root

    property string size: "md"

    readonly property int _h:    size === "sm" ? 24 : size === "lg" ? 36 : 28
    readonly property int _padH: size === "sm" ?  8 : size === "lg" ? 14 : 10
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass

    implicitHeight: _h
    implicitWidth:  140
    leftPadding: _padH; rightPadding: _padH + 20

    font.pixelSize: _fs; font.family: Theme.fontFamily

    readonly property color _bg: {
        if (!enabled) return Theme.isDark ? "#222224" : "#F5F5F5"
        if (_isNeu)  return Theme.background
        if (_isLiq)  return Qt.rgba(1, 1, 1, 0.08)
        return Theme.isDark ? "#1C1C1E" : "#FFFFFF"
    }

    readonly property color _border: {
        if (popup.visible)  return Theme.primary
        if (_isNeu)         return "transparent"
        if (_isLiq)         return Theme.border
        return Theme.isDark ? "#48484A" : "#D1D1D6"
    }

    background: Rectangle {
        radius: root._r
        color: root._bg
        border.color: root._border
        border.width: root._isNeu ? 0 : 0.5

        Behavior on border.color { ColorAnimation { duration: 80 } }

        Rectangle {
            visible: root._isNeu && !root.popup.visible
            anchors.fill: parent; radius: parent.radius; color: "transparent"
            border.color: Theme.neuInsetDark; border.width: 1
            Rectangle {
                anchors { fill: parent; topMargin: 0.5; leftMargin: 0.5 }
                radius: parent.radius; color: "transparent"
                border.color: Theme.neuInsetLight; border.width: 0.5
            }
        }
    }

    // 下拉箭头
    indicator: Canvas {
        width: 10; height: 6
        anchors { right: parent.right; rightMargin: root._padH; verticalCenter: parent.verticalCenter }

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.beginPath()
            ctx.moveTo(0, 0); ctx.lineTo(5, 6); ctx.lineTo(10, 0)
            ctx.strokeStyle = Theme.textSecondary
            ctx.lineWidth = 1.5; ctx.lineCap = "round"; ctx.lineJoin = "round"
            ctx.stroke()
        }
    }

    // 弹出菜单
    popup: Popup {
        y: root.height + 4
        width: root.width
        implicitHeight: contentHeight
        padding: 4

        background: Rectangle {
            radius: root._r
            color: root._isLiq
                   ? Qt.rgba(1, 1, 1, Theme.isDark ? 0.08 : 0.92)
                   : Theme.isDark ? "#2C2C30" : "#FFFFFF"
            border.color: root._isNeu ? "transparent" : Theme.isDark ? "#48484A" : "#E0E0E0"
            border.width: 0.5

            layer.enabled: !root._isNeu
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Qt.rgba(0, 0, 0, Theme.isDark ? 0.4 : 0.12)
                shadowBlur: 0.4
                shadowVerticalOffset: 2
            }
        }

        contentItem: ListView {
            implicitHeight: contentHeight
            model: root.delegateModel
            clip: true
            currentIndex: root.currentIndex
            delegate: ItemDelegate {
                width: ListView.view.width
                implicitHeight: root._h
                padding: 0
                leftPadding: root._padH; rightPadding: root._padH

                contentItem: Text {
                    text: modelData
                    font.pixelSize: root._fs; font.family: Theme.fontFamily
                    color: Theme.text
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    radius: root._r - 2
                    color: highlighted ? (Theme.isDark ? Qt.rgba(0.04,0.52,1,0.18) : Qt.rgba(0,0.44,0.89,0.08))
                                       : "transparent"
                }
            }
        }
    }
}
