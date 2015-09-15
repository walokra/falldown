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

Scene {
    // XXX https://github.com/Bacon2D/Bacon2D/issues/114
    //physics: true
    Component.onCompleted: physics = true

    Image {
        source: Qt.resolvedUrl("../img/board/background-tile.png")
        anchors.fill: parent
        fillMode: Image.Tile
    }

    Column {
        anchors.fill: parent
        spacing: constants.itemSizeSmall

        Item {
            id: topMenuBack
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
        }

        Image {
            source: Qt.resolvedUrl("../img/ui/title.png")

            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 2 * constants.itemSizeSmall // units.gu(10)

            Image {
                source: Qt.resolvedUrl("../img/board/ball-back.png")

                anchors {
                    left: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: parent.height / 10
                }

                height: constants.itemSizeSmall // units.gu(5)
                width: height

                Image {
                    anchors.fill: parent
                    source: Qt.resolvedUrl("../img/board/ball-smile.png")
                }
            }
        }

        /*
        Label {
            anchors {
                left: parent.left
                leftMargin: 2 * Theme.paddingLarge
            }

            text: "v " + version
            color: "#E69F00"
            font.pixelSize: Theme.fontSizeSmall
        }
        */

        Image {
            anchors.topMargin: Theme.paddingLarge
            source: Qt.resolvedUrl("../img/ui/score_back.png")

            width: parent.width
            height: constants.itemSizeMedium

            Text {
                text: settings.highScore

                anchors.fill: parent
                anchors.topMargin: parent.height / 5
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeMedium
            }
        }

        ListItem {
            anchors { left: parent.left; right: parent.right; }

            IconButton {
                id: playBtn
                icon.width: constants.itemSizeExtraLarge
                icon.height: icon.width

                icon.source: Qt.resolvedUrl("../img/ui/play-btn.png")

                anchors.centerIn: parent

                onClicked: Game.startGame()
            }
        }

        ListItem {
            anchors { left: parent.left; right: parent.right }
            width: parent.width
            height: constants.itemSizeLarge

            anchors.leftMargin: constants.paddingExtraLarge
            anchors.rightMargin: constants.paddingExtraLarge

            IconButton {
                anchors { left: parent.left; }
                icon.width: constants.itemSizeLarge
                icon.height: icon.width

                onClicked: settings.mute = !settings.mute

                icon.source: settings.mute ?
                            Qt.resolvedUrl("../img/ui/sound-on-btn-home.png") :
                            Qt.resolvedUrl("../img/ui/sound-off-btn-home.png")
            }

            IconButton {
                icon.width: constants.itemSizeLarge
                icon.height: icon.width
                anchors.right: parent.right

                onClicked: game.currentScene = aboutScene

                icon.source: Qt.resolvedUrl("../img/ui/info-btn-home.png")
            }
        }
    }
}
