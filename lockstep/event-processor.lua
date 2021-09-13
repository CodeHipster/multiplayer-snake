-- the event processor processes a list of events on a given state.
local inspect = require("inspect");

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
    print("processing events: " .. #events)
    print(inspect(events))

    local now = clock:getTime()

    local start = state.timestamp
    local stepEnd = start+500

    local newState = state:copy()

    while stepEnd < now do
        for iter = 1, #events do
            if events[iter].timestamp >= start and events[iter].timestamp < stepEnd then
                -- apply event to state
                print(events[iter].eventType)
                if events[iter].eventType == "change-direction"  then
                    print("changing direction")
                    newState.players[1].snake:setDirection(events[iter].direction)
                end
            end
        
        end
        -- move snakes
        for iter = 1, #state.players do
            newState.players[iter].snake:move()
        end
        
        -- set for next iteration
        start = stepEnd 
        stepEnd = start + 1000 --take 1000 ms steps for now
    end

    
    return newState
end

return EventProcessor


-- events: { {
--     16:30:13.096      direction = {
--     16:30:13.096        x = 0,
--     16:30:13.096        y = -1
--     16:30:13.096      },
--     16:30:13.096      eventType = "change-direction",
--     16:30:13.096      player = "player",
--     16:30:13.096      timestamp = 51465.2,
    