local QBCore = exports['qb-core']:GetCoreObject()
local LockVehicle = Config.LockVehicles == 'Unlocked' and 1 or Config.LockVehicles == 'Locked' and 2 or Config.LockVehicles == 'NoInteract' and 3 or false
local lockenable = LockVehicle and true or false
local plateenabled = Config.CustomPlate and true or false
local plate = plateenabled and Config.Plate or math.random(10000000, 99999999)
local fuelenabled = Config.FuelSystem ~= 'none' and true or false
local fuel = fuelenabled and Config.FuelSystem or nil
local freezeenabled = Config.Freeze and true or false
local vehicles = {}

local function SpawnVeh()
    for k, v in pairs(Config.ShowroomVehicles) do
        for i = 1, #v do
            local model = GetHashKey(v[i].Vehicle)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            local veh = CreateVehicle(model, v[i].coords.x, v[i].coords.y, v[i].coords.z, false, false)
            SetEntityHeading(veh, v[i].coords.w)
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
                exports[fuel]:SetFuel(veh, 0)
            end
            table.insert(vehicles, veh)
        end
    end
end

local function DelVeh()
    for i = 1, #vehicles do
        DeleteVehicle(vehicles[i])
    end
end

AddEventHandler('onResourceStart', SpawnVeh)
AddEventHandler('onResourceStop', DelVeh)
AddEventHandler('QBCore:Client:OnPlayerLoaded', SpawnVeh)
