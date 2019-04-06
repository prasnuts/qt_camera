#pragma once

#include <QObject>

class CameraHandler : public QObject
{
    Q_OBJECT

public:
    /**
     * @brief Explicit constructor
     * @param [in] parent The parent QObject instance if any
     */
    explicit CameraHandler(QObject* parent = nullptr);

    /**
     * @brief Get available cameras of the system
     * @return A QStringList with all available cameras of the system
     */
    Q_INVOKABLE QStringList getAvailableCameras() const;

};

