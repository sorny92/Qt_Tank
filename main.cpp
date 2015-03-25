#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick> //This lane allows register new types from C++
#include "tank.h"
#include "pump.h"
#include "heater.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Tank>("tank", 4, 0, "Tank");
    qmlRegisterType<Pump>("tank", 4, 0, "Pump");
    qmlRegisterType<Heater>("tank", 4, 0, "Heater");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
