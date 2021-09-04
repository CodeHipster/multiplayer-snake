-- a clock which will give the time since the game started.
-- can be used to pause the game.

local Clock = {}

function Clock:new ()
    self.__index = self

    return setmetatable({
        -- anchor is the hook to the application timer to be able to give time since the clock was created
        anchor = system.getTimer(),
    }, self)
end

-- get time passed.
function Clock:getTime()
    return system.getTimer() - self.anchor
end

return Clock