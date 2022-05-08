local QBCore = exports['qb-core']:GetCoreObject()
local InPreview = false
local isActive = false
PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

AddEventHandler('onClientResourceStart',function()
    Citizen.CreateThread(function()
        while true do
            if QBCore ~= nil and QBCore.Functions.GetPlayerData ~= nil then
                QBCore.Functions.GetPlayerData(function(PlayerData)
                    if PlayerData.job then
                        PlayerJob = PlayerData.job
                    end
                end)
                break
            end
        end
        Citizen.Wait(1)
    end)
end)
--car menu
RegisterNetEvent('CL-PoliceGarage:Menu', function()
    local Menu = {
        {
            header = "Police Garage",
            txt = "View Vehicles",
            params = {
                event = "CL-PoliceGarage:Catalog",
            }
        }
    }
    Menu[#Menu+1] = {
        header = "Preview Vehicles",
        txt = "View Vehicles",
        params = {
            event = "CL-PoliceGarage:PreviewCarMenu",
        }
    }
    Menu[#Menu+1] = {
        header = "⬅ Close Menu",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)

--heli menu
RegisterNetEvent('CL-PoliceGarage:MenuHeli', function()
    local Menu = {
        {
            header = "Police Air Garage",
            txt = "View Vehicles",
            params = {
                event = "tlm-PoliceGarage:AirCatalog",
            }
        }
    }
    Menu[#Menu+1] = {
        header = "Preview Vehicles",
        txt = "View Vehicles",
        params = {
            event = "CL-PoliceGarage:PreviewHeliMenu",
        }
    }
    Menu[#Menu+1] = {
        header = "⬅ Close Menu",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)

-- car catalog
RegisterNetEvent("CL-PoliceGarage:Catalog", function()
    local vehicleMenu = {
        {
            header = "Police Garage",
            isMenuHeader = true,
        }
    }
    local authorizedVehicles = Config.PoliceVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for k, v in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.vehiclename,
            txt = "Buy: " .. v.vehiclename .. " For: " .. v.price .. "$",
            params = {
                isServer = true,
                event = "CL-PoliceGarage:TakeMoney",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "CL-PoliceGarage:Menu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)

--heli catalog
RegisterNetEvent("tlm-PoliceGarage:AirCatalog", function()
    local vehicleMenu = {
        {
            header = "Police Air Garage",
            isMenuHeader = true,
        }
    }
    local authorizedVehicles1 = Config.PoliceAirVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for k, v in pairs(authorizedVehicles1) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.vehiclename,
            txt = "Buy: " .. v.vehiclename .. " For: " .. v.price .. "$",
            params = {
                isServer = true,
                event = "tlm-PoliceGarage:TakeAirMoney",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "CL-PoliceGarage:MenuHeli"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent('CL-PoliceGarage:PreviewCarMenu', function()
    local PreviewMenu = {
        {
            header = "Preview Menu",
            isMenuHeader = true
        }
    }
    local authorizedVehicles = Config.PoliceVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for k, v in pairs(authorizedVehicles) do
        PreviewMenu[#PreviewMenu+1] = {
            header = v.vehiclename,
            txt = "Preview: " .. v.vehiclename,
            params = {
                event = "CL-PoliceGarage:PreviewVehicle",
                args = {
                    vehicle = v.vehicle,
                }
            }
        }
    end
    PreviewMenu[#PreviewMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "CL-PoliceGarage:Menu"
        }
    }
    exports['qb-menu']:openMenu(PreviewMenu)
end)

RegisterNetEvent('CL-PoliceGarage:PreviewHeliMenu', function()
    local PreviewMenu1 = {
        {
            header = "Preview Menu",
            isMenuHeader = true
        }
    }
    local authorizedVehicles1 = Config.PoliceAirVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for k, v in pairs(authorizedVehicles1) do
        PreviewMenu1[#PreviewMenu1+1] = {
            header = v.vehiclename,
            txt = "Preview: " .. v.vehiclename,
            params = {
                event = "tlm-PoliceGarage:PreviewAirVehicle",
                args = {
                    vehicle = v.vehicle,
                }
            }
        }
    end
    PreviewMenu1[#PreviewMenu1+1] = {
        header = "⬅ Go Back",
        params = {
            event = "CL-PoliceGarage:Menu"
        }
    }
    exports['qb-menu']:openMenu(PreviewMenu1)
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed) 
        local letSleep = true
        if PlayerJob.name == Config.Job then
            if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.78894, -1020.011, 28.225797, true) < 10) then
                letSleep = false
                DrawMarker(36, 441.78894, -1020.011, 28.225797 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, 0, 0, 0, 255, true, false, false, true, false, false, false)
                if Config.UseMarkerInsteadOfMenu then
                    if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.78894, -1020.011, 28.225797, true) < 1.5) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                        DrawText3D(441.78894, -1020.011, 28.225797, "~g~E~w~ - Police Garage")
                        if IsControlJustReleased(0, 38) then
                            Notify("Park your car and comeback", "error")
                        end
                    end
                else
                    if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.78894, -1020.011, 28.225797, true) < 1.5) then
                        DrawText3D(441.78894, -1020.011, 28.225797, "~g~E~w~ - Police Garage")
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("CL-PoliceGarage:Menu")
                        end
                    end
                end
            end
        end
        if letSleep then
            Wait(2000)
        end
        Wait(1)
    end
end)

