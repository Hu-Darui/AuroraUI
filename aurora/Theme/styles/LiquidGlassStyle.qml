import QtQuick

QtObject {
    id: root

    // ── Light Mode ──
    property QtObject light: QtObject {
        readonly property color background:    "#0A0A1A"
        readonly property color surface:       Qt.rgba(0.10, 0.10, 0.18, 0.45)
        readonly property color elevated:      Qt.rgba(0.15, 0.15, 0.25, 0.55)
        readonly property color text:          "#E8E8F0"
        readonly property color textSecondary: "#9898B8"
        readonly property color primary:       "#A78BFA"
        readonly property color accent:        "#F472B6"
        readonly property color success:       "#34D399"
        readonly property color warning:       "#FBBF24"
        readonly property color danger:        "#F87171"

        // 渐变基调（chromatic iridescence）
        readonly property color gradientA: "#7C3AED"
        readonly property color gradientB: "#3B82F6"
        readonly property color gradientC: "#06B6D4"
        readonly property color gradientD: "#8B5CF6"

        // 光泽高光
        readonly property color shimmerHighlight: Qt.rgba(1, 1, 1, 0.09)
        readonly property color shimmerMid:        Qt.rgba(1, 1, 1, 0.03)

        // 模糊参数
        readonly property real  blurAmount:       28
        readonly property real  surfaceOpacity:    0.40
        readonly property real  borderOpacity:     0.18
        readonly property real  highlightOpacity:  0.22

        // 边光（流动边框）
        readonly property color borderGlow:    Qt.rgba(1, 1, 1, 0.15)
        readonly property real  borderWidth:   1.0
        readonly property color innerHighlight: Qt.rgba(1, 1, 1, 0.08)
    }

    // ── Dark Mode（更深邃） ──
    property QtObject dark: QtObject {
        readonly property color background:    "#050510"
        readonly property color surface:       Qt.rgba(0.06, 0.06, 0.12, 0.40)
        readonly property color elevated:      Qt.rgba(0.10, 0.10, 0.18, 0.50)
        readonly property color text:          "#D0D0E8"
        readonly property color textSecondary: "#7878A8"
        readonly property color primary:       "#C4B5FD"
        readonly property color accent:        "#F9A8D4"
        readonly property color success:       "#6EE7B7"
        readonly property color warning:       "#FCD34D"
        readonly property color danger:        "#FCA5A5"

        readonly property color gradientA: "#5B21B6"
        readonly property color gradientB: "#1D4ED8"
        readonly property color gradientC: "#0E7490"
        readonly property color gradientD: "#6D28D9"

        readonly property color shimmerHighlight: Qt.rgba(1, 1, 1, 0.06)
        readonly property color shimmerMid:        Qt.rgba(1, 1, 1, 0.02)

        readonly property real  blurAmount:       32
        readonly property real  surfaceOpacity:    0.35
        readonly property real  borderOpacity:     0.14
        readonly property real  highlightOpacity:  0.16

        readonly property color borderGlow:    Qt.rgba(1, 1, 1, 0.10)
        readonly property real  borderWidth:   1.0
        readonly property color innerHighlight: Qt.rgba(1, 1, 1, 0.05)
    }

    // ── 动画 ──
    readonly property int morphDuration:   1200
    readonly property int shimmerDuration: 3000
    readonly property int flowDuration:    4000

    // ── 半径（高度圆润） ──
    readonly property real radiusSm: 8
    readonly property real radiusMd: 14
    readonly property real radiusLg: 22
    readonly property real radiusPill: 999
}
