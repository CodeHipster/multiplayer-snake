local MoveSnakes = {}

function MoveSnakes:new (timestamp)
    self.__index = self

    return setmetatable({
        eventType = "move-snakes",
        timestamp = timestamp,
    }, self)
end

return MoveSnakes