#ifndef TREEITEM_H
#define TREEITEM_H

#include <QVariant>
#include <QVector>
#include <QObject>

class TreeItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString itemData READ itemData)

public:
    explicit TreeItem(TreeItem *parentItem = nullptr,QObject *parent=nullptr);
    ~TreeItem();

    void appendChild(TreeItem *child);

    TreeItem *child(int row);
    int childCount() const;
    void setData(QString data);
    int row() const;
    Q_INVOKABLE QString getData();
    TreeItem *parentItem();

    QString key();
    void setKey(QString key);
    QString sep();
    void setSep(QString sep);
    QString value();
    void setValue(QString value);
    QString itemData();


private:
    QVector<TreeItem*> m_childItems;
    QString m_itemData;
    QString m_key;
    QString m_sep;
    QString m_value;
    TreeItem *m_parentItem;
};

#endif // TREEITEM_H
