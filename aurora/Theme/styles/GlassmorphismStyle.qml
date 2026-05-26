import QtQuick

QtObject {
    id: root

    // ── Light Mode ──
    property QtObject light: QtObject {
        // 背景区域放置 vibrant 渐变，玻璃卡片浮在上方
        readonly property color background:    "#F0F0F5"
        readonly property color backgroundGradientA: "#E8D5F5"
        readonly property color backgroundGradientB: "#D5E8F5"
        readonly property color backgroundGradientC: "#F5E2D5"

        // 玻璃表面
        readonly property color surface:       Qt.rgba(1, 1, 1, 0.22)
        readonly property color elevated:      Qt.rgba(1, 1, 1, 0.35)
        readonly property color surfaceDark:   Qt.rgba(0.94, 0.94, 0.98, 0.28)

        // 文字
        readonly property color text:          "#1A1A2E"
        readonly property color textSecondary: "#5A5A7A"
        readonly property color primary:       "#6366F1"
        readonly property color accent:        "#EC4899"
        readonly property color success:       "#10B981"
        readonly property color warning:       "#F59E0B"
        readonly property color danger:        "#EF4444"

        // 玻璃边框高光
        readonly property color borderHighlight: Qt.rgba(1, 1, 1, 0.7)
        readonly property color borderShadow:    Qt.rgba(0, 0, 0, 0.06)
        readonly property real  borderWidth:     0.8

        // 背景模糊
        readonly property real  blurAmount:   22
        readonly property real  surfaceOpacity: 0.22

        // 阴影
        readonly property color dropShadow:    Qt.rgba(0, 0, 0, 0.10)
        readonly property real  shadowBlur:    20
        readonly property real  shadowOffset:  4
    }

    // ── Dark Mode ──
    property QtObject dark: QtObject {
        readonly property color background:    "#0C0C14"
        readonly property color backgroundGradientA: "#1A0A2E"
        readonly property color backgroundGradientB: "#0A1628"
        readonly property color backgroundGradientC: "#2E1A0A"

        readonly property color surface:       Qt.rgba(0.15, 0.15, 0.22, 0.30)
        readonly property color elevated:      Qt.rgba(0.22, 0.22, 0.30, 0.45)
        readonly property color surfaceDark:   Qt.rgba(0.08, 0.08, 0.14, 0.35)

        readonly property color text:          "#E8E8F2"
        readonly property color textSecondary: "#9898B8"
        readonly property color primary:       "#818CF8"
        readonly property color accent:        "#F472B6"
        readonly property color success:       "#34D399"
        readonly property color warning:       "#FBBF24"
        readonly property color danger:        "#F87171"

        readonly property color borderHighlight: Qt.rgba(1, 1, 1, 0.12)
        readonly property color borderShadow:    Qt.rgba(0, 0, 0, 0.25)
        readonly property real  borderWidth:     0.6

        readonly property real  blurAmount:   28
        readonly property real  surfaceOpacity: 0.28

        readonly property color dropShadow:    Qt.rgba(0, 0, 0, 0.35)
        readonly property real  shadowBlur:    26
        readonly property real  shadowOffset:  6
    }

    // ── 半径 ──
    readonly property real radiusSm: 8
    readonly property real radiusMd: 14
    readonly property real radiusLg: 20
    readonly property real radiusPill: 999
}
