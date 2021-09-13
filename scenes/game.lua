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
    -- TODO: add the players to the state
    for iter=1, #players do
        local player = Player:new(10, 10, players[iter].name)
        initialState:addPlayer(player)
    end
    
    -- wire up all the components
    local processor = EventProcessor:new()
    local clock = Clock:new()
    local manager = LockStepManager:new(initialState, clock, processor)
    local renderer = Renderer:new(grid, sceneGroup)
    local inputProcessor = InputProcessor:new(manager, clock)

    -- start the loops
    local function gameLoop()
        print("game looping")
        local state = manager:getState()
        renderer:render(state)
    end

    gameLoopTimer = timer.performWithDelay(1000, gameLoop, 0)


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
