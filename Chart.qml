/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0

Rectangle {
    id: chart
    property var points: []
    property int startDate: 0
    property int endDate: width
    property string activeChart: "level"
    property int gridSize: Math.floor(1+(width-canvas.tickMargin)/20)
    property real gridStep: 20//(width - canvas.tickMargin)/gridSize
    function update() {
        canvas.requestPaint();
    }

    Row {
        id: activeChartRow
        anchors.left: chart.left
        anchors.right: chart.right
        anchors.top: chart.top
        anchors.topMargin: 10
        spacing: 5
        onWidthChanged: {
            var buttonsLen = levelButton.width + temperatureButton.width;
            var space = (width - buttonsLen) / 3;
            spacing = Math.max(space, 10);
        }

        Button {
            id: levelButton
            text: "Level"
            buttonEnabled: chart.activeChart === "level"
            onClicked: {
                chart.activeChart = "level";
                chart.update();
            }
        }
        Button {
            id: temperatureButton
            text: "Temperature"
            buttonEnabled: chart.activeChart === "temperature"
            onClicked: {
                chart.activeChart = "temperature";
                chart.update();
            }
        }
    }

    Text {
        id: fromDate
        color: "#000000"
        font.family: "Open Sans"
        font.pointSize: 8
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        text: "| " + startDate.toString()
    }

    Text {
        id: toDate
        color: "#000000"
        font.family: "Open Sans"
        font.pointSize: 8
        anchors.right: parent.right
        anchors.rightMargin: canvas.tickMargin
        anchors.bottom: parent.bottom
        text: gridSize*10 + "s |"
    }

    Canvas {
        id: canvas

        // Uncomment below lines to use OpenGL hardware accelerated rendering.
        // See Canvas documentation for available options.
        // renderTarget: Canvas.FramebufferObject
        // renderStrategy: Canvas.Threaded

        anchors.top: activeChartRow.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: fromDate.top

        property int pixelSkip: 1
        property int numPoints: 1
        property int tickMargin: 32

        property real xGridStep: (width - tickMargin) / numPoints
        property real yGridOffset: height / 26
        property real yGridStep: height / 12

        function drawBackground(ctx) {
            ctx.save();
            ctx.fillStyle = "#ffffff";
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            ctx.strokeStyle = "#d7d7d7";
            ctx.beginPath();
            // Horizontal grid lines
            for (var i = 0; i < 10; i++) {
                ctx.moveTo(0, canvas.yGridOffset + i * canvas.yGridStep);
                ctx.lineTo(canvas.width, canvas.yGridOffset + i * canvas.yGridStep);
            }

            // Vertical grid lines
            var height = 35 * canvas.height / 36;
            var yOffset = canvas.height - height;
            var xOffset = 0;
            for (i = 0; i < chart.gridSize; i++) {
                ctx.moveTo(xOffset + i * chart.gridStep, yOffset);
                ctx.lineTo(xOffset + i * chart.gridStep, height);
            }
            ctx.stroke();

            // Right ticks
            ctx.strokeStyle = "#666666";
            ctx.beginPath();
            var xStart = canvas.width - tickMargin;
            ctx.moveTo(xStart, 0);
            ctx.lineTo(xStart, canvas.height);
            for (i = 0; i < 10; i++) {
                ctx.moveTo(xStart, canvas.yGridOffset + i * canvas.yGridStep);
                ctx.lineTo(canvas.width, canvas.yGridOffset + i * canvas.yGridStep);
            }
            ctx.moveTo(0, canvas.yGridOffset + 9 * canvas.yGridStep);
            ctx.lineTo(canvas.width, canvas.yGridOffset + 9 * canvas.yGridStep);
            ctx.closePath();
            ctx.stroke();

            ctx.restore();
        }

        function drawScales(ctx, high, low)
        {
            ctx.save();
            ctx.strokeStyle = "#888888";
            ctx.font = "10px Open Sans"
            ctx.beginPath();

            // values on y-axis
            var x = canvas.width - tickMargin + 3;
            var valueStep = (high - low) / 10.0;
            for (var i = 0; i < 10; i +=2) {
                var value = parseFloat(high - i * valueStep).toFixed(1);
                ctx.text(value, x, canvas.yGridOffset + i * yGridStep - 2);
            }
            ctx.closePath();
            ctx.stroke();
            ctx.restore();
        }

        function drawValue(ctx, from, to, color,type, points, highest, lowest)
        {
            ctx.save();
            ctx.globalAlpha = 0.7;
            ctx.strokeStyle = color;
            ctx.lineWidth = 3;
            ctx.beginPath();

            var end = points.length;

            var range = highest - lowest;
            if (range == 0) {
                range = 1;
            }

            for (var i = 0; i < end; i += pixelSkip) {
                var x = points[i].x;
                var y = points[i][type];
                var h = 9 * yGridStep;

                y = h * (lowest - y)/range + h + yGridOffset;

                if (i == 0) {
                    ctx.moveTo(x, y);
                } else {
                    ctx.lineTo(i, y);
                }
            }
            ctx.stroke();
            ctx.restore();
        }

        onPaint: {
            numPoints = simulatorview.time;

            var ctx = canvas.getContext("2d");
            ctx.globalCompositeOperation = "source-over";
            ctx.lineWidth = 1;

            drawBackground(ctx);

            var highestValue = simulatorview.tankHeight;
            var lowestValue = 0;
                points.push({
                                x: xGridStep++,
                                level: simulatorview.tankLevel,
                                temperature: simulatorview.tankTemperature
                            });

            if (chart.activeChart=="level"){
                drawValue(ctx, 0, numPoints,"blue","level", points, highestValue, lowestValue);
                drawScales(ctx, highestValue, lowestValue);
            }
            if (chart.activeChart=="temperature"){
                drawValue(ctx, 0, numPoints, "red","temperature", points, highestValue, lowestValue);
                drawScales(ctx, highestValue, lowestValue);
            }
        }
    }
}
