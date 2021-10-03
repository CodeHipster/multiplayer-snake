-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local composer = require("composer")
local players = require("multiplayer.players")
local game = require("multiplayer.game")
local WebSockets = require("plugin.websockets")
local json = require("json")

local scene = composer.newScene()

local ws = WebSockets.new()
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

    -- Code here runs when the scene is first created but has not yet appeared on screen
    print("creating waiting room scene")
    local sceneGroup = self.view

    local function WsHandler(event)
        if event.type == ws.ONOPEN then
            print("connected")
            ws:send(json.encode({player = players.localPlayer, event = "joined"}))
        elseif event.type == ws.ONMESSAGE then
            print('received message: ' .. event.data)
            
        elseif event.type == ws.ONCLOSE then
            print('disconnected')
        elseif event.type == ws.ONERROR then
            print('error')
        end
    end

    ws:addEventListener(ws.WSEVENT, WsHandler)

    ws:connect('ws://127.0.0.1/games/'.. game.name, {
        port = 8080
    })

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
