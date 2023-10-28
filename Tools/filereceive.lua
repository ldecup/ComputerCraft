-- Small util to receive a file over rednet
rednet.open(modemSidetofill)
local _,message = rednet.receive()
local file = fs.open(filenametofill, "w")
file.writeLine(message)
file.close()