/*
 * Copyright 2014 Marko Wallin
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License version 3 as published by the
 * Free Software Foundation. See http://www.gnu.org/copyleft/gpl.html the full
 * text of the license.
 */

import QtQuick 2.1
import Sailfish.Silica 1.0

CoverBackground {
    id: coverPage

    signal coverStatusChanged(int coverStatus);

    onStatusChanged: {
        if (status === PageStatus.Deactivating) {
        }else if (status === PageStatus.Activating) {

        }

        coverStatusChanged(status);
    }

    Image {
        anchors.left: parent.left
        anchors.leftMargin: Theme.paddingLarge
        anchors.bottom: parent.bottom
        source: "img/falldown.png"
        opacity: 0.2
    }

    Label {
        anchors.top: parent.top
        anchors.topMargin: constants.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: constants.fontSizeMedium
        color: "#E69F00"
//            text: gameScene.score
        text: "Falldown"
    }

}


