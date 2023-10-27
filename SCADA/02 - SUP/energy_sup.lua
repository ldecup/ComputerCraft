local pu = require("periph_utils")
local mon = require("monitoring_utils")
local gui = require("graph_utils")

local config = {
    -- Local channel to supervise
    channelId = tofill,
    displayType = tofill,   -- Supported values: STACK. todo: LINE, GRID
    monitoredDevices = {},
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
        table[message.uid] = message
    --Otherwise, add it as a monitored device
    else
        table.insert(monitoredDevices, {tostring(message.uid), message})
    end
end