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
    ~TranslatorTool();
    TranslatorTool(const TranslatorTool&)=delete;
    TranslatorTool& operator=(const TranslatorTool&)=delete;

private:
    explicit TranslatorTool(QObject *parent = nullptr);

signals:

public slots:

    void initLanguage();

public:
    static TranslatorTool &getInstance();

private:
    QTranslator *translator;
};

#endif // TRANSLATORTOOL_H
