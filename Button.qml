import QtQuick 2.0

Rectangle {
    id: button
    signal clicked
    property alias text: txt.text
    property bool buttonEnabled: false
    width: Math.max(50, txt.width + 16)
    height: 24
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
    }
    Text {
        anchors.centerIn: parent
        font.family: "Open Sans"
        font.pointSize: 19
        font.weight: Font.DemiBold
        color: button.buttonEnabled ? "orange" : "#14aaff"
        id: txt
    }
}
