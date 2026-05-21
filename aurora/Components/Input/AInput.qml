import QtQuick
import QtQuick.Controls

TextField {
    id: root
    
    // 如果你只是想添加一些自定义样式，直接写属性即可
    placeholderTextColor: "#999" // 你可以自定义颜色
    
    background: Rectangle {
        border.color: root.focus ? "#409eff" : "#ccc"
        radius: 4
    }
    
    // 注意：不要再写 property alias placeholderText 了，
    // 因为它是 TextField 自带的，外部可以直接使用它。
}