/*
 * Copyright 2015 Riccardo Padovani <riccardo@rpadovani.com>
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

Column {
    id: title

    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width
    height: 2 * constants.itemSizeSmall

    Image {
        source: Qt.resolvedUrl("../img/ui/title.png")

        width: parent.width
        height: 2 * constants.itemSizeSmall

        Image {
            source: Qt.resolvedUrl("../img/board/ball-back.png")

            anchors {
                left: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 10
            }

            height: constants.itemSizeSmall
            width: height

            Image {
                anchors.fill: parent
                source: Qt.resolvedUrl("../img/board/ball-smile.png")
            }
        }
    }

    Label {
        anchors {
            left: parent.left
            leftMargin: 2 * Theme.paddingMedium
        }

        text: "v " + APP_VERSION + "-" + APP_RELEASE + " Sailfish OS"
        color: "#E69F00"
        font.pixelSize: Theme.fontSizeSmall
    }
}
