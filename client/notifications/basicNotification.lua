function basicNotification(_title, _subtitle, _description, _logo, _duration)
    SendNUIMessage({
        type    = "basicNotification",
        title   = _title,
        subtitle = _subtitle,
        description = _description,
        logo    = _logo,
        duration = _duration
    })
end
exports('basicNotification', basicNotification)