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

local _objectives = {}
function addObjectives(objective)
    exports["horizon"]:normalizeString(objective)

end
exports("addObjective", function(objective)
    addObjectives(objective)
end)

local _title = "Aucun Objectif en cours"
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
        if allCompleted then
            exports["horizon"]:notificationBasic("~g~Tous les objectifs ont été complétés !")
            _objectives = {}
            _title = "Aucun Objectif en cours"
        end
    else
        _objectives[objectiveName] = { text = objective, completed = false }
        exports["horizon"]:notificationBasic("Nouvel objectif : \n~b~" .. objective)
        _title = "Objectif(s) en cours"
    end
    SendNUIMessage({
        type = "showObjectives",
        objectives = _objectives,
        title = _title,
    })
end
exports('toggleObjectives', toggleObjectives)


