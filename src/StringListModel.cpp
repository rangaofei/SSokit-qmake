//
// Created by saka on 2019-02-26.
//

#include "StringListModel.h"

StringListModel::StringListModel(QObject *parent) : QAbstractItemModel(parent) {

}

QHash<int, QByteArray> StringListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "type";
    return roles;
}

QModelIndex StringListModel::index(int row, int column, const QModelIndex &parent) const {
    return QModelIndex();
}

QModelIndex StringListModel::parent(const QModelIndex &child) const {
    return QModelIndex();
}

int StringListModel::rowCount(const QModelIndex &parent) const {
    return 0;
}

int StringListModel::columnCount(const QModelIndex &parent) const {
    return 0;
}

QVariant StringListModel::data(const QModelIndex &index, int role) const {
    return QVariant();
}
