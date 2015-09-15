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

Item {
    id: topMenu
    height: 2 * constants.itemSizeMedium
    z: 100

    anchors {
        left: parent.left
        right: parent.right
    }

    Connections {
        target: coverPage
        onCoverStatusChanged: {
            if (coverStatus === PageStatus.Activating) {
                pause();
            }
        }
    }

    function pause() {
        if (game) {
            if (game.gameState === Bacon2D.Paused) {
                game.gameState = Bacon2D.Running;
                pauseBtn.icon.source = Qt.resolvedUrl("../img/ui/pause-btn.png");
            } else {
                game.gameState = Bacon2D.Paused;
                pauseBtn.icon.source = Qt.resolvedUrl("../img/ui/play-btn.png");
            }
        }
    }

    Item {
        width: parent.width
        anchors.fill: parent

        Image {
            source: Qt.resolvedUrl("../img/ui/top-menu-back.png")

            fillMode: Image.TileHorizontally
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

    Item {
        id: topRow
        height: constants.itemSizeMedium
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        IconButton {
            icon.height: constants.itemSizeMedium
            icon.width: height

            anchors.top: parent.top

            onClicked: settings.mute = !settings.mute

            icon.source: settings.mute ?
                        Qt.resolvedUrl("../img/ui/sound-on-btn.png") :
                        Qt.resolvedUrl("../img/ui/sound-off-btn.png")
        }

        IconButton {
            icon.height: constants.itemSizeMedium;
            icon.width: height

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            onClicked: Game.endGame()

            icon.source: Qt.resolvedUrl("../img/ui/home-btn.png")
        }

        IconButton {
            icon.height: constants.itemSizeMedium;
            icon.width: height

            anchors {
                top: parent.top
                right: parent.right
            }

            onClicked: Game.restartGame();

            icon.source: Qt.resolvedUrl("../img/ui/reset-btn.png")
        }
    }

    Item {
        id: bottomRow
        height: constants.paddingSmall
        anchors {
            left: parent.left
            right: parent.right
            bottom: topRow.bottom
        }

        IconButton {
            id: pauseBtn
            icon.source: Qt.resolvedUrl("../img/ui/pause-btn.png")
            icon.width: constants.itemSizeSmall
            icon.height: width

            anchors.top: parent.top

            onClicked: {
                pause()
            }

            Connections {
                target: gameScene
                onEndGameChanged: {
                    if (gameScene.endGame)
                        pauseBtn.icon.source = Qt.resolvedUrl("../img/ui/pause-btn.png");
                }
            }
        }

        Label {
            text: score

            anchors {
                verticalCenter: pauseBtn.verticalCenter
                horizontalCenter: bottomRow.horizontalCenter
            }

            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            id: lifesRow
            anchors {
                top: parent.top
                right: parent.right
                rightMargin: constants.paddingSmall
            }

            height: constants.itemSizeSmall

            Repeater {
                model: lifes

                delegate: Image {
                    source: Qt.resolvedUrl("../img/ui/heart.png")
                    width: height

                    anchors {
                        top: lifesRow.top
                        bottom: lifesRow.bottom
                        margins: constants.paddingSmall
                    }
                }
            }
        }
    }
}
}
