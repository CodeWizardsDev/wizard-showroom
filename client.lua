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

local vehicleClassNames = {
    [0] = "Compacts",
    [1] = "Sedans",
    [2] = "SUVs",
    [3] = "Coupes",
    [4] = "Muscle",
    [5] = "Sports Classics",
    [6] = "Sports",
    [7] = "Super",
    [8] = "Motorcycles",
    [9] = "Off-road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Vans",
    [13] = "Cycles",
    [14] = "Boats",
    [15] = "Helicopters",
    [16] = "Planes",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Trains"
}

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
                SetVehicleShadowEffect(veh, Config.Shadow)
            end

            local function addTargetOption(veh, optionName, label, icon, onSelect)
                exports.ox_target:addLocalEntity(veh, {{
                    name = optionName,
                    label = label,
                    icon = icon,
                    onSelect = onSelect
                }})
            end
            if Config.EnableTargetOptions then
                if Config.EnableHood then
                    addTargetOption(veh, 'showroom_hood', Translations.target.hood, 'fas fa-car', function()
                        local doorId = 4
                        if GetVehicleDoorAngleRatio(veh, doorId) > 0.0 then
                            SetVehicleDoorShut(veh, doorId, false)
                        else
                            SetVehicleDoorOpen(veh, doorId, false, false)
                        end
                    end)
                end
                if Config.EnableTrunk then
                    addTargetOption(veh, 'showroom_trunk', Translations.target.trunk, 'fas fa-car', function()
                        local doorId = 5
                        if GetVehicleDoorAngleRatio(veh, doorId) > 0.0 then
                            SetVehicleDoorShut(veh, doorId, false)
                        else
                            SetVehicleDoorOpen(veh, doorId, false, false)
                        end
                    end)
                end
                if Config.EnableDoors then
                    addTargetOption(veh, 'showroom_doors', Translations.target.doors, 'fas fa-car-side', function()
                        for doorId = 0, 3 do
                            if GetVehicleDoorAngleRatio(veh, doorId) > 0.0 then
                                SetVehicleDoorShut(veh, doorId, false)
                            else
                                SetVehicleDoorOpen(veh, doorId, false, false)
                            end
                        end
                    end)
                end
                if Config.EnableVehInfo then
                    addTargetOption(veh, 'showroom_info', Translations.target.vehinfo, 'fas fa-info-circle', function()
                        local model = GetEntityModel(veh)
                        local vehicleProps = {
                            model = model,
                            name = GetLabelText(GetDisplayNameFromVehicleModel(model)),
                            brand = GetMakeNameFromVehicleModel(model),
                            plate = GetVehicleNumberPlateText(veh),
                            class = GetVehicleClass(veh)
                        }
                        local info = string.format(
                            "\n\n%s: %s \n%s: %s \n%s: %s",
                            Translations.vehinf.name, vehicleProps.name, 
                            Translations.vehinf.brand, vehicleProps.brand,
                            Translations.vehinf.class, vehicleClassNames[vehicleProps.class] or "Unknown"
                        )
                        TriggerEvent('chat:addMessage', {
                            color = {255, 255, 0},
                            multiline = true,
                            args = {'Vehicle Info', info}
                        })
                    end)
                end
                if Config.EnableVehStat then
                    addTargetOption(veh, 'showroom_stats', Translations.target.vehstat, 'fas fa-chart-bar', function()
                        local acceleration = math.min(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 250, 100)
                        local braking = math.min(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 50, 100)
                        local handling = math.min(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMax') * 33, 100)
                        
                        local maxSpeed = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel')
                        maxSpeed = Config.SpeedUnit == 'mph' and math.floor(maxSpeed * 1.22) or math.floor(maxSpeed * 1.32)
                        
                        local statsText = string.format(
                            "\n\n%s: %d%s\nAcceleration: %d/100\nBraking: %d/100\nHandling: %d/100",
                            Translations.vehstat.topspeed, maxSpeed, Config.SpeedUnit,
                            math.floor(acceleration),
                            math.floor(braking),
                            math.floor(handling)
                        )
                        
                        TriggerEvent('chat:addMessage', {
                            color = {255, 255, 0},
                            multiline = true,
                            args = {"Vehicle Stats", statsText}
                        })
                    end)
                end
            end
            table.insert(vehicles, veh)
        end
    end
end

local function DelVeh()
    for i = 1, #vehicles do
        DeleteVehicle(vehicles[i])
    end
    vehicles = {}
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        DelVeh()
        Citizen.Wait(100)
        SpawnVeh()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        DelVeh()
    end
end)

AddEventHandler(OnPlayerLoaded, function()
    SpawnVeh()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(refresh)
        DelVeh()
        Citizen.Wait(100)
        SpawnVeh()
    end
end)
