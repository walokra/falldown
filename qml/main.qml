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

import Bacon2D 1.0

import "components"
import "scenes"
import "js/game.js" as Game

ApplicationWindow {
    id: root

    QtObject {
        id: units;

        // 1 gu = 18 px
        function gu(value) {
            return value * 14
        }

    }

    Constants {
        id: constants
    }

    property real velocity: units.gu(0.3)

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

//    initialPage: Component {
//            id: main;

//            MainScene {
//            id: mp;
//                property bool __isMainPage : true;
//            }
//    }

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
            interval: 5000

            onTriggered: smallerBall = false;
        }

        Timer {
            id: slowTimeTimer
            interval: 2125

            onTriggered: slowTime = false;
        }

        Timer {
            id: baloonTimer
            interval: 3000

            onTriggered: baloon = false;
        }

        Timer {
            id: glueTimer
            interval: 8000

            onTriggered: glue = false;
        }

        Timer {
            id: wineTimer
            interval: 5000

            onTriggered: wine = false;
        }

        Timer {
            id: newLifeTimer
            interval: 1500

            onTriggered: {
                velocity = oldVelocity;
                Game.addBall();
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
            muted: settings.mute
            loops: Audio.Infinite
            autoPlay: true
            volume: 0.7
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
