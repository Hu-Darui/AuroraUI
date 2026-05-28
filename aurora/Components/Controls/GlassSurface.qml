import QtQuick
import QtQuick.Effects
import aurora 1.0

Rectangle {
    id: root

    property Item target: null
    property color tintColor: Theme.isDark ? Qt.rgba(0.10, 0.10, 0.20, 1.0) : Qt.rgba(0.96, 0.96, 1.0, 1.0)
    property real tintOpacity: Theme.isDark ? 0.50 : 0.40
    property real blurRadius: 32
    property bool showBorder: true

    clip: true

    // 模糊层（捕获背景 + 模糊）
    Item {
        id: blurLayer
        anchors.fill: parent
        layer.enabled: root.target !== null
        layer.effect: MultiEffect {
            blurEnabled: true
            blurMax: root.blurRadius
            blur: 1.0
            saturation: 1.3
        }

        ShaderEffectSource {
            id: backdropCapture
            anchors.fill: parent
            sourceItem: root.target
            sourceRect: root.target ? Qt.rect(
                root.mapToItem(root.target, 0, 0).x,
                root.mapToItem(root.target, 0, 0).y,
                root.width,
                root.height
            ) : Qt.rect(0, 0, 0, 0)
        }
    }

    // 色调覆盖
    Rectangle {
        anchors.fill: parent
        color: root.tintColor
        opacity: root.tintOpacity
    }

    // 顶部反射高光
    Rectangle {
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: 0.5
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.1; color: Theme.isDark ? Qt.rgba(1,1,1,0.18) : Qt.rgba(1,1,1,0.40) }
            GradientStop { position: 0.5; color: Theme.isDark ? Qt.rgba(1,1,1,0.18) : Qt.rgba(1,1,1,0.40) }
            GradientStop { position: 0.9; color: Theme.isDark ? Qt.rgba(1,1,1,0.18) : Qt.rgba(1,1,1,0.40) }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    // 底部折射阴影
    Rectangle {
        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
        height: 0.5
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.1; color: Theme.isDark ? Qt.rgba(0,0,0,0.25) : Qt.rgba(0,0,0,0.08) }
            GradientStop { position: 0.5; color: Theme.isDark ? Qt.rgba(0,0,0,0.25) : Qt.rgba(0,0,0,0.08) }
            GradientStop { position: 0.9; color: Theme.isDark ? Qt.rgba(0,0,0,0.25) : Qt.rgba(0,0,0,0.08) }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    // 边框
    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: "transparent"
        border.color: root.showBorder
            ? (Theme.isDark ? Qt.rgba(1, 1, 1, 0.16) : Qt.rgba(0, 0, 0, 0.07))
            : "transparent"
        border.width: 0.5
    }
}
