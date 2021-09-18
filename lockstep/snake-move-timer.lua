-- generates the events for moving the snakes.
local MoveSnakes = require("lockstep.events.move-snakes");

local SnakeMoveTimer = {}

function SnakeMoveTimer:new(steptime, eventManager)
    self.__index = self

    return setmetatable({
        manager=eventManager,
        steptime=steptime,
        lastStep=0
    }, self)
end

-- get time passed.
function SnakeMoveTimer:generateEvents(timestamp)
    while self.lastStep + self.steptime < timestamp do
        local newStep = self.lastStep + self.steptime
        local moveEvent = MoveSnakes:new(newStep)
        self.manager:addEvent(moveEvent)
        self.lastStep = newStep
    end
end

return SnakeMoveTimer