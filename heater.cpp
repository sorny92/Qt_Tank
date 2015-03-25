#include "heater.h"

Heater::Heater(QObject *parent) :
    QObject(parent)
{
}
QString Heater::state(void){
    return m_state;
}
void Heater::setState(QString state){
    if(state!=m_state){
        if(state=="on" || state=="off"){
            m_state=state;
            emit stateChanged();
        }
    }
}
qreal Heater::heat(void){
    return m_heat;
}
void Heater::setHeat(qreal h){
    if(m_state=="on"){
        if(h!=m_heat){
            m_heat=h;
            emit heatChanged();
        }
    }
    if(m_state=="off"){
        m_heat=0;
    }
}
