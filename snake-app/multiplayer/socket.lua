local WebSockets = require("plugin.websockets")
local inspect = require('inspect')

local ws = WebSockets.new()

local socket = {}

function socket.connect(game)
    -- TODO: can we have multiple connections from a single client?
    -- TODO: how can we check if it is already connected to and endpoint or not?
    ws:connect('ws://127.0.0.1/games/' .. game, {
        port = 8080
    })
    return ws
end

function socket.get()
    return ws
end

return socket

