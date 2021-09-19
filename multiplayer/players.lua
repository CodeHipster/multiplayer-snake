local inspect = require("inspect");
local players = {}

print("in multiplayer.players")

function players.addLocalPlayer(name)
    print(inspect(name))
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
