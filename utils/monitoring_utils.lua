local function IsDeviceKnown(monitoredDevices,telegram)
    for _, device in monitoredDevices do
        if data.uid == device.uid then
            return true
        end
    end
    return false
end

return {IsDeviceKnown = IsDeviceKnown}