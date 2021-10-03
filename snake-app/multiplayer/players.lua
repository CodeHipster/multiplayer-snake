local inspect = require("inspect");
local players = {}

function players.addLocalPlayer(name)
    print("adding local player: " .. name)
    players.localPlayer = name
    table.insert(players, {
        name = name,
        input = true
    });
end

function players.addMultiPlayer(name)
-- TODO: ensure unique
    table.insert(players, {
        name = name,
        input = false
    });
end

return players
