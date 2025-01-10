---@diagnostic disable: lowercase-global
function updateSpeedometerData(_gear, _speed, _fuel, _isEmergency)
    SendNUIMessage({
        type = "updateSpeedometer",
        gear = _gear,
        speed = _speed,
        fuel = _fuel,
        isEmergency = _isEmergency
    })
end
exports('updateSpeedometerData', updateSpeedometerData)