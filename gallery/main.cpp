#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

static QtMessageHandler s_prevHandler = nullptr;

static void filterHandler(QtMsgType type, const QMessageLogContext &ctx, const QString &msg)
{
    if (type == QtWarningMsg && msg.contains("ShaderEffectSource"))
        return;
    if (s_prevHandler)
        s_prevHandler(type, ctx, msg);
}

int main(int argc, char *argv[]) {
    s_prevHandler = qInstallMessageHandler(filterHandler);
    QQuickStyle::setStyle("Basic");
    QGuiApplication app(argc, argv);
    app.setApplicationName("AuroraUI");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("Hu-Darui");
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