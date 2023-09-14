Config = {
    CustomPlate = true,                                               -- Should We Enable Custom Vehicle Plate System? if true, below must have valid value
    Plate = 'CW-SHOW',                                                -- Vehicles Plate Text (UP TO 8 LETTER/NUMBERS)
    
    LockVehicles = 'NoInteract',                                      -- Set Vehicle Lock Status, Available Options = Unlocked, Locked, NoInteract

    FuelSystem = 'LegacyFuel',                                        -- Put Your Fuel Script Name Here! Use 'none' To Disable The System

    Freeze = true,

    ShowroomVehicles = {
        ['pdm'] = {                                                   -- Just A Simple Name!
            [1] = {
                Vehicle = 'autarch',                                  -- Vehicle Model Name!
                colors = { 1 },                                       -- Vehicle Color, First one is main and second one is secondry color! Use: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                coords = vector4(-45.65, -1093.66, 25.44, 69.5),      -- Location To Spawn The Vehicle
            },
        },
--        ['vip'] = {
--            [1] = {
--                Vehicle = 'autarch',
--                colors = { 1 , 1 },
--                coords = vector4(-45.65, -1093.66, 25.44, 69.5),
--            },
--        },
    },
}
