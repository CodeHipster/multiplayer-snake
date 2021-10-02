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

    function gamesList:refresh()
        print("refreshing games")

        local function gamesListener(event)

            if (event.isError) then
                print("Network error: ", event.response)
            else
                print("RESPONSE: " .. event.response)
                local games, pos, msg = json.decode(event.response)
                print(inspect(games))
                for iter = 1, #games do
                    gamesList:addGame(games[iter].name)
                end
            end
        end

        network.request("http://localhost:8080/games", "GET", gamesListener)

    end

    function gamesList:createNewGame(name)

        -- TODO: deduplicate & clear gameslist before adding new again.
        local function createListener(event)

            if (event.isError) then
                print("Network error: ", event.response)
            else
                print("RESPONSE: " .. event.response)
                local games, pos, msg = json.decode(event.response)
                print(inspect(games))
                for iter = 1, #games do
                    gamesList:addGame(games[iter].name)
                end
            end
        end
        local headers = {}

        headers["Content-Type"] = "application/json"

        local body = json.encode({
            name = name
        });

        local params = {}
        params.headers = headers
        params.body = body

        network.request("http://localhost:8080/games", "POST", createListener, params)
    end

    -- do an initial refresh
    gamesList:refresh()

    return gamesList
end

return GamesList
