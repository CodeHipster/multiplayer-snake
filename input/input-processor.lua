local ChangeDirection = require("lockstep.events.change-direction");
local players = require("multiplayer.players")
local directions = require("models.directions");

local InputProcessor = {}

function InputProcessor:new(eventManager, clock)
    self.__index = self

    return setmetatable({
        eventManager = eventManager,
        clock = clock
    }, self)
end

function InputProcessor:onKeyEvent(event)
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print(message)

    if event.phase == "down" then
        if event.keyName == 'w' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), "player", directions.UP))
        elseif event.keyName == 's' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), "player", directions.DOWN))
        elseif event.keyName == 'a' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), "player", directions.LEFT))
        elseif event.keyName == 'd' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), "player", directions.RIGHT))
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

return InputProcessor
