---@diagnostic disable: undefined-global, lowercase-global
RegisterCommand("showObjectives", function()
    SendNUIMessage({
        type = "showObjectives",
        objectives = {
            { text = "Récupérer un véhicule", completed = false },
            { text = "Aller à l'endroit X", completed = false },
            { text = "Récupérer le colis", completed = false },
            { text = "Livrer le colis", completed = false },
            { text = "Détruire le véhicule", completed = false }
        },
    })
end, false)


RegisterNUICallback("completeObjective", function(data, cb)
    print("Objectif complété :", data.index)
    cb("ok")
end)

local _title = "Aucun Objectif en cours"
local _objectives = {}
function addObjectives(objective)
    local objectiveName = exports["horizon"]:normalizeString(objective)
    if _objectives[objectiveName] == nil then
        _objectives[objectiveName] = { text = objective, completed = false }
        exports["horizon"]:notificationBasic("Nouvel objectif : \n~b~" .. objective)
        _title = "Objectif(s) en cours"
        SendNUIMessage({
            type = "showObjectives",
            objectives = _objectives,
            title = _title,
        })
    end
end
exports("addObjectives", addObjectives)

function toggleObjectives(objective)
    local objectiveName = exports["horizon"]:normalizeString(objective)
    if _objectives[objectiveName] then
        _objectives[objectiveName] = { text = objective, completed = true }
        exports["horizon"]:notificationBasic("Objectif complété : \n~b~" .. objective)
        local allCompleted = true
        for oName, oData in pairs(_objectives) do
            if not oData.completed then
                allCompleted = false
                break
            end
        end
        if (allCompleted) then
            exports["horizon"]:notificationBasic("~g~Tous les objectifs ont été complétés !")
            _objectives = {}
            _title = "Aucun Objectif en cours"
            -- Récompense ! 
        end
        SendNUIMessage({
            type = "showObjectives",
            objectives = _objectives,
            title = _title,
        })
    end
end
exports('toggleObjectives', toggleObjectives)


