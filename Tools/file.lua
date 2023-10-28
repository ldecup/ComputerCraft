-- Sends or receives files over rednet
local fileInfo = {
    version = 1,
}

local pu = require("periph_utils")

if arg[1] == nil then
    print("file help for help")
elseif arg[1] == "help" then
    print("file get <filename>")
    print("file send <filename> <computerID>")
    print("file getid")
elseif arg[1] == "getid" then
    print("Computer ID: "..os.getComputerID())
else
    -- Peripheral detection
    config.sideModem = (pu.DetectPeriphByType("modem"))
    rednet.open(config.sideModem)
    local filename = arg[2]
    if arg[1] == "get" then
        -- Retrieves a file over rednet
        print("Ready to receive...")
        local _,message = rednet.receive()
        local file = fs.open(filename, "w")
        file.writeLine(message)
        file.close()
        rednet.close()
        print("File received and saved")
    elseif arg[1] == "send" then
        -- Sends a file over rednet
        local targetId = arg[3]
        local file = fs.open(filename, "r")
        local contents = file.readAll()
        file.close()
        print("Sending "..filename.." to "..targetId)
        rednet.send(targetId, contents)
        rednet.close()
        print("file sent")
    end
end