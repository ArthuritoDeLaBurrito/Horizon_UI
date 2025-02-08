buttonListActive = false

function updateButtonList(_buttonList)
    if not buttonListActive then
        SendNUIMessage({
            action = "updateButtonList",
            buttonList = _buttonList,
            eventName = "bossMenu:updateMarker"
        })
        buttonListActive = true
    else
        sendNotification("Système", "Interface(s)", "Une interface similaire est déjà ouverte")
    end
end


RegisterNUICallback("closeButtonList", function(data, cb)
    if data.action == "close_buttonList" then
        buttonListActive = false
    end
end)


RegisterNUICallback("clickButtonList", function(data, cb)
    if data.action == "click_buttonList" then
        print(json.encode(data))
        exports["horizon"]:_HorizontoInternal(("ui:client:buttonList:click:%s"):format(data.eventName), data)
    end
end)

RegisterCommand("testB", function(source, args, rawCommand)
    updateButtonList({
        {name = "Test1", label = "Vestiaire", desc = "Marqueur du Vestiaire", action = "cloakroom.position"},
        {name = "Test12", label = "Armurerire", desc = "Marqueur du Armurerire", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Menu", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Spawn", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Delete", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"}
        ,
        {name = "Test123", label = "Garage - Menu", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Spawn", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Delete", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Menu", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Spawn", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
        {name = "Test123", label = "Garage - Delete", desc = "Marqueur du Menu du Garage", action = "cloakroom.position"},
    })
end, false)