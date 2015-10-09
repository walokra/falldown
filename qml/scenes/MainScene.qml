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

        Title {

        }

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

                onClicked: { timers.startTimers(); Game.startGame() }
            }
        }

        Row {
            anchors { left: parent.left; right: parent.right }
            width: parent.width
            height: constants.itemSizeLarge

            anchors.leftMargin: constants.paddingLarge
            anchors.rightMargin: constants.paddingLarge

            Item {
                width: parent.width / 3
                height: childrenRect.height

                IconButton {
                    icon.width: constants.itemSizeLarge
                    icon.height: icon.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    onClicked: settings.mute = !settings.mute

                    icon.source: settings.mute ?
                                Qt.resolvedUrl("../img/ui/sound-on-btn-home.png") :
                                Qt.resolvedUrl("../img/ui/sound-off-btn-home.png")
                }
            }

            Item {
                width: parent.width / 3
                height: childrenRect.height

                IconButton {
                    icon.width: constants.itemSizeLarge
                    icon.height: icon.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    onClicked: game.currentScene = settingsScene

                    icon.source: Qt.resolvedUrl("../img/ui/settings-btn-home.png")
                }
            }

            Item {
                width: parent.width / 3
                height: childrenRect.height

                IconButton {
                    icon.width: constants.itemSizeLarge
                    icon.height: icon.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    onClicked: game.currentScene = aboutScene

                    icon.source: Qt.resolvedUrl("../img/ui/info-btn-home.png")
                }
            }
        }
    }
}
