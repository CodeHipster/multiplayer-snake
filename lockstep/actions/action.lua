-- an action is an action a player performs

local Action = {}

function Action:new (action)
    self.__index = self

    return setmetatable({
        action = action,
    }, self)
end

return Action