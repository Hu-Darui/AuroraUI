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

        Components/Button/AButton.qml
        Components/Button/AToggleButton.qml
        Components/Button/AIconButton.qml
        Components/Button/AToggleIconButton.qml
        Components/Button/ASplitButton.qml
        Components/Button/FABButton.qml
        Components/Button/ARadioButton.qml

        Components/Input/AInput.qml
    RESOURCE_PREFIX /aurora
)