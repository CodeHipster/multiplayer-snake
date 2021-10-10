-- the event processor processes a list of events on a given state.
local inspect = require("inspect");

local EventProcessor = {}

function EventProcessor:new ()
    self.__index = self

    return setmetatable({
        
    }, self)
end

function EventProcessor:process(events, state)

    local newState = state:copy()

    for iter = 1, #events do
        -- apply event to state
        if events[iter].eventType == "change-direction"  then
            for pi = 1, #newState.players do
                if newState.players[pi].name == events[iter].player then
                    newState.players[pi].snake:setDirection(events[iter].direction)
                end
            end
        end
    
        if events[iter].eventType == "move-snakes"  then
            -- move snakes
            for iter = 1, #state.players do
                newState.players[iter].snake:move()
            end
        end
    end
            
    return newState
end

-- TODO: remove duplicate code
-- process events up to a timestamp (inclusive)
function EventProcessor:processUntil(events, state, timestamp)

    local newState = state:copy()

    for iter = 1, #events do
        if events[iter].timestamp > timestamp then
            -- exit loop, all events up to timestamp have been processed.
            break;
        end

        -- apply event to state
        if events[iter].eventType == "change-direction"  then
            for pi = 1, #newState.players do
                if newState.players[pi].name == events[iter].player then
                    newState.players[pi].snake:setDirection(events[iter].direction)
                end
            end
        end
    
        if events[iter].eventType == "move-snakes"  then
            -- move snakes
            for iter = 1, #state.players do
                newState.players[iter].snake:move()
            end
        end
    end
            
    return newState
end

return EventProcessor
