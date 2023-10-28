-- To be run on a standalone computer that can act as a fileserver for the dimension
-- Requires a modem and a chatbox

local fileInfo = {
    version = 1,
}

local config = {
    masterKeyWord = "CMD",  -- Server-wide keyword used to invoke commands
    keyWord = "GIT",    -- Keyword specific to this system
}

local luau = require("lua_utils")
local pu = require("periph_utils")

---- Init phase ----
-- Peripheral detection
config.sideModem = (pu.DetectPeriphByType("modem"))
config.sideChat = (pu.DetectPeriphByType("chatbox"))
local chatbox = peripheral.wrap(config.sideChat)

while true do
    local chat, author, message = os.pullEvent("chat")
    local messageTable = luau.StringSplit(message, " ")
    if (messageTable[1] == config.masterKeyWord and messageTable[2] == config.keyWord) then
        if messageTable[3] == nil then
            chatbox.sendMessage(config.keyWord.." server version "..fileInfo.version.." is UP")
            sleep(1)
            chatbox.sendMessage(config.keyWord.." HELP for help")
        elseif messageTable[3] == "HELP" then
            chatbox.sendMessage(config.keyWord.." GET <filename>")
            sleep(1)
            chatbox.sendMessage(config.keyWord.." SEND <filename> <computerID>")
            sleep(1)
            chatbox.sendMessage(config.keyWord.." GETID")
        elseif messageTable[3] == "GETID" then
            chatbox.sendMessage(config.keyWord.." server ID: "..os.getComputerID())
        else
            local filename = messageTable[4]
            if messageTable[3] == "GET" then
                shell.run("file get "..filename)
                chatbox.sendMessage(config.keyWord.." "..filename.." received")
            elseif messageTable[3] == "SEND" then
                shell.run("file send "..filename.." "..messageTable[5])
                chatbox.sendMessage(config.keyWord.." "..filename.." sent to "..messageTable[5])
            end
        end
    end
end