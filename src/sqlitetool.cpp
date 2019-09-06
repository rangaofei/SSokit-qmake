#include "sqlitetool.h"

//#include <QSqlDatabase>
//#include <QSqlQuery>
//#include <qsqlerror>
#include <qdebug.h>

SQLiteTool::SQLiteTool(QObject *parent) : QObject(parent)
{
//    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setHostName("rangaofei.cn");
//    db.setDatabaseName("ssokit_note.db");
//    db.setUserName("rangaofei");
//    db.setPassword("123459");
//    bool ok = db.open();
//    if(ok){
//        qDebug()<<"打开成功";
//    }else {
//        qDebug()<<"打开失败";
//    }
//    //创建表格
//    QSqlQuery *qslQuery = new QSqlQuery(db);
//    if(!qslQuery->exec("create table if not exists student(id int primary key, name text, age int)"))
//    {
//        qDebug() << "Error: Fail to create table."<< qslQuery->lastError().text();
//    }
//    else
//    {
//        qDebug() << "Table created!";
//    }
//    //插入数据
//    if(!qslQuery->exec("INSERT INTO student VALUES(2, \"Wang\", 23)"))
//    {
//        qDebug() << qslQuery->lastError().text();
//    }
//    else
//    {
//        qDebug() << "inserted Wang!";
//    }

//    //查询数据
//        qslQuery->exec("select * from student");
//        if(!qslQuery->exec())
//        {
//            qDebug()<<qslQuery->lastError();
//        }
//        else
//        {
//            while(qslQuery->next())
//            {
//                int id = qslQuery->value(0).toInt();
//                QString name = qslQuery->value(1).toString();
//                int age = qslQuery->value(2).toInt();
//                qDebug()<<QString("id:%1    name:%2    age:%3").arg(id).arg(name).arg(age);
//            }
//        }

//    db.close();

}
