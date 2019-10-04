#ifndef __TOOLKIT_H__
#define __TOOLKIT_H__

#include <QGlobalStatic>
#include <QVector>
#include <QHostAddress>

class QAbstractSocket;

typedef struct _IPAddr
{
    QHostAddress ip;
    quint16 port;
} IPAddr;

class TK
{
public:
    typedef enum { OUT=0, OUT2IN, IN, ERR } PARSE_STA;

    static const char* hextab;
    static QString ascii2hex(const QString& src, QVector<uint>& posmap, uint& count);
    static QString bin2hex(const char* buf, uint len);
    static QString bin2ascii(const char* buf, uint len);
    static bool ascii2bin(const QString& src, QByteArray& dst, QString& err);

    static char* createBuffer(qint64& cap, qint64 limit);
    static void  releaseBuffer(char*& buf);

    static const char* socketTypeName(bool tcp);
    static const char* socketTypeName(QAbstractSocket* skt);

    static QString ipstr(const QHostAddress& addr, quint16 port);
    static QString ipstr(const QHostAddress& addr, quint16 port, bool tcp);
};

#endif // __TOOLKIT_H__

