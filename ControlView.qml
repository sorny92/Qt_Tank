import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0

Rectangle {
    property alias spinnerInputValue: spinnerInput.value
    property alias spinnerOutputValue: spinnerOutput.value
    property string pumpOutputState
    property string pumpInputState
    property string heaterState: "off"
    property alias text: txt.text
    function update() { graph.update() }
    id:root

    Image {
        id: tank
        source: "/images/tank.svg"
        anchors.top: parent.top
        anchors.left: parent.left
        sourceSize.width: parent.width
        sourceSize.height:parent.height

        Text {
            height: 20
            width: 100
            focus:false
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            text: tank.width + " " + tank.height +" "+simulatorview.tanklevel
            id: txt
        }
        //Pump input
        Image{
            id: pump1
            x: parent.width/12.5
            y: parent.height/25
            sourceSize.width: parent.width/5
            sourceSize.height: parent.height/5
            state: "close"
            states: [
                State{
                    name: "close"
                    PropertyChanges {
                        target: pump1
                        source: "/images/pumpSTOP.svg"
                    }
                },
                State{
                    name: "open"
                    PropertyChanges {
                        target: pump1
                        source: "/images/pumpRUN.svg"
                    }
                }]
            MouseArea{
                z: 1
                id: mouse1
                anchors.fill: parent
                onClicked: {
                    parent.state = ( parent.state == "close" ? "open" : "close");
                    pump1.state == "open"? pumpInputState="open" : pumpInputState="close"
                }
            }
            Image {
                z: 0
                source: "/images/pumpMaskClick.svg"
                sourceSize.width: parent.width
                visible: mouse1.pressed? true : false
            }
        }
        //Pump output
        Image{
            id: pump2
            x: parent.width/1.39
            y: parent.height/1.47
            sourceSize.width: parent.width/5
            sourceSize.height: parent.height/5
            state: "close"
            states: [
                State{
                    name: "close"
                    PropertyChanges {
                        target: pump2
                        source: "/images/pumpSTOP.svg"
                    }
                },
                State{
                    name: "open"
                    PropertyChanges {
                        target: pump2
                        source: "/images/pumpRUN.svg"
                    }
                }]
            MouseArea{
                z: 1
                id: mouse2
                anchors.fill: parent
                onClicked: {
                    parent.state = ( parent.state == "close" ? "open" : "close");
                    pump2.state == "open"? pumpOutputState="open" : pumpOutputState="close"
                }
            }
            Image {
                z: 0
                source: "/images/pumpMaskClick.svg"
                sourceSize.width: parent.width
                visible: mouse2.pressed? true : false
            }
        }
        Image{
            id:heater
            x: parent.width/4.1
            y: parent.height/1.4
            z:-1
            sourceSize.width: parent.width/3
            sourceSize.height: parent.height/4
            state: "off"
            states: [
                State{
                    name: "off"
                    PropertyChanges {
                        target: heater
                        source: "/images/heaterOFF.svg"
                    }
                },
                State{
                    name: "on"
                    PropertyChanges {
                        target: heater
                        source: "/images/heaterON.svg"
                    }
                }]
        }

            Text{
                id: txtHeater
                text: "Heater"
                x: tank.width/1.32
                y: tank.height/4
                width: heaterON.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            Button{
                id:heaterON
                text: "ON"
                width: Math.min(parent.width/8,85)
                height: Math.min(parent.height/7,85)
                anchors.left: txtHeater.left
                anchors.top: txtHeater.bottom
                onClicked: {
                    heaterON.enabled=false;
                    heaterOFF.enabled=true;
                    heaterState="on";
                    heater.state=heaterState;
                }
            }
            Button{
                id:heaterOFF
                width: Math.min(parent.width/8,85)
                height: Math.min(parent.height/7,85)
                anchors.left: heaterON.left
                anchors.top: heaterON.bottom
                anchors.topMargin: 3
                enabled: false
                text: "OFF"
                onClicked: {
                    heaterON.enabled=true;
                    heaterOFF.enabled=false;
                    heaterState="off";
                    heater.state=heaterState;
                }
            }

            //Positioning the arrow in relation to the level of the tank
       Row{
            x: tank.width/1.667
            y:(tank.height/1.5)
              -(tank.height*0.0033*(100*(simulatorview.tankLevel/simulatorview.tankHeight)))
            spacing: 3
            Image {
                y: 2
                source: "/images/LevelArrow.svg"
                sourceSize.height: 8
                verticalAlignment: Image.AlignBottom

            }
           Text {
                id: leveltext
                text: (100*(simulatorview.tankLevel/simulatorview.tankHeight)).toFixed(1)+" %"
                font.pointSize: 8

            }
        }
        //Control the inflow of the pump
        Spinner{
            id:spinnerInput
            x: parent.width/2
            y: parent.height/20
            label: "Input"
        }
        //Control the outflow of the tank
        Spinner{
            id:spinnerOutput
            x: parent.width/1.333
            y: parent.height/20
            label: "Output"
        }
    }
    Chart{
        id: graph
        anchors.right: parent.right
        anchors.top: { if(window.height>window.width){
                tank.bottom} else parent.top}
        anchors.bottom: parent.bottom
        anchors.left: { if(window.height>window.width){
                parent.left} else tank.right}
        radius: 10
    }
}
