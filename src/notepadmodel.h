#ifndef NOTEPADVIEW_H
#define NOTEPADVIEW_H

#include <QObject>

class NotepadModel : public QObject {
Q_OBJECT
public:
    explicit NotepadModel(QObject *parent = nullptr);



    void setPlaceHolder(const QString &data);

signals:

public slots:
    QString placeHolder();
private:
    QString m_placeHolder;
};

#endif // NOTEPADVIEW_H
