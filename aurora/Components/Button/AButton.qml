import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Button {
    id: root

    property string variant: "primary"
    property string size: "md"
    property bool loading: false

    readonly property int _h:    size === "sm" ? 24 : size === "lg" ? 36 : 28
    readonly property int _padH: size === "sm" ? 10 : size === "lg" ? 20 : 14
    readonly property int _r:    size === "sm" ?  6 : size === "lg" ?  9 :  7
    readonly property int _fs:   size === "sm" ? 12 : size === "lg" ? 15 : 13

    readonly property bool _isNeu:  Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq:  Theme.style === Theme.styleLiquidGlass
    readonly property bool _isGls:  Theme.style === Theme.styleGlassmorphism
    readonly property bool _isDef:  Theme.style === Theme.styleDefault

    implicitHeight: _h
    implicitWidth:  contentItem.implicitWidth + _padH * 2

    // ═══════════════════════════════════════
    // 背景色
    // ═══════════════════════════════════════
    readonly property color _bgColor: {
        if (!enabled) return Theme.isDark ? "#2A2A2C" : "#F0F0F0"

        // ── Neumorphism: 与背景同色 ──
        if (_isNeu) return Theme.background

        // ── Liquid Glass: 半透明 ──
        if (_isLiq) {
            if (variant === "primary") return Qt.rgba(0.65, 0.55, 0.95, Theme.lgSurfaceOpacity + 0.15)
            if (variant === "ghost")   return "transparent"
            return Qt.rgba(1, 1, 1, Theme.lgSurfaceOpacity)
        }

        // ── Glassmorphism: 半透明白 ──
        if (_isGls) {
            if (variant === "primary") return Qt.rgba(0.39, 0.33, 0.95, 0.55)
            if (variant === "ghost")   return "transparent"
            return Theme.surface
        }

        // ── Default ──
        if (variant === "primary")     return Theme.isDark ? "#0A84FF" : "#0071E3"
        if (variant === "secondary")   return Theme.isDark ? "#3A3A3C" : "#FFFFFF"
        if (variant === "tinted")      return Theme.isDark ? Qt.rgba(0.04, 0.52, 1, 0.18) : Qt.rgba(0, 0.44, 0.89, 0.10)
        if (variant === "destructive") return Theme.isDark ? "#FF453A" : "#FF3B30"
        return "transparent"
    }

    // ═══════════════════════════════════════
    // 前景色
    // ═══════════════════════════════════════
    readonly property color _fgColor: {
        if (!enabled) return Theme.isDark ? "#4A4A4E" : "#AAAAAA"

        if (_isNeu) {
            if (variant === "primary")     return Theme.primary
            if (variant === "destructive") return Theme.danger
            if (variant === "ghost")       return Theme.textSecondary
            return Theme.text
        }

        if (_isLiq) {
            if (variant === "primary")     return "#FFFFFF"
            if (variant === "ghost")       return Theme.isDark ? Theme.liquidGlass.dark.primary : Theme.liquidGlass.light.primary
            return Theme.text
        }

        if (_isGls) {
            if (variant === "primary")     return "#FFFFFF"
            if (variant === "ghost")       return Theme.primary
            return Theme.text
        }

        // Default
        if (variant === "primary")     return "#FFFFFF"
        if (variant === "secondary")   return Theme.text
        if (variant === "tinted")      return Theme.isDark ? "#0A84FF" : "#0071E3"
        if (variant === "destructive") return "#FFFFFF"
        return Theme.isDark ? "#0A84FF" : "#0071E3"
    }

    // ═══════════════════════════════════════
    // Neumorphism 阴影组件（light-shadow + dark-shadow）
    // ═══════════════════════════════════════
    readonly property bool _neuRaised:  _isNeu && !root.pressed
    readonly property bool _neuPressed: _isNeu && root.pressed

    // ═══════════════════════════════════════
    // background
    // ═══════════════════════════════════════
    background: Item {
        // ── Neumorphism: 亮面高光（左上） ──
        Rectangle {
            visible: root._neuRaised
            anchors {
                fill: parent
                topMargin:  -Theme.neuShadowDist * 0.4
                leftMargin: -Theme.neuShadowDist * 0.4
            }
            radius: root._r + Theme.neuShadowDist * 0.4
            color: Theme.neuLightShadow
        }

        // ── Neumorphism: 暗面阴影（右下） ──
        Rectangle {
            visible: root._neuRaised
            anchors {
                fill: parent
                bottomMargin: -Theme.neuShadowDist * 0.5
                rightMargin:  -Theme.neuShadowDist * 0.5
            }
            radius: root._r + Theme.neuShadowDist * 0.5
            color: Theme.neuDarkShadow
        }

        // ── 主表面 ──
        Rectangle {
            id: bgRect
            anchors.fill: parent
            radius: {
                if (_isNeu) return Theme.radiusMd
                if (_isLiq) return Theme.radiusMd
                if (_isGls) return Theme.radiusMd
                return root._r
            }
            color: root._bgColor

            Behavior on color { ColorAnimation { duration: Theme.durationFast } }

            // ── Neumorphism: 表面凸起 ──
            // (颜色与背景相同，阴影提供深度)

            // ── Glassmorphism: 顶部高光（暗色模式下不显示） ──
            Rectangle {
                visible: _isGls && variant !== "ghost" && !Theme.isDark
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: 0.8
                radius: parent.radius
                color: root.pressed ? "transparent" : Qt.rgba(1, 1, 1, 0.40)
            }

            // ── 默认：顶部高光细线（暗色模式不显示） ──
            Rectangle {
                visible: _isDef && !Theme.isDark && (variant === "secondary" || variant === "primary" || variant === "destructive")
                anchors { top: parent.top; left: parent.left; right: parent.right }
                anchors.topMargin: 0.5
                anchors.leftMargin: 1
                anchors.rightMargin: 1
                height: 1
                radius: root._r
                color: Qt.rgba(1, 1, 1, variant === "secondary" ? 0.85 : 0.22)
            }

            // ── 按下覆盖层 ──
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: {
                    if (_isNeu && root.pressed) return Theme.neuInsetDark
                    if (root.pressed) return Qt.rgba(0, 0, 0, _isGls ? 0.06 : _isLiq ? 0.10 : 0.08)
                    return "transparent"
                }
                Behavior on color { ColorAnimation { duration: 60 } }
            }

            // ── Hover 高亮（非 neumorphism） ──
            Rectangle {
                visible: !_isNeu && (variant === "secondary" || variant === "ghost" || variant === "tinted"
                         || _isGls || _isLiq)
                anchors.fill: parent
                radius: parent.radius
                color: {
                    if (!root.hovered || root.pressed) return "transparent"
                    if (_isGls) return Qt.rgba(1, 1, 1, 0.08)
                    if (_isLiq) return Qt.rgba(1, 1, 1, 0.06)
                    return Qt.rgba(0, 0, 0, Theme.isDark ? 0.06 : 0.04)
                }
                Behavior on color { ColorAnimation { duration: 100 } }
            }

            // ── 边框 ──
            property color _borderClr: {
                if (_isNeu)  return "transparent"
                if (_isLiq)  return Theme.border
                if (_isGls)  return Theme.gmBorderHighlight
                if (variant === "secondary") return Theme.isDark ? "#48484A" : "#D1D1D6"
                if (variant === "ghost")     return Theme.isDark ? "#0A84FF" : "#0071E3"
                return "transparent"
            }

            border.color: _borderClr
            border.width: {
                if (_isNeu) return 0
                if (_isLiq) return 1.0
                if (_isGls) return Theme.gmBorderWidth
                if (variant === "secondary" || variant === "ghost") return 0.5
                return 0
            }

            // ── 阴影（非 neumorphism） ──
            layer.enabled: !_isNeu && (_isGls || _isLiq
                           || variant === "primary" || variant === "secondary" || variant === "destructive")
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: {
                    if (_isGls) return Theme.gmDropShadow
                    if (_isLiq) return Qt.rgba(0, 0, 0, 0.25)
                    return Qt.rgba(0, 0, 0, Theme.isDark ? 0.35 : 0.15)
                }
                shadowBlur: {
                    if (_isGls) return Theme.gmShadowBlur * 0.4
                    if (_isLiq) return 0.5
                    return 0.3
                }
                shadowVerticalOffset: {
                    if (_isGls) return Theme.gmShadowOffset * 0.5
                    if (_isLiq) return 2
                    return 1
                }
            }
        }
    }

    // ═══════════════════════════════════════
    // contentItem
    // ═══════════════════════════════════════
    contentItem: Row {
        spacing: 5
        anchors.centerIn: parent

        Rectangle {
            visible: root.loading
            width: 12; height: 12
            radius: 6
            color: "transparent"
            border.color: root._fgColor
            border.width: 1.5
            anchors.verticalCenter: parent.verticalCenter

            RotationAnimator on rotation {
                running:  root.loading
                from: 0; to: 360
                duration: 800
                loops: Animation.Infinite
            }
        }

        Text {
            text:               root.text
            color:              root._fgColor
            font.pixelSize:     root._fs
            font.weight:        Font.Medium
            font.family:        Theme.fontFamily
            font.letterSpacing: -0.15
            renderType:         Text.NativeRendering
            anchors.verticalCenter: parent.verticalCenter

            Behavior on color { ColorAnimation { duration: Theme.durationFast } }
        }
    }

    // ═══════════════════════════════════════
    // 按下动画
    // ═══════════════════════════════════════
    scale: {
        if (_isNeu && pressed) return 0.98  // neumorphism: 轻微下沉而非缩放
        if (pressed) return 0.97
        return 1.0
    }
    Behavior on scale {
        NumberAnimation { duration: _isNeu ? 120 : 80; easing.type: Easing.OutQuad }
    }

    focusPolicy: Qt.NoFocus
}
