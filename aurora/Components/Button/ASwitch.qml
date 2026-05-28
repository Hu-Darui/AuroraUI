import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import aurora 1.0

Item {
    id: root

    property bool checked: false
    property string size: "md"
    property bool enabled: true

    signal toggled(bool checked)

    // ── 尺寸令牌（保持高度 scannable） ──────────────────
    readonly property int _kw: size === "sm" ? 16 : size === "lg" ? 24 : 20
    readonly property int _tw: size === "sm" ? 36 : size === "lg" ? 52 : 44
    readonly property int _th: size === "sm" ? 20 : size === "lg" ? 28 : 24
    readonly property int _pad: size === "sm" ? 2  : size === "lg" ? 3  : 2

    readonly property bool _isNeu: Theme.style === Theme.styleNeumorphism
    readonly property bool _isLiq: Theme.style === Theme.styleLiquidGlass
    
    implicitWidth: _tw
    implicitHeight: _th

    // ── 轨道色彩收归单例控制（✨ 核心优化点） ─────────────────
    readonly property color _trackOn: {
        if (_isNeu) return Theme.primary
        if (_isLiq) return Theme.lgPrimary         // 👈 完美对接全局流体激活色
        return Theme.primary
    }
    readonly property color _trackOff: {
        if (_isNeu) return Theme.background
        if (_isLiq) return Theme.surface           // 👈 对接全局基础中性无色玻璃
        return Theme.isDark ? "#3A3A3C" : "#E0E0E0"
    }

    // ── 轨道基座 ───────────────────────────────────────
    Rectangle {
        id: track
        anchors.fill: parent
        radius: _th / 2
        color: root.checked ? _trackOn : _trackOff

        Behavior on color { ColorAnimation { duration: Theme.durationFast } }

        // ── [LiquidGlass] 轨道微距高光边框（使用全局边框高光） ──
        border.color: {
            if (!_isLiq) return "transparent"
            return root.checked ? Theme.lgBorderTop : Theme.border
        }
        border.width: _isLiq ? 1 : 0

        // ── [LiquidGlass] 内部折射暗影槽 ──
        Rectangle {
            visible: _isLiq && !root.checked
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.color: Theme.isDark ? Qt.rgba(0, 0, 0, 0.25) : Qt.rgba(0, 0, 0, 0.05)
            border.width: 1
            anchors.margins: 0.5
        }

        // ── [Neumorphism] off: 凹陷感（完全由主题控制） ──
        Rectangle {
            visible: _isNeu && !root.checked
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.color: Theme.neuInsetDark
            border.width: 1
            
            Rectangle {
                anchors { fill: parent; topMargin: 0.5; leftMargin: 0.5 }
                radius: parent.radius
                color: "transparent"
                border.color: Theme.neuInsetLight
                border.width: 0.5
            }
        }

        // ── [Neumorphism] on: 凸起感 ──
        Rectangle {
            visible: _isNeu && root.checked
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.color: Theme.neuLightShadow
            border.width: 1
        }
    }

    // ── 核心旋钮 ───────────────────────────────────────
    Rectangle {
        id: knob
        height: _kw
        radius: _kw / 2
        y: _pad

        gradient: _isLiq ? liquidGradient : null
        color: _isLiq ? "transparent" : (_isNeu ? Theme.elevated : (Theme.isDark ? "#F5F5F7" : "#FFFFFF"))

        // ── [LiquidGlass] 旋钮晶莹度渐变（移除生硬的硬编码色） ──
        Gradient {
            id: liquidGradient
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#FFFFFF" }
            GradientStop { 
                position: 1.0; 
                color: root.checked ? (Theme.isDark ? Qt.rgba(0.9, 0.9, 1.0, 0.95) : Qt.rgba(0.95, 0.93, 1.0, 0.98)) 
                                    : (Theme.isDark ? Qt.rgba(0.85, 0.88, 0.92, 0.85) : Qt.rgba(0.93, 0.95, 0.98, 0.90))
            }
        }

        // ── [LiquidGlass] 旋钮超亮玻璃外轮廓（✨ 已修正 Token 名称并加入安全防御） ──
        border.color: _isLiq ? (Theme.lgShimmerHigh ?? "transparent") : "transparent"
        border.width: _isLiq ? 0.6 : 0

        // ── [LiquidGlass] 玻璃顶光高光穹顶（增强晶莹剔透感） ──
        Rectangle {
            visible: _isLiq
            anchors { top: parent.top; left: parent.left; right: parent.right; margins: 1 }
            height: parent.height * 0.45
            radius: parent.radius
            opacity: Theme.isDark ? 0.35 : 0.60
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "#FFFFFF" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        // ── [Neumorphism] 旋钮外部凸起双向阴影 ──
        Rectangle {
            visible: _isNeu
            anchors { fill: parent; topMargin: -1.5; leftMargin: -1.5 }
            radius: parent.radius + 1.5
            color: Theme.neuLightShadow
            z: -1
        }
        Rectangle {
            visible: _isNeu
            anchors { fill: parent; bottomMargin: -1.5; rightMargin: -1.5 }
            radius: parent.radius + 1.5
            color: Theme.neuDarkShadow
            z: -1
        }

        // ── 霓虹漫反射与晶体微投影（💡 性能与视觉双优化） ──
        layer.enabled: !_isNeu
        layer.effect: MultiEffect {
            shadowEnabled: true
            // ✨ 激活时使用我们刚刚在全局配置里添加的 lgPrimaryShadow，产生有色霓虹漏光特效！
            shadowColor: _isLiq 
                ? (root.checked ? Theme.lgPrimaryShadow : Qt.rgba(0, 0, 0, Theme.isDark ? 0.35 : 0.15))
                : Qt.rgba(0, 0, 0, Theme.isDark ? 0.40 : 0.12)
            shadowBlur: _isLiq ? 0.5 : 0.3
            shadowVerticalOffset: _isLiq ? 2 : 1
        }
    }

    // ── 状态机控制流体拉伸动画（这部分逻辑很棒，予以保留） ──
    states: [
        State {
            name: "off"
            when: !root.checked
            PropertyChanges { target: knob; x: _pad; width: _kw }
        },
        State {
            name: "on"
            when: root.checked
            PropertyChanges { target: knob; x: _tw - _kw - _pad; width: _kw }
        }
    ]

    transitions: [
        Transition {
            from: "*"; to: "*"
            enabled: root._isLiq
            ParallelAnimation {
                NumberAnimation { property: "x"; duration: 240; easing.type: Easing.InOutCubic }
                SequentialAnimation {
                    NumberAnimation { 
                        property: "width"
                        to: root._kw + (root.size === "lg" ? 10 : (root.size === "sm" ? 5 : 7))
                        duration: 110
                        easing.type: Easing.OutQuad 
                    }
                    NumberAnimation { 
                        property: "width"
                        to: root._kw
                        duration: 130
                        easing.type: Easing.InQuad 
                    }
                }
            }
        },
        Transition {
            from: "*"; to: "*"
            enabled: !root._isLiq
            NumberAnimation { property: "x"; duration: Theme.durationFast; easing.type: Easing.InOutCubic }
        }
    ]

    // ── 用户交互控制 ────────────────────────────────────
    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        onClicked: {
            root.checked = !root.checked
            root.toggled(root.checked)
        }
    }

    HoverHandler {
        enabled: root.enabled && !_isNeu
        cursorShape: Qt.PointingHandCursor
    }
}