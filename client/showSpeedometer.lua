function updateSpeedometerData(_gear, _speed, _fuel)
    SendNUIMessage({
        type = "updateSpeedometer",
        gear = _gear,
        speed = _speed,
        fuel = _fuel,
    })
end
exports('updateSpeedometerData', updateSpeedometerData)