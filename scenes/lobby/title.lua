Title = {}

function Title:new()

    local titleOptions = {
        text = "Snakes!",
        x = 12.5,
        y = 2,
        width = 13,
        height = 3,
        fontSize = 3,
        align = "center"
    }
    display.newText(titleOptions)
end

return Title
