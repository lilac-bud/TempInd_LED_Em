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
    return float(range_lower + std::rand() % range_delta) / 10;
}