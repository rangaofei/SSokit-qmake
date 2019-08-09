#ifndef TRANSLATORTOOL_H
#define TRANSLATORTOOL_H

#include <QObject>
#include <QTranslator>

class TranslatorTool : public QObject
{
    Q_OBJECT
public:
    explicit TranslatorTool(QObject *parent = nullptr);

signals:
    void onLanguageSet(int type);
public slots:
    void setLanguage(int type);

    void initLanguage();

private:
    static QTranslator *translator;
private:
    static QTranslator *getInstance();
};

#endif // TRANSLATORTOOL_H
