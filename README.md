# Wizard Vehicle Showroom
Our first script! please give us star if this script is usefull for you!

# ShowCase
0.00 ms on ResMon!

![image](https://github.com/CodeWizardsDev/wizard-showroom/assets/94300419/959e7848-3efe-4b7d-a390-6405b07960f5)



# Features
- Spawn addon/default vehicles!
- Change Vehicle Primary/Secondry Color
- Custom/Random Plate
- Customizable Vehicle lock: Unlocked, Locked, NoInteract
- Customizable Fuel-System (for Unlocked mode)
- Customizable Fuel-Level (for Unlocked mode)
- Customizable Refresh Vehicles Timer, You can simply use Sec, Min and Hour
- Customizable Shadow Effects
- Interaction menu using ox-target script
- Option to open Hood, Trunk or Doors
- Option to Show vehicle information
- Option to Show vehicle performance status

# Depencies
- [qb-core](https://github.com/qbcore-framework/qb-core) or [es-extended](https://github.com/ESX-Official/es_extended) or NOTHING!

# Installation
- Drag and drop the file in your `resources` folder
- Add this to your server cfg server.cfg  `ensure wizard-showroom`

- Open config.lua and edit `Framework` to your framework or use none for STANDALONE
- Customize the script as you want!

 ## Customizing
 - To use custom license plates, make sure you enabled `CustomPlate` on line 5, then on line 6, change `Plate`. **UP TO 8 LETTERS**
 - To change vehicle lock system, edit `LockVehicles` on line 8, You have 3 Options: Unlocked, Locked, NoInteract
 - To edit fuel system, change `FuelSystem` on line 10. you have to enter the fuel script name there.
 - To edit fuel level, change `FuelLevel` on line 11.
 - To make vehicle stuck, make sure `Freeze` is true on line 13
 - To edit vehicles refresh time, edit `Refresh` and `RefreshUnit` on lines 15 and 16, you can use 'Sec', 'Min' or 'Hour' on `RefreshUnit`
 - To edit vehicles shadow stats, edit `Shadow` on line 18.

 - You can spawn vehicle using `Vehicle`
 - You can chnage spawn location using `coords`
 - You can change vehicle primary/secondery colors using `colors`, ALSO REMOVE IT FOR RANDOM COLORS
 - You can change vehicle liveries using `livery`, ALSO REMOVE IT FOR RANDOM LIVERY
 - You can change vehicle extras using `extra`, ALSO REMOVE IT FOR RANDOM EXTRA

# Support
- [Discord Server](https://discord.gg/ZBvacHyczY)
- Discord ID: mohammad_hs5
