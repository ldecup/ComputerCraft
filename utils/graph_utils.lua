local function WriteText(x,y,text,textColor,device)
    device.setTextColor(textColor)
    device.setCursorPos(x,y)
    device.write(text)
end

local function DrawLine(x,y,width,height,lineColor,device)
    for yPos = y, y+height-1 do
        device.setBackgroundColor(lineColor)
        device.setCursorPos(x,yPos)
        device.write(string.rep(" ",width))
    end
end

return {WriteText = WriteText, DrawLine = DrawLine}