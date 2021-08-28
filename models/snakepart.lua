local SnakePart = {}

SnakePart.__index = SnakePart -- refering to SnakePart for fields that are not on the instance.

function SnakePart:new(x, y)
    local displayObject = display.newRect(x + .5, y + .5, 1, 1)
    displayObject.strokeWidth = 0
    displayObject:setFillColor(0, 1, 0)

    local instance = {
        next = nil,
        position = {
            x = x,
            y = y
        },
        displayObject = displayObject
    }
    setmetatable(instance, SnakePart) -- self refers to SnakePart

    return instance;
end

return SnakePart
