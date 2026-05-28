import QtQuick

QtObject {
    id: root

    // ══════════════════════════════════════════
    // Light Mode
    // ══════════════════════════════════════════
    property QtObject light: QtObject {

        // ── 基础色板 ──────────────────────────
        readonly property color background:    "#E8E8F0"
        readonly property color surface:       Qt.rgba(1, 1, 1, 0.55)
        readonly property color elevated:      Qt.rgba(1, 1, 1, 0.72)
        readonly property color text:          "#1C1C1E"
        readonly property color textSecondary: "#6E6E73"
        readonly property color primary:       "#5E5CE6"
        readonly property color accent:        "#FF375F"
        readonly property color success:       "#34C759"
        readonly property color warning:       "#FF9500"
        readonly property color danger:        "#FF3B30"

        // ── 页面背景（壁纸基色 + 光晕球颜色）──
        // 浅色模式：淡紫蓝色调，接近 macOS Sequoia 默认壁纸
        readonly property color gradientA:     "#D4D4F0"   // 左上 淡紫
        readonly property color gradientB:     "#E2D4F0"   // 右上 淡粉紫
        readonly property color gradientC:     "#D4E2F8"   // 左下 淡蓝
        readonly property color gradientD:     "#F0D4E8"   // 右下 淡玫瑰

        // 背景光晕球（散射光源）
        readonly property color glowOrb0:      "#A0A0FF"   // 蓝紫
        readonly property color glowOrb1:      "#C0A0FF"   // 紫
        readonly property color glowOrb2:      "#FFA0C0"   // 玫瑰
        readonly property color glowOrb3:      "#A0C8FF"   // 天蓝
        readonly property color glowOrb4:      "#D0A0FF"   // 淡紫
        readonly property real  glowOrbOpacity: 0.30

        // ── 玻璃材质分层 ─────────────────────
        // 主体填充：白色带透明，浅色下需要更高不透明度才有分层感
        readonly property color lgSurface:         Qt.rgba(1, 1, 1, 0.45)
        readonly property color lgSurfaceHover:    Qt.rgba(1, 1, 1, 0.60)
        readonly property color lgSurfacePressed:  Qt.rgba(1, 1, 1, 0.35)

        // 边框：上边亮（高光），下边暗（厚度感）
        readonly property color lgBorderTop:       Qt.rgba(1, 1, 1, 0.85)
        readonly property color lgBorderBottom:    Qt.rgba(0, 0, 0, 0.10)
        readonly property color lgBorderLeft:      Qt.rgba(1, 1, 1, 0.70)
        readonly property color lgBorderRight:     Qt.rgba(0, 0, 0, 0.06)
        // 兼容旧字段
        readonly property color borderGlow:        Qt.rgba(1, 1, 1, 0.75)
        readonly property real  borderWidth:       0.8
        readonly property color innerHighlight:    Qt.rgba(1, 1, 1, 0.80)

        // 顶部 1px 高光条（玻璃最亮的反射边）
        readonly property color lgHighlight:       Qt.rgba(1, 1, 1, 0.92)

        // 内部阴影（玻璃底部/内侧的阴影感，浅色较弱）
        readonly property color lgInnerShadow:     Qt.rgba(0, 0, 0, 0.05)

        // 左上角漫反射光斑
        readonly property color lgSheen:           Qt.rgba(1, 1, 1, 0.55)
        readonly property real  lgSheenOpacity:    0.55

        // ── 棱镜折射色斑（彩虹效果）────────────
        // 浅色模式下折射更明显，透明度稍高
        readonly property color lgPrismA:          Qt.rgba(0.38, 0.58, 1.00, 0.12)  // 蓝
        readonly property color lgPrismB:          Qt.rgba(1.00, 0.38, 0.65, 0.09)  // 粉
        readonly property color lgPrismC:          Qt.rgba(0.38, 1.00, 0.75, 0.08)  // 青绿
        readonly property color lgPrismD:          Qt.rgba(1.00, 0.85, 0.30, 0.07)  // 琥珀

        // ── 模糊与透明度参数 ──────────────────
        readonly property real  blurAmount:        28
        readonly property real  blurMax:           48
        readonly property real  surfaceOpacity:    0.45
        readonly property real  borderOpacity:     0.80
        readonly property real  highlightOpacity:  0.92

        // ── shimmer 动画色 ────────────────────
        readonly property color shimmerHighlight:  Qt.rgba(1, 1, 1, 0.65)
        readonly property color shimmerMid:        Qt.rgba(1, 1, 1, 0.12)
        readonly property color shimmerEnd:        Qt.rgba(1, 1, 1, 0.00)

        // ── 投影（组件悬浮阴影）──────────────
        readonly property color dropShadow:        Qt.rgba(0, 0, 0, 0.18)
        readonly property real  shadowBlur:        20
        readonly property real  shadowOffset:      8
    }

    // ══════════════════════════════════════════
    // Dark Mode
    // ══════════════════════════════════════════
    property QtObject dark: QtObject {

        // ── 基础色板 ──────────────────────────
        readonly property color background:    "#0A0A1E"
        readonly property color surface:       Qt.rgba(1, 1, 1, 0.08)
        readonly property color elevated:      Qt.rgba(1, 1, 1, 0.14)
        readonly property color text:          "#F5F5F7"
        readonly property color textSecondary: "#98989D"
        readonly property color primary:       "#7D7AFF"
        readonly property color accent:        "#FF6482"
        readonly property color success:       "#30D158"
        readonly property color warning:       "#FF9F0A"
        readonly property color danger:        "#FF453A"

        // ── 页面背景（深色宇宙感）─────────────
        readonly property color gradientA:     "#0A0A2E"   // 深蓝紫
        readonly property color gradientB:     "#1A0533"   // 深紫
        readonly property color gradientC:     "#0D1B4B"   // 深蓝
        readonly property color gradientD:     "#001A33"   // 深海蓝

        // 背景光晕球（暗色下更鲜艳，制造深度）
        readonly property color glowOrb0:      "#7722FF"   // 紫
        readonly property color glowOrb1:      "#0055FF"   // 蓝
        readonly property color glowOrb2:      "#FF0077"   // 玫红
        readonly property color glowOrb3:      "#00AAFF"   // 天蓝
        readonly property color glowOrb4:      "#AA00FF"   // 深紫
        readonly property real  glowOrbOpacity: 0.28

        // ── 玻璃材质分层 ─────────────────────
        // 暗色下玻璃透明度低，依赖高光线和折射色体现材质
        readonly property color lgSurface:         Qt.rgba(1, 1, 1, 0.07)
        readonly property color lgSurfaceHover:    Qt.rgba(1, 1, 1, 0.13)
        readonly property color lgSurfacePressed:  Qt.rgba(1, 1, 1, 0.05)

        // 边框
        readonly property color lgBorderTop:       Qt.rgba(1, 1, 1, 0.28)
        readonly property color lgBorderBottom:    Qt.rgba(1, 1, 1, 0.06)
        readonly property color lgBorderLeft:      Qt.rgba(1, 1, 1, 0.20)
        readonly property color lgBorderRight:     Qt.rgba(1, 1, 1, 0.04)
        // 兼容旧字段
        readonly property color borderGlow:        Qt.rgba(1, 1, 1, 0.22)
        readonly property real  borderWidth:       0.8
        readonly property color innerHighlight:    Qt.rgba(1, 1, 1, 0.18)

        // 顶部高光条
        readonly property color lgHighlight:       Qt.rgba(1, 1, 1, 0.55)

        // 内部阴影（暗色下更明显）
        readonly property color lgInnerShadow:     Qt.rgba(0, 0, 0, 0.30)

        // 左上角漫反射光斑
        readonly property color lgSheen:           Qt.rgba(1, 1, 1, 0.10)
        readonly property real  lgSheenOpacity:    0.10

        // ── 棱镜折射色斑 ─────────────────────
        // 暗色下折射色更饱和但透明度稍低
        readonly property color lgPrismA:          Qt.rgba(0.40, 0.62, 1.00, 0.07)  // 蓝
        readonly property color lgPrismB:          Qt.rgba(1.00, 0.40, 0.68, 0.06)  // 粉
        readonly property color lgPrismC:          Qt.rgba(0.40, 1.00, 0.78, 0.06)  // 青绿
        readonly property color lgPrismD:          Qt.rgba(1.00, 0.88, 0.32, 0.05)  // 琥珀

        // ── 模糊与透明度参数 ──────────────────
        readonly property real  blurAmount:        32
        readonly property real  blurMax:           56
        readonly property real  surfaceOpacity:    0.07
        readonly property real  borderOpacity:     0.22
        readonly property real  highlightOpacity:  0.55

        // ── shimmer 动画色 ────────────────────
        readonly property color shimmerHighlight:  Qt.rgba(1, 1, 1, 0.22)
        readonly property color shimmerMid:        Qt.rgba(1, 1, 1, 0.06)
        readonly property color shimmerEnd:        Qt.rgba(1, 1, 1, 0.00)

        // ── 投影 ─────────────────────────────
        readonly property color dropShadow:        Qt.rgba(0, 0, 0, 0.45)
        readonly property real  shadowBlur:        28
        readonly property real  shadowOffset:      12
    }

    // ══════════════════════════════════════════
    // 动画时长
    // ══════════════════════════════════════════
    readonly property int morphDuration:    600
    readonly property int shimmerDuration:  2400
    readonly property int flowDuration:     3600
    readonly property int hoverDuration:    160
    readonly property int pressDuration:    80

    // ══════════════════════════════════════════
    // 圆角（Liquid Glass 偏大圆角）
    // ══════════════════════════════════════════
    readonly property real radiusSm:   10
    readonly property real radiusMd:   16
    readonly property real radiusLg:   24
    readonly property real radiusXl:   32
    readonly property real radiusPill: 999
}