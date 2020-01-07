#ifndef JSONFORMAT_H
#define JSONFORMAT_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QAbstractListModel>
#include "TreeItem.h"
#include <QString>


class JsonModel : public QAbstractItemModel
{
    Q_OBJECT

public:
    explicit JsonModel(QObject *parent = nullptr);
    ~JsonModel();

    enum JsonType{
        KEY = Qt::UserRole + 1,
        VALUE = Qt::UserRole +2,
    };
    Q_ENUM(JsonType)

    // QAbstractItemModel interface
public:
    QModelIndex index(int row, int column, const QModelIndex &parent) const;
    QModelIndex parent(const QModelIndex &child) const;
    int rowCount(const QModelIndex &parent) const;
    int columnCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    Qt::ItemFlags flags(const QModelIndex &index) const;

    void convertJsonToTree(QJsonDocument *doc);

    void parseJsonObject(TreeItem * parentItem,QJsonObject *jsonValue);
    void parseJsonArray(TreeItem * parentItem,QJsonArray *jsonValue);

protected:
    QHash<int,QByteArray> roleNames() const;

private:
    TreeItem *rootItem;
};


class JsonFormat :public QObject
{
    Q_OBJECT

public:
    explicit JsonFormat(QObject *parent = nullptr);

    ~JsonFormat();
    Q_PROPERTY(JsonModel* jsonModel READ jsonModel WRITE setJsonModel NOTIFY jsonModelChanged)
signals:
    void formattedJson(QString data);

    void formattedError(QString error);
public slots:

    JsonModel *jsonModel();

    void setJsonModel(JsonModel *jsonModel);

    void checkJonsStr(const QVariant data);

    void convertJsonToTreeModel(const QVariant data);

signals:
    void jsonModelChanged();

private:
    JsonModel *m_jsonModel;
    QJsonDocument *m_jsonDocument;
    QJsonParseError m_error;
};

#endif // JSONFORMAT_H
