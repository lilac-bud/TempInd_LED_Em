#include "temperaturesensor.h"

#include <stdlib.h>
#include <ctime>

TemperatureSensor::TemperatureSensor(QObject *parent)
    : QObject{parent}
{
    std::srand((unsigned)time(nullptr));
}

float TemperatureSensor::getTemperature()
{
    int t = range_delta ? range_lower + std::rand() % range_delta : range_lower;
    return float(t) / 10;
}

void TemperatureSensor::setLowerTemp(double value)
{
    range_lower = (int)(value * 10);
    updateDelta();
}
void TemperatureSensor::setUpperTemp(double value)
{
    range_upper = (int)(value * 10);
    updateDelta();
}