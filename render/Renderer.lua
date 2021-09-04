local Renderer = {}

function Renderer:new (grid)
    self.__index = self

    return setmetatable({
        grid = grid
    }, self)
end

function Renderer:render(state)
    print("rendering state")
end


return Renderer