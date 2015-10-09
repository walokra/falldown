/*
 * Copyright 2015 Riccardo Padovani <riccardo@rpadovani.com>
 * Copyright 2015 Marko Wallin <marko.wallin@iki.fi> (Sailfish OS port)
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

import "../js/game.js" as Game

import "../components"

Scene {
    property int lastScore

    Image {
        source: Qt.resolvedUrl("../img/board/background-tile.png")
        anchors.fill: parent
        fillMode: Image.Tile
    }

    Column {
        id: column

        anchors { left: parent.left; right: parent.right }
        spacing: constants.paddingMedium
        height: childrenRect.height

        Item {
            width: parent.width
            height: constants.itemSizeMedium

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
                icon.height: constants.itemSizeMedium;
                icon.width: height

                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: constants.paddingMedium
                }

                onClicked: game.currentScene = mainScene

                icon.source: Qt.resolvedUrl("../img/ui/home-btn.png")
            }
        }

        Title {

        }

        Column {
            anchors { left: parent.left; right: parent.right }
            anchors.topMargin: constants.paddingLarge
            spacing: constants.paddingMedium

            Text {
                text: "GAME OVER"
                color: "#d55e00"
                font.pixelSize: constants.fontSizeExtraLarge

                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: lastScore
                color: "#d55e00"
                font.pixelSize: constants.fontSizeExtraLarge + constants.fontSizeMedium

                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: lastScore < settings.highScore ?
                        "Your best score is " + settings.highScore :
                        "This is your new best score!"
                font.pixelSize: constants.fontSizeMedium

                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item {
                anchors { left: parent.left; right: parent.right }
                height: constants.paddingLarge
            }

            Column {
                anchors { left: parent.left; right: parent.right }
                anchors.topMargin: constants.paddingLarge
                spacing: constants.paddingSmall

                IconButton {
                    id: playBtn
                    icon.width: constants.itemSizeExtraLarge
                    icon.height: icon.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    icon.source: Qt.resolvedUrl("../img/ui/play-btn.png")

                    onClicked: { timers.startTimers(); Game.startGame() }
                }

                Item {
                    anchors { left: parent.left; right: parent.right }
                    height: constants.paddingMedium
                }

                Text {
                    id: playTxt
                    text: "Play again"

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: constants.paddingMedium
                    color: "#0072B2"
                    font.pixelSize: constants.fontSizeMedium
                }
            }
        }
    }
}
