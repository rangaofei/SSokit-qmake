#ifndef TREEITEM_H
#define TREEITEM_H

#include <QVariant>
#include <QVector>
#include <QObject>

class TreeItem : public QObject
{
    Q_OBJECT
public:
    explicit TreeItem(TreeItem *parentItem = nullptr,QObject *parent=nullptr);
    ~TreeItem();

    void appendChild(TreeItem *child);

    TreeItem *child(int row);
    int childCount() const;
    QString data(int column) const;
    void setData(QString data);
    int row() const;
    Q_INVOKABLE QString getData();
    TreeItem *parentItem();

private:
    QVector<TreeItem*> m_childItems;
    QString m_itemData;
    TreeItem *m_parentItem;
};

#endif // TREEITEM_H
