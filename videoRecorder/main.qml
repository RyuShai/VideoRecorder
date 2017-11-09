import QtQuick 2.0
import QtQuick.Controls 2.2
import QtMultimedia 5.4
import QtQuick.Layouts 1.3
import "config.js" as Config
ApplicationWindow {

    id: root
    visible: true
    width: Config.WINDOW_WIDTH
    height: Config.WINDOW_HEIGH
    title: qsTr("Video Recorder")

    SwipeView{
        id: mainScreenSwipe
        currentIndex: 0
        anchors.fill: parent
        Item{
            id:screenVideo
            VideoOutput{
                id: videoPreview
                source: camera
                fillMode: VideoOutput.Stretch
                width: 1280
                height: 720

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

            }
            ColumnLayout{
                id: controller
                anchors.right: screenVideo.right
                anchors.rightMargin: 10

                ColumnLayout{
                    CheckBox{
                        id: muteCheck
                        text: qsTr("Mute")
                    }
                }

                Button{
                    id: recordButton
                    text: "Record"
                    z:1
                    onClicked: {
                        console.log("record button clicked")
                         recordFunction();
                    }
                }
                Button{
                    id: stoprecordButton
                    text: "Record"
                    z:1
                    onClicked: {
                        console.log("record button clicked")
//                         recordFunction();
                        camera.videoRecorder.stop()
                        recordButton.text="stop"
                    }
                }
                Rectangle{
                    anchors.fill: parent
                    color: "blue"
                    opacity: 0.3
                }
            }
        }
        Item{
            id:screenPhoto
        }

        onCurrentIndexChanged:{
            switch(currentIndex)
            {
            case 0:root.title = qsTr("Video recorder");break;
            case 1:root.title = qsTr("Photo shoter"); break;

            }
        }
    }
    PageIndicator{
        id: pagePosition

        count: mainScreenSwipe.count
        currentIndex: mainScreenSwipe.currentIndex

        anchors.bottom: mainScreenSwipe.bottom
        anchors.horizontalCenter: parent.horizontalCenter

    }
    ////////////////////
    Camera{
        id: camera
        captureMode: Camera.CaptureVideo
        //video zone///
        videoRecorder{
            audioBitRate: 48000
            audioCodec: "MP3"
            audioChannels: 1
            audioEncodingMode: CameraRecorder.ConstantBitRateEncoding
            frameRate: 30
            mediaContainer: "mp4"
            resolution: "1280x720"
            videoCodec: "h264"
            videoEncodingMode: CameraRecorder.ConstantQualityEncoding
            outputLocation: "Ryu"
            muted: muteCheck.checked
            onRecorderStateChanged: {
                console.log("state: "+ camera.videoRecorder.recorderState)
            }
            onRecorderStatusChanged: console.log("status: "+camera.videoRecorder.recorderStatus )
        }
        ///////////////
        Component.onCompleted: start()
    }
    function recordFunction()
    {
        console.log("called: "+ camera.videoRecorder.recorderState)
        switch(camera.videoRecorder.recorderState){
        case CameraRecorder.StoppedState:
            camera.videoRecorder.record()
            recordButton.text="stop"
            break;
        case CameraRecorder.RecordingState:
            camera.videoRecorder.stop()
            recordButton.text = "Record"
            break;
        }
    }

}
