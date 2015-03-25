import QtQuick 2.0
import QtQml.Models 2.1
Rectangle{
    property int worklistActive
    id: root
    ListView{
        id: worklist
        anchors.fill: parent
        highlightMoveDuration: 750
        clip: true
        /* This view doesn't allow the user to change between the views */
        interactive: false
        focus: false
        orientation: ListView.Horizontal
        currentIndex: worklistActive
        spacing: 20
        model: ObjectModel {
            ControlView {
                id: controlview
                width: root.width
                height: root.height
                color: "lightsteelblue"
            }
            ConfigureView {
                id: configureview
                width: root.width
                height: root.height
                text: window.width + " " + window.height
            }
            SimulatorView {
                id: simulatorview
                width: root.width
                height: root.height
            }
        }
    }
}
