local SnakePart = require("models.snakepart")

local SnakeHead = {}

function SnakeHead:new(x, y)
    -- just override the displayObject.
    local instance = SnakePart:new(x, y)
    instance.displayObject = display.newRect(x + .5, y + .5, 1, 1)
    instance.displayObject.strokeWidth = 0
    instance.displayObject:setFillColor( 0,1,1 )
end

return SnakeHead

-- So method lookup will go as follows: instance looks at self then at SnakeHead_mt, which looks