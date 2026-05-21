// TypographyTokens.qml
pragma Singleton
import QtQuick

QtObject {
    readonly property string fontFamily: "SF Pro Text"

    // weight 用数字，避免 Font.Xxx 枚举在 Qt 6 的兼容问题
    readonly property int weightRegular: 400
    readonly property int weightMedium:  500
    readonly property int weightSemiBold: 600
    readonly property int weightBold:    700

    readonly property font title:   Qt.font({ pixelSize: 20, weight: 600 })
    readonly property font body:    Qt.font({ pixelSize: 14, weight: 400 })
    readonly property font caption: Qt.font({ pixelSize: 12, weight: 400 })
}