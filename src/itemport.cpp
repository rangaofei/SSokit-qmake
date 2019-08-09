#include "itemport.h"

ItemPort::ItemPort(QObject *parent) : QObject(parent)
{

}

ItemPort::ItemPort(QString port):m_port(port)
{

}

QString ItemPort::port() const
{
    return m_port;
}
