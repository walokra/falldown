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

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QtQml>
#include <QDebug>

#include <sailfishapp.h>
// If using statically linked Bacon2D, include plugins.h
#include <plugins.h>

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    // If using statically linked Bacon2D, register harbour.falldown.bacon2d as Bacon2D type
    Plugins plugins;
    plugins.registerTypes("Bacon2D");

    app->setApplicationName("harbour-falldown");
    app->setOrganizationName("harbour-falldown");
    app->setApplicationVersion(APP_VERSION);

    QScopedPointer<QQuickView> view(SailfishApp::createView());

    // If using dynamically linked Bacon2D, put QML files and .so under lib directory and uncomment next line
//    view->engine()->addImportPath(SailfishApp::pathTo("lib/").toLocalFile());

    view->rootContext()->setContextProperty("APP_VERSION", APP_VERSION);
    view->rootContext()->setContextProperty("APP_RELEASE", APP_RELEASE);

    view->setSource(SailfishApp::pathTo("qml/main.qml"));

    view->show();

    return app->exec();
}
