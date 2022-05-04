local QBCore = exports['qb-core']:GetCoreObject()
local isActive = false

discord = {
    ['webhook'] = "",
    ['name'] = '',
    ['image'] = ""
}

function DiscordLog(name, message, color)
    local embed = {
        {
            ["color"] = 04255,
            ["title"] = "Police Garage Purchase Records",
            ["description"] = message,
            ["url"] = "",
            ["footer"] = {
            ["text"] = "",
            ["icon_url"] = ""
        },
            ["thumbnail"] = {
                ["url"] = "",
            },
    }
}
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = embed, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end

QBCore.Functions.CreateCallback('CL-PoliceGarage:CheckIfActive', function(source, cb)
    local src = source

    if not isActive then
        TriggerEvent("CL-PoliceGarage:server:SetActive", true)
        cb(true)
    else
        cb(false)
        TriggerClientEvent("QBCore:Notify", src, "Someone Is In The Menu Please Wait !", "error")
    end
end)

RegisterNetEvent('CL-PoliceGarage:server:SetActive', function(status)
    if status ~= nil then
        isActive = status
        TriggerClientEvent('CL-PoliceGarage:client:SetActive', -1, isActive)
    else
        TriggerClientEvent('CL-PoliceGarage:client:SetActive', -1, isActive)
    end
end)

RegisterServerEvent("CL-PoliceGarage:AddVehicleSQL", function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.license,
        Player.PlayerData.citizenid,
        vehicle,
        hash,
        json.encode(mods),
        plate,
        0
    })
end)

RegisterServerEvent('CL-PoliceGarage:TakeMoney', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local steamname = GetPlayerName(src)
    if Player.PlayerData.money.cash >= data.price then
        TriggerClientEvent("CL-PoliceGarage:SpawnVehicle", src, data.vehicle)  
        Player.Functions.RemoveMoney("cash", data.price)
        TriggerClientEvent('QBCore:Notify', src, 'Vehicle Successfully Bought', "success")    
        DiscordLog(discord['webhook'], 'New Vehicle Bought By: **'..steamname..'** ID: **' ..source.. '** Bought: **' ..data.vehiclename.. '** For: **' ..data.price.. '$**', 14177041) 
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end    
end)

RegisterServerEvent('CL-PoliceGarage:TakeAirMoney', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local steamname = GetPlayerName(src)
    if Player.PlayerData.money.cash >= data.price then
        TriggerClientEvent("CL-PoliceGarage:SpawnAirVehicle", src, data.vehicle)  
        Player.Functions.RemoveMoney("cash", data.price)
        TriggerClientEvent('QBCore:Notify', src, 'Vehicle Successfully Bought', "success")    
        DiscordLog(discord['webhook'], 'New Vehicle Bought By: **'..steamname..'** ID: **' ..source.. '** Bought: **' ..data.vehiclename.. '** For: **' ..data.price.. '$**', 14177041) 
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end    
end)
