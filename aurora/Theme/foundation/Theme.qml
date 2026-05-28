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
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.primary ?? "transparent") : (neumorphism.light?.primary ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.primary ?? "transparent") : (liquidGlass.light?.primary ?? "transparent")
        return isDark ? (dark?.primary ?? "transparent") : (light?.primary ?? "transparent")
    }

    readonly property color text: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.text ?? "transparent") : (neumorphism.light?.text ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.text ?? "transparent") : (liquidGlass.light?.text ?? "transparent")
        return isDark ? (dark?.text ?? "transparent") : (light?.text ?? "transparent")
    }

    readonly property color textSecondary: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.textSecondary ?? "transparent") : (neumorphism.light?.textSecondary ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.textSecondary ?? "transparent") : (liquidGlass.light?.textSecondary ?? "transparent")
        return isDark ? (dark?.textSecondary ?? "transparent") : (light?.textSecondary ?? "transparent")
    }

    readonly property color border: {
        if (style === styleNeumorphism)   return "transparent"
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.borderGlow ?? "transparent") : (liquidGlass.light?.borderGlow ?? "transparent")
        return isDark ? (dark?.border ?? "transparent") : (light?.border ?? "transparent")
    }

    readonly property color background: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.background ?? "transparent") : (neumorphism.light?.background ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.background ?? "transparent") : (liquidGlass.light?.background ?? "transparent")
        return isDark ? (dark?.background ?? "transparent") : (light?.background ?? "transparent")
    }

    readonly property color surface: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.surface ?? "transparent") : (neumorphism.light?.surface ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.surface ?? "transparent") : (liquidGlass.light?.surface ?? "transparent")
        return isDark ? (dark?.surface ?? "transparent") : (light?.surface ?? "transparent")
    }

    readonly property color elevated: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.elevated ?? "transparent") : (neumorphism.light?.elevated ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.elevated ?? "transparent") : (liquidGlass.light?.elevated ?? "transparent")
        return isDark ? (dark?.elevated ?? "transparent") : (light?.elevated ?? "transparent")
    }

    readonly property color success: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.success ?? "transparent") : (neumorphism.light?.success ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.success ?? "transparent") : (liquidGlass.light?.success ?? "transparent")
        return isDark ? (dark?.success ?? "transparent") : (light?.success ?? "transparent")
    }

    readonly property color warning: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.warning ?? "transparent") : (neumorphism.light?.warning ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.warning ?? "transparent") : (liquidGlass.light?.warning ?? "transparent")
        return isDark ? (dark?.warning ?? "transparent") : (light?.warning ?? "transparent")
    }

    readonly property color danger: {
        if (style === styleNeumorphism)   return isDark ? (neumorphism.dark?.danger ?? "transparent") : (neumorphism.light?.danger ?? "transparent")
        if (style === styleLiquidGlass)   return isDark ? (liquidGlass.dark?.danger ?? "transparent") : (liquidGlass.light?.danger ?? "transparent")
        return isDark ? (dark?.danger ?? "transparent") : (light?.danger ?? "transparent")
    }

    // ── 圆角 ──
    readonly property real radiusSm: {
        if (style === styleNeumorphism)   return neumorphism?.radiusSm ?? 0
        if (style === styleLiquidGlass)   return liquidGlass?.radiusSm ?? 0
        return RadiusTokens?.sm ?? 0
    }
    readonly property real radiusMd: {
        if (style === styleNeumorphism)   return neumorphism?.radiusMd ?? 0
        if (style === styleLiquidGlass)   return liquidGlass?.radiusMd ?? 0
        return RadiusTokens?.md ?? 0
    }
    readonly property real radiusLg: {
        if (style === styleNeumorphism)   return neumorphism?.radiusLg ?? 0
        if (style === styleLiquidGlass)   return liquidGlass?.radiusLg ?? 0
        return RadiusTokens?.lg ?? 0
    }
    readonly property real radiusPill: {
        if (style === styleNeumorphism)   return neumorphism?.radiusPill ?? 0
        if (style === styleLiquidGlass)   return liquidGlass?.radiusPill ?? 0
        return 999
    }

    readonly property real radiusNone: 0
    readonly property real radiusXl: radiusLg

    // ═══════════════════════════════════════
    // Neumorphism 阴影组
    // ═══════════════════════════════════════
    readonly property color neuDarkShadow:   isDark ? (neumorphism.dark?.darkShadow ?? "transparent") : (neumorphism.light?.darkShadow ?? "transparent")
    readonly property color neuLightShadow:  isDark ? (neumorphism.dark?.lightShadow ?? "transparent") : (neumorphism.light?.lightShadow ?? "transparent")
    readonly property real  neuShadowDist:   isDark ? (neumorphism.dark?.shadowDistance ?? 0) : (neumorphism.light?.shadowDistance ?? 0)
    readonly property real  neuShadowBlur:   isDark ? (neumorphism.dark?.shadowBlur ?? 0) : (neumorphism.light?.shadowBlur ?? 0)
    readonly property color neuInsetDark:    isDark ? (neumorphism.dark?.insetDarkShadow ?? "transparent") : (neumorphism.light?.insetDarkShadow ?? "transparent")
    readonly property color neuInsetLight:   isDark ? (neumorphism.dark?.insetLightShadow ?? "transparent") : (neumorphism.light?.insetLightShadow ?? "transparent")
    readonly property real  neuInsetDist:    isDark ? (neumorphism.dark?.insetDistance ?? 0) : (neumorphism.light?.insetDistance ?? 0)
    readonly property real  neuInsetBlur:    isDark ? (neumorphism.dark?.insetBlur ?? 0) : (neumorphism.light?.insetBlur ?? 0)

    // ── Liquid Glass 参数 ──
    readonly property color lgPrimary:         isDark ? (liquidGlass.dark?.lgPrimary ?? "transparent") : (liquidGlass.light?.lgPrimary ?? "transparent")
    readonly property color lgPrimaryShadow:   isDark ? (liquidGlass.dark?.lgPrimaryShadow ?? "transparent") : (liquidGlass.light?.lgPrimaryShadow ?? "transparent")
    readonly property color lgBorderTop:       isDark ? (liquidGlass.dark?.lgBorderTop ?? "transparent") : (liquidGlass.light?.lgBorderTop ?? "transparent")
    readonly property color lgBorderBottom:    isDark ? (liquidGlass.dark?.lgBorderBottom ?? "transparent") : (liquidGlass.light?.lgBorderBottom ?? "transparent")
    readonly property real  lgBlurAmount:      isDark ? (liquidGlass.dark?.blurAmount ?? 0) : (liquidGlass.light?.blurAmount ?? 0)
    readonly property real  lgSurfaceOpacity:  isDark ? (liquidGlass.dark?.surfaceOpacity ?? 0) : (liquidGlass.light?.surfaceOpacity ?? 0)
    readonly property real  lgBorderOpacity:   isDark ? (liquidGlass.dark?.borderOpacity ?? 0) : (liquidGlass.light?.borderOpacity ?? 0)
    readonly property color lgGradientA:       isDark ? (liquidGlass.dark?.gradientA ?? "transparent") : (liquidGlass.light?.gradientA ?? "transparent")
    readonly property color lgGradientB:       isDark ? (liquidGlass.dark?.gradientB ?? "transparent") : (liquidGlass.light?.gradientB ?? "transparent")
    readonly property color lgGradientC:       isDark ? (liquidGlass.dark?.gradientC ?? "transparent") : (liquidGlass.light?.gradientC ?? "transparent")
    readonly property color lgGradientD:       isDark ? (liquidGlass.dark?.gradientD ?? "transparent") : (liquidGlass.light?.gradientD ?? "transparent")
    readonly property color lgShimmerHigh:     isDark ? (liquidGlass.dark?.shimmerHighlight ?? "transparent") : (liquidGlass.light?.shimmerHighlight ?? "transparent")
    readonly property int   lgMorphDuration:   liquidGlass?.morphDuration ?? 600
    readonly property int   lgShimmerDuration: liquidGlass?.shimmerDuration ?? 2400
    readonly property int   lgFlowDuration:    liquidGlass?.flowDuration ?? 3600

    // ✨【新增桥接】完美映射你本地配置的极光融合动态光球环境属性
    readonly property color glowOrb0:          isDark ? (liquidGlass.dark?.glowOrb0 ?? "transparent") : (liquidGlass.light?.glowOrb0 ?? "transparent")
    readonly property color glowOrb1:          isDark ? (liquidGlass.dark?.glowOrb1 ?? "transparent") : (liquidGlass.light?.glowOrb1 ?? "transparent")
    readonly property color glowOrb2:          isDark ? (liquidGlass.dark?.glowOrb2 ?? "transparent") : (liquidGlass.light?.glowOrb2 ?? "transparent")
    readonly property color glowOrb3:          isDark ? (liquidGlass.dark?.glowOrb3 ?? "transparent") : (liquidGlass.light?.glowOrb3 ?? "transparent")
    readonly property color glowOrb4:          isDark ? (liquidGlass.dark?.glowOrb4 ?? "transparent") : (liquidGlass.light?.glowOrb4 ?? "transparent")
    readonly property real  glowOrbOpacity:    isDark ? (liquidGlass.dark?.glowOrbOpacity ?? 0) : (liquidGlass.light?.glowOrbOpacity ?? 0)
    readonly property real  lgBlurMax:         isDark ? (liquidGlass.dark?.blurMax ?? 0) : (liquidGlass.light?.blurMax ?? 0)

    // ═══════════════════════════════════════
    // 动画
    // ═══════════════════════════════════════
    readonly property int durationFast:   MotionTokens?.durationFast ?? 160
    readonly property int durationNormal: MotionTokens?.durationNormal ?? 300
    readonly property int durationSlow:   MotionTokens?.durationSlow ?? 500
    readonly property int easeInOut:      MotionTokens?.easeInOut ?? 0
    readonly property int easeOut:        MotionTokens?.easeOut ?? 0

    // ── 间距 ──
    readonly property real spacingXs: SpacingTokens?.xs ?? 4
    readonly property real spacingSm: SpacingTokens?.sm ?? 8
    readonly property real spacingMd: SpacingTokens?.md ?? 16
    readonly property real spacingLg: SpacingTokens?.lg ?? 24
    readonly property real spacingXl: SpacingTokens?.xl ?? 32

    // ── 字体 ──
    readonly property string fontFamily:   TypographyTokens?.fontFamily ?? "sans-serif"
    readonly property int    weightRegular: TypographyTokens?.weightRegular ?? 400
    readonly property int    weightMedium:  TypographyTokens?.weightMedium ?? 500
    readonly property int    weightSemiBold: TypographyTokens?.weightSemiBold ?? 600
    readonly property int    weightBold:    TypographyTokens?.weightBold ?? 700

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