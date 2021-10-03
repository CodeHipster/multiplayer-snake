local inspect = require("inspect");

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
    -- TODO: make sure events are sorted on their timestamp
    table.insert(self.events, event)
end

function Manager:getState()
    -- get last moment where each player has done an action
    local timestamp = confirmedTimestamp(self.events, self.state.players)
    if (timestamp) then
        -- process events up until timestamp
        self.state = self.processor:processUntil(self.events, self.state, timestamp)
        -- remove processed events from the list
        self.events = removeEvents(self.events, timestamp)
    end

    -- process the remaining events.
    local newState = self.processor:process(self.events, self.state)

    return newState
end

-- remove events from the table with a timestamp less then given timestamp(inclusive)
function removeEvents(events, timestamp)
    local newEvents = {}

    for iter = 1, #events do
        if (events[iter].timestamp > timestamp) then
            table.insert(newEvents, events[iter])
        end
    end

    return newEvents
end

function confirmedTimestamp(events, players)
    -- print(inspect(events))
    -- print(inspect(players))
    local playerTimestamps = {}
    -- set value to -1 for each player. Meaning no timestamp
    for iter = 1, #players do
        playerTimestamps[players[iter].name] = -1
    end

    function done()
        for key, value in pairs(playerTimestamps) do
            if (value == -1) then
                return false
            end
        end
        return true
    end

    function min()
        local min = -1

        for key, value in pairs(playerTimestamps) do
            if (min == -1 or value < min) then
                min = value
            end
        end

        return min
    end

    -- iterate from end to start
    for iter = #events, 1, -1 do
        if (events[iter].player) then
            -- if player is not in playerTimestamps
            if (playerTimestamps[events[iter].player] == -1) then
                -- add the timestamp.
                playerTimestamps[events[iter].player] = events[iter].timestamp
                -- check if all players have a timestamp
                if (done()) then
                    return min()
                end
            end
        end
    end

    return false

end

return Manager
