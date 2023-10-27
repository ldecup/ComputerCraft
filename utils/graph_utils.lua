local function WriteText(device,x,y,text,textColor)
    device.setTextColor(textColor)
    device.setCursorPos(x,y)
    device.write(text)
end

local function DrawLine(device,x,y,width,height,lineColor)
    for yPos = y, y+height-1 do
        device.setBackgroundColor(lineColor)
        device.setCursorPos(x,yPos)
        device.write(string.rep(" ",width))
    end
end

return {WriteText = WriteText, DrawLine = DrawLine}