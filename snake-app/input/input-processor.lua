local ChangeDirection = require("lockstep.events.change-direction")
local players = require("multiplayer.players")
local directions = require("models.directions")
local json = require("json")

local InputProcessor = {}

function InputProcessor:new(eventManager, clock, player, websocket)
    self.__index = self

    return setmetatable({
        eventManager = eventManager,
        clock = clock,
        player = player,
        ws = websocket
    }, self)
end

function InputProcessor:onKeyEvent(event)
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print(message)

    if event.phase == "down" then
        if event.keyName == 'w' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), self.player.name, directions.UP))
            self.ws:send(json.encode({type = "input", time =self.clock:getTime(), player = self.player.name, direction = directions.UP}))
        elseif event.keyName == 's' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), self.player.name, directions.DOWN))
            self.ws:send(json.encode({type = "input", time =self.clock:getTime(), player = self.player.name, direction = directions.DOWN}))
        elseif event.keyName == 'a' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), self.player.name, directions.LEFT))
            self.ws:send(json.encode({type = "input", time =self.clock:getTime(), player = self.player.name, direction = directions.LEFT}))
        elseif event.keyName == 'd' then
            self.eventManager:addEvent(ChangeDirection:new(self.clock:getTime(), self.player.name, directions.RIGHT))
            self.ws:send(json.encode({type = "input", time =self.clock:getTime(), player = self.player.name, direction = directions.RIGHT}))
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

return InputProcessor
