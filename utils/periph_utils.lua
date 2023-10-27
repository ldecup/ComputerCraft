local dict = require("dictionnaries")

local function DetectPeriphByType(deviceType)
    if deviceType == "ENERGY_STORE" then
        for _, device in pairs(dict.ENERGY_STORE) do
            local side = DetectDevice(device)
            if side ~= nil then
                return side, device
            end
        end
    elseif deviceType == "ENERGY_PROD" then
        for _, device in pairs(dict.ENERGY_PROD) do
            local side = DetectDevice(device)
            if side ~= nil then
                return side, device
            end
        end
    else
        local side = DetectDevice(deviceType)
        if side ~= nil then
            return side, deviceType
        end
    end
    return nil, nil
end

function DetectDevice(deviceType)
    for _, side in pairs(peripheral.getNames()) do
        if peripheral.getType(side) == deviceType then
            return side
        end
    end
    return nil
end

return {DetectPeriphByType = DetectPeriphByType}