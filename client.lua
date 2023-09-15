local players = {}
local OnPlayerLoaded = ''

if Config.Framework == 'QBCore' then
    local QBCore = exports['qb-core']:GetCoreObject()
    players = QBCore.Functions.GetPlayers()
    OnPlayerLoaded = 'QBCore:Client:OnPlayerLoaded'
elseif Config.Framework == 'Esx' then
    local ESX = {}
    players = ESX.GetPlayers()
    OnPlayerLoaded = 'esx:playerLoaded'
else
    players = GetPlayerFromServerId()
    OnPlayerLoaded = 'playerConnecting'
end

local LockVehicle = Config.LockVehicles == 'Unlocked' and 1 or Config.LockVehicles == 'Locked' and 2 or Config.LockVehicles == 'NoInteract' and 3 or false
local lockenable = LockVehicle and true or false
local plateenabled = Config.CustomPlate and true or false
local plate = plateenabled and Config.Plate or nil
local fuelenabled = Config.FuelSystem ~= 'none' and true or false
local fuel = fuelenabled and Config.FuelSystem or nil
local fuellevel = fuelenabled and Config.FuelLevel or '0'
local freezeenabled = Config.Freeze and true or false
local vehicles = {}
local refreshunit = Config.RefreshUnit == 'Sec' and 1000 or Config.RefreshUnit == 'Min' and 60000 or Config.RefreshUnit == 'Hour' and 3600000
local refresh = (Config.Refresh * refreshunit) or 5000

local function SpawnVeh()
    for k, v in pairs(Config.ShowroomVehicles) do
        for i = 1, #v do
            local model = GetHashKey(v[i].Vehicle)
            local shadoweffect = shadow
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            local veh = CreateVehicle(model, v[i].coords.x, v[i].coords.y, v[i].coords.z, v[i].coords.w, false, false)
            SetVehicleOnGroundProperly(veh)
            SetEntityInvincible(veh, true)
            SetVehicleDirtLevel(veh, 0.0)
            if v[i].colors then
                SetVehicleColours(veh, v[i].colors[1], v[i].colors[2])
            end
            if lockenable then
                SetVehicleDoorsLocked(veh, LockVehicle)
            end
            if freezeenabled then
                FreezeEntityPosition(veh, true)
            end
            if plateenabled then
                SetVehicleNumberPlateText(veh, plate)
            end
            if fuelenabled then
                exports[fuel]:SetFuel(veh, fuellevel)
            end
            if v[i].livery then
                if GetNumVehicleMods(veh, 48) == 0 and GetVehicleLiveryCount(veh) ~= 0 then
                    SetVehicleLivery(veh, v[i].livery)
                    SetVehicleMod(veh, 48, -1, false)
                else
                    SetVehicleMod(veh, 48, (v[i].livery - 1), false)
                    SetVehicleLivery(veh, -1)
                end
            end
            if v[i].extra then
                for _, z in pairs(v[i].extra) do
                    SetVehicleExtra(veh, z, 0)
                end
            end
            if Config.Shadow == false then
                SetVehicleShadowEffect(veh, Config.Shadow) -- Disable vehicle shadows
            end
            table.insert(vehicles, veh)
        end
    end
end

local function DelVeh()
    for i = 1, #vehicles do
        DeleteVehicle(vehicles[i])
    end
    vehicles = {} -- Clear the vehicles table
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        DelVeh() -- Delete any existing vehicles when the resource starts
        Citizen.Wait(100)
        SpawnVeh()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        DelVeh() -- Delete the vehicles when the resource stops
    end
end)

AddEventHandler(OnPlayerLoaded, function()
    SpawnVeh() -- Spawn vehicles when a player is loaded
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(refresh) -- Check every specified interval
        DelVeh()
        Citizen.Wait(100)
        SpawnVeh()
    end
end)
