pragma Singleton
import QtQuick

QtObject {
    // macOS 系统色板
    readonly property color systemBlue:   "#007AFF"
    readonly property color systemGray:   "#8E8E93"

    // 基础
    readonly property color white:        "#FFFFFF"
    readonly property color black:        "#000000"

    // 亮色灰阶
    readonly property color gray100:      "#F2F2F7"
    readonly property color gray200:      "#E5E5EA"

    // 暗色灰阶
    readonly property color darkGray800:  "#1C1C1E"
    readonly property color darkGray700:  "#2C2C2E"
    readonly property color darkGray600:  "#3A3A3C"  // ← 补上 elevated 用
}