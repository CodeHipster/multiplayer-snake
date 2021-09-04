-- the event processor processes a list of events on a given state.

local EventProcessor = {}

function EventProcessor:new ()
    self.__index = self

    return setmetatable({
        
    }, self)
end

function EventProcessor:process(events, state, clock)
    -- get all events within a game step. 
    -- get the final events for the players
    -- set the state for each player
    -- apply game logic
    -- redo until current time.
end

return EventProcessor