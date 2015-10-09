/*
* Copyright 2015 Riccardo Padovani <riccardo@rpadovani.com>
*
* This file is part of falldown.
*
* falldown is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; version 3.
*
* falldown is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0

import harbour.falldown.bacon2d 1.0

import "../components"

Scene {
    Image {
        source: Qt.resolvedUrl("../img/board/background-tile.png")
        anchors.fill: parent
        fillMode: Image.Tile
    }

    Flickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column

            anchors {
                left: parent.left
                right: parent.right
            }
            spacing: Theme.paddingMedium

            Item {
                width: parent.width
                height: Theme.itemSizeMedium

                Image {
                    source: Qt.resolvedUrl("../img/ui/top-menu-back.png")

                    fillMode: Image.TileHorizontally
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                }

                IconButton {
                    icon.height: Theme.itemSizeMedium
                    icon.width: height

                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: Theme.paddingMedium
                    }

                    onClicked: game.currentScene = mainScene

                    icon.source: Qt.resolvedUrl("../img/ui/home-btn.png")
                }
            }

            Column {
                anchors.topMargin: 2 * Theme.paddingMedium
                width: parent.width

                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                    right: parent.right
                }

                spacing: constants.paddingExtraLarge

                Text {
                    text: "Control"
                }

                Row {
                    anchors { left: parent.left; right: parent.right }
                    width: parent.width
                    height: childrenRect.height

                    spacing: constants.paddingSmall

                    IconButton {
                        width: parent.width / 2
                        height: units.gu(13)

                        onClicked: {
                            settings.control = "tilt";
                            slider.value = settings.tiltSensivity
                        }

                        icon.source: Qt.resolvedUrl("../img/ui/control-tilt.png")
                    }

                    IconButton {
                        width: parent.width / 2
                        height: units.gu(13)

                        onClicked: {
                            settings.control = "touch";
                            slider.value = settings.touchSensivity;
                        }

                        icon.source: Qt.resolvedUrl("../img/ui/control-touch.png")
                    }
                }

                Row {
                    anchors { left: parent.left; right: parent.right }
                    width: parent.width
                    height: 2 * constants.paddingExtraLarge

                    Rectangle {
                        color: "lightblue";

                        width: parent.width / 2
                        height: childrenRect.height

                        TextSwitch {
                            width: constants.paddingLarge
                            anchors.horizontalCenter: parent.horizontalCenter

                            checked: settings.control === 'tilt'
                        }
                    }

                    Rectangle {
                        color: "lightblue";

                        width: parent.width / 2
                        height: childrenRect.height

                        TextSwitch {
                            width: constants.paddingLarge
                            anchors.horizontalCenter: parent.horizontalCenter

                            checked: settings.control === 'touch'
                        }
                    }
                }

                Column {
                    anchors { left: parent.left; right: parent.right }
                    width: parent.width
                    height: constants.paddingMedium
                }

                Text {
                    text: "Sensivity"
                }

                Rectangle {
                    color: "lightblue";

                    anchors { left: parent.left; right: parent.right }
                    width: parent.width
                    height: childrenRect.height

                Slider {
                    id: slider
                    width: parent.width

//                    label: "Sensivity";

                    minimumValue: 0.1
                    maximumValue: 2.0
                    value: settings.control === "tilt" ?
                        settings.tiltSensivity : settings.touchSensivity
                    valueText: value;

                    stepSize: 0.1;

                    /// XXX WTF
                    onValueChanged: {
                        settings.control === "tilt" ?
                        settings.tiltSensivity = value :
                        settings.touchSensivity = value
                    }
                }
                }
            }
        }
    }
}
