local Snake = {}

function Snake:new (x, y)
    self.__index = self

    return setmetatable({
        x = x,
        y = y
    }, self)
end

return Snake