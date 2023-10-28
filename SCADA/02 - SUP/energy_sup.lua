local pu = require("periph_utils")
local mon = require("monitoring_utils")
local gui = require("graph_utils")

local config = {
    -- Local channel to supervise
    channelId = tofill,
    displayType = tofill,   -- Supported values: UNIQUE. todo: LINE, GRID, STACK
    deviceIdToMonitor = tofill,    --UID of the device to display on the monitor
    monitoredDevices = {},
    -- Only supports static monitor size (4*3)
}

---- Init phase ----
-- Peripheral detection
config.sideModem = (pu.DetectPeriphByType("modem"))
local modem = peripheral.wrap(config.sideModem)
config.sideMonitor = (pu.DetectPeriphByType("monitor"))
local monitor = peripheral.wrap(config.sideMonitor)

modem.open(config.channelId)
local monitoredDevices = {}

while true do
    -- Screen update is cadenced on message reception
    -- Might be worth looking into io.popen for multithreading at high device counts
    local event, _, channel, _, message, _ = os.pullEvent("modem_message")

    -- If we have seen that device before, update its data
    if mon.IsDeviceKnown(monitoredDevices, message) then
        for _, device in pairs(monitoredDevices) do
            if device[1] == message.uid then
                device[2] = message
            end
        end
    --Otherwise, add it as a monitored device
    else
        print("New device: "..message.uid)
        table.insert(monitoredDevices, {message.uid, message})
    end

    -- Screen update
    local monitoredData = mon.GetDeviceDataById(monitoredDevices, config.deviceIdToMonitor)
    if monitoredData ~= nil then
        if monitoredData.type == "STORE" then
            


        elseif monitoredData.type == "PROD" then





        end
    end


end