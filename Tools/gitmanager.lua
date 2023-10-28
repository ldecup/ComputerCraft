local config = {
    keyWord = "GIT",

}

---- Init phase ----
-- Peripheral detection
config.sideModem = (pu.DetectPeriphByType("modem"))
config.sideChat = (pu.DetectPeriphByType("chatbox"))
local chatbox = peripheral.wrap(config.sideChat)

while true do
    local chat, author, message = os.pullEvent("chat")
    
    


    
end