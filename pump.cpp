#include "pump.h"

Pump::Pump(QObject *parent) :
    QObject(parent)
{
}
//Set State
QString Pump::state(void){
    return m_state;
}

void Pump::setState(QString state){
    if(state!=m_state){
        if(state=="open" || state=="close"){
            m_state=state;
            emit stateChanged();
        }
    }
}
//Set Flow
qreal Pump::flow(void){
    return m_flow;
}
// FLow in liters/second
void Pump::setFlow(qreal f){
    if(m_state=="open"){
        if(f!=m_flow){
            m_flow=f;
            emit flowChanged();
        }
    }
    if(m_state=="close"){
        m_flow=0;
    }
}
