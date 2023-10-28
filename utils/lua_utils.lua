-- Splits a string based on a delimiter
local function StringSplit(inString, delim)
    local outTable = {}
    for str in string.gmatch(inString, "([^"..delim.."]+)") do
        table.insert(outTable, str)
    end
    return outTable
end

return {StringSplit = StringSplit}