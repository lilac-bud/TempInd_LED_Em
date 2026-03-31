#ifndef TEMPERATURESENSOR_H
#define TEMPERATURESENSOR_H

#include <QObject>

class TemperatureSensor : public QObject
{
    Q_OBJECT
private:
    int range_lower = 200;
    int range_delta = 150;

public:
    explicit TemperatureSensor(QObject *parent = nullptr);
    Q_INVOKABLE float getTemperature();
    Q_INVOKABLE void setLowerTemp(double value) { range_lower = (int)(value * 10); }
    Q_INVOKABLE void setUpperTemp(double value) { range_delta = (int)(value * 10) - range_lower; }
};

#endif // TEMPERATURESENSOR_H
