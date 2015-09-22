#include <QtCore/QCoreApplication>
#include <QDBusMessage>

#include <mce/dbus-names.h>
#include <mce/mode-names.h>

#include "falldown.h"

/*
 * Main
 */
Falldown::Falldown(QObject *parent) : QObject(parent) {
}

/*
 * Display blank prevention.
 * Request blank prevent from mce.
 */
void Falldown::displayBlankPreventer(bool cancel) {
    if (!cancel) {
//        printf("requesting mce to prevent blanking\n");
        QDBusMessage m = QDBusMessage::createMethodCall(MCE_SERVICE, MCE_REQUEST_PATH, MCE_REQUEST_IF, MCE_PREVENT_BLANK_REQ);
        QDBusConnection::systemBus().send(m);
    }
    else if (cancel) {
//        printf("cancelling blanking prevent request\n");
        QDBusMessage m = QDBusMessage::createMethodCall(MCE_SERVICE, MCE_REQUEST_PATH, MCE_REQUEST_IF, MCE_CANCEL_PREVENT_BLANK_REQ);
        QDBusConnection::systemBus().send(m);
    }
}
