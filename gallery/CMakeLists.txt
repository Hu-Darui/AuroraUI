# --- 添加这一行，显式查找需要的模块 ---
find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_add_executable(aurora_gallery main.cpp)

qt_add_qml_module(aurora_gallery
    URI "gallery"
    VERSION 1.0
    QML_FILES
        main.qml
)

target_link_libraries(aurora_gallery PRIVATE 
    Qt6::Quick
    Qt6::QuickControls2
    aurora
)

target_sources(aurora_gallery PRIVATE ../resources/app.rc)