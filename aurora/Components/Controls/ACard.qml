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

        // ── Main surface ──
        Rectangle {
            id: cardBg
            anchors.fill: parent
            radius: Theme.radiusLg
            color: root.flat ? "transparent" : Theme.elevated
            border.color: root.flat ? "transparent"
                : root._isLiq ? Theme.border
                : root._isGls ? Theme.gmBorderHighlight
                : Qt.rgba(0, 0, 0, 0.06)
            border.width: root.flat ? 0
                : root._isLiq ? 1.0
                : root._isGls ? Theme.gmBorderWidth
                : 0.5

            // ── LiquidGlass: 渐变底层 ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors.fill: parent; radius: parent.radius
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.lgGradientA }
                    GradientStop { position: 0.33; color: Theme.lgGradientB }
                    GradientStop { position: 0.66; color: Theme.lgGradientC }
                    GradientStop { position: 1.0; color: Theme.lgGradientD }
                }
                opacity: Theme.isDark ? 0.35 : 0.25
            }

            // ── LiquidGlass: 渐变模糊层（毛玻璃效果） ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors { fill: parent; margins: 2 }
                radius: parent.radius - 1
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.lgGradientA }
                    GradientStop { position: 0.3; color: Theme.lgGradientB }
                    GradientStop { position: 0.7; color: Theme.lgGradientC }
                    GradientStop { position: 1.0; color: Theme.lgGradientD }
                }
                opacity: Theme.isDark ? 0.2 : 0.3
                layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: true; blurMax: Theme.lgBlurAmount
                    blur: Theme.isDark ? 0.8 : 0.6
                }
            }

            // ── LiquidGlass: 顶部光泽 ──
            Rectangle {
                visible: !root.flat && root._isLiq
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: parent.height * 0.5; radius: parent.radius
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.lgShimmerHigh }
                    GradientStop { position: 0.6; color: Theme.lgShimmerHigh }
                    GradientStop { position: 0.8; color: "transparent" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }

            // ── Glassmorphism: 顶部高光 ──
            Rectangle {
                visible: !root.flat && root._isGls
                anchors { top: parent.top; left: parent.left; leftMargin: 1; right: parent.right; rightMargin: 1 }
                height: 1.5; radius: parent.radius; color: Theme.gmBorderHighlight
            }
        }

        // ── Drop shadow ──
        layer.enabled: !root.flat && (root._isGls || root._isLiq) && root.elevation >= 0
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: root._isGls ? Theme.gmDropShadow : Qt.rgba(0, 0, 0, 0.35)
            shadowBlur: root._isGls ? Theme.gmShadowBlur * 0.5 : 0.7
            shadowVerticalOffset: root._isGls ? Theme.gmShadowOffset : 6
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
