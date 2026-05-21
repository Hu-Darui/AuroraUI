// Components/Button/ARadioButton.qml
import QtQuick
import QtQuick.Controls
import aurora 1.0

AButton {
    id: root
    
    // 关键点 1：必须开启 checkable，否则 ButtonGroup 不会接管它
    checkable: true 
    
    implicitWidth: 32
    implicitHeight: 32

    // 关键点 2：不要直接覆盖 contentItem，而是通过覆写基类内容
    // 或者确保基类的 contentItem 逻辑是空的，或者基类允许 contentItem 注入
    contentItem: Item {
        Rectangle {
            anchors.centerIn: parent
            width: 16; height: 16
            radius: 8
            color: "transparent"
            border.color: root.checked ? Theme.primary : Theme.border
            border.width: 2

            Rectangle {
                anchors.centerIn: parent
                width: 8; height: 8
                radius: 4
                color: Theme.primary
                visible: root.checked
                scale: root.checked ? 1 : 0
                Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }
            }
        }
    }
}