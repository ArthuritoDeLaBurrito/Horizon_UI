local nuiVisible = false

function openUI(pageName)
    -- Envoie un événement à l'UI
    SendNUIMessage({
        type = "openUI",
        page = pageName
    })
    SetNuiFocus(true, true)
end

function sendDataToPage(pageName, data)
    SendNUIMessage({
        type = "updatePageData", -- Type du message
        page = pageName,        -- Nom de la page cible
        data = data             -- Données à envoyer
    })
end

RegisterNUICallback("closeUI", function(data, cb)
    print("L'UI a été fermée par l'utilisateur.")
    SetNuiFocus(false, false)
    cb("ok")
end)


function sendNotification(title, subtitle, description, logo, duration)
    SendNUIMessage({
        type = "showNotification",
        title = title or " ",
        subtitle = subtitle or " ",
        description = description or "",
        logo = logo or "../src/assets/img/logo_96x96.png", -- URL ou chemin local pour le logo
        duration = duration or 3000 -- Durée par défaut : 3 secondes
    })
end


function sendNUI(_type, _display)
    SendNUIMessage({
        type = _type,
        display = _display
    })
end

local first = false 
function ShutdownLoadingScreenUI()
    if not first then
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        print("dsokfjdslfsqdqsdkj")

        Wait(1000)
        SendNUIMessage({
            type = "hideLoadingScreen" -- Fermer la ressource d'écran de chargement
        })
        print("azeaze")
        
        
        first = true
    end
end

RegisterCommand("t", function()
   --[[ SendNUIMessage({
        type = "toggleInventory",
        visible = inventoryVisible
    })]]
    SetNuiFocus(false, false)
end, false)


RegisterNUICallback("menuOptions", function(data, cb)
    print("Liste complète des options reçue :")
    for _, option in ipairs(data.data) do
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

    cb("ok") -- Confirme que l'action est terminée
end)