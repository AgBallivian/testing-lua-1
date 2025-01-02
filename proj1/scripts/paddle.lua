-- paddle.lua example

-- Define the Paddle object as a table
local Paddle = {}
Paddle.__index = Paddle -- Enables "class-like" behavior

-- Constructor: Creates a new paddle instance
function Paddle:new(x, y, width, height, speed)
    local instance = setmetatable({}, Paddle) -- Create a new table with Paddle as its prototype
    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.speed = speed
    return instance
end

-- Move the paddle based on input
function Paddle:move(direction, dt)
    if direction == "left" then
        self.x = self.x - self.speed * dt
    elseif direction == "right" then
        self.x = self.x + self.speed * dt
    end
end

-- Clamp the paddle within the screen boundaries
function Paddle:clamp(screenWidth)
    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > screenWidth then
        self.x = screenWidth - self.width
    end
end

-- Draw the paddle
function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Paddle
