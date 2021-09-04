local composer = require("composer")
local Snake = require("models.snake")
local Apple = require("models.apple")
local directions = require("models.directions")
local Grid = require("models.grid")

local scene = composer.newScene()

local state = {
    snake = nil,
}

local gameLoopTimer = nil

-- create()
function scene:create(event)
    print("initializing game")

    local sceneGroup = self.view
    -- draw a grid
    local grid = Grid:new(display.contentWidth,  display.contentHeight)
    sceneGroup:insert(grid.displayGroup)

    -- TODO: maybe have a lobby scene when we implement multiplayer?
    -- init state
    state.snake = Snake:new(10, 10)
    sceneGroup:insert(state.snake.displayGroup)

    -- start the loops
    local function gameLoop()
        print("game looping")
        -- move snakes
        state.snake:move()
    end

    gameLoopTimer = timer.performWithDelay(500, gameLoop, 0)

    local function onKeyEvent(event)
        -- Print which key was pressed down/up
        local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
        print(message)

        if event.phase == "down" then
            if event.keyName == 'w' then
                state.snake:setDirection(directions.UP)
            elseif event.keyName == 's' then
                state.snake:setDirection(directions.DOWN)
            elseif event.keyName == 'a' then
                state.snake:setDirection(directions.LEFT)
            elseif event.keyName == 'd' then
                state.snake:setDirection(directions.RIGHT)
            end
        end

        -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
        -- This lets the operating system execute its default handling of the key
        return false
    end
    -- TODO: we should remove the listener as well when we switch scenes.
    -- TODO: can the listener be part of an object?
    -- Add the key event listener
    Runtime:addEventListener("key", onKeyEvent)
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
