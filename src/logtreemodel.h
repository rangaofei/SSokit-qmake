#ifndef LOGTREEMODEL_H
#define LOGTREEMODEL_H

#include <QObject>
#include <QAbstractItemModel>

typedef struct log_data {
    quint32 index;
    QString time;
    QString data;
    QString hexData;

} LogData;

class LogTreeModel : public QAbstractItemModel {
public:
    LogTreeModel(QObject *parent);

    virtual ~LogTreeModel();

    QModelIndex index(int row, int column, const QModelIndex &parent) const override;

    QModelIndex parent(const QModelIndex &child) const override;

    int rowCount(const QModelIndex &parent) const override;

    int columnCount(const QModelIndex &parent) const override;

    QVariant data(const QModelIndex &index, int role) const override;
};

#endif // LOGTREEMODEL_H