--heli thread
CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed) 
        local letSleep = true
        if PlayerJob.name == Config.Job then
            if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, -1281.07, -3397.44, 13.94, true) < 10) then
                letSleep = false
                DrawMarker(36, -1281.07, -3397.44, 13.94 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, 0, 0, 0, 255, true, false, false, true, false, false, false)
                if Config.UseMarkerInsteadOfMenu then
                    if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, -1281.07, -3397.44, 13.94, true) < 1.5) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                        DrawText3D(-1281.07, -3397.44, 13.94, "~g~E~w~ - Police Air Garage")
                        if IsControlJustReleased(0, 38) then
                            Notify("Park your car and comeback", "error")
                        end
                    end
                else
                    if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, -1281.07, -3397.44, 13.94, true) < 1.5) then
                        DrawText3D(-1281.07, -3397.44, 13.94, "~g~E~w~ - Police Air Garage")
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("CL-PoliceGarage:MenuHeli")
                        end
                    end
                end
            end
        end
        if letSleep then
            Wait(2000)
        end
        Wait(1)
    end
end)

RegisterNetEvent('CL-PoliceGarage:client:SetActive', function(status)
    isActive = status
end)

RegisterNetEvent("CL-PoliceGarage:SpawnVehicle", function(vehicle)
    local coords = vector4(438.47174, -1021.936, 28.627538, 96.793121)
    local v = Config.PoliceVehicles
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
        exports['lj-fuel']:SetFuel(veh, 100.0)
        CloseMenu()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        TriggerServerEvent("CL-PoliceGarage:AddVehicleSQL", props, vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh))
    end, coords, true)
end)

RegisterNetEvent("tlm-PoliceGarage:SpawnAirVehicle", function(vehicle)
    local coords = vector4(-1266.04, -3371.06, 13.94, 330.3)
    local v = Config.PoliceAirVehicles
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
        exports['lj-fuel']:SetFuel(veh, 100.0)
        CloseMenu()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        TriggerServerEvent("CL-PoliceGarage:AddVehicleSQL", props, vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh))
    end, coords, true)
end)

RegisterNetEvent("CL-PoliceGarage:PreviewVehicle", function(data)
    QBCore.Functions.TriggerCallback('CL-PoliceGarage:CheckIfActive', function(result)
        if result then
            InPreview = true
            local coords = vector4(307.1, -595.011, 43, 55.184043)
            QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                SetEntityVisible(PlayerPedId(), false, 1)
                FreezeEntityPosition(PlayerPedId(), true)
                SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                exports['lj-fuel']:SetFuel(veh, 0.0)
                CloseMenu()
                FreezeEntityPosition(veh, true)
                SetVehicleEngineOn(veh, false, false)
                DoScreenFadeOut(200)
                Citizen.Wait(500)
                DoScreenFadeIn(200)
                SetVehicleUndriveable(veh, true)
                VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 307.1, -595.011, 43, 50, 0.00, 282.17034, 80.00, true, 0)
                SetCamActive(VehicleCam, true)
                RenderScriptCams(true, true, 500, true, true)
                Citizen.CreateThread(function()
                    while true do
                        if InPreview then
                            ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                        elseif not InPreview then
                            break
                        end
                        Citizen.Wait(1)
                    end
                end)
                Citizen.CreateThread(function()
                    while true do
                        if IsControlJustReleased(0, 177) then
                            SetEntityVisible(PlayerPedId(), true, 1)
                            FreezeEntityPosition(PlayerPedId(), false)
                            PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            QBCore.Functions.DeleteVehicle(veh)
                            DoScreenFadeOut(200)
                            Citizen.Wait(500)
                            DoScreenFadeIn(200)
                            RenderScriptCams(false, false, 1, true, true)
                            InPreview = false
                            TriggerServerEvent("CL-PoliceGarage:server:SetActive", false)
                            break
                        end
                        Citizen.Wait(1)
                    end
                end)
            end, coords, true)
        end
    end)
end)

RegisterNetEvent("tlm-PoliceGarage:PreviewAirVehicle", function(data)
    QBCore.Functions.TriggerCallback('CL-PoliceGarage:CheckIfActive', function(result)
        if result then
            InPreview = true
            local coords = vector4(-1271.18, -3380.68, 13.91, 30.00)
            QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                SetEntityVisible(PlayerPedId(), false, 1)
                FreezeEntityPosition(PlayerPedId(), true)
                SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                exports['lj-fuel']:SetFuel(veh, 0.0)
                CloseMenu()
                FreezeEntityPosition(veh, true)
                SetVehicleEngineOn(veh, false, false)
                DoScreenFadeOut(200)
                Citizen.Wait(500)
                DoScreenFadeIn(200)
                SetVehicleUndriveable(veh, true)
                VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1265.18, -3370.68, 17.91, 50, 0.00, 149.17034, 80.00, true, 0)
                SetCamActive(VehicleCam, true)
                RenderScriptCams(true, true, 500, true, true)
                Citizen.CreateThread(function()
                        while true do
                        if InPreview then
                            ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                        elseif not InPreview then
                            break
                        end
                        Citizen.Wait(1)
                    end
                end)
                Citizen.CreateThread(function()
                    while true do
                        if IsControlJustReleased(0, 177) then
                            SetEntityVisible(PlayerPedId(), true, 1)
                            FreezeEntityPosition(PlayerPedId(), false)
                            PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            QBCore.Functions.DeleteVehicle(veh)
                            DoScreenFadeOut(200)
                            Citizen.Wait(500)
                            DoScreenFadeIn(200)
                            RenderScriptCams(false, false, 1, true, true)
                            InPreview = false
                            TriggerServerEvent("CL-PoliceGarage:server:SetActive", false)
                            break
                        end
                        Citizen.Wait(1)
                    end
                end)
            end, coords, true)
        end
    end)
end)

function CloseMenu()
    exports['qb-menu']:closeMenu()
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
