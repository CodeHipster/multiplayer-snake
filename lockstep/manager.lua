-- a lockstep manager, keeps track of all the events
local EventProcessor = require("lockstep.event-processor");
local Clock = require("lockstep.game-clock");

local Manager = {}

function Manager:new (initialState)
    self.__index = self

    return setmetatable({
        events = {},
        state = initialState,
        processor = EventProcessor:new(),
        clock = Clock:new(),
    }, self)
end

function Manager:addEvent(event)
    table.insert(self.events, event)
end

function Manager:getState()
    return self.eventProcessor.process(self.events, self.state, self.clock)
end

return Manager