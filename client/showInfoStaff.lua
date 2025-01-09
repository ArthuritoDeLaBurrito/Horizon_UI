local showInfoStaff = false

function toggleInfoStaff(data)
    showInfoStaff = not showInfoStaff
    SendNUIMessage({
        type = "toggleInfoStaff",
        display = showInfoStaff
    })
end

exports('toggleInfoStaff', toggleInfoStaff)

function updateInfoStaff(data)
    showInfoStaff = not showInfoStaff
    SendNUIMessage({
        type = "updateInfoStaff",
        info = data
    })
end

exports('updateInfoStaff', updateInfoStaff)