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
        type = "showNotification",
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
                setupMessageHud()
                sendNotification("Vous êtes entrer en mode HUD", "warning", 3000)
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
                sendNotification("Vous êtes sortie du mode HUD", "success", 3000)
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

function setupMessageHud()
    Citizen.CreateThread(function()
        while showHud do
            SendNUIMessage({
                type = "showInfoMessage",
                message = "Les mouvements de caméra et les coups de poing sont désactivés."
            })
            Citizen.Wait(5000) -- Attendre 5 secondes avant de renvoyer le message
        end
    end)
end
