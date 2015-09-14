# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

include(./Bacon2D/src/Bacon2D-static.pri)

# The name of your application
TARGET = harbour-falldown

# Application version
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += APP_RELEASE=\\\"$$RELEASE\\\"

QT += multimedia sensors

CONFIG += sailfishapp

SOURCES += src/main.cpp

#DEFINES += BACON2D_NAMESPACE=\\\"harbour.falldown.bacon2d\\\"

OTHER_FILES += \
        rpm/harbour-falldown.changes.in \
        rpm/harbour-falldown.yaml \
        rpm/harbour-falldown.spec \
        harbour-falldown.desktop \
        qml/main.qml \
        qml/components/Ball.qml\
        qml/components/PowerUp.qml\
        qml/components/Hole.qml\
        qml/components/TopMenu.qml\
        qml/components/Floor.qml\
        qml/scenes/AboutScene.qml\
        qml/scenes/EndScene.qml\
        qml/scenes/GameScene.qml\
        qml/scenes/MainScene.qml\
        qml/img/board/floor-middle.png\
        qml/img/board/floor-left.png\
        qml/img/board/floor-right.png\
        qml/img/board/background-tile.png\
        qml/img/board/ball-back.png\
        qml/img/board/ball-smile.png\
        qml/img/board/baloon.png\
        qml/img/board/clock-slow-lvl.png\
        qml/img/board/elixir-3-balls.png\
        qml/img/board/elixir-get-smaller.png\
        qml/img/board/glue.png\
        qml/img/board/null.png\
        qml/img/board/wine.png\
        qml/img/ui/heart.png\
        qml/img/ui/home-btn.png\
        qml/img/ui/info-btn-home.png\
        qml/img/ui/info-code.png\
        qml/img/ui/info-graphics.png\
        qml/img/ui/info-license.png\
        qml/img/ui/info-music.png\
        qml/img/ui/info-website.png\
        qml/img/ui/pause-btn.png\
        qml/img/ui/play-btn.png\
        qml/img/ui/reset-btn.png\
        qml/img/ui/score_back.png\
        qml/img/ui/sound-off-btn-home.png\
        qml/img/ui/sound-off-btn.png\
        qml/img/ui/sound-on-btn-home.png\
        qml/img/ui/sound-on-btn.png\
        qml/img/ui/title.png\
        qml/img/ui/top-menu-back.png\
        qml/img/pig-128.png\
        qml/js/game.js\
        qml/sounds/Balloon.wav\
        qml/sounds/Clock.wav\
        qml/sounds/Death.wav\
        qml/sounds/Glue.wav\
        qml/sounds/Heart.wav\
        qml/sounds/Multiply.wav\
        qml/sounds/Shrink.wav\
        qml/sounds/Swollow.wav\
        qml/sounds/Wine.wav\
        qml/sounds/soundtrack.mp3 \
        harbour-falldown.png \
        qml/CoverPage.qml \
        qml/Constants.qml

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
#TRANSLATIONS += translations/harbour-falldown-de.ts

