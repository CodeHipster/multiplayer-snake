local Snake = require("models.snake");

local Player = {}

function Player:new(x, y, name)
    self.__index = self

    return setmetatable({
        name = name,
        snake = Snake:new(x, y),
    }, self)
end

return Player
