import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    visible: true
    property int  margin : 10
    width: mainLayout.implicitWidth + 2*margin
    height: mainLayout.implicitHeight + 2*margin
    minimumWidth: mainLayout.minimumWidth + 2*margin
    minimumHeight: mainLayout.minimumHeight + 2*margin
    title: qsTr("qmlfirst")

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
                state: "state1"

                Image {
                    anchors.fill: parent
                    id: ima
                    source: "images/state1.jpg"
                }

                states: [
                    State {
                        name: "state1"
                        PropertyChanges {target: ima; source:  "images/state1.jpg"}
                        AnchorChanges { target: rec; anchors.horizontalCenter: rectangle.horizontalCenter;
                            anchors.verticalCenter: rectangle.verticalCenter;
                        }
                        PropertyChanges { target: rec; scale: 1.0}
                    },
                    State {
                        name: "state2"
                        PropertyChanges {target: ima; source:  "images/state2.jpg"}
                        AnchorChanges { target: rec; anchors.top: rectangle.top; anchors.left: rectangle.left}
                        PropertyChanges { target: rec; scale: 1.0}
                    },
                    State {
                        name: "state3"
                        PropertyChanges {target: ima; source:  "images/state3.jpg"}
                        AnchorChanges { target: rec; anchors.right: rectangle.right; anchors.bottom: rectangle.bottom}
                        PropertyChanges { target: rec; scale: 1.0}
                    }

                ]

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
                    implicitWidth: 100
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
                        switch (rec.state)
                        {
                            case "state1":
                                state1Ani.running = true;
                                break;
                            case "state2":
                               state2Ani.running = true;
                                break;
                            case "state3":
                               state3Ani.running = true;
                                break;
                            default:
                         }
                    }
                }

                Button {
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

