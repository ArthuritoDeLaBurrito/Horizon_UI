local sodaMachineProx = false
local sodaMachineProximity = function()
    sodaMachineProx = not sodaMachineProx
    if sodaMachineProx then
        SendNUIMessage({ type = "showDispenser" })
    else
        SendNUIMessage({ type = "errorDispenser" })
    end
end
exports("sodaMachineProximity", sodaMachineProximity)
