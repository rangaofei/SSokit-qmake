#ifndef SENDMESSAGEDATA_H
#define SENDMESSAGEDATA_H

#include <QObject>



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
    const QString content();
    void setContent(QString content);
    const QString header();
    void setHeader(QString header);
    const QString footer();
    void setFooter(QString footer);
    bool withHeader();
    void setWithHeader(bool withHeader);
    int lengthSize();
    void setLengthSize(int lengthSize);
    bool endian();
    void setEndian(bool endian);
    bool plainText();
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
