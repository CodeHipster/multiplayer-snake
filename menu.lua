-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local composer = require( "composer" )
 
local scene = composer.newScene()

local function gotoGame()
    composer.gotoScene( "game" )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
  

-- create()
function scene:create( event )
    
    -- Code here runs when the scene is first created but has not yet appeared on screen
    print("creating menu scene")
    local sceneGroup = self.view

    local name = nil;
    local game = nil;
    local function nameListener( event )
        if ( event.phase == "ended" or event.phase == "submitted" ) then
            print( event.target.text )
            username = event.target.text
        end
    end

    local function gameListener( event )
        if ( event.phase == "ended" or event.phase == "submitted" ) then
            print( event.target.text )
            username = event.target.text
        end
    end

    local function play( event )
        print("name: " .. name)
        print("game: " .. game)
    end

    local name = native.newTextField( 10, 10, 25, 2 )
    name:addEventListener( "userInput", nameListener )

    local game = native.newTextField( 10, 13, 25, 2 )
    game:addEventListener( "userInput", gameListener )

    local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 15, native.systemFont, 1 )
    playButton:setFillColor( 0.82, 0.86, 1 )
    playButton:addEventListener( "tap", play )

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
