if not game:IsLoaded() then
    game.Loaded:Wait()
end

local dahood_id = {2788229376, 7213786345} -- Place Id for Da Hood normal and vc
local GetFullName = game.GetFullName

local function debug_print(...)
    --printconsole(table.concat({...}), 255, 115, 115)
end

if not table.find(dahood_id, game.PlaceId) then return end

printconsole(game.Players.LocalPlayer.Name .. " has joined DaHood! Anti-Cheat Running", 255, 255, 0)
local AntiCheat_Flags = {"TeleportDetect", "CHECKER_1", "CHECKER_2", "OneMoreTime", "BreathingHAMON"} -- Flags that trigger anticheat
local MainEvent = game.ReplicatedStorage.MainEvent

local oldNamecall = nil
oldNamecall = hookmetamethod(game, "__namecall", function(...)
    if getnamecallmethod() == "FireServer" then
        local self, arg1 = ...

        if table.find(AntiCheat_Flags, arg1) and self == MainEvent then
            debug_print("DETECTED " .. tostring(arg1) .. " FROM '" .. GetFullName(getcallingscript()) .. "': " .. tostring(arg1), 255, 115,115)
            return false
        end
    end

    if getfenv(2).crash then -- From Stefanuk12's github
        -- // Hook the crash function to prevent game from crashing
        hookfunction(getfenv(2).crash, function()
            debug_print(GetFullName(getcallingscript()) .. ": Crash Attempt")
        end)
    end
    
    return oldNamecall(...)
end)