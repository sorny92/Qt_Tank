#include "tank.h"
#include "math.h"
//#define PI (3.141592653589793)
#define PI 1

Tank::Tank(QObject *parent) :
    QObject(parent)
{
}
qreal Tank::height(void) {
    return m_height;
}

void Tank::setHeight(qreal h){
    if(h!=m_height){
        m_height=h;
        emit heightChanged();
    }
}

qreal Tank::radius(void) {
    return m_radius;
}

void Tank::setRadius(qreal r){
    if( r != m_radius){
        m_radius=r;
        emit radiusChanged();
    }
}

qreal Tank::capacity(void) {
    m_capacity = PI*m_radius*m_radius*m_height/1000;
    return m_capacity;
}

qreal Tank::volume(void){
    m_volume=PI*m_radius*m_radius*m_level/1000;
    return m_volume;
}

qreal Tank::level(void){
    return m_level;
}

void Tank::setLevel(qreal l){
        if (l>=m_height){
            m_level=m_height;
        }else{
            m_level=l;
        }
        emit levelChanged();
}

qreal Tank::temperature(void){
    return m_temperature;
}

void Tank::setTemperature(qreal t){
    if(t!=m_temperature){
        m_temperature=t;
        emit temperatureChanged();
    }
}

qreal Tank::density(void){
    return m_density;
}

void Tank::setDensity(qreal d){
    if(d!=m_density){
        m_density=d;
        emit densityChanged();
    }
}

qreal Tank::heatCapacity(void){
    return m_heatCapacity;
}

void Tank::setHeatCapacity(qreal hc){
    m_heatCapacity=hc;
}

void Tank::inEnergy(qreal energy){
    m_temperature+=(energy/(m_density*m_volume*m_heatCapacity*1000));
    if(m_temperature>100){
        m_temperature=100;
    }
    emit temperatureChanged();
}

// Insert volumes of liquid in the tank
void Tank::inFlow(qreal flow){
    m_level+=(flow/(PI*m_radius*m_radius/100));
    if (m_level>m_height){
        m_level=m_height;
    }
    emit levelChanged();
}

// Throw out volumes of liquid of the tank
void Tank::outFlow(qreal flow){
    if(m_temperature>0){
        m_level-=(flow/(PI*m_radius*m_radius/100));
        if (m_level<0){
            m_level=0;
        }
    }
    emit levelChanged();
}

