local Grid = {}
Grid.__index = Grid

function Grid:new(width, height)

    local instance = {
        displayGroup = display.newGroup(),
    }

    local group = instance.displayGroup

    for y = 0, height do
        local line = display.newLine(group, 0, y, width, y)
        line.strokeWidth = 0.1
    end

    for x = 0, width do
        local line = display.newLine(group, x, 0, x, height)
        line.strokeWidth = 0.1
    end

    setmetatable(instance, Grid)
    return instance
end

return Grid 