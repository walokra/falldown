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

import QtSensors 5.0
import QtMultimedia 5.0

import harbour.falldown.bacon2d 1.0

import "components"
import "scenes"
import "js/game.js" as Game

ApplicationWindow {
    id: root

    property bool isMuted: false
    property bool appActive: true

    QtObject {
        id: timers

        function startTimers() {
            displayTimer.start()
        }

        function stopTimers() {
            displayTimer.stop()
        }
    }

    QtObject {
        id: units

        // 1 gu = 18 px in Ubuntu
        function gu(value) {
            return value * 16
        }
    }

    Constants {
        id: constants
    }

    property real velocity: units.gu(0.4)

    // XXX: check all the code to de-duplicate all these alias
    property alias smallerBall: gameScene.smallerBall
    property alias gravity: gameScene.gravity
    property alias score: gameScene.score
    property alias lifes: gameScene.lifes
    property alias numberOfBalls: gameScene.numberOfBalls
    property alias slowTime: gameScene.slowTime
    property alias baloon: gameScene.baloon
    property alias glue: gameScene.glue
    property alias wine: gameScene.wine
    property alias oldVelocity: gameScene.oldVelocity
    property alias highScore: settings.highScore
    property alias mute: settings.mute

    property int smallBallInterval: 5000
    property int slowTimeInterval: 2125
    property int baloonInterval: 3000
    property int glueInterval: 8000
    property int wineInterval: 5000

    cover: CoverPage { id: coverPage; }

    Game {
        id: game
        anchors.centerIn: parent
        anchors.fill: parent

        property alias smallerBall: gameScene.smallerBall
        property alias gravity: gameScene.gravity
        property alias score: gameScene.score
        property alias lifes: gameScene.lifes
        property alias numberOfBalls: gameScene.numberOfBalls
        property alias slowTime: gameScene.slowTime
        property alias baloon: gameScene.baloon
        property alias glue: gameScene.glue
        property alias wine: gameScene.wine
        property alias oldVelocity: gameScene.oldVelocity
        property alias highScore: settings.highScore

        // Bacon2D enums
        property int active: 0
        property int inactive: 1
        property int running: 2
        property int paused: 3
        property int suspended: 4

        currentScene: mainScene

        Settings {
            id: settings
            property int highScore: 0;
            property bool mute: false

            onMuteChanged: {
                if (mute) {
                    soundtrack.stop();
                } else {
                    soundtrack.play();
                }
            }
        }

        MainScene {
            id: mainScene
            anchors.fill: parent
        }

        GameScene {
            id: gameScene
            anchors.fill: parent

            gravity: Qt.point(0, 20)
        }

        AboutScene {
            id: aboutScene
            anchors.fill: parent
        }

        EndScene {
            id: endScene
            anchors.fill: parent
        }

        Floor { id: floor }
        Hole { id: hole }
        Ball { id: ball }
        PowerUp { id: powerUp }

        Timer {
            id: smallerBallTimer
            interval: smallBallInterval

            onTriggered: smallerBall = false;
        }

        Timer {
            id: slowTimeTimer
            interval: slowTimeInterval

            onTriggered: slowTime = false;
        }

        Timer {
            id: baloonTimer
            interval: baloonInterval

            onTriggered: baloon = false;
        }

        Timer {
            id: glueTimer
            interval: glueInterval

            onTriggered: glue = false;
        }

        Timer {
            id: wineTimer
            interval: wineInterval

            onTriggered: wine = false;
        }

        Timer {
            id: newLifeTimer
            interval: 1500

            onTriggered: {
                if (game.gameState !== game.paused) {
                    velocity = oldVelocity;
                    Game.addBall();
                }
            }
        }

        Timer {
            id: displayTimer
            property alias suspend: displayTimer.running

            interval: 60000
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                _falldown.displayBlankPreventer(false)
            }

            onRunningChanged: {
                if (!running) {
                    _falldown.displayBlankPreventer(true)
                }
            }

        }

        SoundEffect {
            id: balloonSound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Balloon.wav")
        }

        SoundEffect {
            id: clockSound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Clock.wav")
        }

        SoundEffect {
            id: glueSound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Glue.wav")
        }

        SoundEffect {
            id: heartSound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Heart.wav")
        }

        SoundEffect {
            id: multiplySound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Multiply.wav")
        }

        SoundEffect {
            id: shrinkSound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Shrink.wav")
        }

        SoundEffect {
            id: swollowSound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Swollow.wav")
        }

        SoundEffect {
            id: wineSound
            muted: settings.mute
            loops: 0
            source: Qt.resolvedUrl("../sounds/Wine.wav")
        }

        Audio {
            id: soundtrack
            source: Qt.resolvedUrl("sounds/soundtrack.mp3")
            muted: isMuted || settings.mute
            loops: Audio.Infinite
            autoPlay: true
        }

        Keys.onPressed: {
            var inverted = wine ? -1 : 1;
            var ballVelocity = glue ? 3 : 20;
            ballVelocity = ballVelocity * inverted;

            if (event.key === Qt.Key_Left) {
              gravity = Qt.point(-ballVelocity, 20)
            }

            if (event.key === Qt.Key_Right) {
              gravity = Qt.point(ballVelocity, 20)
            }
        }

        Keys.onReleased: gravity = Qt.point(0, 20)

        Accelerometer {
            active: true

            onReadingChanged: {
                var inverted = wine ? -1 : 1;
                var ballVelocity = glue ? -2 : -12;
                gravity = Qt.point(ballVelocity * reading.x * inverted, 20)
            }
        }
    }
}
