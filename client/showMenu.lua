---@diagnostic disable: cast-local-type
local openMenu = false
function showMenu(_title, _options)
    if not openMenu then
        openMenu = not openMenu
        SendNUIMessage({
            type = "openMenu",
            title = _title,
            options = _options
        })
        SetNuiFocus(true, true) 
        Citizen.CreateThread(function()
            while openMenu do
                Citizen.Wait(10)
                DisableControlAction(0, 24, openMenu) -- Désactiver l'attaque principale (clic gauche)
                DisableControlAction(0, 140, openMenu) -- Désactiver le coup de poing de mêlée
                DisableControlAction(0, 141, openMenu) -- Désactiver les attaques secondaires de mêlée
                DisableControlAction(0, 142, openMenu) -- Désactiver les attaques secondaires de mêlée (spécifique)
                DisableControlAction(0, 1, openMenu) -- Déplacement horizontal de la souris
                DisableControlAction(0, 2, openMenu) -- Déplacement vertical de la souris
            end
        end)
    else
    end
end
exports('showMenu', showMenu)


RegisterNUICallback("returnMenu", function(data, cb)
    print("Liste complète des options reçue :")
    for _, option in ipairs(data) do
        print(string.format("Option: %s, Checked: %s", option.label, tostring(option.checked)))
        -- Logique basée sur chaque option
        if option.value == "weather" and option.checked then
            print("Météo activée.")
            -- Exemple : Active une logique liée à la météo
        elseif option.value == "traffic" and not option.checked then
            print("Trafic désactivé.")
            -- Exemple : Désactive une logique liée au trafic
        end
    end
    openMenu = not openMenu
    SetNuiFocus(false, false) 
    cb("ok") -- Confirme que l'action est terminée
end)