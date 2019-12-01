#ifndef SENDMESSAGEDATA_H
#define SENDMESSAGEDATA_H

#include <QObject>


//qml类，用来传递发送信息
class SendMessageData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString content READ content WRITE setContent)
    Q_PROPERTY(QString header READ header WRITE setHeader)
    Q_PROPERTY(QString footer READ footer WRITE setFooter)
    Q_PROPERTY(bool withHeader READ withHeader WRITE setWithHeader)
    Q_PROPERTY(int lengthSize READ lengthSize WRITE setLengthSize)
    Q_PROPERTY(bool endian READ endian WRITE setEndian)
    Q_PROPERTY(bool plainText READ plainText WRITE setPlainText)
public:

    explicit SendMessageData(QObject *parent = nullptr);
    ~SendMessageData();
signals:

public slots:
    //发送的主要内容
    const QString content();
    //设置发送的主要内容
    void setContent(QString content);
    //发送头信息
    const QString header();
    //设置发送头信息
    void setHeader(QString header);
    //发送尾信息
    const QString footer();
    //设置发送尾信息
    void setFooter(QString footer);
    //是否发送头
    bool withHeader();
    //设置是否发送头
    void setWithHeader(bool withHeader);
    //内容长度
    int lengthSize();
    //设置内容长度
    void setLengthSize(int lengthSize);
    //大小端
    bool endian();
    //设置是否大端
    void setEndian(bool endian);
    //是否纯文本
    bool plainText();
    //设置是否纯文本
    void setPlainText(bool plainText);


    QString getTargetMsg();
private:
    QString m_content;//将要发送的内容
    QString m_header;//头信息
    QString m_footer;//尾信息
    bool m_withHeader;//是否包含头信息
    int m_lengthSize;//长度大小
    bool m_endian;//字节序模式
    bool m_plainText;//是否是纯文本

};

#endif // SENDMESSAGEDATA_H
