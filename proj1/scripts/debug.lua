-- debug stuff

local Debug = {}
Debug.__index = Debug

function Debug:new()
    local instance = setmetatable({}, Debug)
    return instance
end
