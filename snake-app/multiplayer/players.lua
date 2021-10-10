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

-- returns false if the player was not added. otherwise true.
function players.addMultiPlayer(name)

    for iter = 1, #players do
        if players[iter].name == name then
            -- TODO, handle other player having same name.
            return false
        end
    end

    table.insert(players, {
        name = name,
        input = false
    });
    print("added player: " .. name)
    return true
end

return players
