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

Component {
    PhysicsEntity {
        id: ballEntity
        height: width
        width: gameScene.smallerBall ? units.gu(3.5) : units.gu(5)

        bodyType: Body.Dynamic
        gravityScale: gameScene.balloon ? units.gu(0.2) : units.gu(0.5)

        property color ballColor: Qt.rgba(0.86, 0.28, 0.07, 1)  // #DD4814

        fixtures: Circle {
            // This is the physic entity
            radius: target.width / 2

            density: 1
            friction: 0.8
            restitution: 0.1
        }

        Image {
            anchors.fill: parent

            source: Qt.resolvedUrl("../img/board/ball-back.png")
        }

        function doDestroy() {
            gameScene.numberOfBalls--;
            destroy();
        }

        Connections {
            target: gameScene
            onEndGameChanged: {
                if (gameScene.endGame)
                    ballEntity.doDestroy();
            }
        }

        behavior: ScriptBehavior {
            script: {
                var position = target.y;

                if (position < 0) {
                    ballEntity.doDestroy();
                }

                if (position > game.height + units.gu(8)) {
                    // If the ball falls in some way out of the game
                    ballEntity.doDestroy();
                 }
            }
        }

        Image {
            anchors.fill: parent

            source: Qt.resolvedUrl("../img/board/ball-smile.png")
            rotation: -parent.rotation
        }
    }
}
