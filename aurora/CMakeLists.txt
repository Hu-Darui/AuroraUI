set_source_files_properties(
    Theme/foundation/Theme.qml
    Theme/tokens/ColorTokens.qml
    Theme/tokens/RadiusTokens.qml
    Theme/tokens/MotionTokens.qml
    Theme/tokens/SpacingTokens.qml
    Theme/tokens/TypographyTokens.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(aurora
    URI "aurora"
    VERSION 1.0
    QML_FILES
        Theme/foundation/Theme.qml
        Theme/tokens/ColorTokens.qml
        Theme/tokens/RadiusTokens.qml
        Theme/tokens/MotionTokens.qml
        Theme/tokens/SpacingTokens.qml
        Theme/tokens/TypographyTokens.qml
        Theme/themes/LightTheme.qml
        Theme/themes/DarkTheme.qml

        Theme/styles/NeumorphismStyle.qml
        Theme/styles/LiquidGlassStyle.qml
        Theme/styles/GlassmorphismStyle.qml

        Components/Button/AButton.qml
        Components/Button/AToggleButton.qml
        Components/Button/AIconButton.qml
        Components/Button/AToggleIconButton.qml
        Components/Button/ASplitButton.qml
        Components/Button/FABButton.qml
        Components/Button/ARadioButton.qml
        Components/Button/ASwitch.qml

        Components/Input/AInput.qml
        Components/Input/ATextBox.qml
        Components/Input/ATextArea.qml
        Components/Input/APasswordBox.qml
        Components/Input/AComboBox.qml
        Components/Input/ASpinBox.qml
        Components/Input/ATextField.qml

        Components/Controls/ACard.qml
        Components/Controls/BaseContainer.qml

        Components/Navigation/ANavBar.qml
        Components/Navigation/ATabBar.qml
        Components/Navigation/ABreadcrumb.qml

        Components/Feedback/AProgressBar.qml
        Components/Feedback/AProgressCircle.qml
        Components/Feedback/ABadge.qml
        Components/Feedback/ATooltip.qml
        Components/Feedback/ASkeleton.qml

        Components/Data/AListView.qml
        Components/Data/ATableView.qml
        Components/Data/APagination.qml

        Components/Dialog/ADialog.qml
    RESOURCE_PREFIX /aurora
)
