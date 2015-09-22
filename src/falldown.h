#ifndef FALLDOWN_H
#define FALLDOWN_H

#include <QtCore/QObject>
#include <QtDBus/QtDBus>

class QDBusInterface;
class Falldown: public QObject {
    Q_OBJECT

public:
    explicit Falldown(QObject *parent = 0);

    Q_INVOKABLE void displayBlankPreventer(bool cancel = false);
};

#endif // FALLDOWN_H
