// Controls/BaseContainer.qml
import QtQuick
import aurora 1.0  // 必须使用模块名导入

Rectangle {
    id: root
    color: Theme.palette.background
    radius: Theme.radius.xl
    
    // 强制所有容器自带平滑切换逻辑
    Behavior on color {
        ColorAnimation { 
            duration: Theme.motion.duration
            easing: Theme.motion.easeOut 
        }
    }
}