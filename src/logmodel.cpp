#include <utility>

#include "logmodel.h"

LogModel::LogModel(QObject *parent) : QObject(parent) {

}

void LogModel::writeMsg(QString msg) {
    emit sendMsg(std::move(msg));
}
