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

        // ── LiquidGlass: hover 白色柔光（不改变卡片色调，只提亮） ──
        Rectangle {
            id: glowRect
            visible: !root.flat && root._isLiq
            anchors.centerIn: parent
            width: parent.width * 1.10
            height: parent.height * 1.10
            radius: Theme.radiusLg + 10
            color: "white"
            opacity: 0

            Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true
                blur: 1.0
                blurMax: 56
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

            // ── 边框：白色高光边（模拟玻璃受光边缘） ──
            border.color: {
                if (root.flat) return "transparent"
                if (root._isLiq) {
                    return Theme.isDark
                           ? Qt.rgba(1, 1, 1, (root.hovered ? 0.26 : 0.16) * _intensityScale)
                           : Qt.rgba(1, 1, 1, (root.hovered ? 0.88 : 0.72) * _intensityScale)
                }
                return Qt.rgba(0, 0, 0, 0.06)
            }
            border.width: root.flat ? 0 : (root._isLiq ? 1 : 0.5)

            Behavior on border.color { ColorAnimation { duration: 200 } }

            // ── LiquidGlass: 内层深色边框（右下暗边 → 玻璃厚度感） ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors { fill: parent; margins: 1 }
                radius: parent.radius - 1
                color: "transparent"
                border.color: Theme.isDark
                              ? Qt.rgba(0, 0, 0, 0.40 * _intensityScale)
                              : Qt.rgba(0, 0, 0, 0.07 * _intensityScale)
                border.width: 1
            }

            // ── LiquidGlass: 顶部高光条（主高光，宽而亮） ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors {
                    top: parent.top; topMargin: 1
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width * 0.78
                height: 2
                radius: 1
                opacity: (Theme.isDark ? 0.55 : 0.88) * _intensityScale
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0;  color: "transparent" }
                    GradientStop { position: 0.20; color: "white" }
                    GradientStop { position: 0.80; color: "white" }
                    GradientStop { position: 1.0;  color: "transparent" }
                }
            }

            // ── LiquidGlass: 顶部漫反射环境光（✨ 核心视觉重构点） ──
            // 放弃原先有硬切边缘的 52%x50% 纯白方块，改用全宽环境光通过垂直渐变向下方柔和淡出，完美解决暗色模式下的光斑问题
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors { fill: parent; margins: 1 }
                radius: parent.radius - 1
                opacity: _intensityScale
                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { 
                        position: 0.0
                        color: Theme.isDark ? Qt.rgba(255, 255, 255, 0.06) : Qt.rgba(255, 255, 255, 0.14) 
                    }
                    GradientStop { 
                        position: 0.4
                        color: Theme.isDark ? Qt.rgba(255, 255, 255, 0.01) : Qt.rgba(255, 255, 255, 0.04) 
                    }
                    GradientStop { 
                        position: 1.0
                        color: "transparent" 
                    }
                }
            }

            // ── LiquidGlass: 底部内阴影线（玻璃下边缘厚度） ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors {
                    bottom: parent.bottom; bottomMargin: 1
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width * 0.68
                height: 1
                radius: 1
                opacity: (Theme.isDark ? 0.55 : 0.18) * _intensityScale
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0;  color: "transparent" }
                    GradientStop { position: 0.25; color: Theme.isDark ? "black" : Qt.rgba(0, 0, 0, 0.5) }
                    GradientStop { position: 0.75; color: Theme.isDark ? "black" : Qt.rgba(0, 0, 0, 0.5) }
                    GradientStop { position: 1.0;  color: "transparent" }
                }
            }
        }

        // ── Drop shadow（hover 时浮起） ──
        layer.enabled: !root.flat && root._isLiq && root.elevation >= 0
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Qt.rgba(0, 0, 0, Theme.isDark ? 0.52 : 0.18)
            shadowBlur: 0.65
            shadowVerticalOffset: root.hovered ? 10 : 5
            shadowHorizontalOffset: 0

            Behavior on shadowVerticalOffset { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
        }
    }

    // ── LiquidGlass hover 呼吸动画 ──
    SequentialAnimation {
        id: hoverAnim
        running: root._isLiq && root.hovered
        loops: Animation.Infinite
        NumberAnimation {
            target: glowRect; property: "opacity"
            to: 0.10 * _intensityScale
            duration: 1400; easing.type: Easing.InOutSine
        }
        NumberAnimation {
            target: glowRect; property: "opacity"
            to: 0.04 * _intensityScale
            duration: 1400; easing.type: Easing.InOutSine
        }
    }

    onHoveredChanged: {
        if (!root._isLiq) return
        if (root.hovered) {
            glowRect.opacity = 0.07 * _intensityScale
            hoverAnim.start()
        } else {
            hoverAnim.stop()
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