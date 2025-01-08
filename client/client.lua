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


function sendNotification(message, notificationType, duration)
    SendNUIMessage({
        type = "notification",
        message = message,
        notificationType = notificationType or "info", -- Types possibles : 'info', 'success', 'warning', 'error'
        duration = duration or 3000 -- Durée en millisecondes
    })
end

local first = false 
function ShutdownLoadingScreen()
    if not first then
        
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        SendNUIMessage({
            type = "hideLoadingScreen" -- Fermer la ressource d'écran de chargement
        })
        first = true
    end
end
