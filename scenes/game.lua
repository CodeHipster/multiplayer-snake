local composer = require( "composer" )
local Snake = require("models.snake")
local Apple = require("models.apple")
 
local scene = composer.newScene()

local state = {
    snake = nil,
    apple = nil
}

local gameLoopTimer = nil

-- create()
function scene:create( event )
    print("initializing game")
    
    local sceneGroup = self.view
    -- draw a grid
    local width = display.contentWidth
    local height = display.contentHeight

    for y=0, height do 
        local line = display.newLine(sceneGroup, 0,y,width,y)
        line.strokeWidth = 0.1
    end

    for x=0, width do
        local line = display.newLine(sceneGroup, x,0,x,height)
        line.strokeWidth = 0.1
    end

    -- TODO: maybe have a lobby scene when we implement multiplayer?
    -- init state
    state.snake = Snake:new(10,10)
    state.apple = Apple:new(20,20)

    -- start the loop
    
    local function gameLoop()
        print("looping")
    end 

    gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
end


-- show()
function scene:show( event )
    print("showing game")

    timer.resume(gameLoopTimer)

end

-- show()
function scene:hide( event )
    print("hiding game")
    timer.pause(gameLoopTimer)
end

-- destroy()
function scene:destroy( event )
    print("destroying game")
    timer.cancel(gameLoopTimer)
end




-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene