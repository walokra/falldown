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

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    app->setApplicationName("harbour-falldown");
    app->setOrganizationName("harbour-falldown");
    app->setApplicationVersion(APP_VERSION);

    QScopedPointer<QQuickView> view(SailfishApp::createView());

//    Put Bacon2D QML files you built under imports/Bacon2D
    view->engine()->addImportPath(SailfishApp::pathTo("qml/imports/").toLocalFile());

    view->rootContext()->setContextProperty("APP_VERSION", APP_VERSION);
    view->rootContext()->setContextProperty("APP_RELEASE", APP_RELEASE);

    view->setSource(SailfishApp::pathTo("qml/main.qml"));

    view->show();

    return app->exec();
}
