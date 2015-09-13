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

var BASIC_POSSIBILITY_OF_POWERUP = 0.07;
var PERCENTUAL_INCREMENTS_FOR_EACH_FLOOR_WITHOUT_POWERUP = 0.01;
var PERCENTUAL_OF_POSITIVE_POWERUPS = 0.65;
var PERCENTUAL_OF_TWO_HOLES = 0.1;

var UPPER_LIMIT_THREE_BALLS = 0.2;
var UPPER_LIMIT_SMALLER_BALL = 0.6;
var UPPER_LIMIT_SLOW_DOWN = 0.9;
var UPPER_LIMIT_EXTRA_LIFE = 1;

var UPPER_LIMIT_BALOON = 0.45;
var UPPER_LIMIT_GLUE = 0.9;
var UPPER_LIMIT_WINE = 1;

var howManyFloorsWithoutPowerUp = 0;

function addFloor(width, gu) {
    // Choose number of holes in the floor, 90% of times just one
    var numberOfHoles = Math.random() < PERCENTUAL_OF_TWO_HOLES ? 2 : 1;

    // Let's see if we have a power up
    var newPowerUp = Math.random() <= BASIC_POSSIBILITY_OF_POWERUP + howManyFloorsWithoutPowerUp * PERCENTUAL_INCREMENTS_FOR_EACH_FLOOR_WITHOUT_POWERUP ? true : false;
    if (newPowerUp) {
        addPowerup();
        howManyFloorsWithoutPowerUp = 0;
    } else {
        howManyFloorsWithoutPowerUp++;
    }

    var firstHolePosition = randomIntFromInterval(0, numberOfHoles === 2 ? width/2 : width - gu * 7);
    var secondHolePosition = randomIntFromInterval(firstHolePosition + gu * 9, width - gu * 7);

    var firstFloor = floor.createObject(gameScene);
    firstFloor.x = -10;
    firstFloor.y = gameScene.height;
    firstFloor.width = firstHolePosition + 10;

    var firstHole = hole.createObject(gameScene);
    firstHole.x = firstHolePosition;
    firstHole.y = gameScene.height;

    var secondFloor = floor.createObject(gameScene);
    secondFloor.x = firstHolePosition + gu * 7;
    secondFloor.y = gameScene.height;
    secondFloor.width = (numberOfHoles === 2 ? secondHolePosition : width + 10) - firstHolePosition - gu * 7;

    if (numberOfHoles === 2) {
        var secondHole = hole.createObject(gameScene);
        secondHole.x = secondHolePosition;
        secondHole.y = gameScene.height;
        secondHole.launchedOther = true;

        var thirdFloor = floor.createObject(gameScene);
        thirdFloor.x = secondHolePosition + gu * 7;
        thirdFloor.y = gameScene.height;
        thirdFloor.width = width - secondHolePosition - gu * 7 + 10;
    }
}

function addBall(x, y) {
    var newBall = ball.createObject(gameScene);
    newBall.x = x || gameScene.width / 2;
    newBall.y = y || 0;
    numberOfBalls++;
}

function addPowerup() {
    var newPowerUp = powerUp.createObject(gameScene);
    var isPositivePowerUp = Math.random() <= PERCENTUAL_OF_POSITIVE_POWERUPS;
    var typeOfPowerUp = Math.random();

    if (isPositivePowerUp) {
        if (typeOfPowerUp < UPPER_LIMIT_THREE_BALLS) {
            newPowerUp.typeOfPowerUp = 'threeBalls';
        } else if (typeOfPowerUp < UPPER_LIMIT_SMALLER_BALL) {
            newPowerUp.typeOfPowerUp = 'smallBall';
        } else if (typeOfPowerUp < UPPER_LIMIT_SLOW_DOWN) {
            newPowerUp.typeOfPowerUp = 'slowTime';
        } else if (lifes < 3) {
            newPowerUp.typeOfPowerUp = 'heart';
        } else {
            // No hearts for you, sorry!
            newPowerUp.typeOfPowerUp = 'threeBalls';
        }
    } else {
        if (typeOfPowerUp < UPPER_LIMIT_BALOON) {
            newPowerUp.typeOfPowerUp = 'baloon';
        } else if (typeOfPowerUp < UPPER_LIMIT_GLUE) {
            newPowerUp.typeOfPowerUp = 'glue';
        } else {
            newPowerUp.typeOfPowerUp = 'wine';
        }
    }
    newPowerUp.x = randomIntFromInterval(0, gameScene.width / 1.2);
    newPowerUp.y = gameScene.height + 2;
}

// Credits to http://stackoverflow.com/a/7228322/2586392
function randomIntFromInterval(min, max) {
    if (max < min) return max;
    return Math.floor(Math.random() * (max - min + 1) + min);
}

function startGame() {
    gameScene.endGame = false;
    resetGame();
    game.currentScene = gameScene;
    game.gameState = Bacon2D.Running;
    Game.addFloor(parent.width, units.gu(1));
    Game.addBall();
}

function resetGame() {
    gravity = Qt.point(0, 20);
    score = 0;
    velocity = units.gu(0.3);
    lifes = 2;
    numberOfBalls = 0;
    smallerBall = false;
    slowTime = false;
    baloon = false;
    glue = false;
    wine = false;
}

function endGame() {
    gameScene.endGame = true;
    game.currentScene = endScene;
    endScene.lastScore = score;
    if (score > settings.highScore) {
        highScore = score;
    }

    resetGame();
}

function restartGame() {
    gameScene.endGame = true;
    startGame();
}
