Config = {
    Framework = 'QBCore',                                             -- FrameWork! Use 'none' For StandAlone Use, Available Options: 'QBCore', 'Esx', 'none'
    
    CustomPlate = true,                                               -- Should We Enable Custom Vehicle Plate System? if true, below must have valid value
    Plate = 'CW-SHOW',                                                -- Vehicles Plate Text (UP TO 8 LETTER/NUMBERS)
    
    LockVehicles = 'NoInteract',                                      -- Set Vehicle Lock Status, Available Options = Unlocked, Locked, NoInteract

    FuelSystem = 'LegacyFuel',                                        -- Put Your Fuel Script Name Here! Use 'none' To Disable The System
    FuelLevel = '0',                                                  -- Put Your Fuel Level For Vehicles Here! Available Options = '0' to '100'
    
    Freeze = true,                                                    -- Should We Freeze Vehicles? true or false

    Refresh = 5,                                                      -- Put The Time For Refresh. PLEASE NOTE THAT LOWER THAN 10 SEC MAY CONSUME YOUR SERVER CPU
    RefreshUnit = 'Min',                                              -- Put The Unit For Refresh, Available Options = 'Sec', 'Min' or 'Hour'. PLEASE NOTE THAT LOWER THAN 10 SEC MAY CONSUME YOUR SERVER CPU

    Shadow = true,                                                    -- Put false or true, While false, Vehicles Won't Have Shadow Effect

    ShowroomVehicles = {
        ['pdm'] = {                                                   -- Just A Simple Name!
            [1] = {
                Vehicle = 'autarch',                                  -- Vehicle Model Name!
                colors = { 1 },                                       -- Vehicle Color, Can Be Removed, First one is main and second one is secondry color! Use: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                livery = 0,                                           -- Vehicle Livery ID, Can Be Removed
                extra = { 1 , 2 },                                    -- Vehicle Extras ID, Can Be Removed
                coords = vector4(-45.65, -1093.66, 25.44, 69.5),      -- Location To Spawn The Vehicle
            },
        },
--        ['vip'] = {
--            [1] = {
--                Vehicle = 'autarch',
--                colors = { 1 , 1 },
--                livery = 0,
--                extra = { 1 , 2 },
--                coords = vector4(-45.65, -1093.66, 25.44, 69.5),
--            },
--        },
    },
}
