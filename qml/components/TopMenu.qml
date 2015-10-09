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
                pause()
                soundtrack.stop()
            }
            if (coverStatus === PageStatus.Deactiving) {
                if (!settings.mute) {
                    soundtrack.play()
                }
            }
        }
    }

    Connections {
        target: Qt.application
        onActiveChanged: {
            if (!Qt.application.active) {
                pause()
                appActive = true
                isMuted = true
                soundtrack.stop()
            }
            else {
                appActive = false
                isMuted = false
                if (!settings.mute) {
                    soundtrack.play()
                }
            }
        }
    }

    property bool isSmallerBall: false
    property bool isSlowTime: false
    property bool isBalloonTime: false
    property bool isGlueTime: false
    property bool isWine: false

    function pause() {
        if (game) {
            timers.stopTimers()
            game.gameState = game.paused
            pauseBtn.icon.source = Qt.resolvedUrl("../img/ui/play-btn.png")

            // Check if powerups are active when pausing
            if (smallerBallTimer.running) {
                smallBallInterval = smallerBallTimer.interval
                isSmallerBall = true
            }
            if (slowTimeTimer.running) {
                isSlowTime = true
            }
            if (balloonTimer.running) {
                isBalloonTime = true
            }
            if (glueTimer.running) {
                isGlueTime = true
            }
            if (wineTimer.running) {
                wineInterval = wineTimer.interval
                isWine = true
            }
        }
    }

    function play() {
        if (game) {
            game.gameState = game.running
            pauseBtn.icon.source = Qt.resolvedUrl("../img/ui/pause-btn.png")
            timers.startTimers()
        }
        if (!settings.mute) {
            soundtrack.play()
        }

        // Restart powerup timers which were possibly timeouted while paused
        if (isSmallerBall) {
            smallerBallTimer.interval = smallBallInterval
            gameScene.smallerBall = true
            smallerBallTimer.start()
            isSmallerBall = false
            smallBallInterval = 5000
        }
        if (isSlowTime) {
            slowTimeTimer.interval = slowTimeInterval
            gameScene.slowTime = true
            slowTimeTimer.start()
            isSlowTime = false
            slowTimeInterval = 2125
        }
        if (isBalloonTime) {
            balloonTimer.interval = balloonInterval
            gameScene.balloon = true
            balloonTimer.start()
            isBalloonTime = false
            balloonInterval = 3000
        }
        if (isGlueTime) {
            glueTimer.interval = glueInterval
            gameScene.glue = true
            glueTimer.start()
            isGlueTime = false
            glueInterval = 8000
        }
        if (isWine) {
            wineTimer.interval = wineInterval
            gameScene.wine = true
            wineTimer.start()
            isWine = false
            wineInterval = 5000
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
            id: soundBtn
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
                (game.gameState === game.paused) ? play() : pause()
            }

            Connections {
                target: gameScene
                onEndGameChanged: {
                    if (gameScene.endGame) {
                        pauseBtn.icon.source = Qt.resolvedUrl("../img/ui/pause-btn.png");
                    }
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
