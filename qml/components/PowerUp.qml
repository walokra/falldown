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

import harbour.falldown.bacon2d 1.0

import "../js/game.js" as Game

Component {
    PhysicsEntity {
        id: powerUp
        bodyType: Body.Kinematic

        height: units.gu(6)
        width: height

        updateInterval: 1
        sleepingAllowed: true
        linearVelocity: Qt.point(0, -velocity)

        property var typeOfPowerUp

        function doDestroy() {
            destroy();
        }

        Connections {
            target: gameScene
            onEndGameChanged: {
                if (gameScene.endGame)
                    powerUp.doDestroy();
            }
        }

        fixtures: [
            Box {
                sensor: true
                width: target.width
                height: target.height

                onBeginContact: {
                    var body = other.getBody();
                    if (powerUp.typeOfPowerUp === 'threeBalls') {
                        multiplySound.play();
                        Game.addBall(body.target.x, body.target.y - body.target.height / 2);
                        Game.addBall(body.target.x, body.target.y + body.target.height / 2);
                    } else if (powerUp.typeOfPowerUp === 'smallBall') {
                        shrinkSound.play();
                        game.smallerBall = true;
                        smallerBallTimer.restart();
                    } else if (typeOfPowerUp === 'slowTime') {
                        clockSound.play();
                        game.slowTime = true;
                        slowTimeTimer.restart();
                    } else if (powerUp.typeOfPowerUp === 'heart') {
                        heartSound.play();
                        game.lifes = game.lifes + 1;
                    } else if (powerUp.typeOfPowerUp === 'baloon') {
                        balloonSound.play();
                        game.baloon = true;
                        baloonTimer.restart();
                    } else if (powerUp.typeOfPowerUp === 'glue') {
                        glueSound.play();
                        game.glue = true;
                        glueTimer.restart();
                    } else if (powerUp.typeOfPowerUp === 'wine') {
                        wineSound.play();
                        game.wine = true;
                        wineTimer.restart();
                    }

                    target.doDestroy();
                }
            }
        ]

        Image {
            source: {
                if (powerUp.typeOfPowerUp === 'threeBalls')
                    return Qt.resolvedUrl("../img/board/elixir-3-balls.png");
                if (powerUp.typeOfPowerUp === 'smallBall')
                    return Qt.resolvedUrl("../img/board/elixir-get-smaller.png");
                if (powerUp.typeOfPowerUp === 'slowTime')
                    return Qt.resolvedUrl("../img/board/clock-slow-lvl.png");
                if (powerUp.typeOfPowerUp === 'heart')
                    return Qt.resolvedUrl("../img/ui/heart.png");
                if (powerUp.typeOfPowerUp === 'baloon')
                    return Qt.resolvedUrl("../img/board/baloon.png");
                if (powerUp.typeOfPowerUp === 'glue')
                    return Qt.resolvedUrl("../img/board/glue.png");
                if (powerUp.typeOfPowerUp === 'wine')
                    return Qt.resolvedUrl("../img/board/wine.png");

                // The component has been created but still not instantiated
                return Qt.resolvedUrl("../img/board/null.png");
            }
            anchors.fill: parent
        }

        behavior: ScriptBehavior {
            script: {
                if (target.y < -units.gu(4)) {
                    powerUp.doDestroy();
                }
            }
        }
    }
}
