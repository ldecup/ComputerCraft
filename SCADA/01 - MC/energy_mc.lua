local pu = require("periph_utils")
local dict = require("dictionnaries")

local config = {
    type = tofill,    -- PROD or STORE
    unit = tofill,    -- Mekanism storage is in J, BR is in RF
    updateFreqInSec = 1,
    -- Local channel for broadcast to the superviser
    channelId = tofill,
}

---- Init phase ----
-- Peripheral detection
config.sideModem = (pu.DetectPeriphByType("modem"))
local modem = peripheral.wrap(config.sideModem)
config.sideDevice, deviceType = (pu.DetectPeriphByType("ENERGY_"..config.type))
local device = peripheral.wrap(config.sideDevice)

-- Data init
local data = dict.ENERGY_DATA
data.uid = os.getComputerID()
data.type = config.type
data.unit = config.unit
data.loc = {gps.locate()}

-- BR devices contain multiple devices with their own methods
if config.type == "PROD" then
    data.capacity = device.battery().capacity()
    data.fuelTankCap = device.fuelTank().capacity()
    if device.coolantTank() ~= nil then
        -- Not all reactors have coolant tanks
        data.coolTankCap = device.coolantTank().capacity()
    end
else
    data.capacity = device.getMaxEnergy()
end

---- MAIN ----
while true do
    ---- Update local data ----
    -- BR devices contain multiple devices with their own methods
    if config.type == "PROD" then
        data.currentEnergy = device.battery.stored()
        data.fuelTankStored = device.fuelTank().fuel()
        data.fuelTankFillPer = data.fuelTankStored/data.fuelTankCap*100
        if device.coolantTank() ~= nil then
            -- Not all reactors have coolant tanks
            data.coolTankStored = device.coolantTank().coolant() -- Guessed coolant(), not tested
            data.coolTankFillPer = data.coolTankStored/data.coolTankCap*100
        end
        data.active = device.active()
        -- TODO control rod management
        -- data.controlRods...
    else
        data.currentEnergy = device.getEnergy()
    end
    data.currentEnergyPercent = data.currentEnergy/data.capacity*100

    ---- Broadcast data on network ----
    modem.transmit(config.channelId,config.channelId,data)
    sleep(config.updateFreqInSec)
end