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

import harbour.falldown.bacon2d 1.0

import "../components"

Scene {
    Image {
        source: Qt.resolvedUrl("../img/board/background-tile.png")
        anchors.fill: parent
        fillMode: Image.Tile
    }

    Flickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column

            anchors {
                left: parent.left
                right: parent.right
            }
            spacing: Theme.paddingMedium

            Item {
                width: parent.width
                height: Theme.itemSizeMedium

                Image {
                    source: Qt.resolvedUrl("../img/ui/top-menu-back.png")

                    fillMode: Image.TileHorizontally
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                }

                IconButton {
                    icon.height: Theme.itemSizeMedium
                    icon.width: height

                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: Theme.paddingMedium
                    }

                    onClicked: game.currentScene = mainScene

                    icon.source: Qt.resolvedUrl("../img/ui/home-btn.png")
                }
            }

            Title {

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

            Column {
                anchors.topMargin: 2 * Theme.paddingMedium

                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingMedium
                }

                spacing: Theme.paddingSmall

                Text {
                    text: "Website"
                }

                Row {
                    width: parent.width

                    Image {
                        source: Qt.resolvedUrl("../img/ui/info-website.png")

                        width: Theme.itemSizeMedium
                        height: width
                    }

                    Label {
                        textFormat: Text.RichText
                        text: "<style>a:link { color: #0072B2; }</style>
                            <a href='https://launchpad.net/falldown'>Ubuntu Phone</a><br />
                            <a href='https://github.com/walokra/falldown'>Sailfish OS port</a>"
                        color: "#0072B2"
                        font.pixelSize: Theme.fontSizeMedium
                        onLinkActivated: Qt.openUrlExternally(link);
                    }

                }

                Text {
                    text: "Authors"
                }

                Row {
                    width: parent.width

                    Image {
                        source: Qt.resolvedUrl("../img/ui/info-code.png")

                        width: Theme.itemSizeMedium
                        height: width
                    }

                    Text {
                        text: "Riccardo Padovani"
                        color: "#0072B2"
                        font.pixelSize: Theme.fontSizeMedium
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row {
                    width: parent.width

                    Image {
                        source: Qt.resolvedUrl("../img/ui/info-music.png")

                        width: Theme.itemSizeMedium
                        height: width
                    }

                    Text {
                        text: "Tyrel Parker"
                        color: "#0072B2"
                        font.pixelSize: Theme.fontSizeMedium
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row {
                    width: parent.width

                    Image {
                        source: Qt.resolvedUrl("../img/ui/info-graphics.png")

                        width: Theme.itemSizeMedium
                        height: width
                    }

                    Text {
                        text: "Michał Prędotka"
                        color: "#0072B2"
                        font.pixelSize: Theme.fontSizeMedium
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    text: "Sailfish OS port"
                }

                Row {
                    width: parent.width

                    Image {
                        source: Qt.resolvedUrl("../img/ui/info-code.png")

                        width: Theme.itemSizeMedium
                        height: width
                    }

                    Text {
                        text: "Marko Wallin"
                        color: "#0072B2"
                        font.pixelSize: Theme.fontSizeMedium
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    text: "License"
                }

                Row {
                    width: parent.width

                    Image {
                        source: Qt.resolvedUrl("../img/ui/info-license.png")

                        width: Theme.itemSizeMedium
                        height: width
                    }

                    Text {
                        textFormat: Text.RichText
                        text: "<style>a:link { color: #0072B2; }</style>
                            <a href='https://www.gnu.org/licenses/gpl-3.0.html'>GPL v3</a>"
                        color: "#0072B2"
                        font.pixelSize: Theme.fontSizeMedium
                        onLinkActivated: Qt.openUrlExternally(link);
                        anchors.verticalCenter: parent.verticalCenter
                    }                    
                }

                Text {
                    text: "Engine"
                }

                Row {
                    width: parent.width

                    Image {
                        source: Qt.resolvedUrl("../img/pig-128.png")

                        width: Theme.itemSizeMedium
                        height: width
                    }

                    Text {
                        textFormat: Text.RichText
                        text: "<style>a:link { color: #0072B2; }</style>
                            <a href='http://bacon2d.com/'>Bacon 2D</a>"
                        color: "#0072B2"
                        font.pixelSize: Theme.fontSizeMedium
                        onLinkActivated: Qt.openUrlExternally(link);
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
