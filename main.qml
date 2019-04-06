import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2

import QtMultimedia 5.9

Window {
    visible: true
    width: 640
    height: 480
    title: "Camera Detector"

    readonly property int customMargin: 10
    property bool camerasFound: false
    property string selectedDeviceId: ""

    Rectangle {
        id: rectangleChecker
        anchors.fill: parent
        anchors.margins: customMargin

        Label {
            id: labelSource
            text: "Select Camera Source"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ListView {
            id: listViewCamera
            width: parent.width
            anchors.top: labelSource.bottom
            anchors.bottom: labelError.top
            anchors.margins: customMargin
            clip: true
            keyNavigationEnabled: true
            focus: true
            activeFocusOnTab: true

            model: listModelCamera
            delegate: cameraDelegate

        }

        ListModel {
            id: listModelCamera
        }

        Component {
            id: cameraDelegate

            Rectangle {
                id: wrapper
                width: parent.width
                height: sourceText.height
                property alias delegateSourceString: sourceText.text
                property string delegateDeviceId: deviceId
                anchors.margins: customMargin
                color: ListView.isCurrentItem ? "lightsteelblue" : "transparent"

                Text {
                    id: sourceText
                    width: parent.width
                    height: 40
                    text: sourceString
                    verticalAlignment: Qt.AlignVCenter
                    elide: Qt.ElideLeft
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listViewCamera.forceActiveFocus();
                        listViewCamera.currentIndex = index;
                    }
                    onDoubleClicked: {
                        listViewCamera.forceActiveFocus();
                        listViewCamera.currentIndex = index;
                    }
                }
            }
        }

        Label {
            id: labelError
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.margins: customMargin
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        Button {
            id: buttonOk
            text: "Select"
            anchors.bottom: parent.bottom
            anchors.right: parent.right

        }
    }

    Loader {
        id: loader
        anchors.fill: parent
        onLoaded: {
            item.visible = true
        }
    }

    Component {
        id: componentCamera

        Item {
            id: itemViewer
            anchors.fill: parent
            anchors.margins: customMargin

            Camera {
                id: camera
                deviceId: selectedDeviceId
            }

            VideoOutput {
                id: videoOutput
                source: camera
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Timer {
        id: timer
        interval: 500
        repeat: true
        onTriggered: {
            findAvailableCameras();
        }
    }

    Component.onCompleted: {
        if(!findAvailableCameras()) {
            timer.start();
        }
    }

    onCamerasFoundChanged: {
        if(camerasFound){
            timer.stop();
        }
    }

    function findAvailableCameras() {
        var camList = camHandler.getAvailableCameras();

        if(camList.length === 0){
            var message = "No streams available!\n\nPlease check your devices or connect a camera...";
            labelError.text = message;
            buttonOk.visible = false;
        } else{
            camerasFound = true;
            labelError.visible = false;
            buttonOk.visible = true;
            for(var index = 0; index < camList.length; index += 2){
                listModelCamera.append({ sourceString: camList[index] + "   ( " + camList[index+1] +" )", deviceId: camList[index+1]});
            }
        }
        return camerasFound;
    }


}
