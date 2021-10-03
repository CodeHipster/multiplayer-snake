local directions = require("models.directions")
local SnakeHead = require("models.snakehead")

local Snake = {}
Snake.__index = Snake

function Snake:new(x, y)

    local instance = {
        -- Linked list for all the snake parts
        head = SnakeHead:new(x, y),
        direction = directions.LEFT,
    }

    setmetatable(instance, Snake)
    return instance
end

function Snake:setDirection(direction)
    self.direction = direction
end

function Snake:move()
    -- move the head into the direction required.
    -- store the new position in a temp variable
    -- loop through the list, 
    -- save the position in another temp variable
    -- update the position with the 1 temp variable 
    -- replace the 1 temp variable with the second temp variable

    -- TODO: make a class for Position with an metamethod __add
    local newPosition = {
        x = self.head.position.x + self.direction.x,
        y = self.head.position.y + self.direction.y
    }
    local tempPosition = nil

    local part = self.head
    repeat
        tempPosition = part.pos
        part:setPosition(newPosition)
        -- set values for next part
        part = part.next
        newPosition = tempPosition
    until part == nil
    
end

return Snake
