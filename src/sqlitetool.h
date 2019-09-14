#ifndef SQLITETOOL_H
#define SQLITETOOL_H

#include <QDateTime>
#include <QObject>
#include <QQmlListProperty>
#include <QSqlDatabase>

#define TABLE_NAME "note_book"
#define COLUMN_ID "id"
#define COLUMN_TITLE "title"
#define COLUMN_CONTENT "content"
#define COLUMN_CREATE_AT "create_at"
#define COLUMN_UPDATE_AT "update_at"


class NoteBook : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)
    Q_PROPERTY(QString updateAt READ updateAt WRITE setUpdateAt NOTIFY updateAtChanged)


public:
    NoteBook(QObject *parent = nullptr):QObject(parent){

    }
    ~NoteBook(){

    }

    int32_t id()const{
        return m_id;
    }

    void setId(int32_t id){
        this->m_id=id;
    }

    QString title()const{
        return m_title;
    }
    void setTitle(const QString title){
        this->m_title=title;
    }
    QString content()const{
        return m_content;
    }
    void setContent(const QString content){
        this->m_content=content;
    }

    QString createAt() const{
        return this->m_create_at;
    }

    void setCreateAt(const QString createAt){
        this->m_create_at=createAt;
    }

    QString updateAt() const{
        return this->m_update_at;
    }

    void setUpdateAt(const QString updateAt){
        this->m_update_at = updateAt;
    }


signals:
    void titleChanged();
    void contentChanged();
    void updateAtChanged();
private:
    int32_t m_id;
    QString m_title;
    QString m_content;
    QString m_create_at;
    QString m_update_at;
};

class SQLiteTool : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<NoteBook> notes READ notes NOTIFY itemChanged)

public:
    explicit SQLiteTool(QObject *parent = nullptr);
    ~ SQLiteTool();

    bool openDb();

    void createTable();

signals:
    void itemChanged();

public slots:
    QQmlListProperty<NoteBook> notes();

    Q_INVOKABLE void appendData(NoteBook *noteBook);
    Q_INVOKABLE void updateData(NoteBook *noteBook);
    Q_INVOKABLE void deleteData(NoteBook *noteBook);
    Q_INVOKABLE void addNewData();
    Q_INVOKABLE int notesCount()const;

private:
    QList<NoteBook*> m_notes;
    QSqlDatabase m_db;
};

#endif // SQLITETOOL_H
