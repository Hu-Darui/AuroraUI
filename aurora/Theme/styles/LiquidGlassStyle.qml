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
        readonly property color gradientA:     "#D4D4F0"   
        readonly property color gradientB:     "#E2D4F0"   
        readonly property color gradientC:     "#D4E2F8"   
        readonly property color gradientD:     "#F0D4E8"   

        readonly property color glowOrb0:      "#A0A0FF"   
        readonly property color glowOrb1:      "#C0A0FF"   
        readonly property color glowOrb2:      "#FFA0C0"   
        readonly property color glowOrb3:      "#A0C8FF"   
        readonly property color glowOrb4:      "#D0A0FF"   
        readonly property real  glowOrbOpacity: 0.30

        // ── 玻璃材质分层 ─────────────────────
        readonly property color lgSurface:         Qt.rgba(1, 1, 1, 0.45)
        readonly property color lgSurfaceHover:    Qt.rgba(1, 1, 1, 0.60)
        readonly property color lgSurfacePressed:  Qt.rgba(1, 1, 1, 0.35)

        // ✨【新增】浅色有色流体玻璃（完美匹配 #5E5CE6）
        readonly property color lgPrimary:         Qt.rgba(0.37, 0.36, 0.90, 0.85) 
        readonly property color lgPrimaryShadow:   Qt.rgba(0.37, 0.36, 0.90, 0.35) 

        readonly property color lgBorderTop:       Qt.rgba(1, 1, 1, 0.85)
        readonly property color lgBorderBottom:    Qt.rgba(0, 0, 0, 0.10)
        readonly property color lgBorderLeft:      Qt.rgba(1, 1, 1, 0.70)
        readonly property color lgBorderRight:     Qt.rgba(0, 0, 0, 0.06)
        
        readonly property color borderGlow:        Qt.rgba(1, 1, 1, 0.75)
        readonly property real  borderWidth:       0.8
        readonly property color innerHighlight:    Qt.rgba(1, 1, 1, 0.80)
        readonly property color lgHighlight:       Qt.rgba(1, 1, 1, 0.92)
        readonly property color lgInnerShadow:     Qt.rgba(0, 0, 0, 0.05)
        readonly property color lgSheen:           Qt.rgba(1, 1, 1, 0.55)
        readonly property real  lgSheenOpacity:    0.55

        // ── 棱镜折射色斑（彩虹效果）────────────
        readonly property color lgPrismA:          Qt.rgba(0.38, 0.58, 1.00, 0.12)  
        readonly property color lgPrismB:          Qt.rgba(1.00, 0.38, 0.65, 0.09)  
        readonly property color lgPrismC:          Qt.rgba(0.38, 1.00, 0.75, 0.08)  
        readonly property color lgPrismD:          Qt.rgba(1.00, 0.85, 0.30, 0.07)  

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

        // ── 投影 ─────────────────────────────
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
        readonly property color gradientA:     "#0A0A2E"   
        readonly property color gradientB:     "#1A0533"   
        readonly property color gradientC:     "#0D1B4B"   
        readonly property color gradientD:     "#001A33"   

        readonly property color glowOrb0:      "#7722FF"   
        readonly property color glowOrb1:      "#0055FF"   
        readonly property color glowOrb2:      "#FF0077"   
        readonly property color glowOrb3:      "#00AAFF"   
        readonly property color glowOrb4:      "#AA00FF"   
        readonly property real  glowOrbOpacity: 0.28

        // ── 玻璃材质分层 ─────────────────────
        readonly property color lgSurface:         Qt.rgba(1, 1, 1, 0.07)
        readonly property color lgSurfaceHover:    Qt.rgba(1, 1, 1, 0.13)
        readonly property color lgSurfacePressed:  Qt.rgba(1, 1, 1, 0.05)

        // ✨【新增】深色有色流体玻璃（完美匹配 #7D7AFF）
        readonly property color lgPrimary:         Qt.rgba(0.49, 0.48, 1.00, 0.85) 
        readonly property color lgPrimaryShadow:   Qt.rgba(0.49, 0.48, 1.00, 0.40) 

        readonly property color lgBorderTop:       Qt.rgba(1, 1, 1, 0.28)
        readonly property color lgBorderBottom:    Qt.rgba(1, 1, 1, 0.06)
        readonly property color lgBorderLeft:      Qt.rgba(1, 1, 1, 0.20)
        readonly property color lgBorderRight:     Qt.rgba(1, 1, 1, 0.04)
        
        readonly property color borderGlow:        Qt.rgba(1, 1, 1, 0.22)
        readonly property real  borderWidth:       0.8
        readonly property color innerHighlight:    Qt.rgba(1, 1, 1, 0.18)
        readonly property color lgHighlight:       Qt.rgba(1, 1, 1, 0.55)
        readonly property color lgInnerShadow:     Qt.rgba(0, 0, 0, 0.30)
        readonly property color lgSheen:           Qt.rgba(1, 1, 1, 0.10)
        readonly property real  lgSheenOpacity:    0.10

        // ── 棱镜折射色斑 ─────────────────────
        readonly property color lgPrismA:          Qt.rgba(0.40, 0.62, 1.00, 0.07)  
        readonly property color lgPrismB:          Qt.rgba(1.00, 0.40, 0.68, 0.06)  
        readonly property color lgPrismC:          Qt.rgba(0.40, 1.00, 0.78, 0.06)  
        readonly property color lgPrismD:          Qt.rgba(1.00, 0.88, 0.32, 0.05)  

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
    // 圆角
    // ══════════════════════════════════════════
    readonly property real radiusSm:   10
    readonly property real radiusMd:   16
    readonly property real radiusLg:   24
    readonly property real radiusXl:   32
    readonly property real radiusPill: 999
}