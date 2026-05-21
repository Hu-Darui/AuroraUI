pragma Singleton
import QtQuick

QtObject {
    id: root

    property bool isDark: false

    readonly property LightTheme light: LightTheme {}
    readonly property DarkTheme  dark:  DarkTheme  {}

    // 颜色
    readonly property color primary:       isDark ? dark.primary       : light.primary
    readonly property color text:          isDark ? dark.text          : light.text
    readonly property color textSecondary: isDark ? dark.textSecondary : light.textSecondary
    readonly property color border:        isDark ? dark.border        : light.border
    readonly property color background:    isDark ? dark.background    : light.background
    readonly property color surface:       isDark ? dark.surface       : light.surface
    readonly property color elevated:      isDark ? dark.elevated      : light.elevated
    readonly property color success:       isDark ? dark.success       : light.success
    readonly property color warning:       isDark ? dark.warning       : light.warning
    readonly property color danger:        isDark ? dark.danger        : light.danger

    // 圆角
    readonly property real radiusNone: RadiusTokens.none
    readonly property real radiusSm:   RadiusTokens.sm
    readonly property real radiusMd:   RadiusTokens.md
    readonly property real radiusLg:   RadiusTokens.lg
    readonly property real radiusXl:   RadiusTokens.xl
    readonly property real radiusPill: 999

    // 动画
    readonly property int durationFast:   MotionTokens.durationFast
    readonly property int durationNormal: MotionTokens.durationNormal
    readonly property int durationSlow:   MotionTokens.durationSlow
    readonly property int easeInOut:      MotionTokens.easeInOut
    readonly property int easeOut:        MotionTokens.easeOut

    // 间距
    readonly property real spacingXs: SpacingTokens.xs
    readonly property real spacingSm: SpacingTokens.sm
    readonly property real spacingMd: SpacingTokens.md
    readonly property real spacingLg: SpacingTokens.lg
    readonly property real spacingXl: SpacingTokens.xl

    // 字体
    readonly property string fontFamily:   TypographyTokens.fontFamily
    readonly property int    weightRegular: TypographyTokens.weightRegular
    readonly property int    weightMedium:  TypographyTokens.weightMedium
    readonly property int    weightSemiBold: TypographyTokens.weightSemiBold
    readonly property int    weightBold:    TypographyTokens.weightBold
}