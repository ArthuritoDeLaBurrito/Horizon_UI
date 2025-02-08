function infoToggle(_message)
    SendNUIMessage({
        type    = "toggleInfo",
        message = _message,
    })
end
exports('infoToggle', infoToggle)