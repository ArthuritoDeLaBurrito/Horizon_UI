local showHud = false -- État du HUD

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- Vérifie si la touche TAB est pressée
        if IsControlPressed(0, 192) then -- Touche "Tab"
            if not showHud then
                showHud = true -- Marque la touche TAB comme pressée
                SendNUIMessage({
                    type = "toggleHud",
                    display = true
                })
                SetNuiFocusKeepInput(true) 
                SetNuiFocus(true, true) -- Active la souris pour interagir avec le HUD
            end
        else
            if showHud then
                showHud = false -- Marque la touche TAB comme relâchée
                SendNUIMessage({
                    type = "toggleHud",
                    display = false
                })
                SetNuiFocusKeepInput(false) 
                SetNuiFocus(false, false) -- Désactive la souris
            end
        end
        if showHud then
            DisableControlAction(0, 24, showHud) -- Désactiver l'attaque principale (clic gauche)
            DisableControlAction(0, 140, showHud) -- Désactiver le coup de poing de mêlée
            DisableControlAction(0, 141, showHud) -- Désactiver les attaques secondaires de mêlée
            DisableControlAction(0, 142, showHud) -- Désactiver les attaques secondaires de mêlée (spécifique)
            DisableControlAction(0, 1, showHud) -- Déplacement horizontal de la souris
            DisableControlAction(0, 2, showHud) -- Déplacement vertical de la souris
        end
    end
end)

---@diagnostic disable-next-line: lowercase-global
function updateHud(data)
    SendNUIMessage({
        type = "updateHud",
        info = data
    })
end
exports('updateHud', updateHud)