TEMPLATE = app

QT += qml quick svg core

SOURCES += main.cpp \
    tank.cpp \
    pump.cpp \
    heater.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    shaders/line.fsh \
    shaders/noisy.fsh \
    shaders/line.vsh \
    shaders/noisy.vsh

HEADERS += \
    tank.h \
    pump.h \
    heater.h
