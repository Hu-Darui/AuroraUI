import QtQuick
import QtQuick.Controls
import aurora 1.0  // 引用你开发的 aurora 库

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: "AuroraUI - 组件实验室"
    Row{
        AButton {
            text: "测试按钮 A"
            onClicked: console.log("按钮A被点击")
        }
        AToggleButton {
            text: "测试按钮 B"
            onClicked: console.log("按钮B被点击")
        }
        AIconButton {
            text: "测试图标按钮"
            onClicked: console.log("图标按钮被点击")
        }
        AToggleIconButton {
            text: "测试图标按钮"
            onClicked: console.log("图标按钮被点击")
        }
        ASplitButton {
            text: "测试图标按钮"
            onClicked: console.log("图标按钮被点击")
        }
        FABButton {
            text: "测试图标按钮"
            onClicked: console.log("图标按钮被点击")
        }
        ARadioButton { id: btn1; text: "选项 A" }
        ARadioButton { id: btn2; text: "选项 B" }
        ARadioButton { id: btn3; text: "选项 C" }
    }
    ButtonGroup {
        id: radioGroup
        buttons: [btn1, btn2, btn3]
    }
}