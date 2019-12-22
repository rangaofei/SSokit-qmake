#ifndef LOGMESSAGEMODEL_H
#define LOGMESSAGEMODEL_H

#include <QAbstractItemModel>
#include <QObject>
#include <QTime>

class LogMessageModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(bool isRev READ isRev WRITE setIsRev NOTIFY isRevChanged)
    Q_PROPERTY(QString host READ host WRITE setHost NOTIFY hostChanged)
    Q_PROPERTY(int32_t length READ length WRITE setLength NOTIFY lengthChanged)

public:

    QVariant obj;

    explicit LogMessageModel(QObject *parent = nullptr){
        Q_UNUSED(parent)
        m_time=QTime::currentTime().toString("HH:mm:ss.zzz ");
    }
    ~LogMessageModel(){
    }

    Q_INVOKABLE QString time() const{
        return this->m_time;
    }

    Q_INVOKABLE void setTime(QString time){
        this->m_time=time;
    }

    Q_INVOKABLE bool isRev() const{
        return this->m_isRev;
    }
    Q_INVOKABLE void setIsRev(bool isRev) {
        this->m_isRev=isRev;
    }

    Q_INVOKABLE QString host() const{
        return this->m_host;
    }

    Q_INVOKABLE void setHost(QString host){
        this->m_host=host;
    }


    Q_INVOKABLE int64_t length() const{
        return this->m_length;
    }

    Q_INVOKABLE void setLength(int64_t length){
        this->m_length=length;
    }

    Q_INVOKABLE const char* buf(){
        return this->m_buf;
    }


    Q_INVOKABLE void setBuf(const char* buf){
        this->m_buf=buf;
    }

signals:
    void timeChanged();
    void isRevChanged();
    void hostChanged();
    void lengthChanged();

public slots:


private:
    QString m_time;
    bool m_isRev;
    QString m_host;
    int64_t m_length;
    const char* m_buf;
};

class LogMessageListPrivate;

class LogMessageList : public QAbstractListModel{

    Q_OBJECT

public:

    enum Datatype{
        time=1,
        isRev,
        host,
        length,
        ascData,
        hexData,
        textData,
        binData,
    };
    Q_ENUM(Datatype)

    explicit LogMessageList(QObject *parent=nullptr);
    ~LogMessageList();

    Q_INVOKABLE void setCurrentItem(int index);

public slots:

    void addData(LogMessageModel* model);

    void clearData();

    void clearRecvData();

    void clearSendData();

    LogMessageModel* get(int index);

    int rowCount(const QModelIndex &parent=QModelIndex()) const;  //返回给定父项行数

    QVariant data(const QModelIndex &index, int role=Qt::DisplayRole) const;//返回索引所在项给定角色的存储数据

protected:
    QHash<int,QByteArray> roleNames() const;  //返回模型的角色名


private:
    QList<LogMessageModel*> m_dataList;
    LogMessageModel * m_currentData;
};


#endif // LOGMESSAGEMODEL_H
