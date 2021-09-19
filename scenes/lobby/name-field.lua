local inspect = require("inspect");

local NameField = {}

function NameField:new()
    local nameField = {
        name = "beep"
    }
    local nameOptions = {
        text = "Name: ",
        x = 3, 
        y = 6, 
        width = 5, 
        height = 2
    }
    display.newText( nameOptions )
    local nameInput = native.newTextField( 14, 5.5, 19, 2 )
    nameInput.text = nameField.name;

    local function nameListener( event )
        nameField.name = event.target.text
    end

    nameInput:addEventListener( "userInput", nameListener )

    return nameField
end

return NameField