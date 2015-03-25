#ifndef PUMP_H
#define PUMP_H

#include <QObject>
#include <QString>

class Pump : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal flow READ flow WRITE setFlow NOTIFY flowChanged)
    Q_PROPERTY(QString state READ state WRITE setState NOTIFY stateChanged)
public:
    explicit Pump(QObject *parent = 0);
    QString state(void);
    qreal flow(void);
    void setState(QString state);
    void setFlow(qreal f);


signals:
    void stateChanged();
    void flowChanged();

public slots:

private:
    QString m_state;
    qreal m_flow;
};

#endif // PUMP_H
