function showInfoMessage(_message)
    SendNUIMessage({
        type = "showInfoMessage",
        message = _message
    })
end

exports('showInfoMessage', showInfoMessage)