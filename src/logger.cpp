#include <QDate>
#include <QDir>
#include <QTextStream>
#include <QKeySequence>
#include <QApplication>
#include <QClipboard>
#include <QTreeWidget>
#include <QPlainTextEdit>
#include "toolkit.h"
#include "setting.h"
#include "Logger.h"
#include "SettingTool.h"

#define SET_MAX_LOGITM  100
#define SET_MAX_LOGTRM  30

Logger::Logger(QObject *parent)
: QObject(parent),m_chkWrite(nullptr),m_treeOut(nullptr),m_textOut(nullptr)
{
}

Logger::~Logger()
{
	m_file.close();
}

void Logger::syncOutput()
{
	QList<QTreeWidgetItem*> list = m_treeOut->selectedItems();
	if (!list.isEmpty())
		m_textOut->setPlainText(list.first()->text(0));
	else
		m_textOut->clear();
}

void Logger::ctxmenu(const QPoint& pos)
{
	if (sender() == (QObject*)m_treeOut)
		m_cmlog.exec(m_treeOut->mapToGlobal(pos));
	else
		m_cmtxt.exec(m_textOut->mapToGlobal(pos));
}

void Logger::copy()
{
	if (sender() == (QObject*)m_treeOut)
	{
		QList<QTreeWidgetItem*> list = m_treeOut->selectedItems();
		if (!list.isEmpty())
			QApplication::clipboard()->setText(list.first()->text(0));
	}
	else
	{
		m_textOut->copy();
	}
}

const QString Logger::getLogFileName()
{
//	int i = 0;
//	while (2 > i++)
//	{
//		if (!m_dir.isEmpty())
//		{
//			QDir d;
//			if (d.exists(m_dir) || d.mkpath(m_dir)) {
//				i = 0;
//				break;
//			}
//		}

//        m_dir = SettingTool::getInstance()- + "/" + property(SET_SEC_DIR).toString();
//	}

//	return (i==2) ? QString() : m_dir + QDir::separator() +
//		QDate::currentDate().toString("yyyyMMdd.log");
    return nullptr;
}

void Logger::writeLogFile(const QString& info)
{
	if (!m_chkWrite->isChecked())
		return;

	m_file.close();
	m_file.setFileName(getLogFileName());

	if (m_file.open(QIODevice::Append|
					QIODevice::WriteOnly|
					QIODevice::Text))
	{
		QByteArray a(info.toUtf8());

		const char* d = a.data();
		for (int n=a.size(); n>0;)
		{
			int w = m_file.write(d, n);

			d += w;
			n -= w;
		}

		m_file.close();
	}
}

void Logger::clear()
{
	m_treeOut->clear();
	m_textOut->clear();
}

void Logger::output(const QString& info)
{
	output("MSG", info);
}

void Logger::output(const char* buf, uint len)
{
	output("DAT", buf, len);
}

void Logger::pack()
{
	if (m_treeOut->topLevelItemCount() > SET_MAX_LOGITM)
		m_treeOut->model()->removeRows(0, SET_MAX_LOGTRM);

	m_treeOut->scrollToBottom();
}

QTreeWidgetItem* Logger::appendLogEntry(QTreeWidgetItem* p, const QString& t)
{
	QTreeWidgetItem* res = new QTreeWidgetItem(p);
	if (res)
	{
		res->setText(0, t);

		if (p)
		{
			p->addChild(res);
		}
		else
		{
			m_treeOut->addTopLevelItem(res);
			m_textOut->setPlainText(t);
		}
	}
	return res;
}

void Logger::output(const QString& title, const QString& info)
{
	QTreeWidgetItem* it = new QTreeWidgetItem(0);
	if (!it) return;

	QString lab(QTime::currentTime().toString("HH:mm:ss "));
	
	lab += title;
	lab += ' ';
	lab += info;

	appendLogEntry(0, lab);

	pack();

	lab += '\n';
	lab += '\n';

	writeLogFile(lab);
}

void Logger::output(const QString& title, const char* buf, quint32 len)
{
	QString lab(QTime::currentTime().toString("HH:mm:ss "));
	
	QTextStream out(&lab);

	out << title
		<< " <" << len << "> "
		<< TK::bin2ascii(buf, len);

	QString hex = TK::bin2hex(buf, len);

	QTreeWidgetItem* it = appendLogEntry(0, lab);
	if (it)
	{
		appendLogEntry(it, hex);

		pack();
	}

	out << '\n' << hex << '\n' << '\n';

	writeLogFile(lab);
}
