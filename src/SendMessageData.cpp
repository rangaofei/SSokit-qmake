#include "SendMessageData.h"

SendMessageData::SendMessageData(QObject *parent) : QObject(parent)
{

}

SendMessageData::~SendMessageData()
{

}

const QString SendMessageData::content()
{
    return this->m_content;
}

void SendMessageData::setContent(QString content)
{
    this->m_content=content;
}

const QString SendMessageData::header()
{
    return this->m_header;
}

void SendMessageData::setHeader(QString header)
{
    this->m_header=header;
}

const QString SendMessageData::footer()
{
    return this->m_footer;
}

void SendMessageData::setFooter(QString footer)
{
    this->m_footer=footer;
}

bool SendMessageData::withHeader()
{
    return m_withHeader;
}

void SendMessageData::setWithHeader(bool withHeader)
{
    this->m_withHeader=withHeader;
}

int SendMessageData::lengthSize()
{
    return this->m_lengthSize;
}

void SendMessageData::setLengthSize(int lengthSize)
{
    this->m_lengthSize=lengthSize;
}

bool SendMessageData::endian()
{
    return this->m_endian;
}

void SendMessageData::setEndian(bool endian)
{
    this->m_endian=endian;
}

bool SendMessageData::plainText()
{
    return this->m_plainText;
}

void SendMessageData::setPlainText(bool plainText)
{
    this->m_plainText=plainText;
}

QString SendMessageData::getTargetMsg()
{
    return this->content()+this->m_footer;
}
