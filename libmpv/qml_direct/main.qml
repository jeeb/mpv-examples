import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1

import mpvtest 1.0

ApplicationWindow {
    width: 1280
    height: 720
    color: "#00000000"
    title: qsTr("MPV QML Test")
    visible: true

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: fileDialog.shortcuts.pictures

        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrl)

            console.log("calling setFullScreen")
            renderer.setFullScreen()

            renderer.command(["loadfile",fileDialog.fileUrl.toString() /*.replace("file://", "")*/])
            fileDialog.close()
        }
        onRejected: {
            console.log("Canceled")
            fileDialog.close()
        }
        // Component.onCompleted: visible = true
    }

    MpvObject {
        id: renderer

        // This object isn't real and not visible; it just renders into the
        // background of the containing Window.
        width: 0
        height: 0
    }

    MouseArea {
        anchors.fill: parent
        // onClicked: renderer.command(["loadfile", "/storage/emulated/0/Video/DTB_OP.mkv"])
        onClicked: fileDialog.open()
    }

    Rectangle {
        id: labelFrame
        anchors.margins: -50
        radius: 5
        color: "white"
        border.color: "black"
        opacity: 0.8
        anchors.fill: box
    }

    Row {
        id: box
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 100

        Text {
            anchors.margins: 10
            wrapMode: Text.WordWrap
            text: "QtQuick and mpv are both rendering stuff.\n
                   In this example, mpv is always in the background.\n
                   Click to load test.mkv"
        }

        Column {
            Button {
                anchors.margins: 10
                text: "Reinit QQuickItem renderer (for testing opengl-cb uninit during playback)"
                onClicked: renderer.reinitRenderer()
            }
            Button {
                anchors.margins: 10
                text: "Cycle video"
                onClicked: renderer.command(["cycle", "video"])
            }
        }
    }
}
