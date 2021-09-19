-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local composer = require("composer")
local GameEntry = require("scenes.lobby.game-entry")
local GamesList = require("scenes.lobby.games-list")
local Title = require("scenes.lobby.title")
local NameField = require("scenes.lobby.name-field");
local JoinButton = require("scenes.lobby.join-button")
local RefreshButton = require("scenes.lobby.refresh-button")
local players = require("multiplayer.players")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)
--TODO: add all display objects to sceneContainer
--TODO: network calls
--TODO: classfile for the lobby manager
    -- titles
    Title:new()

    -- input field for name
    local nameField = NameField:new()

    -- lobby manager
    local lobbyManager = {
        play = {},
        refresh = {},
        selectedGame = nil,
        listeners = {}
    }
    function lobbyManager.play.tap()
        print("play button clicked")
        players.addLocalPlayer(nameField.name)
        composer.gotoScene("scenes.game")
    end
    function lobbyManager.refresh.tap()
        print("refresh button clicked")
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
    GamesList:new(lobbyManager)

    -- join button
    JoinButton:new(lobbyManager)

    -- refresh button
    RefreshButton:new(lobbyManager)

end

-- hide()
function scene:hide(event)

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
