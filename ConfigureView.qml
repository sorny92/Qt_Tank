import QtQuick 2.0

Rectangle {
    property alias text: txt.text
    width: 100
    height: 62
    color: "yellow"

    Text {
        anchors.centerIn: parent
        id: txt
        text: "hola"
    }
}
