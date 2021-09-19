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

ws:connect('ws://127.0.0.1/snake', {port=8080})


ws:send()