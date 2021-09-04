local State = {}

function State:new ()
    self.__index = self

    return setmetatable({
        players = {},
        timestamp = 0,
    }, self)
end

function State:addPlayer(player)
    table.insert(self.players, player)
end

return State