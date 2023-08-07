-- Create a new instance of the database
local db = Database.new(GetCurrentResourceName(), "players", true, true, 60000, true)

-- Initialize the database with the "players" collection
db:init({"players"})

-- Event: When a player joins
AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    local playerIdentifier = GetPlayerIdentifier(source, 0)
    
    -- Load player data from the database
    local playerData = db:get("players", playerIdentifier)
    if not playerData then
        playerData = { name = playerName, money = 0, level = 1 }
        db:insert("players", playerIdentifier, playerData)
    end
end)

-- Event: When a player leaves
AddEventHandler("playerDropped", function(reason)
    local playerIdentifier = GetPlayerIdentifier(source, 0)
    
    -- Save player data to the database
    local playerData = {
        name = GetPlayerName(source),
        money = getPlayerMoney(source), -- Assume you have a function for this
        level = getPlayerLevel(source)  -- Assume you have a function for this
    }

    db:update("players", playerIdentifier, playerData)
end)
