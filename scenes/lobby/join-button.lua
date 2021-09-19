local JoinButton = {}

function JoinButton:new(lobbyManager)
    local width = 10
    local height = 3

    local background = display.newRect(0, 21, width, height);
    background:setFillColor(0.2);
    background:translate(width / 2, height / 2)

    local buttonOptions = {
        text = "Create new game",
        x = 0, 
        y = 22, 
        width = width, 
        height = height,
        align = "center"
    }
    local button = display.newText(buttonOptions)
    button:translate(width / 2, height / 2)
    background:addEventListener( "tap", lobbyManager.play )

    -- register as listener to the lobbyManager
    function setButtonText(gameName)
        button.text = "Join: " .. gameName
    end
    lobbyManager.addListener(setButtonText)

    return button
end

return JoinButton