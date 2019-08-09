//
// Created by saka on 2019-02-26.
//

#ifndef SSOKIT_STRINGLISTMODEL_H
#define SSOKIT_STRINGLISTMODEL_H


#include <QAbstractItemModel>

class StringListModel : public QAbstractItemModel {
Q_OBJECT
public:
    enum StringRole {
        TypeRole
    };

    StringListModel(QObject *parent= nullptr);

    QHash<int, QByteArray> roleNames() const override;

    QModelIndex index(int row, int column, const QModelIndex &parent) const override;

    QModelIndex parent(const QModelIndex &child) const override;

    int rowCount(const QModelIndex &parent) const override;

    int columnCount(const QModelIndex &parent) const override;

    QVariant data(const QModelIndex &index, int role) const override;
};

#endif //SSOKIT_STRINGLISTMODEL_H
