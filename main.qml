import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQml.StateMachine 1.0

ApplicationWindow {
    visible: true
    property int  margin : 10
    width: mainLayout.implicitWidth + 2*margin
    height: mainLayout.implicitHeight + 2*margin
    minimumWidth: mainLayout.minimumWidth + 2*margin
    minimumHeight: mainLayout.minimumHeight + 2*margin
    title: qsTr("qmlfirst")

    property int  threeState : 0

    ColumnLayout {
        id:mainLayout
        anchors.fill: parent
        anchors.margins: margin

        Rectangle {
            id: rectangle
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 400
            color: "black"

            Rectangle  {
                id:rec
                width: 100
                height: 100

                Image {
                    anchors.fill: parent
                    id: ima
                    source: "images/state1.jpg"
                }

                StateMachine {
                    id: stateMachine
                    initialState: state1
                    running: true

                    //create state1
                    State {
                        id:state1
                        SignalTransition {
                            targetState: state2
                            signal: stateBtn.clicked
                        }
                        onEntered: {
                            PropertyChanges : {
                                    target: rec;
                                    rec.anchors.horizontalCenter =rectangle.horizontalCenter;
                                    rec.anchors.verticalCenter = rectangle.verticalCenter;
                                    rec.scale = 1.0;
                            }
                            PropertyChanges :{ target: ima; ima.source =  "images/state1.jpg"}
                            threeState = 0;
                        }
                    }

                    //create state2
                    State {
                        id:state2
                        SignalTransition {
                            targetState: state3
                            signal: stateBtn.clicked
                        }
                        onEntered: {
                            PropertyChanges : {
                                target: rec;
                                rec.anchors.horizontalCenter = undefined;
                                rec.anchors.verticalCenter = undefined;
                                rec.x = 0;
                                rec.y = 0;
                                rec.scale = 1.0;
                            }
                            PropertyChanges :{ target: ima; ima.source =  "images/state2.jpg"}
                            threeState = 1;
                        }
                    }

                    //create state3
                    State {
                        id:state3
                        SignalTransition {
                            targetState: state1
                            signal: stateBtn.clicked
                        }
                        onEntered: {
                            PropertyChanges : {
                                target: rec;
                                rec.x = rectangle.width - rec.width;
                                rec.y = rectangle.height - rec.height;
                                rec.scale = 1.0;
                            }
                            PropertyChanges :{ target: ima; ima.source =  "images/state3.jpg"}
                            threeState = 2;
                        }
                    }

                }

                SequentialAnimation {
                    id:state1Ani
                    running: false
                    XAnimator {
                        target: rec
                        from: rec.x
                        to: rectangle.width - 100
                        duration: 1000

                    }

                    XAnimator {
                        target: rec
                        from:rectangle.width -  100
                        to: 0
                        duration: 2000
                    }

                    XAnimator {
                        target: rec
                        from: 0
                        to:rectangle.width/2 - 5 * margin
                        duration: 1000
                    }
                }

                SequentialAnimation {
                    id:state2Ani
                    running: false
                    XAnimator {
                        target: rec
                        from: rec.x
                        to: rectangle.width - 100
                        duration: 2000

                    }

                    XAnimator {
                        target: rec
                        from:rectangle.width -  100
                        to: 0
                        duration: 2000
                    }
            }

                SequentialAnimation {
                    id:state3Ani
                    running: false
                    XAnimator {
                        target: rec
                        from: rec.x
                        to: 0
                        duration: 2000
                    }

                    XAnimator {
                        target: rec
                        from:0
                        to: rectangle.width - 100
                        duration: 2000
                    }
                }
            }
        }

        GroupBox {
            Layout.fillWidth: true
            RowLayout {
                anchors.fill: parent
                Button {
                    id:stateBtn
                    implicitWidth: 100
                    Layout.fillWidth: true
                    text: "Change State"
                    style: ButtonStyle {
                        background: Rectangle {
                            color:"#FFEBCD"
                            border.width: control.pressed?2:1
                            border.color: "yellow"
                            radius: 6
                            gradient: Gradient {
                                GradientStop { position: 0; color: control.pressed? "#C1FFC1":"#FFEBCD"}
                                GradientStop { position: 1; color: control.pressed? "#C0FF3E":"#FFEBCD"}
                            }
                        }
                    }
                    onClicked: {
                        state1Ani.stop();
                        state2Ani.stop();
                        state3Ani.stop();
                        switch (rec.state)
                        {
                            case "state1":
                                rec.state = "state2";
                                break;
                            case "state2":
                                rec.state = "state3";
                                break;
                            case "state3":
                                rec.state = "state1";
                                break;
                            default:
                        }
                    }
                }

                Button {
                    id: animationBtn
                    Layout.fillWidth: true
                    implicitWidth: 100
                    text: "Animation"

                    style: ButtonStyle {
                        background: Rectangle {
                            color:"#FFEBCD"
                            border.width: control.pressed?2:1
                            border.color: "yellow"
                            radius: 6
                            gradient: Gradient {
                                GradientStop { position: 0; color: control.pressed? "#C1FFC1":"#FFEBCD"}
                                GradientStop { position: 1; color: control.pressed? "#C0FF3E":"#FFEBCD"}
                            }
                        }
                    }
                    onClicked: {
                        switch (threeState)
                        {
                            case 0:
                                state1Ani.running = true;
                                break;
                            case 1:
                               state2Ani.running = true;
                                break;
                            case 2:
                               state3Ani.running = true;
                                break;
                            default:
                         }
                    }
                }

                Button {
                    id: enlargeBtn
                    Layout.fillWidth: true
                    implicitWidth: 100
                    text: "+"
                    style: ButtonStyle {
                        background: Rectangle {
                            color:"#FFEBCD"
                            border.width: control.pressed?2:1
                            border.color: "yellow"
                            radius: 6
                            gradient: Gradient {
                                GradientStop { position: 0; color: control.pressed? "#C1FFC1":"#FFEBCD"}
                                GradientStop { position: 1; color: control.pressed? "#C0FF3E":"#FFEBCD"}
                            }
                        }
                    }
                    onClicked: {
                        if(rec.scale > 1.5 - 0.00001 && rec.scale < 1.5 + 0.00001)
                        {
                            console.log("the scale is 1.5");
                        }
                         else rec.scale += 0.1;
                    }
                }

                Button {
                    id: narrowBtn
                    Layout.fillWidth: true
                    implicitWidth: 100
                    text:"-"
                    style: ButtonStyle {
                        background: Rectangle {
                            color:"#FFEBCD"
                            border.width: control.pressed?2:1
                            border.color: "yellow"
                            radius: 6
                            gradient: Gradient {
                                GradientStop { position: 0; color: control.pressed? "#C1FFC1":"#FFEBCD"}
                                GradientStop { position: 1; color: control.pressed? "#C0FF3E":"#FFEBCD"}
                            }
                        }
                    }
                    onClicked: {
                        if(rec.scale > 0.5 - 0.00001 && rec.scale < 0.5 + 0.00001)
                        {
                            console.log("the scale is 0.5");
                        }
                         else rec.scale -= 0.1;
                    }
                }
            }
        }
    }
}

