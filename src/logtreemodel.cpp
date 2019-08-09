#include "logtreemodel.h"

LogTreeModel::LogTreeModel(QObject *parent) : QAbstractItemModel(parent) {}

LogTreeModel::~LogTreeModel() {

}

QModelIndex LogTreeModel::index(int row, int column, const QModelIndex &parent) const {
    return createIndex(row, column);

}

QModelIndex LogTreeModel::parent(const QModelIndex &child) const {
    return QModelIndex();
}

int LogTreeModel::rowCount(const QModelIndex &parent) const {
    // 根节点下有2行，其它行下没有
    if (parent.row() == -1)
    {
        return 2;
    }
    return 0;
}

int LogTreeModel::columnCount(const QModelIndex &parent) const {
    return 2;
}

QVariant LogTreeModel::data(const QModelIndex &index, int role) const {
    return QVariant();
}
