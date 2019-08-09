#include "notepadmodel.h"

NotepadModel::NotepadModel(QObject *parent) : QObject(parent) {

}

QString NotepadModel::placeHolder() {
    return "123";
}

void NotepadModel::setPlaceHolder(const QString &data) {
    m_placeHolder = data;
}

