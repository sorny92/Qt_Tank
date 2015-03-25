import QtQuick 2.0

Rectangle {
    property int menuIndex: menulist.currentIndex
    signal indexChanged
    id: root
    radius:10

    ListView{
        id: menulist
        interactive: false
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        model: menumodel
        spacing: height/40
        clip: true
        currentIndex: -1
        onCurrentIndexChanged: root.indexChanged()
        delegate: Rectangle {
            id: delegaterec
            height: menulist.height/7
            width: parent.width
            color: mouse.pressed? "lightsteelblue" : "blue"
            Text {
                text: name
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouse
                anchors.fill: parent;
                onClicked: {
                    menulist.currentIndex = index
                }
            }
        }

    }
    ListModel {
        id: menumodel
        ListElement {name: "Control"}
        ListElement {name: "Configure"}
        ListElement {name: "Simulator Configure"}
        ListElement {name: "Quit"}
    }
}
