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
    readonly property bool _isDef:  Theme.style === Theme.styleDefault

    implicitHeight: _h
    implicitWidth:  contentItem.implicitWidth + _padH * 2

    // ═══════════════════════════════════════
    // 背景色
    // ═══════════════════════════════════════
    readonly property color _bgColor: {
        if (!enabled) return Theme.isDark ? "#2A2A2C" : "#F0F0F0"
        if (_isNeu) return Theme.background
        if (_isLiq) {
            if (variant === "ghost") return "transparent"
            // primary 用渐变，这里给 fallback 底色（渐变层叠在上面）
            if (variant === "primary") return Theme.isDark ? Qt.rgba(0.20, 0.10, 0.60, 0.85) : Qt.rgba(0.20, 0.30, 0.90, 0.80)
            return Theme.isDark ? Qt.rgba(1, 1, 1, 0.07) : Qt.rgba(1, 1, 1, 0.35)
        }
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
            if (variant === "destructive") return "#FFFFFF"
            if (variant === "ghost")       return Theme.primary
            if (variant === "tinted")      return Theme.primary
            return Theme.isDark ? Qt.rgba(1,1,1,0.85) : Qt.rgba(0,0,0,0.75)
        }
        if (variant === "primary")     return "#FFFFFF"
        if (variant === "secondary")   return Theme.text
        if (variant === "tinted")      return Theme.isDark ? "#0A84FF" : "#0071E3"
        if (variant === "destructive") return "#FFFFFF"
        return Theme.isDark ? "#0A84FF" : "#0071E3"
    }

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
            radius: _isNeu ? Theme.radiusMd : _isLiq ? Theme.radiusMd : root._r
            color: root._bgColor

            Behavior on color { ColorAnimation { duration: Theme.durationFast } }

            // ── LiquidGlass primary: 渐变填充层 ──
            Rectangle {
                visible: root._isLiq && root.variant === "primary" && root.enabled
                anchors.fill: parent
                radius: parent.radius
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Theme.isDark ? "#6622EE" : "#5544FF" }
                    GradientStop { position: 1.0; color: Theme.isDark ? "#0055FF" : "#2288FF" }
                }
                opacity: root.pressed ? 0.80 : 1.0
                Behavior on opacity { NumberAnimation { duration: 80 } }
            }

            // ── LiquidGlass destructive: 渐变填充层 ──
            Rectangle {
                visible: root._isLiq && root.variant === "destructive" && root.enabled
                anchors.fill: parent
                radius: parent.radius
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Theme.isDark ? "#FF2244" : "#FF3B30" }
                    GradientStop { position: 1.0; color: Theme.isDark ? "#CC1122" : "#CC2020" }
                }
                opacity: root.pressed ? 0.80 : 1.0
                Behavior on opacity { NumberAnimation { duration: 80 } }
            }

            // ── LiquidGlass: 顶部高光条 ──
            Rectangle {
                visible: root._isLiq && root.enabled && root.variant !== "ghost"
                anchors {
                    top: parent.top; topMargin: 1
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width * 0.65
                height: 1
                radius: 1
                opacity: root.variant === "primary" ? 0.45 : (Theme.isDark ? 0.40 : 0.75)
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0;  color: "transparent" }
                    GradientStop { position: 0.30; color: "white" }
                    GradientStop { position: 0.70; color: "white" }
                    GradientStop { position: 1.0;  color: "transparent" }
                }
            }

            // ── 默认：顶部高光细线 ──
            Rectangle {
                visible: _isDef && !Theme.isDark && (variant === "secondary" || variant === "primary" || variant === "destructive")
                anchors { top: parent.top; left: parent.left; right: parent.right }
                anchors.topMargin:  0.5
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
                    if (root.pressed) return Qt.rgba(0, 0, 0, _isLiq ? 0.12 : 0.08)
                    return "transparent"
                }
                Behavior on color { ColorAnimation { duration: 60 } }
            }

            // ── Hover 高亮 ──
            Rectangle {
                visible: !_isNeu && (variant === "secondary" || variant === "ghost"
                         || variant === "tinted" || _isLiq)
                anchors.fill: parent
                radius: parent.radius
                color: {
                    if (!root.hovered || root.pressed) return "transparent"
                    if (_isLiq) {
                        if (root.variant === "primary" || root.variant === "destructive")
                            return Qt.rgba(1, 1, 1, 0.12)
                        return Qt.rgba(1, 1, 1, 0.10)
                    }
                    return Qt.rgba(0, 0, 0, Theme.isDark ? 0.06 : 0.04)
                }
                Behavior on color { ColorAnimation { duration: 100 } }
            }

            // ── 边框 ──
            property color _borderClr: {
                if (_isNeu)  return "transparent"
                if (_isLiq) {
                    if (variant === "primary" || variant === "destructive")
                        return Qt.rgba(1, 1, 1, Theme.isDark ? 0.30 : 0.40)
                    if (variant === "ghost")
                        return Theme.isDark ? Qt.rgba(1,1,1,0.25) : Qt.rgba(0,0,0,0.18)
                    return Theme.isDark ? Qt.rgba(1, 1, 1, 0.20) : Qt.rgba(1, 1, 1, 0.70)
                }
                if (variant === "secondary") return Theme.isDark ? "#48484A" : "#D1D1D6"
                if (variant === "ghost")     return Theme.isDark ? "#0A84FF" : "#0071E3"
                return "transparent"
            }

            border.color: _borderClr
            border.width: {
                if (_isNeu) return 0
                if (_isLiq) return 1
                if (variant === "secondary" || variant === "ghost") return 0.5
                return 0
            }

            // ── 阴影 ──
            layer.enabled: !_isNeu && (_isLiq
                           || variant === "primary" || variant === "secondary" || variant === "destructive")
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: {
                    if (_isLiq && (root.variant === "primary" || root.variant === "destructive"))
                        return Qt.rgba(0, 0, 0, 0.35)
                    if (_isLiq) return Qt.rgba(0, 0, 0, 0.20)
                    return Qt.rgba(0, 0, 0, Theme.isDark ? 0.35 : 0.15)
                }
                shadowBlur: _isLiq ? 0.5 : 0.3
                shadowVerticalOffset: _isLiq ? 3 : 1
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
    // 按下缩放动画
    // ═══════════════════════════════════════
    scale: {
        if (_isNeu && pressed) return 0.98
        if (pressed) return 0.96
        return 1.0
    }
    Behavior on scale {
        NumberAnimation { duration: _isNeu ? 120 : 80; easing.type: Easing.OutQuad }
    }

    focusPolicy: Qt.NoFocus
}
