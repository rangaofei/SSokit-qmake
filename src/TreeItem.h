#ifndef TREEITEM_H
#define TREEITEM_H

#include <QVariant>
#include <QVector>
#include <QObject>

class JsonCustomProperty : public QObject
{

    Q_OBJECT
    Q_PROPERTY(QString jsonKey READ key WRITE setKey NOTIFY keyChanged)
    Q_PROPERTY(QString jsonValue READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(int jsonValue READ type WRITE setType NOTIFY typeChanged)
public:
    JsonCustomProperty(QObject *parent = nullptr):QObject(parent)
    {

    }

    JsonCustomProperty(const JsonCustomProperty &other):QObject (nullptr)
    {
        m_key=other.m_key;
        m_value=other.m_value;
        m_type=other.m_type;
    }

    ~JsonCustomProperty()
    {

    }

    QString key()
    {
        return m_key;
    }
    void setKey(QString key)
    {
        this->m_key=key;
    }

    QString value()
    {
        return m_value;
    }

    void setValue(QString value)
    {
        this->value()=value;
    }

    int type()
    {
        return m_type;
    }

    void setType(int type)
    {
        this->m_type=type;
    }

signals:
    void keyChanged();
    void valueChanged();
    void typeChanged();

private:
    QString m_key;
    QString m_value;
    int m_type;
};


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
    QString itemData();
    void setItemData(QString itemData);
    void setProperty(QString key,QString value,int type);
    JsonCustomProperty* property();

private:
    QVector<TreeItem*> m_childItems;
    QString m_itemData;
    TreeItem *m_parentItem;
    JsonCustomProperty* m_property;
};

#endif // TREEITEM_H
