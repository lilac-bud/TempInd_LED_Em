cmake_minimum_required(VERSION 3.16)

project(TempInd_LED_Em VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appTempInd_LED_Em
    main.cpp
)

qt_add_qml_module(appTempInd_LED_Em
    URI TempInd_LED_Em
    QML_FILES
        Main.qml
    SOURCES temperaturesensor.h temperaturesensor.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTempInd_LED_Em PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTempInd_LED_Em
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTempInd_LED_Em
    PRIVATE Qt6::Quick
)

install(TARGETS appTempInd_LED_Em
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
