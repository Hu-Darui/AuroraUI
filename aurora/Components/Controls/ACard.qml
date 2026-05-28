import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Control {
    id: root

    property string title: ""
    property int elevation: 0
    property bool flat: false
    property color accentColor: Theme.primary
    property real glassOpacity: -1
    property real glassIntensity: -1

    default property alias content: inner.data

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass

    readonly property real _opacityScale: glassOpacity >= 0 ? glassOpacity : 1.0
    readonly property real _intensityScale: glassIntensity >= 0 ? glassIntensity : 1.0

    padding: 20
    hoverEnabled: true

    Behavior on scale { NumberAnimation { duration: 280; easing.type: Easing.OutCubic } }

    background: Item {
        implicitWidth: 400
        implicitHeight: 150

        // ── Neumorphism shadows ──
        Rectangle {
            visible: !root.flat && root._isNeu
            anchors { fill: parent; topMargin: -8; leftMargin: -8 }
            radius: Theme.radiusLg + 8; color: Theme.neuLightShadow
        }
        Rectangle {
            visible: !root.flat && root._isNeu
            anchors { fill: parent; bottomMargin: -8; rightMargin: -8 }
            radius: Theme.radiusLg + 8; color: Theme.neuDarkShadow
        }

        // ── LiquidGlass: 背景光晕 ──
        Rectangle {
            id: glowRect
            visible: !root.flat && root._isLiq
            anchors.centerIn: parent
            width: parent.width * 0.85
            height: parent.height * 0.85
            radius: 20
            color: root.accentColor
            opacity: root.hovered ? 0.18 * _intensityScale : 0

            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true
                blur: 1.0
                blurMax: 32
            }
        }

        // ── Main surface ──
        Rectangle {
            id: cardBg
            anchors.fill: parent
            radius: Theme.radiusLg

            // ── 颜色 ──
            color: {
                if (root.flat) return "transparent"
                if (root._isLiq) {
                    var baseColor = root.hovered
                        ? (Theme.isDark ? Theme.liquidGlass.dark.lgSurfaceHover : Theme.liquidGlass.light.lgSurfaceHover)
                        : (Theme.isDark ? Theme.liquidGlass.dark.lgSurface      : Theme.liquidGlass.light.lgSurface)
                    return Qt.rgba(baseColor.r, baseColor.g, baseColor.b, baseColor.a * _opacityScale)
                }
                return Theme.elevated
            }

            Behavior on color { ColorAnimation { duration: root._isLiq ? 160 : 80 } }

            // ── 边框 ──
            border.color: {
                if (root.flat) return "transparent"
                if (root._isLiq) return "transparent"
                return Qt.rgba(0, 0, 0, 0.06)
            }
            border.width: {
                if (root.flat) return 0
                return 0.5
            }

            // ── LiquidGlass: 顶部高光条 ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors { top: parent.top; topMargin: 1; horizontalCenter: parent.horizontalCenter }
                width: parent.width * 0.55
                height: 1
                radius: 1
                opacity: (Theme.isDark ? Theme.liquidGlass.dark.highlightOpacity : Theme.liquidGlass.light.highlightOpacity) * _intensityScale
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 0.5; color: "white" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }

            // ── LiquidGlass: 左上角漫反射光斑 ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors { top: parent.top; left: parent.left; margins: 1 }
                width: parent.width * 0.40
                height: parent.height * 0.45
                radius: parent.radius * 0.85
                color: "white"
                opacity: (Theme.isDark ? 0.035 : 0.08) * _intensityScale
            }
        }

        // ── Drop shadow ──
        layer.enabled: !root.flat && root._isLiq && root.elevation >= 0
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Qt.rgba(0, 0, 0, 0.35)
            shadowBlur: root._isLiq ? 0.6 : 0.7
            shadowVerticalOffset: 6
        }
    }

    // ── LiquidGlass hover 呼吸动画 ──
    ParallelAnimation {
        id: hoverAnim
        running: root._isLiq && root.hovered
        loops: Animation.Infinite
        SequentialAnimation {
            NumberAnimation { target: root; property: "scale"; from: 1.0; to: 1.012; duration: 900; easing.type: Easing.InOutSine }
            NumberAnimation { target: root; property: "scale"; from: 1.012; to: 1.004; duration: 900; easing.type: Easing.InOutSine }
        }
        SequentialAnimation {
            NumberAnimation { target: glowRect; property: "opacity"; from: 0.18 * _intensityScale; to: 0.26 * _intensityScale; duration: 900; easing.type: Easing.InOutSine }
            NumberAnimation { target: glowRect; property: "opacity"; from: 0.26 * _intensityScale; to: 0.14 * _intensityScale; duration: 900; easing.type: Easing.InOutSine }
        }
    }
    onHoveredChanged: {
        if (!root._isLiq) return
        if (!root.hovered) {
            hoverAnim.stop()
            root.scale = 1.0
            glowRect.opacity = 0
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
