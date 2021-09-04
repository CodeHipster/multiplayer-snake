-- event has a command and a timestamp (ms since start)

local Event = {}

function Event:new (command, timestamp, player)
    self.__index = self

    return setmetatable({
        command = command,
        timestamp = timestamp,
        player = player
    }, self)
end

return Event