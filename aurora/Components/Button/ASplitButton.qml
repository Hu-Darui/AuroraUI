import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Item {
    id: root

    property string text:    ""
    property string variant: "primary"   // primary | secondary
    property string size:    "md"
    property bool   enabled: true

    signal clicked()
    signal dropdownClicked()

    readonly property int _h:    size === "sm" ? 24 : size === "lg" ? 36 : 28
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13
    readonly property int _arrowW: size === "sm" ? 24 : size === "lg" ? 32 : 28

    implicitHeight: _h
    implicitWidth:  mainBtn.implicitWidth + _arrowW

    readonly property color _bgColor:
        !enabled ? (Theme.isDark ? "#2A2A2C" : "#F0F0F0") :
        variant === "primary" ? (Theme.isDark ? "#0A84FF" : "#0071E3") :
                                (Theme.isDark ? "#3A3A3C" : "#FFFFFF")

    readonly property color _fgColor:
        !enabled          ? (Theme.isDark ? "#4A4A4E" : "#AAAAAA") :
        variant === "primary" ? "#FFFFFF" :
                                Theme.text

    readonly property color _dividerColor:
        variant === "primary" ? Qt.rgba(1, 1, 1, 0.25)
                              : (Theme.isDark ? "#48484A" : "#D1D1D6")

    // 整体背景
    Rectangle {
        anchors.fill: parent
        radius: root._r
        color:  root._bgColor
        border.color: root.variant === "secondary"
                      ? (Theme.isDark ? "#48484A" : "#D1D1D6") : "transparent"
        border.width: root.variant === "secondary" ? 0.5 : 0

        Behavior on color { ColorAnimation { duration: 150 } }

        // 顶部高光
        Rectangle {
            anchors { top: parent.top; left: parent.left; right: parent.right }
            anchors.topMargin: 0.5; anchors.leftMargin: 1; anchors.rightMargin: 1
            height: 1; radius: root._r
            color: Qt.rgba(1, 1, 1, root.variant === "primary" ? 0.22 : 0.85)
        }

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor:   Qt.rgba(0, 0, 0, Theme.isDark ? 0.35 : 0.15)
            shadowBlur:    0.3
            shadowVerticalOffset: 1
        }
    }

    // 主按钮区域
    Button {
        id: mainBtn
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
        implicitWidth: contentItem.implicitWidth + 28
        enabled: root.enabled
        focusPolicy: Qt.NoFocus

        onClicked: root.clicked()

        background: Rectangle {
            color: mainBtn.pressed ? Qt.rgba(0, 0, 0, 0.08) : "transparent"
            radius: root._r
            // 右侧不圆角，贴着分隔线
            Rectangle {
                anchors { top: parent.top; right: parent.right; bottom: parent.bottom }
                width: root._r
                color: parent.color
            }
            Behavior on color { ColorAnimation { duration: 60 } }
        }

        contentItem: Text {
            text:               root.text
            color:              root._fgColor
            font.pixelSize:     root._fs
            font.weight:        500
            font.family:        Theme.fontFamily
            font.letterSpacing: -0.15
            renderType:         Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment:   Text.AlignVCenter
        }
    }

    // 分隔线
    Rectangle {
        anchors { top: parent.top; bottom: parent.bottom }
        anchors.topMargin: 4; anchors.bottomMargin: 4
        x: mainBtn.width
        width: 0.5
        color: root._dividerColor
    }

    // 箭头按钮区域
    Button {
        id: arrowBtn
        anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
        width: root._arrowW
        enabled: root.enabled
        focusPolicy: Qt.NoFocus

        onClicked: root.dropdownClicked()

        background: Rectangle {
            color: arrowBtn.pressed ? Qt.rgba(0, 0, 0, 0.08) : "transparent"
            radius: root._r
            // 左侧不圆角
            Rectangle {
                anchors { top: parent.top; left: parent.left; bottom: parent.bottom }
                width: root._r
                color: parent.color
            }
            Behavior on color { ColorAnimation { duration: 60 } }
        }

        contentItem: Item {
            // 向下箭头
            Canvas {
                anchors.centerIn: parent
                width: 8; height: 5

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.moveTo(0, 0)
                    ctx.lineTo(4, 5)
                    ctx.lineTo(8, 0)
                    ctx.strokeStyle = root._fgColor
                    ctx.lineWidth = 1.5
                    ctx.lineCap = "round"
                    ctx.lineJoin = "round"
                    ctx.stroke()
                }

                // 颜色变化时重绘
                Connections {
                    target: root
                    function onVariantChanged() { arrowCanvas.requestPaint() }
                }
            }
        }
    }

    scale: 1.0
}