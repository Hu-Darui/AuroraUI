// Components/Button/AFAB.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

AButton {
    id: root
    size: "lg" // FAB 通常较大
    
    background: Rectangle {
        radius: root.height / 2
        color: root._bgColor

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowBlur: 0.5
            shadowVerticalOffset: 4
            shadowColor: "#40000000"
        }
    }
}