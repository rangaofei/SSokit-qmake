#ifndef TRANSLATORTOOL_H
#define TRANSLATORTOOL_H

#include <QObject>
#include <QTranslator>
#include <QLocale>
#include <QDebug>
#include <QApplication>
#define LANGUAGE_DIR ":/assets/language"

class TranslatorTool : public QObject
{
    Q_OBJECT
public:
    explicit TranslatorTool(QObject *parent = nullptr);

signals:
public slots:

    void initLanguage();

private:
    static QTranslator *translator;
private:
    static QTranslator *getInstance();
};

#endif // TRANSLATORTOOL_H
