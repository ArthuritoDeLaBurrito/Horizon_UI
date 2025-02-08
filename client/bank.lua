--[[
Citizen.CreateThread(function()
    SetNuiFocus(true, true)
    SendNUIMessage({ 
        action = "OpenBankingMenu",
        banklabel = "Chez les Riches",
        mybankdata = {id = 1, iban = "123456", created = 1733870360, bank = 150000, transactions = {}, account_id = 1, owner = 6576574, limit = nil, permissions = {}},
        playerdata = {name = "Arthurito", money = 1000000, sex = "m", new = false, pincode = 1234, partners = {}, accounts = {}},
        moneyform = "$",
        ibannumbers = 6,
        ibanprefix = "US",
        costs = {pincode = 1000, iban = 15000, sub = 30000},
        dailylimit = 250000,
    })
end)
]]