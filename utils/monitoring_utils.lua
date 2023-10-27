local function IsDeviceKnown(monitoredDevices,telegram)
    for _, device in pairs(monitoredDevices) do
        if telegram.uid == device[1] then
            return true
        end
    end
    return false
end

return {IsDeviceKnown = IsDeviceKnown}