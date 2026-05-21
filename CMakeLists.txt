cmake_minimum_required(VERSION 3.16)
project(AuroraUI VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Core Qml Quick)
qt_standard_project_setup(REQUIRES 6.8)

# 确保顺序：先 aurora，后 app
add_subdirectory(aurora)
add_subdirectory(gallery)