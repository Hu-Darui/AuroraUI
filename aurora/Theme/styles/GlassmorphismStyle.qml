import QtQuick

QtObject {
    id: root

    // ── Light Mode ──
    property QtObject light: QtObject {
        readonly property color background:    "#F0F0F5"
        readonly property color backgroundGradientA: "#E8D5F5"
        readonly property color backgroundGradientB: "#D5E8F5"
        readonly property color backgroundGradientC: "#F5E2D5"

        readonly property color surface:       Qt.rgba(1, 1, 1, 0.22)
        readonly property color elevated:      Qt.rgba(1, 1, 1, 0.35)
        readonly property color surfaceDark:   Qt.rgba(0.94, 0.94, 0.98, 0.28)

        readonly property color text:          "#1A1A2E"
        readonly property color textSecondary: "#5A5A7A"
        readonly property color primary:       "#6366F1"
        readonly property color accent:        "#EC4899"
        readonly property color success:       "#10B981"
        readonly property color warning:       "#F59E0B"
        readonly property color danger:        "#EF4444"

        readonly property color borderHighlight: Qt.rgba(1, 1, 1, 0.7)
        readonly property color borderShadow:    Qt.rgba(0, 0, 0, 0.06)
        readonly property real  borderWidth:     0.8

        readonly property real  blurAmount:   22
        readonly property real  surfaceOpacity: 0.22

        readonly property color dropShadow:    Qt.rgba(0, 0, 0, 0.10)
        readonly property real  shadowBlur:    20
        readonly property real  shadowOffset:  4
    }

    // ── Dark Mode（提高对比度和可读性） ──
    property QtObject dark: QtObject {
        readonly property color background:    "#0D0D1A"
        readonly property color backgroundGradientA: "#3B1560"
        readonly property color backgroundGradientB: "#0E3A5C"
        readonly property color backgroundGradientC: "#5C2A15"

        // 提高表面不透明度，让卡片与背景有清晰区分
        readonly property color surface:       Qt.rgba(0.18, 0.18, 0.28, 0.72)
        readonly property color elevated:      Qt.rgba(0.25, 0.25, 0.35, 0.85)
        readonly property color surfaceDark:   Qt.rgba(0.12, 0.12, 0.20, 0.60)

        readonly property color text:          "#EDEDF5"
        readonly property color textSecondary: "#AAAAC0"
        readonly property color primary:       "#9B9CFF"
        readonly property color accent:        "#F472B6"
        readonly property color success:       "#4ADE80"
        readonly property color warning:       "#FBBF24"
        readonly property color danger:        "#F87171"

        // 边框高光更明显
        readonly property color borderHighlight: Qt.rgba(1, 1, 1, 0.22)
        readonly property color borderShadow:    Qt.rgba(0, 0, 0, 0.40)
        readonly property real  borderWidth:     0.8

        readonly property real  blurAmount:   26
        readonly property real  surfaceOpacity: 0.60

        // 加深阴影让卡片更突出
        readonly property color dropShadow:    Qt.rgba(0, 0, 0, 0.50)
        readonly property real  shadowBlur:    28
        readonly property real  shadowOffset:  8
    }

    // ── 半径 ──
    readonly property real radiusSm: 8
    readonly property real radiusMd: 14
    readonly property real radiusLg: 20
    readonly property real radiusPill: 999
}
