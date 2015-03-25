#ifndef HEATER_H
#define HEATER_H

#include <QObject>
#include <QString>

class Heater : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal heat READ heat WRITE setHeat NOTIFY heatChanged)
    Q_PROPERTY(QString state READ state WRITE setState NOTIFY stateChanged)
public:
    explicit Heater(QObject *parent = 0);
    QString state(void);
    qreal heat(void);
    void setState(QString state);
    void setHeat(qreal h);


signals:
    void stateChanged();
    void heatChanged();

public slots:

private:
    QString m_state;
    qreal m_heat;
};

#endif // HEATER_H
