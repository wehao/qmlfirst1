import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.1

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
               // color: "red"
                //anchors.centerIn: parent
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
                    },
                    State {
                        name: "state2"
                        PropertyChanges {target: ima; source:  "images/state2.jpg"}
                        AnchorChanges { target: rec; anchors.top: rectangle.top; anchors.left: rectangle.left}
                    },
                    State {
                        name: "state3"
                        PropertyChanges {target: ima; source:  "images/state3.jpg"}
                        AnchorChanges { target: rec; anchors.right: rectangle.right; anchors.bottom: rectangle.bottom}
                    }
                ]
                property int  state1x : 0
                XAnimator {
                    id:state1Ani1
                    target: rec
                    from:rec.x
                    to:rectangle.width - 100
                    duration: 1000
                    running: false
                }

                XAnimator {
                    id:state1Ani2
                    target: rec
                    from:rectangle.width - 100
                    to:rec.x
                    duration: 1000
                    running: false
                }

//                SequentialAnimation {
//                    id:state1Ani
//                    running: false
//                    NumberAnimation {

//                        target: rec
//                        property: "x"
//                        from: rec.x
//                        to: rectangle.width - 100
//                        duration: 1000

//                    }
//                }
            }

        }

        GroupBox {
            Layout.fillWidth: true
            RowLayout {
                anchors.fill: parent
                Button {
                    text: "Change State"
                    onClicked: {
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
                    text: "Animation"
                    onClicked: {
                        switch (rec.state)
                        {
                            case "state1":
//                                console.log("jjj");
//                                console.log(rec.x);
//                                console.log(mainLayout.width);
                                state1x: rec.x;
                                state1Ani.running = true;
                                break;
                            case "state2":
                                //rec.state = "state3";
                                break;
                            case "state3":
                                //rec.state = "state1";
                                break;
                            default:
                         }
                    }
                }

                Button {
                    text: "Scale"
                }

                Button {
                    text:"All"
                }

            }
        }





    }

}
