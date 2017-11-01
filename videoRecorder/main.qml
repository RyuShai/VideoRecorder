import QtQuick 2.7
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import QtQuick.Layouts 1.3

ApplicationWindow {

    id: root
    visible: true
    width: 1280
    height: 720
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
                width: 1080
                height: 607

                anchors.left: mainScreenSwipe.left
                anchors.verticalCenter: mainScreenSwipe.verticalCenter

            }
            ColumnLayout{
                anchors.right: screenVideo.right
                anchors.rightMargin: 10
                CheckBox{
                    id: muteCheck
                    text: qsTr("Mute")
                }
                Button{
                    id: recordButton
                    text: "Record"
                    onClicked: {

                    }
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
        //video zone///
        videoRecorder.audioBitRate: 128000
        videoRecorder.audioCodec: "aac"
        ///////////////

    }
}
