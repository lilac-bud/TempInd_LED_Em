#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "temperaturesensor.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<TemperatureSensor>("temperaturesensor", 1, 0, "TemperatureSensor");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TempInd_LED_Em", "Main");

    return QCoreApplication::exec();
}
