import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property real value: 0
    property string size: "md"

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls: Theme.style === Theme.styleGlassmorphism

    readonly property int _sz: size === "sm" ? 40 : size === "lg" ? 84 : 60
    readonly property real _sw: size === "sm" ? 3 : size === "lg" ? 6 : 4.5

    implicitWidth: _sz
    implicitHeight: _sz

    readonly property color _trackColor: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Qt.rgba(1, 1, 1, 0.06)
        if (_isGls) return Qt.rgba(1, 1, 1, 0.08)
        return Theme.isDark ? "#3A3A3C" : "#E5E5EA"
    }

    readonly property color _fillColor: {
        if (_isNeu) return Theme.primary
        if (_isLiq) return "#A78BFA"
        if (_isGls) return "#818CF8"
        return Theme.primary
    }

    contentItem: Item {
        anchors.fill: parent

        // ── Neumorphism: 外凸起环 ──
        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; margins: -6 }
            radius: width / 2; color: "transparent"
            border.color: Theme.neuDarkShadow; border.width: root._sw * 0.8
        }
        Rectangle {
            visible: root._isNeu
            anchors { fill: parent; margins: -8 }
            radius: width / 2; color: "transparent"
            border.color: Theme.neuLightShadow; border.width: root._sw * 0.8
        }

        // ── Track ring ──
        Canvas {
            id: trackCanvas
            anchors.fill: parent
            rotation: -90

            onPaint: {
                var ctx = getContext("2d")
                var w = width, h = height
                var cx = w / 2, cy = h / 2
                var r = Math.min(cx, cy) - root._sw / 2 - 2
                ctx.clearRect(0, 0, w, h)
                ctx.beginPath()
                ctx.arc(cx, cy, r, 0, Math.PI * 2)
                ctx.strokeStyle = String(root._trackColor)
                ctx.lineWidth = root._sw
                ctx.lineCap = "round"
                ctx.stroke()
            }
        }

        // ── Fill ring ──
        Canvas {
            id: fillCanvas
            anchors.fill: parent
            rotation: -90

            onPaint: {
                var ctx = getContext("2d")
                var w = width, h = height
                var cx = w / 2, cy = h / 2
                var r = Math.min(cx, cy) - root._sw / 2 - 2
                ctx.clearRect(0, 0, w, h)
                var angle = (root.value / 100) * Math.PI * 2
                if (angle > 0.001) {
                    ctx.beginPath()
                    ctx.arc(cx, cy, r, 0, angle)
                    ctx.strokeStyle = String(root._fillColor)
                    ctx.lineWidth = root._sw
                    ctx.lineCap = "round"
                    ctx.stroke()
                }
            }

            // ── Glassmorphism: 环上高光 ──
            layer.enabled: root._isGls && root.value > 0
            layer.effect: MultiEffect {
                shadowEnabled: true; shadowColor: Theme.gmDropShadow
                shadowBlur: 0.4; shadowVerticalOffset: 2
            }
        }

        // Center label
        Text {
            anchors.centerIn: parent
            text: Math.round(root.value) + "%"
            font.pixelSize: root.size === "sm" ? 10 : root.size === "lg" ? 16 : 13
            font.weight: Theme.weightBold
            font.family: Theme.fontFamily
            color: Theme.text
        }

    }

    // 重绘触发
    Connections {
        target: root
        function onValueChanged() { fillCanvas.requestPaint() }
    }
    Connections {
        target: Theme
        function onStyleChanged() { trackCanvas.requestPaint(); fillCanvas.requestPaint() }
        function onIsDarkChanged() { trackCanvas.requestPaint(); fillCanvas.requestPaint() }
    }
}
