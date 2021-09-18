-- a generic event has a eventType,a timestamp (ms since start), and a player it applies too.

local ChangeDirection = {}

function ChangeDirection:new (timestamp, player, direction)
    self.__index = self

    return setmetatable({
        eventType = "change-direction",
        timestamp = timestamp,
        player = player, -- name of the player as string
        direction = direction
    }, self)
end

return ChangeDirection
