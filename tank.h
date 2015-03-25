#ifndef TANK_H
#define TANK_H

#include <QObject>
#include <QString>

class Tank : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(qreal height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(qreal level READ level WRITE setLevel NOTIFY levelChanged)
    Q_PROPERTY(qreal density READ density WRITE setDensity NOTIFY densityChanged)
    Q_PROPERTY(qreal heatCapacity READ heatCapacity WRITE setHeatCapacity NOTIFY heatCapacityChanged)
    Q_PROPERTY(qreal temperature READ temperature WRITE setTemperature NOTIFY temperatureChanged)
    Q_PROPERTY(qreal capacity READ capacity)
    Q_PROPERTY(qreal volume READ volume)


public:
    explicit Tank(QObject *parent = 0);
    qreal height(void);
    qreal capacity(void);
    qreal radius(void);
    qreal level(void);
    qreal temperature(void);
    qreal volume(void);
    qreal density(void);
    qreal heatCapacity(void);
    void setLevel(qreal l);
    void setRadius(qreal r);
    void setHeight(qreal h);
    void setTemperature(qreal t);
    void setDensity(qreal d);
    void setHeatCapacity(qreal hc);

signals:
    void heightChanged();
    void radiusChanged();
    void levelChanged();
    void temperatureChanged();
    void densityChanged();
    void materialChanged();
    void heatCapacityChanged();

public slots:
    void inFlow(qreal flow);
    void outFlow(qreal flow);
    void inEnergy(qreal energy);
private:
    qreal m_height;
    qreal m_radius;
    qreal m_capacity;
    qreal m_level;
    qreal m_volume;
    qreal m_temperature;
    qreal m_density;
    qreal m_heatCapacity;
};
#endif // TANK_H
