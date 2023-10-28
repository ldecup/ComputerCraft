-- Sends a file over rednet
local modem = peripheral.find("modem") or error("No modem attached", 0)
rednet.open(modem)
write("File to send: ")
local filename = read()
write("Target rednet ID: ")
local targetId = read()
local file = fs.open(filename, "r")
local contents = file.readAll()
file.close()
rednet.send(targetId, contents)
print("file sent")