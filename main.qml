import QtQuick 2.2
import QtQuick.Window 2.1
import QtQml.Models 2.1
import tank 4.0 //imports the new QML object

Window {
    property string textMenu: textMenu.text
    id: window
    visible: true
    width: 700
    height: 460
    color: "white"
    title: qsTr("Test")
    minimumHeight: 360
    minimumWidth: 400

    Rectangle{
        id: bexit
        width: parent.width
        anchors.top: parent.top
        height: 50
        color: "red"
        Text{
            id: textMenu
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Main Menu"
        }

        Rectangle{
            id: bback
            anchors.left: parent.left
            height: parent.height
            width: txt.width +20
            color: Qt.darker(bexit.color)
            visible: false
            Text{
                id:txt
                text: "Back"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.decrementCurrentIndex()
                }
            }
        }
    }

    ListView{
        property int rootActive: root.currentIndex
        id: root
        anchors.top: bexit.bottom
        width: parent.width
        anchors.bottom: parent.bottom
        snapMode: ListView.SnapOneItem
        clip: true
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 750
        focus: false
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        currentIndex: 0
        spacing: 20
        onCurrentIndexChanged: {
            if(root.currentIndex == 0){
                bback.visible = false
                textMenu.text= "Main Menu";
            } else bback.visible = true
        }

        model: ObjectModel {
            /* This is the configuration of the main Menu. Here you configure what happen
               clicking different buttons.                                                   */
            MenuView {
                id: menuview
                width: root.width
                height: root.height
                color: "black"
                /* Every "if" active the view is configured:
                    0 -> Control View
                    1 -> Configure View
                    2 -> Exit                                   */
                onMenuIndexChanged:
                {
                    if(menuview.menuIndex == 0){
                        workview.worklistActive = 0;
                        root.incrementCurrentIndex();
                        textMenu.text= "Control Window";

                    }
                    if(menuview.menuIndex == 1){
                        workview.worklistActive = 1;
                        root.incrementCurrentIndex();
                        textMenu.text= "Control Configuration";
                    }
                    if(menuview.menuIndex == 2){
                        workview.worklistActive = 2;
                        root.incrementCurrentIndex();
                        textMenu.text= "Simulation Configuration";
                    }
                    if(menuview.menuIndex == 3){
                        Qt.quit();
                    }
                }
            }
            /* This is the ListView of the control and configuration views, the value of worklistActive
                will set the active view                                                                */
            WorkView {
                id: workview
                width: root.width
                height: root.height
                color: "lightblue"
                /* This line makes inactive the button exit in first moment and allow a correct
                   working of the Menu */
                worklistActive: 3
            }
        }
    }
}
