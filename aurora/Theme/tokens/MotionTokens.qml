pragma Singleton
import QtQuick

QtObject {
    readonly property int durationFast:   150
    readonly property int durationNormal: 250
    readonly property int durationSlow:   400
    readonly property int easeInOut:      Easing.InOutQuad
    readonly property int easeOut:        Easing.OutCubic
}