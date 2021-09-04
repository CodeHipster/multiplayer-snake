-- the change direction action. 

local directions = require("models.directions");
local actionStatus = require("models.actions.action-status");

local ChangeDirection = {}

-- status can be 'intent' or 'final'
function ChangeDirection:new (direction, status)
    self.__index = self

    return setmetatable({
        direction = direction,
        status = status
    }, self)
end

return ChangeDirection