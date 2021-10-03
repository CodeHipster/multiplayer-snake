local Widget = require("widget")
local json = require("json")
local inspect = require("inspect");

GamesList = {}

function GamesList:new(lobbyManager)
    local gamesListOptions = {
        id = "games-list",
        left = 1,
        top = 8,
        width = 23,
        height = 12,
        horizontalScrollDisabled = true,
        backgroundColor = {0.5, 0.5, 0.5}
    }

    -- extend object with functionality from the widget
    local gamesList = Widget.newScrollView(gamesListOptions)
    gamesList.count = 0

    -- insert a game by name
    function gamesList:addGame(name)
        local position = self.count + 1
        local entry = GameEntry:new(name, {(position % 2) / 10 + 0.2}, position, lobbyManager.selectGame)
        gamesList:insert(entry)
        self.count = self.count + 1
    end

    function gamesList.handleResponse(event)
        if (event.isError) then
            print("Network error: ", event.response)
        else
            -- empty: gamesList
            for iter = gamesList.numChildren, 1, -1 do
                gamesList:remove(iter)
            end
            gamesList.count = 0

            local games, pos, msg = json.decode(event.response)
            for iter = 1, #games do
                gamesList:addGame(games[iter].name)
            end
            -- removing objects does not automatically change the scroll height...
            gamesList:setScrollHeight(gamesList.count * 4)
        end
    end

    function gamesList:refresh()
        print("refreshing games")

        network.request("http://localhost:8080/games", "GET", gamesList.handleResponse)
    end

    function gamesList:createNewGame(name)
        local params = {
            headers = {
                ["Content-Type"] = "application/json"
            },
            body = json.encode({
                name = name
            })
        }

        local function wrapHandler(event)
            gamesList.handleResponse(event)
            if (not event.isError) then
                lobbyManager.selectGame(name)
            end
        end

        network.request("http://localhost:8080/games", "POST", wrapHandler, params)
    end

    -- do an initial refresh
    gamesList:refresh()

    return gamesList
end

return GamesList
