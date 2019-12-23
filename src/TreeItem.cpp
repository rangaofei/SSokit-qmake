#include "TreeItem.h"
TreeItem::TreeItem(TreeItem *itemParent,QObject *parent)
    : QObject(parent),m_parentItem(itemParent)
{}
TreeItem::~TreeItem()
{
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *item)
{
    m_childItems.append(item);
}

TreeItem *TreeItem::child(int row)
{
    if (row < 0 || row >= m_childItems.size())
        return nullptr;
    return m_childItems.at(row);
}

int TreeItem::childCount() const
{
    return m_childItems.count();
}


QString TreeItem::data(int column) const
{
    return m_itemData;

}

void TreeItem::setData(QString data)
{
    this->m_itemData=data;
}

TreeItem *TreeItem::parentItem()
{
    return m_parentItem;
}

int TreeItem::row() const
{
    if (m_parentItem)
        return m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this));

    return 0;
}

QString TreeItem::getData()
{
    return this->m_itemData;
}
