local composer = require("composer")
local Snake = require("models.snake")
local Apple = require("models.apple")
local directions = require("models.directions")
local Grid = require("models.grid")
local players = require("multiplayer.players");
local State = require("models.state");
local LockStepManager = require("lockstep.manager")
local Renderer = require("render.Renderer");
local InputProcessor = require("input.input-processor");
local EventProcessor = require("lockstep.event-processor");
local Clock = require("lockstep.game-clock");
local Player = require("models.player");
local SnakeMoveTimer = require("lockstep.snake-move-timer");
local socket = require("multiplayer.socket")
local inspect = require("inspect");
local json = require("json")
local ChangeDirection = require("lockstep.events.change-direction")

local scene = composer.newScene()

local state = {
    snake = nil,
}

local gameLoopTimer = nil


-- create()
function scene:create(event)
    print("initializing game")
    local sceneGroup = self.view 
    
    local grid = Grid:new(display.contentWidth,  display.contentHeight)
    local initialState = State:new()
    
    print(inspect(players))
    for iter=1, #players do
        print("adding player: ".. players[iter].name)
        local player = Player:new(10, 10, players[iter].name)
        initialState:addPlayer(player)
    end
    
    -- wire up all the components
    local websocket = socket.get()
    local processor = EventProcessor:new()
    local clock = Clock:new()
    local manager = LockStepManager:new(initialState, clock, processor)
    local renderer = Renderer:new(grid, sceneGroup)
    --TODO: get player controlling the input.
    local inputProcessor = InputProcessor:new(manager, clock, players[1], websocket)
    local snakeMoveTimer = SnakeMoveTimer:new(200, manager)


    local function socketHandler(event)
        if event.type == websocket.ONMESSAGE then
            print('game received message' .. inspect(event))
            local input, pos, msg = json.decode(event.data)                    
            if msg then
                print("error decoding json.")
                return
            end
        
            if not input.type then
                print("message has no type")
                return
            elseif input.type ~= "input" then
                print("message was not for input handler")
                return
            end
            manager:addEvent(ChangeDirection:new(input.time, input.player, input.direction))
        elseif event.type == websocket.ONCLOSE then
            print('game disconnected')
        elseif event.type == websocket.ONERROR then
            print('game error')
        end
    end

    websocket:addEventListener(websocket.WSEVENT, socketHandler)

    -- start the loops
    local function gameLoop()
        snakeMoveTimer:generateEvents(clock:getTime())
        local state = manager:getState()
        renderer:render(state)
    end

    gameLoopTimer = timer.performWithDelay(30, gameLoop, 0)

    -- wrap method in function, as we can't directly feed a method into the Runtime
    local function inputListener(event)
        inputProcessor:onKeyEvent(event)
    end

    -- TODO: we should remove the listener as well when we switch scenes.
    -- TODO: can the listener be part of an object?
    -- Add the key event listener
    Runtime:addEventListener("key", inputListener)

end

-- show()
function scene:show(event)
    print("showing game")

    timer.resume(gameLoopTimer)
end

-- show()
function scene:hide(event)
    print("hiding game")
    timer.pause(gameLoopTimer)
end

-- destroy()
function scene:destroy(event)
    print("destroying game")
    timer.cancel(gameLoopTimer)
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene
