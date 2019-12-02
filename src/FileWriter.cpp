#include "FileWriter.h"

FileWriter::FileWriter(QObject *parent) : QObject(parent)
{
    file=new QFile;
}

FileWriter::~FileWriter()
{
    file->flush();
    file->close();
    delete file;
}

void FileWriter::setFileName(QString& name)
{
    file->setFileName(name);
    file->open(QIODevice::WriteOnly);
}



void FileWriter::writeData(QByteArray data)
{
    file->write(data);
}

void FileWriter::writeLogMessage(LogMessageModel *model)
{
    file->write(model->byteArray());
}
