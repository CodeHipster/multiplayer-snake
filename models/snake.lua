local direction = require("models.direction")
local SnakeHead = require("models.snakehead")

local Snake = {}
Snake.__index = Snake

function Snake:new(x, y)

    local instance = {
        -- Linked list for all the snake parts
        head = SnakeHead:new(x, y),
        direction = direction.LEFT,
        displayGroup = display.newGroup()
    }

    setmetatable(instance, Snake)
    return instance
end

function Snake:setDirection(direction)
    self.direction = direction
end

return Snake
