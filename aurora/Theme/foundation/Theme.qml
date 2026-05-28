pragma Singleton
import QtQuick
import aurora 1.0

QtObject {
    id: root

    // ═══════════════════════════════════════
    // 设计风格枚举
    // ═══════════════════════════════════════
    readonly property int styleDefault:      0
    readonly property int styleNeumorphism:  1
    readonly property int styleLiquidGlass:  2

    property int style: styleDefault
    property bool isDark: false

    // ── 风格实例 ──
    readonly property NeumorphismStyle  neumorphism:  NeumorphismStyle {}
    readonly property LiquidGlassStyle  liquidGlass:  LiquidGlassStyle {}

    // ── 原有主题实例（兼容） ──
    readonly property LightTheme light: LightTheme {}
    readonly property DarkTheme  dark:  DarkTheme  {}

    // ═══════════════════════════════════════
    // 自适应颜色
    // ═══════════════════════════════════════

    readonly property color primary: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.primary   : neumorphism.light.primary
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.primary   : liquidGlass.light.primary
        return isDark ? dark.primary : light.primary
    }

    readonly property color text: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.text   : neumorphism.light.text
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.text   : liquidGlass.light.text
        return isDark ? dark.text : light.text
    }

    readonly property color textSecondary: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.textSecondary   : neumorphism.light.textSecondary
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.textSecondary   : liquidGlass.light.textSecondary
        return isDark ? dark.textSecondary : light.textSecondary
    }

    readonly property color border: {
        if (style === styleNeumorphism)   return "transparent"
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.borderGlow   : liquidGlass.light.borderGlow
        return isDark ? dark.border : light.border
    }

    readonly property color background: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.background   : neumorphism.light.background
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.background   : liquidGlass.light.background
        return isDark ? dark.background : light.background
    }

    readonly property color surface: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.surface   : neumorphism.light.surface
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.surface   : liquidGlass.light.surface
        return isDark ? dark.surface : light.surface
    }

    readonly property color elevated: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.elevated   : neumorphism.light.elevated
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.elevated   : liquidGlass.light.elevated
        return isDark ? dark.elevated : light.elevated
    }

    readonly property color success: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.success   : neumorphism.light.success
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.success   : liquidGlass.light.success
        return isDark ? dark.success : light.success
    }

    readonly property color warning: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.warning   : neumorphism.light.warning
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.warning   : liquidGlass.light.warning
        return isDark ? dark.warning : light.warning
    }

    readonly property color danger: {
        if (style === styleNeumorphism)   return isDark ? neumorphism.dark.danger   : neumorphism.light.danger
        if (style === styleLiquidGlass)   return isDark ? liquidGlass.dark.danger   : liquidGlass.light.danger
        return isDark ? dark.danger : light.danger
    }

    // ── 圆角 ──
    readonly property real radiusSm: {
        if (style === styleNeumorphism)   return neumorphism.radiusSm
        if (style === styleLiquidGlass)   return liquidGlass.radiusSm
        return RadiusTokens.sm
    }
    readonly property real radiusMd: {
        if (style === styleNeumorphism)   return neumorphism.radiusMd
        if (style === styleLiquidGlass)   return liquidGlass.radiusMd
        return RadiusTokens.md
    }
    readonly property real radiusLg: {
        if (style === styleNeumorphism)   return neumorphism.radiusLg
        if (style === styleLiquidGlass)   return liquidGlass.radiusLg
        return RadiusTokens.lg
    }
    readonly property real radiusPill: {
        if (style === styleNeumorphism)   return neumorphism.radiusPill
        if (style === styleLiquidGlass)   return liquidGlass.radiusPill
        return 999
    }

    readonly property real radiusNone: 0
    readonly property real radiusXl: radiusLg

    // ═══════════════════════════════════════
    // Neumorphism 阴影组
    // ═══════════════════════════════════════
    readonly property color neuDarkShadow:   isDark ? neumorphism.dark.darkShadow   : neumorphism.light.darkShadow
    readonly property color neuLightShadow:  isDark ? neumorphism.dark.lightShadow  : neumorphism.light.lightShadow
    readonly property real  neuShadowDist:   isDark ? neumorphism.dark.shadowDistance : neumorphism.light.shadowDistance
    readonly property real  neuShadowBlur:   isDark ? neumorphism.dark.shadowBlur     : neumorphism.light.shadowBlur
    readonly property color neuInsetDark:    isDark ? neumorphism.dark.insetDarkShadow  : neumorphism.light.insetDarkShadow
    readonly property color neuInsetLight:   isDark ? neumorphism.dark.insetLightShadow : neumorphism.light.insetLightShadow
    readonly property real  neuInsetDist:    isDark ? neumorphism.dark.insetDistance : neumorphism.light.insetDistance
    readonly property real  neuInsetBlur:    isDark ? neumorphism.dark.insetBlur     : neumorphism.light.insetBlur

    // ── Liquid Glass 参数 ──
    readonly property real  lgBlurAmount:      isDark ? liquidGlass.dark.blurAmount      : liquidGlass.light.blurAmount
    readonly property real  lgSurfaceOpacity:  isDark ? liquidGlass.dark.surfaceOpacity  : liquidGlass.light.surfaceOpacity
    readonly property real  lgBorderOpacity:   isDark ? liquidGlass.dark.borderOpacity   : liquidGlass.light.borderOpacity
    readonly property color lgGradientA:       isDark ? liquidGlass.dark.gradientA       : liquidGlass.light.gradientA
    readonly property color lgGradientB:       isDark ? liquidGlass.dark.gradientB       : liquidGlass.light.gradientB
    readonly property color lgGradientC:       isDark ? liquidGlass.dark.gradientC       : liquidGlass.light.gradientC
    readonly property color lgGradientD:       isDark ? liquidGlass.dark.gradientD       : liquidGlass.light.gradientD
    readonly property color lgShimmerHigh:     isDark ? liquidGlass.dark.shimmerHighlight : liquidGlass.light.shimmerHighlight
    readonly property int   lgMorphDuration:   liquidGlass.morphDuration
    readonly property int   lgShimmerDuration: liquidGlass.shimmerDuration
    readonly property int   lgFlowDuration:    liquidGlass.flowDuration

    // ═══════════════════════════════════════
    // 动画
    // ═══════════════════════════════════════
    readonly property int durationFast:   MotionTokens.durationFast
    readonly property int durationNormal: MotionTokens.durationNormal
    readonly property int durationSlow:   MotionTokens.durationSlow
    readonly property int easeInOut:      MotionTokens.easeInOut
    readonly property int easeOut:        MotionTokens.easeOut

    // ── 间距 ──
    readonly property real spacingXs: SpacingTokens.xs
    readonly property real spacingSm: SpacingTokens.sm
    readonly property real spacingMd: SpacingTokens.md
    readonly property real spacingLg: SpacingTokens.lg
    readonly property real spacingXl: SpacingTokens.xl

    // ── 字体 ──
    readonly property string fontFamily:   TypographyTokens.fontFamily
    readonly property int    weightRegular: TypographyTokens.weightRegular
    readonly property int    weightMedium:  TypographyTokens.weightMedium
    readonly property int    weightSemiBold: TypographyTokens.weightSemiBold
    readonly property int    weightBold:    TypographyTokens.weightBold

    // ═══════════════════════════════════════
    // 方法
    // ═══════════════════════════════════════
    function toggleTheme() {
        isDark = !isDark
    }

    function cycleStyle() {
        style = (style + 1) % 3
    }
}
