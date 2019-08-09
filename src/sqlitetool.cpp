//#include "sqlitetool.h"

//#include <QSqlDatabase>
//#include <QSqlQuery>
//#include <qsqlerror>
//#include <qdebug.h>

//SQLiteTool::SQLiteTool(QObject *parent) : QObject(parent)
//{
//    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setHostName("rangao");
//    db.setDatabaseName("./note.db");
//    db.setUserName("rangaofei");
//    db.setPassword("123456");
//    bool ok = db.open();
//    if(ok){
//        qDebug()<<"打开成功";
//    }else {
//        qDebug()<<"打开失败";
//    }
//    //创建表格
//    //create table student(id int primary key, name text, age int)
//    QSqlQuery *qslQuery = new QSqlQuery(db);
//    if(!qslQuery->exec("create table student(id int primary key, name text, age int)"))
//    {
//        qDebug() << "Error: Fail to create table."<< qslQuery->lastError().text();
//    }
//    else
//    {
//        qDebug() << "Table created!";
//    }
//    //插入数据
//    if(!qslQuery->exec("INSERT INTO student VALUES(1, \"Wang\", 23)"))
//    {
//        qDebug() << qslQuery->lastError().text();
//    }
//    else
//    {
//        qDebug() << "inserted Wang!";
//    }

//    db.close();

//}
