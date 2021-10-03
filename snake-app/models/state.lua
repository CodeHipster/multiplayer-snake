local State = {}

function copy(obj, seen)
    if type(obj) ~= 'table' then
        return obj
    end
    if seen and seen[obj] then
        return seen[obj]
    end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do
        res[copy(k, s)] = copy(v, s)
    end
    return res
end

function State:new()
    self.__index = self

    return setmetatable({
        players = {}, --table with player models
        timestamp = 0
    }, self)
end

function State:addPlayer(player)
    table.insert(self.players, player)
end

function State:copy()
    return copy(self)
end

return State
