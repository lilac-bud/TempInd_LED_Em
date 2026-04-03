#ifndef TEMPERATURESENSOR_H
#define TEMPERATURESENSOR_H

#include <QObject>

class TemperatureSensor : public QObject
{
    Q_OBJECT
private:
    int range_lower = 200;
    int range_upper = 350;
    int range_delta = range_upper - range_lower;

public:
    explicit TemperatureSensor(QObject *parent = nullptr);
    Q_INVOKABLE float getTemperature();
    Q_INVOKABLE void setLowerTemp(double value);
    Q_INVOKABLE void setUpperTemp(double value);
    void updateDelta() { range_delta = range_upper - range_lower; }
};

#endif // TEMPERATURESENSOR_H
