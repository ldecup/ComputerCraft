local function FileSend(device,channelId,payload)
    -- Will broadcast a packet on a specific channel (not the reserved BROADCAST channel 65535)
    device.transmit(channelId,channelId,payload)
end


return {BroadcastPacket = BroadcastPacket}