QT += qml quick
android: QT += core androidextras
HEADERS += main.h
SOURCES += main.cpp

QT_CONFIG -= no-pkg-config
CONFIG += link_pkgconfig debug
PKGCONFIG += mpv

RESOURCES += mpvtest.qrc

OTHER_FILES += main.qml
