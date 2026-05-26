import QtQuick

QtObject {
    id: root

    // ── Light Mode ──
    property QtObject light: QtObject {
        readonly property color background:    "#E8ECF0"
        readonly property color surface:       "#E8ECF0"
        readonly property color elevated:      "#EEF1F5"
        readonly property color text:          "#2D3748"
        readonly property color textSecondary: "#718096"
        readonly property color primary:       "#7C83FF"
        readonly property color accent:        "#FF7C83"
        readonly property color success:       "#68D391"
        readonly property color warning:       "#F6AD55"
        readonly property color danger:        "#FC8181"

        // 阴影：light-shadow (亮面) + dark-shadow (暗面)
        readonly property color darkShadow:  Qt.rgba(0.596, 0.612, 0.667, 0.35)
        readonly property color lightShadow: Qt.rgba(1, 1, 1, 0.85)
        readonly property real  shadowDistance: 8
        readonly property real  shadowBlur:     14

        // 内阴影（按下态）
        readonly property color insetDarkShadow:  Qt.rgba(0.596, 0.612, 0.667, 0.18)
        readonly property color insetLightShadow: Qt.rgba(1, 1, 1, 0.55)
        readonly property real  insetDistance: 4
        readonly property real  insetBlur:     6
    }

    // ── Dark Mode ──
    property QtObject dark: QtObject {
        readonly property color background:    "#20232A"
        readonly property color surface:       "#20232A"
        readonly property color elevated:      "#282C35"
        readonly property color text:          "#E2E8F0"
        readonly property color textSecondary: "#A0AEC0"
        readonly property color primary:       "#9B9FFF"
        readonly property color accent:        "#FF9B9F"
        readonly property color success:       "#68D391"
        readonly property color warning:       "#F6AD55"
        readonly property color danger:        "#FC8181"

        readonly property color darkShadow:  Qt.rgba(0.06, 0.07, 0.10, 0.55)
        readonly property color lightShadow: Qt.rgba(0.18, 0.19, 0.22, 0.35)
        readonly property real  shadowDistance: 8
        readonly property real  shadowBlur:     14

        readonly property color insetDarkShadow:  Qt.rgba(0.06, 0.07, 0.10, 0.30)
        readonly property color insetLightShadow: Qt.rgba(0.18, 0.19, 0.22, 0.15)
        readonly property real  insetDistance: 4
        readonly property real  insetBlur:     6
    }

    // ── 半径（更圆润） ──
    readonly property real radiusSm: 10
    readonly property real radiusMd: 16
    readonly property real radiusLg: 24
    readonly property real radiusPill: 999
}
