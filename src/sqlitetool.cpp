#include "sqlitetool.h"

#include <QSqlQuery>
#include <qsqlerror>
#include <qdebug.h>

SQLiteTool::SQLiteTool(QObject *parent) : QObject(parent)
{
    m_db =QSqlDatabase::addDatabase("QSQLITE");
    m_db.setHostName("rangaofei.cn");
    m_db.setDatabaseName("ssokit_note.db");
    m_db.setUserName("rangaofei");
    m_db.setPassword("");
    if(!openDb()){
        return;
    }
    createTable();
}

SQLiteTool::~SQLiteTool()
{
    if(m_db.isOpen()){
        m_db.close();
    }
}

bool SQLiteTool::openDb()
{
    bool ok = m_db.open();
    if(ok){
        qDebug()<<"打开成功";
        return true;
    }else {
        qDebug()<<"打开失败";
        return false;
    }
}

void SQLiteTool::createTable()
{
    QString sqlStr=QString("CREATE TABLE IF NOT EXISTS %1 ( "
                           "%2 INTEGER PRIMARY KEY AUTOINCREMENT, "
                           "%3 TEXT NOT NULL, "
                           "%4 TEXT, "
                           "%5 TimeStamp NOT NULL DEFAULT (datetime('now','localtime')), "
                           "%6 TimeStamp NOT NULL DEFAULT (datetime('now','localtime'))"
                           ")")
            .arg(TABLE_NAME)
            .arg(COLUMN_ID)
            .arg(COLUMN_TITLE)
            .arg(COLUMN_CONTENT)
            .arg(COLUMN_CREATE_AT)
            .arg(COLUMN_UPDATE_AT);
    qDebug()<<sqlStr;
    //创建表格
    m_qslQuery = new QSqlQuery(m_db);
    if(!m_qslQuery->exec(sqlStr))
    {
        qDebug() << "Error: Fail to create table."<< m_qslQuery->lastError().text();
    }
    else
    {
        qDebug() << "Table created!";
    }
}

QQmlListProperty<NoteBook> SQLiteTool::notes()
{
    m_notes.clear();
    //查询数据
    m_qslQuery->exec("select * from note_book order by update_at desc");
    if(!m_qslQuery->exec())
    {
        qDebug()<<m_qslQuery->lastError();
    }
    else
    {
        while(m_qslQuery->next())
        {
            int id = m_qslQuery->value(0).toInt();
            QString title = m_qslQuery->value(1).toString();
            QString content = m_qslQuery->value(2).toString();
            QString updateAt=m_qslQuery->value(4).toString();
            NoteBook *n=new NoteBook;
            n->setId(id);
            n->setTitle(title);
            n->setContent(content);
            n->setUpdateAt(updateAt);
            m_notes.append(n);
        }
    }
    return QQmlListProperty<NoteBook>(this,m_notes);
}

void SQLiteTool::appendData(NoteBook *noteBook)
{
    if(noteBook==nullptr){
        return;
    }
    QSqlQuery *sqlQuery=new QSqlQuery(m_db);
    sqlQuery->prepare("INSERT INTO note_book (title,content) VALUES (:title,:content)");
    sqlQuery->bindValue(":title", noteBook->title());
    sqlQuery->bindValue(":content",noteBook->content());
    sqlQuery->exec();

}

void SQLiteTool::updateData(NoteBook *noteBook)
{
    if(noteBook==nullptr){
        return;
    }
    QSqlQuery *sqlQuery=new QSqlQuery(m_db);
    sqlQuery->prepare("UPDATE note_book SET title = :title, content = :content, update_at = :update_at where id = :id");
    sqlQuery->bindValue(":id",noteBook->id());
    sqlQuery->bindValue(":title",noteBook->title());
    sqlQuery->bindValue(":content",noteBook->content());
    QDateTime current_date_time =QDateTime::currentDateTime();
    QString current_date =current_date_time.toString("yyyy-MM-dd hh:mm:ss");
    sqlQuery->bindValue(":update_at",current_date);
    sqlQuery->exec();
    emit itemChanged();
}

void SQLiteTool::deleteData(NoteBook *noteBook)
{

    if(noteBook==nullptr){
        return;
    }
    qDebug()<<noteBook->id()<<"----";
    QSqlQuery *sqlQuery=new QSqlQuery(m_db);
    sqlQuery->prepare("delete from note_book where id = ?");
    sqlQuery->addBindValue(noteBook->id());
    sqlQuery->exec();
    emit itemChanged();
}

void SQLiteTool::addNewData()
{
    NoteBook *noteBook=new NoteBook;
    QSqlQuery *sqlQuery=new QSqlQuery(m_db);
    QDateTime current_date_time =QDateTime::currentDateTime();
    QString current_date =current_date_time.toString("yyyy-MM-ddhh:mm:ss");
    noteBook->setTitle(current_date);
    sqlQuery->prepare("INSERT INTO note_book (title,content) VALUES (:title,:content)");
    sqlQuery->bindValue(":title", noteBook->title());
    sqlQuery->bindValue(":content",noteBook->content());
    sqlQuery->exec();
    delete noteBook;
    emit itemChanged();
}


int SQLiteTool::notesCount() const
{
    return m_notes.size();
}
