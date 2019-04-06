#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include "CameraHandler.hpp"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    CameraHandler camHandler{};
    engine.rootContext()->setContextProperty("camHandler", &camHandler);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
