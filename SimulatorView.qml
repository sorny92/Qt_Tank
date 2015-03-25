import QtQuick 2.0
import tank 4.0
import QtQml.Models 2.1

Rectangle {
    property double tankLevel: tank.level
    property double tankHeight: tank.height
    property double time: 0
    property double tankTemperature: tank.temperature
    color: "lightblue"
    id:root
    Timer {
        id:timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            tank.capacity;
            tank.volume;
            pumpOutput.flow=parseFloat(teOutFlow.text)*controlview.spinnerOutputValue/100;
            pumpInput.flow=parseFloat(teInFlow.text)*controlview.spinnerInputValue/100;
            tank.inFlow(pumpInput.flow);
            tank.outFlow(pumpOutput.flow);
            time+= interval/1000;
            //Simulates the transmision of energy between the tank and the environment
            if(teExtTemperature.text<tankTemperature){
                tank.inEnergy(-20);
            }else{
                tank.inEnergy(20);
            }
            heater.heat=teHeat.text;
            tank.inEnergy(heater.heat);
            console.log(tank.radius +"\t"+tank.capacity.toFixed(1) +"\t"+tank.level.toFixed(1)+"\t"+controlview.heaterState+"\t"+tank.heatCapacity+"\t"+tank.density+"\t"+heater.heat+"\t"+teExtTemperature+"\t"+tank.temperature);
            controlview.update();

        }
    }
    Tank {
        id:tank
        //Initial level
        level: 10
        radius: teRadius.text
        height: teHeight.text
        heatCapacity: teHeatCapacity.text
        temperature: teTemperature.text
        density: teDensity.text
    }
    Pump {
        id: pumpInput
        flow: parseFloat(teInFlow.text)*controlview.spinnerInputValue
        state: controlview.pumpInputState
    }
    Pump {
        id: pumpOutput
        flow: parseFloat(teOutFlow.text)*controlview.spinnerOutputValue
        state: controlview.pumpOutputState
    }
    Heater{
        id: heater
        state:controlview.heaterState
        heat:teHeat.text
    }

    Text{
        id:textinfo
        text: "In this view the user can configure different values of the simulation"
        anchors.top: parent.top
        width: parent.width
        wrapMode: Text.Wrap
    }
    GridView{
       anchors.top: textinfo.bottom
       anchors.margins: 20
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.bottom: parent.bottom
       model: modelgrid
       cellHeight: 170
       cellWidth: 200
       clip:true

       }
ObjectModel{
        id: modelgrid
        Column{
            id: colRadius
            Text{
                text: "\nRadius"
            }
            Row{
                Rectangle {
                    id:recRadius
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "black"
                    TextInput {
                        id: teRadius
                        anchors.fill: parent
                        text: "100"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            tank.radius = parseFloat(text);
                        }
                    }
                }
                Text{
                    text:"cm"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id:colHeight
            Text {
                text: "\nHeight"
            }
            Row{
                Rectangle {
                    id:recHeight
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teHeight
                        anchors.fill: parent
                        text: "100"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            tank.height = parseFloat(text);
                        }
                    }
                }
                Text{
                    text:"cm"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id:colTemperature
            Text{
                text: "Initial\nTemperature"
            }
            Row{
                Rectangle {
                    id:recTemperature
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teTemperature
                        anchors.fill: parent
                        text: "100"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            tank.temperature=text;
                        }
                    }
                }
                Text{
                    text:"ºC"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id:colDensity
            Text {
                text: "\nDensity"
            }
            Row{
                Rectangle {
                    id:recDensity
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teDensity
                        anchors.fill: parent
                        text: "1000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            tank.density=teDensity.text;
                        }
                    }
                }
                Text{
                    text:"kg/m3"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id:colHeatCapacity
            Text {
                text: "Heat\nCapacity"
            }
            Row{
                Rectangle {
                    id:recHeatCapacity
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teHeatCapacity
                        anchors.fill: parent
                        text: "4180"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            tank.heatCapacity=teHeatCapacity.text;
                        }
                    }
                }
                Text{
                    text:"J/K"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id: colInFlow
            Text{
                text: "Input\nFlow"
            }
            Row{
                Rectangle {
                    id:recInFlow
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teInFlow
                        anchors.fill: parent
                        text: "2"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            pumpInput.flow=text;
                        }
                    }
                }
                Text{
                    text:"L/s"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id:colOutFlow
            Text{
                text: "Output\nFlow"
            }
            Row{
                Rectangle {
                    id:recOutFlow
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teOutFlow
                        anchors.fill: parent
                        text: "2"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            pumpOutput.flow=text;
                        }
                    }
                }
                Text{
                    text:"L/s"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id: colHeat
            Text{
                text: "Heater \nenergy"
            }
            Row{
                Rectangle {
                    id:recHeat
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teHeat
                        anchors.fill: parent
                        text: "4000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: {
                            heater.heat=text;
                        }
                    }
                }
                Text{
                    text:"J/s"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

        Column{
            id: colExtTemperature
            Text{
                text: "External\nTemperature"
            }
            Row{
                Rectangle {
                    id:recExtTemperature
                    width: 80
                    height: 40
                    border.width: 2
                    border.color: "blue"
                    TextInput {
                        id: teExtTemperature
                        anchors.fill: parent
                        text: "20"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                    }
                }
                Text{
                    text:"ºC"
                    verticalAlignment: Text.AlignVCenter
                    height: 40
                }
            }
        }

    }
}
