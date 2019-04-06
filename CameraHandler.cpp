#include "CameraHandler.hpp"

#include <QCameraInfo>

CameraHandler::CameraHandler(QObject* parent) : QObject(parent)
{

}

QStringList CameraHandler::getAvailableCameras() const
{
    auto const camList = QCameraInfo::availableCameras();
    QStringList camListStrList;
    for(auto const& camera: camList){
        camListStrList << camera.description();
        camListStrList << camera.deviceName();
    }
    return camListStrList;
}
