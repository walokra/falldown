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
        id: hole
        bodyType: Body.Kinematic

        height: units.gu(1.25)
        width: units.gu(7)

        sleepingAllowed: true
        linearVelocity: Qt.point(0, -velocity)

        property bool launchedOther: false
        property int numberOfContacts: 0

        function doDestroy() {
            destroy();
        }

        Connections {
            target: gameScene
            onEndGameChanged: {
                if (gameScene.endGame)
                    hole.doDestroy();
            }
        }

        fixtures: [
            // The sensor the ball go throught
            Edge {
                vertices: [
                    Qt.point(0, 0),
                    Qt.point(target.width, 1)
                ]
                sensor: true

                onBeginContact: {
                    target.numberOfContacts++;
                    if (target.numberOfContacts <= gameScene.numberOfBalls)
                        gameScene.score++;
                }
            }
        ]

        behavior: ScriptBehavior {
            script: {
                var position = target.y;
                if (position < gameScene.height - units.gu(8) && !target.launchedOther){
                    target.launchedOther = true;
                    Game.addFloor(parent.width, units.gu(1));
                }

                if (position < -units.gu(4)) {
                    hole.doDestroy();
                }
            }
        }
    }
}
