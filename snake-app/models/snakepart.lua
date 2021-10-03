local SnakePart = {}

SnakePart.__index = SnakePart -- refering to SnakePart for fields that are not on the instance.

function SnakePart:new(x, y)

    local instance = {
        next = nil,
        position = {
            x = x,
            y = y
        },
    }
    setmetatable(instance, SnakePart) -- self refers to SnakePart

    return instance;
end


function SnakePart:setPosition(position)
    self.position = position
end

return SnakePart
