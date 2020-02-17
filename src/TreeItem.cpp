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



void TreeItem::setData(QString data)
{
    this->m_itemData=data;
}

TreeItem *TreeItem::parentItem()
{
    return m_parentItem;
}

QString TreeItem::itemData()
{
    return this->m_itemData;
}

void TreeItem::setItemData(QString itemData)
{
    this->m_itemData=itemData;
}

void TreeItem::setProperty(QString key,QString value,int type)
{
    this->m_property=new JsonCustomProperty;
    this->m_property->setKey(key);
    this->m_property->setValue(value);
    this->m_property->setType(type);
}

JsonCustomProperty* TreeItem::property()
{
    return this->m_property;
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
