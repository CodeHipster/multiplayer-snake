local inspect = require("inspect");

local NameField = {}

function NameField:new()
    local nameField = display.newGroup();
    nameField.name = "beep"

    local nameOptions = {
        text = "Name: ",
        x = 3, 
        y = 6, 
        width = 5, 
        height = 2
    }
    local nameText = display.newText( nameOptions )
    nameField:insert(nameText)
    local nameInput = native.newTextField( 14, 5.5, 19, 2 )
    nameField:insert(nameInput)
    nameInput.text = nameField.name;

    local function hide()
        -- have to manually hide. 
        -- https://docs.coronalabs.com/api/library/native/newTextField.html
        nameInput.isVisible = false
    end

    nameField.hide = hide

    local function nameListener( event )
        nameField.name = event.target.text
    end

    nameInput:addEventListener( "userInput", nameListener )

    return nameField
end

return NameField