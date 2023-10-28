local function IsDeviceKnown(monitoredDevices,telegram)
    for _, device in pairs(monitoredDevices) do
        if telegram.uid == device[1] then
            return true
        end
    end
    return false
end

local function GetDeviceDataById(monitoredDevices,deviceId)
    for _, device in pairs(monitoredDevices) do
        if device[1] == deviceId then
            return device[2]
        end
    end
    return nil
end

return {IsDeviceKnown = IsDeviceKnown, GetDeviceDataById = GetDeviceDataById}