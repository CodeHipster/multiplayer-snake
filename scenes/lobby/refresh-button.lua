local RefreshButton = {}

function RefreshButton:new(lobbyManager)
    local width = 5
    local height = 3

    local background = display.newRect(20, 21, width, height);
    background:setFillColor(0.2);
    background:translate(width / 2, height / 2)

    local buttonOptions = {
        text = "Refresh",
        x = 20, 
        y = 22, 
        width = width, 
        height = height,
        align = "center"
    }
    local button = display.newText(buttonOptions)
    button:translate(width / 2, height / 2)
    background:addEventListener( "tap", lobbyManager.refresh )

    return button
end

return RefreshButton