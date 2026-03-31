import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import temperaturesensor

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: "Эмулятор датчика температуры и контроллера светодиода"

    function setTimerText(){
        var t = new Date().getTime() - ledTimer.startTime
        timerText.text = "LED работал " + (t / 1000).toLocaleString(Qt.locale(), 'f', 3) + " сек."
    }

    header: ToolBar{
        RowLayout{
            ToolButton{
                text: "Main"
                onClicked: {
                    mainBody.currentIndex = 0
                }
            }
            ToolButton{
                text: "Settings"
                onClicked: {
                    mainBody.currentIndex = 1
                }
            }
        }
    }

    StackLayout{
        id: mainBody
        anchors.fill: parent
        Column{
            spacing: 10
            padding: 10
            RowLayout{
                Button{
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 30
                    text: "Старт"
                    onClicked: {
                        tempTimer.start()
                        logTimer.start()
                    }
                }
                Item{
                    Layout.preferredHeight: 30
                    Layout.alignment: Qt.AlignVCenter
                    TemperatureSensor{
                        id: tempSensor
                        property real curTemp : 0
                    }
                    Timer{
                        id: tempTimer
                        interval: 2000
                        repeat: true
                        triggeredOnStart: true
                        onTriggered: {
                            tempSensor.curTemp = tempSensor.getTemperature()
                            if ((tempSensor.curTemp < 30.0 && led.activated) || (tempSensor.curTemp > 30.0 && !led.activated)){
                                led.activated = !led.activated
                            }
                        }
                    }
                    Timer{
                        id: logTimer
                        interval: 5000
                        repeat: true
                        onTriggered: {
                            var ledState = led.activated ? "ON" : "OFF"
                            var data = {"temp" : tempSensor.curTemp.toLocaleString(Qt.locale(), 'f', 1), "led" : ledState}
                            console.log(JSON.stringify(data))
                        }
                    }
                    Text{
                        text: tempTimer.running ? "Температура: " + tempSensor.curTemp.toLocaleString(Qt.locale(), 'f', 1) + " °C" : "Ожидание старта..."
                        padding: 5
                    }
                }
            }
            GridLayout{
                columns: 2
                rows: 3
                columnSpacing: 20
                Rectangle{
                    id: led
                    property bool activated: false
                    Layout.rowSpan: 2
                    color: activated ? "cyan" : "white"
                    border.color: "black"
                    border.width: 2
                    radius: 50
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60
                    onActivatedChanged: {
                        if (activated){
                            ledTimer.startTime = new Date().getTime()
                            ledTimer.start()
                        }
                        else{
                            ledTimer.stop()
                            setTimerText()
                        }
                    }
                }
                Button{
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 30
                    text: "LED ON"
                    onClicked: {
                        led.activated = true
                    }
                }
                Button{
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 30
                    text: "LED OFF"
                    onClicked: {
                        led.activated = false
                    }
                }
                Item{
                    Layout.columnSpan: 2
                    Timer{
                        id: ledTimer
                        property double startTime: 0
                        interval: 100
                        repeat: true
                        triggeredOnStart: true
                        onTriggered: setTimerText()
                    }
                    Text{
                        id: timerText
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 30
                        text: "LED ещё не включался"
                        padding: 5
                    }
                }
            }
        }
        GridLayout{
            columns: 2
            rows: 2
            columnSpacing: 5
            rowSpacing: 5
            Text{
                text: "Нижняя граница температуры"
                padding: 5
            }
            DoubleSpinBox{
                decimals: 1
                stepSize: 0.1
                to: 50
                value: 20
                onValueChanged: tempSensor.setLowerTemp(value)
            }
            Text{
                text: "Верхняя граница температуры"
                padding: 5
            }
            DoubleSpinBox{
                decimals: 1
                stepSize: 0.1
                to: 50
                value: 35
                onValueChanged: tempSensor.setUpperTemp(value)
            }
        }
    }
}
