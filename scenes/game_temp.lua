
-- setup websocket connection
local WebSockets = require("plugin.websockets")

local ws = WebSockets.new()

-- draw a grid
local width = display.contentWidth
local height = display.contentHeight

for y=0, height do 
    local line = display.newLine(0,y,width,y)
    line.strokeWidth = 0.1
end

for x=0, width do
    local line = display.newLine(x,0,x,height)
    line.strokeWidth = 0.1
end

local snakeDG= display.newGroup()
local head = {next = nil, pos={x=10, y=10}}

local function emptyGroup(group)
    for i = group.numChildren, 1, -1 do
        group:remove(i)
    end
end

local function drawSnake()
    emptyGroup(snakeDG)
    local currentPart = head
    repeat
        local snakePart = display.newRect(currentPart.pos.x + .5, currentPart.pos.y + .5, 1, 1)
        snakePart.strokeWidth = 0
        snakePart:setFillColor( 0,1,0 )
        snakeDG:insert(snakePart)
        currentPart = currentPart.next
    until currentPart == nil
end
drawSnake()

-- draw random apple
local apple = {x = 0, y = 0}
local appleDisplay = nil
local function randomizeApple()
    if(appleDisplay ~= nil) then
        appleDisplay:removeSelf()
    end
    apple = {x = math.random(0, width-1), y = math.random(0, height -1) }
    appleDisplay = display.newRect(apple.x + .5, apple.y + .5, 1, 1)
    appleDisplay.strokeWidth = 0
    appleDisplay:setFillColor( 1,0,0 )
end
randomizeApple()

local direction = {x=0, y=0}

local function onKeyEvent( event )
 
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print( message )

    if event.phase == "down" then
        
ws:send("snakes in the house")
        if event.keyName == 'w' then direction = {x=0,y=-1}
        elseif event.keyName == 's' then direction = {x=0,y=1}
        elseif event.keyName == 'a' then direction = {x=-1,y=0}
        elseif event.keyName == 'd' then direction = {x=1,y=0}
        end 
    end
 
    print([[direction x ]] .. direction.x .. [[ direction y ]] .. direction.y)

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end
 
-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )

local function moveSnake()
    local newX = head.pos.x + direction.x
    local newY = head.pos.y + direction.y

    if(newX == apple.x and newY == apple.y) then
        --add head piece without moving
        local newHead = {next = head, pos={x=newX, y=newY}}
        head = newHead
        --spawn new apple
        randomizeApple()
    else
        --move the positions on the parts
        local part = head
        local newPos = {x = newX, y = newY}
        repeat
            local old = part.pos
            part.pos = newPos
            -- set values for next part
            part = part.next
            newPos = old   
        until part == nil
    end
end

local function gameLoop()
    moveSnake()
    drawSnake()
end 

gameLoopTimer = timer.performWithDelay( 100, gameLoop, 0 )


local function WsHandler(event)
    if event.type == ws.ONOPEN then
        print('connected')
    elseif event.type == ws.ONMESSAGE then
        print('message')
    elseif event.type == ws.ONCLOSE then
        print('disconnected')
    elseif event.type == ws.ONERROR then
        print('error')
    end
end
  
ws:addEventListener(ws.WSEVENT, WsHandler)

ws:connect('ws://127.0.0.1/chat/testing', {port=8080})


-- create()
function scene:create( event )
    
    -- Code here runs when the scene is first created but has not yet appeared on screen
    print("initializing game.")


end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------