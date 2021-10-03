local JoinButton = {}

function JoinButton:new(lobbyManager)

    local group = display.newGroup();
    local width = 10
    local height = 3

    local background = display.newRect(0, 21, width, height);
    group:insert(background)
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
    group:insert(button)
    button:translate(width / 2, height / 2)
    background:addEventListener( "tap", lobbyManager.play )

    -- register as listener to the lobbyManager
    local function setButtonText(gameName)
        button.text = "Join: " .. gameName
    end
    lobbyManager.addListener(setButtonText)

    return group
end

return JoinButton