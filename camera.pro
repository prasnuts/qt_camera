requires(contains(QT_CONFIG, accessibility))

qtHaveModule(widgets) {
    QT += widgets # QApplication is required to get native styling with QtQuickControls
}

TARGET = camera

TEMPLATE = app
QT += multimedia qml quick
CONFIG += c++11
CONFIG += qtquickcompiler

SOURCES += \
        main.cpp \
        CameraHandler.cpp

RESOURCES += qml.qrc

unix {
    isEmpty(PREFIX) {
        PREFIX = /home/samarakp/dev/qt/install
    }

    target.path = $$PREFIX/bin

    shortcutfiles.files = assets/camera.desktop
    shortcutfiles.path = $$PREFIX/share/applications/
    data.files += assets/cameraIcon.svg
    data.path = $$PREFIX/share/pixmaps/

    INSTALLS += shortcutfiles
    INSTALLS += data
}

INSTALLS += target

# Needed for bringing browser from background to foreground using QDesktopServices: http://bugreports.qt-project.org/browse/QTBUG-8336
TARGET.CAPABILITY += SwEvent

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

OTHER_FILES +=

HEADERS += CameraHandler.hpp

DISTFILES += \
    assets/camera.desktop \
    assets/cameraIcon.svg \
    README.md \
    LICENSE.txt
