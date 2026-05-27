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

        readonly property color gradientA: "#7C3AED"
        readonly property color gradientB: "#3B82F6"
        readonly property color gradientC: "#06B6D4"
        readonly property color gradientD: "#8B5CF6"

        readonly property color shimmerHighlight: Qt.rgba(1, 1, 1, 0.09)
        readonly property color shimmerMid:        Qt.rgba(1, 1, 1, 0.03)

        readonly property real  blurAmount:       28
        readonly property real  surfaceOpacity:    0.40
        readonly property real  borderOpacity:     0.18
        readonly property real  highlightOpacity:  0.22

        readonly property color borderGlow:    Qt.rgba(1, 1, 1, 0.15)
        readonly property real  borderWidth:   1.0
        readonly property color innerHighlight: Qt.rgba(1, 1, 1, 0.08)
    }

    // ── Dark Mode（提高对比度，深而清晰） ──
    property QtObject dark: QtObject {
        // 背景保持深邃但不要全黑
        readonly property color background:    "#070718"
        // 表面不透明度大幅提高，卡片与背景有明显分界
        readonly property color surface:       Qt.rgba(0.14, 0.14, 0.26, 0.65)
        readonly property color elevated:      Qt.rgba(0.20, 0.20, 0.33, 0.78)
        // 文字更亮更高对比
        readonly property color text:          "#E8E8F5"
        readonly property color textSecondary: "#9A9AC0"
        // 主色提亮
        readonly property color primary:       "#C4B5FD"
        readonly property color accent:        "#F9A8D4"
        readonly property color success:       "#6EE7B7"
        readonly property color warning:       "#FCD34D"
        readonly property color danger:        "#FCA5A5"

        // 渐变色彩更饱和
        readonly property color gradientA: "#6D28D9"
        readonly property color gradientB: "#2563EB"
        readonly property color gradientC: "#0891B2"
        readonly property color gradientD: "#7C3AED"

        readonly property color shimmerHighlight: Qt.rgba(1, 1, 1, 0.08)
        readonly property color shimmerMid:        Qt.rgba(1, 1, 1, 0.03)

        readonly property real  blurAmount:       30
        readonly property real  surfaceOpacity:    0.55
        readonly property real  borderOpacity:     0.22
        readonly property real  highlightOpacity:  0.20

        // 边框发光更明显
        readonly property color borderGlow:    Qt.rgba(1, 1, 1, 0.18)
        readonly property real  borderWidth:   1.2
        readonly property color innerHighlight: Qt.rgba(1, 1, 1, 0.08)
    }

    // ── 动画 ──
    readonly property int morphDuration:   1200
    readonly property int shimmerDuration: 3000
    readonly property int flowDuration:    4000

    // ── 半径 ──
    readonly property real radiusSm: 8
    readonly property real radiusMd: 14
    readonly property real radiusLg: 22
    readonly property real radiusPill: 999
}
