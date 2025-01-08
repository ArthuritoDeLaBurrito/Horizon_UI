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

-- Fonction pour mettre à jour le HUD
function updateHud(health, hunger, thirst)
    SendNUIMessage({
        type = "updateHud",
        health = health,
        hunger = hunger,
        thirst = thirst
    })
end

-- Simule la faim et la soif
local hunger = 100
local thirst = 100

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Mise à jour toutes les 5 secondes

        -- Récupère la vie du joueur
        local playerPed = PlayerPedId()
        local health = GetEntityHealth(playerPed) - 100 -- La vie commence à 100 par défaut

        -- Réduction progressive de la faim et de la soif
        hunger = math.max(0, hunger - 1) -- Diminue de 1 jusqu'à un minimum de 0
        thirst = math.max(0, thirst - 1) -- Diminue de 1 jusqu'à un minimum de 0

        -- Met à jour le HUD
        updateHud(health, hunger, thirst)
    end
end)


local showHud = false
Citizen.CreateThread(function()
    while true do
        if IsControlPressed(0, 192) then
            if not showHud then
                SendNUIMessage({
                    type = "toggleHud",
                    display = true
                })
                showHud = true
                SetNuiFocus(true, true)
            end
        else
            if showHud then
                showHud = false
                SendNUIMessage({
                    type = "toggleHud",
                    display = false
                })
                SetNuiFocus(false, false)
            end
        end
        Wait(100)
    end
end)