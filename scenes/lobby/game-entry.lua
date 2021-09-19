local inspect = require("inspect");

GameEntry = {}

local width = 23
local height = 4

-- color as {r, g, b} where r/g/b are within 0-256
-- position starts at 1
function GameEntry:new(name, color, position, listener)

    local entry = display.newGroup(width, height)
    entry:translate(width / 2, (height / 2) + ((position - 1)*height)) -- center
    local background = display.newRect(0, 0, width, height);
    background:setFillColor(unpack(color))
    local text = display.newText({
        text = name
    })
    entry:insert(background)
    entry:insert(text)

    function beep(event)
        listener(name)
    end

    entry:addEventListener("tap", beep )
    return entry
end

return GameEntry
