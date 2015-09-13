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

import Bacon2D 1.0

Component {
    PhysicsEntity {
        id: floor

        height: units.gu(1.25)

        sleepingAllowed: true
        linearVelocity: Qt.point(0, -velocity)
        bodyType: Body.Kinematic

        function doDestroy() {
            destroy();
        }

        behavior: ScriptBehavior {
            script: {
                if (target.y < -units.gu(4)) {
                    floor.doDestroy();
                }
            }
        }

        Connections {
            target: gameScene
            onEndGameChanged: {
                if (gameScene.endGame)
                    floor.doDestroy();
            }
        }

        fixtures: [
            // The sensor the ball go throught
            Edge {
                vertices: [
                    Qt.point(0, 0),
                    Qt.point(target.width, 1)
                ]
            }
        ]

        Image {
            id: leftImage

            source: Qt.resolvedUrl("../img/board/floor-left.png")
            width: 10

            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }
        }

        Image {
            id: middleImage

            source: Qt.resolvedUrl("../img/board/floor-middle.png")
            fillMode: Image.TileHorizontally

            anchors {
                left: leftImage.right
                right: rightImage.left
                top: parent.top
                bottom: parent.bottom
            }
        }

        Image {
            id: rightImage

            source: Qt.resolvedUrl("../img/board/floor-right.png")
            width: 10

            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }
        }
    }
}
