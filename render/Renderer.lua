local Renderer = {}
local inspect = require("inspect");

function Renderer:new(grid, displayGroup)
    self.__index = self

    local gridGroup = display.newGroup()

    -- draw the grid, only need to do this once.
    for y = 0, grid.height do
        local line = display.newLine(gridGroup, 0, y, grid.width, y)
        line.strokeWidth = 0.1
    end

    for x = 0, grid.width do
        local line = display.newLine(gridGroup, x, 0, x, grid.height)
        line.strokeWidth = 0.1
    end

    return setmetatable({
        grid = gridGroup,
        parent = displayGroup,
        state = display.newGroup() -- containing the display items for the current state.
    }, self)
end

function Renderer:render(state)
    print("rendering state")
    -- empty previous state display
    self.state:removeSelf()
    self.state = display.newGroup();

    for iter = 1, #state.players do
        -- draw player snake
        drawSnake(state.players[iter].snake, self.state)
    end
end

function drawSnake(snake, group)
    local displayObject = display.newRect(group, snake.head.position.x - .5, snake.head.position.y - .5, 1, 1)
    displayObject.strokeWidth = 0
    displayObject:setFillColor(0, 1, 0)

end

return Renderer

-- local displayObject = display.newRect(x - .5, y - .5, 1, 1)
-- displayObject.strokeWidth = 0
-- displayObject:setFillColor(0, 1, 0)

-- instance.displayObject.strokeWidth = 0
-- instance.displayObject:setFillColor( 0,1,1 )
