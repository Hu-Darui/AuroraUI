#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDebug>


int main(int argc, char *argv[]) {
    QQuickStyle::setStyle("Basic");
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    // 监听加载错误，方便调试
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

    // 加载 gallery 的主入口
    // 这里的路径取决于你在 gallery/CMakeLists.txt 中定义的 URI
    // 如果 URI 是 "gallery"，默认生成的资源路径通常是 :/qt/qml/gallery/main.qml
    const QUrl url(u"qrc:/qt/qml/gallery/main.qml"_qs);
    engine.load(url);

    if (engine.rootObjects().isEmpty()) return -1;

    return app.exec();
}