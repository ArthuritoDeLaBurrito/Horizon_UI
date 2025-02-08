function showMenu(_menu, _dynamic)
    SendNUIMessage({
        type = "createMenu",
        menu = _menu,
        dynamic = _dynamic
    })
end
exports('showMenu', showMenu)

local keys = {["172"] = "ArrowUp", ["173"] = "ArrowDown",["176"] = "Enter", ["177"] = "Backspace"}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)
        for k,v in pairs(keys) do
            if IsControlJustPressed(0, tonumber(k)) then
                SendNUIMessage({
                    type = "keyPress",
                    key = v
                })
            end
        end
    end
end)