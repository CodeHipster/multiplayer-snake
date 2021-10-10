-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local composer = require("composer")
local players = require("multiplayer.players")
local game = require("multiplayer.game")
local socket = require("multiplayer.socket")
local json = require("json")
local inspect = require("inspect")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- convert the players object to just a table of names
local function playerNames(players)
    local names = {}
    for iter = 1, #players do
        table.insert(names, players[iter].name)
    end

    return names
end

local function processMessage(msg, ws)
    local playerlist, pos, msg = json.decode(msg)
    if msg then
        print("error decoding json.")
        return
    end

    if not playerlist.type then
        print("message has no type")
        return
    elseif playerlist.type ~= "playerlist" then
        print("message was not for waiting screen handler")
        return
    end

    print(inspect(playerlist))

    local addedPlayer = false
    for iter = 1, #playerlist.players do
        addedPlayer = addedPlayer or players.addMultiPlayer(playerlist.players[iter])
    end

    if addedPlayer then
        ws:send(json.encode({type = "playerlist", players = playerNames(players)}))
    end

    if(#players == 2) then
        print("starting the game!")
        composer.gotoScene("scenes.game");
    end
end

-- create()
function scene:create(event)

    -- Code here runs when the scene is first created but has not yet appeared on screen
    print("creating waiting room scene")
    local sceneGroup = self.view

    local ws = socket.connect(game.name)

    local function handler(event)
        if event.type == ws.ONOPEN then
            print('lobby connected')
            ws:send(json.encode({type = "playerlist", players = playerNames(players)}))
        elseif event.type == ws.ONMESSAGE then
            print('lobby received message')
            processMessage(event.data, ws)
        elseif event.type == ws.ONCLOSE then
            print('lobby disconnected')
        elseif event.type == ws.ONERROR then
            print('lobby error')
        end
    end


    ws:addEventListener(ws.WSEVENT, handler)




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
