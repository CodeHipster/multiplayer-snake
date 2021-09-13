-- a lockstep manager, keeps track of all the events
local Manager = {}

function Manager:new(initialState, clock, eventProcessor)
    self.__index = self


    return setmetatable({
        events = {},
        state = initialState,
        processor = eventProcessor,
        clock = clock
    }, self)
end

function Manager:addEvent(event)
    table.insert(self.events, event)
end

function Manager:getState()

    local newState = self.processor:process(self.events, self.state, self.clock)

    return newState
end

return Manager
