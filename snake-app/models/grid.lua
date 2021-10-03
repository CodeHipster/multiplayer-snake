local Grid = {}
Grid.__index = Grid

function Grid:new(width, height)

    local instance = {
        width = width,
        height = height,
    }

    setmetatable(instance, Grid)
    return instance
end

return Grid 