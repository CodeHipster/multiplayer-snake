-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local composer = require("composer")
local GameEntry = require("scenes.lobby.game-entry")
local GamesList = require("scenes.lobby.games-list")
local Title = require("scenes.lobby.title")
local NameField = require("scenes.lobby.name-field")
local JoinButton = require("scenes.lobby.join-button")
local RefreshButton = require("scenes.lobby.refresh-button")
local players = require("multiplayer.players")
local game = require("multiplayer.game");
local inspect = require("inspect")

local scene = composer.newScene()


-- objects that need hiding, like native text input.
local hidables = {}
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)
--TODO: add all display objects to sceneContainer
--TODO: network calls
--TODO: classfile for the lobby manager
    local sceneGroup = self.view

    -- titles
    local title = Title:new()
    sceneGroup:insert(title)

    -- input field for name
    local nameField = NameField:new()
    table.insert(hidables, nameField)
    sceneGroup:insert(nameField)

    local gamesList

    -- lobby manager
    local lobbyManager = {
        play = {},
        refresh = {},
        selectedGame = nil,
        listeners = {}
    }
    function lobbyManager.play.tap()
        print("play button clicked")
        if(lobbyManager.selectedGame == nil) then
            gamesList:createNewGame(nameField.name)
        else
            players.addLocalPlayer(nameField.name)
            game.setName(lobbyManager.selectedGame)
            composer.gotoScene("scenes.waiting-room.screen")
        end
    end
    function lobbyManager.refresh.tap()
        gamesList:refresh()
    end
    function lobbyManager.selectGame(game)
        print("selecting game: " .. game)
        lobbyManager.selectedGame = game
        for iter = 1, #lobbyManager.listeners do
            lobbyManager.listeners[iter](game)
        end
    end
    function lobbyManager.addListener(listener)
        table.insert(lobbyManager.listeners, listener);
    end

    -- show list of games
    gamesList = GamesList:new(lobbyManager)
    sceneGroup:insert(gamesList)

    -- join button
    local join = JoinButton:new(lobbyManager)
    sceneGroup:insert(join)

    -- refresh button
    local refresh = RefreshButton:new(lobbyManager)
    sceneGroup:insert(refresh)

end

-- hide()
function scene:hide(event)
    for iter = 1, #hidables do
        hidables[iter]:hide()
    end
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
