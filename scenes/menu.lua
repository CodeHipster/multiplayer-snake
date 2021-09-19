-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local composer = require( "composer" )
local players = require("multiplayer.players");
 
local scene = composer.newScene()

local nameField = nil
local gameField = nil
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
  
-- create()
function scene:create( event )
    
    -- Code here runs when the scene is first created but has not yet appeared on screen
    print("creating menu scene")
    local sceneGroup = self.view

    gameField = native.newTextField( 10, 13, 25, 2 )
    nameField = native.newTextField( 10, 10, 25, 2 )

    local name = "player";
    local game = "game1";
    local function nameListener( event )
        -- TODO: make robust, fill the value while typing.
        if ( event.phase == "ended" or event.phase == "submitted" ) then
            print( event.target.text )
            name = event.target.text
        end
    end

    local function gameListener( event )
        -- TODO: make robust, fill the value while typing.
        if ( event.phase == "ended" or event.phase == "submitted" ) then
            print( event.target.text )
            game = event.target.text
        end
    end

    local function play( event )
        print("name: " .. name)
        print("game: " .. game)
        players.addLocalPlayer(name)
        composer.gotoScene( "scenes.game" )
    end 

    nameField.text = name;
    nameField:addEventListener( "userInput", nameListener )

    gameField.text = game;
    gameField:addEventListener( "userInput", gameListener )

    local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 15, native.systemFont, 1 )
    playButton:setFillColor( 0.82, 0.86, 1 )
    playButton:addEventListener( "tap", play )

end


-- hide()
function scene:hide( event )
    nameField.isVisible = false
    gameField.isVisible = false
    
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
