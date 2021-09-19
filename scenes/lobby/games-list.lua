local widget = require( "widget" )

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

    local gamesList = {
        count = 0
    }

    -- extend object with functionality from the widget
    local widget = widget.newScrollView(gamesListOptions)
    setmetatable(gamesList, {
        __index = widget
    })

    -- insert a game by name
    function gamesList:insert(name)
        local position = self.count + 1
        local entry = GameEntry:new(name, {(position % 2) / 10 + 0.2}, position, lobbyManager.selectGame)
        widget:insert(entry)
        self.count = self.count + 1
    end

    function gamesList:refresh()
        -- get the new list.
        --TODO: get list from server
        local games = {}
        table.insert(games, "game1")
        table.insert(games, "game2")
        table.insert(games, "game3")
        table.insert(games, "game4")
        table.insert(games, "game5")
        table.insert(games, "game6")
        table.insert(games, "game7")
        table.insert(games, "game8")

        for iter = 1, #games do
            gamesList:insert(games[iter])
        end
    end

    -- do an initial refresh
    gamesList:refresh()

    return gamesList
end

return GamesList