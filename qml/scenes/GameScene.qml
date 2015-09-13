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

import QtMultimedia 5.0

import Bacon2D 1.0

import "../components"
import "../js/game.js" as Game

Scene {
    physics: true
    clip: true
    debug: true

    property int score: 0
    property int lifes: 2
    property int numberOfBalls: 0
    property int oldVelocity: 0

    property bool endGame: false
    property bool smallerBall: false
    property bool slowTime: false

    property bool baloon: false
    property bool glue: false
    property bool wine: false

    property bool lostBall: false

    onSlowTimeChanged: {
        if (slowTime) {
            oldVelocity = velocity;
            velocity = units.gu(0.1);
        } else {
            velocity = oldVelocity;
        }
    }

    onNumberOfBallsChanged: {
        if (numberOfBalls === 0 && gameScene.running) {
            lostBall = false;
            lostBall = true;
            if (lifes > 0) {
                deathSound.play();
                lifes--;
                oldVelocity = velocity
                velocity = -units.gu(1.1);
                newLifeTimer.restart();
            }
            else {
                Game.endGame();
            }
        }
    }

    SoundEffect {
        id: deathSound
        muted: settings.mute
        loops: 0
        source: Qt.resolvedUrl("../sounds/Death.wav")
    }

    onScoreChanged: {
        if ((score % 10 == 0) && velocity < units.gu(3))
            velocity += 0.1;
    }

    Image {
        source: Qt.resolvedUrl("../img/board/background-tile.png")
        fillMode: Image.Tile

        anchors.fill: parent
    }

    TopMenu {
        id: menuRow
        y: gameScene.running ? -constants.itemSizeMedium : 0

        property int lifes

        Binding { target: menuRow; property: "lifes"; value: gameScene.lifes }

        Behavior on y { NumberAnimation {} }
    }

    /* walls */
    PhysicsEntity {
        width: units.gu(0.1)

        anchors {
            top: parent.top;
            bottom: parent.bottom;
            left: parent.left;
        }

        fixtures: [
            Edge {
                vertices: [
                    Qt.point(0, 0),
                    Qt.point(1, gameScene.height)
                ]
            }
        ]
    }

    PhysicsEntity {
        width: units.gu(0.1)

        anchors {
            top: parent.top;
            bottom: parent.bottom;
            right: parent.right;
        }

        fixtures: [
            Edge {
                vertices: [
                    Qt.point(0, 0),
                    Qt.point(-1, gameScene.height)
                ]
            }
        ]
    }

    PhysicsEntity {
        height: units.gu(0.1)
        anchors {
            top: parent.bottom;
            left: parent.left;
            right: parent.right;
        }

        fixtures: [
            Edge {
                vertices: [
                    Qt.point(0, 0),
                    Qt.point(gameScene.width, 1)
                ]
            }
        ]
    }
}
