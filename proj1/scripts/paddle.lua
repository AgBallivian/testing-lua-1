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
    instance.rotation = 0
    return instance
end

-- Move the paddle based on input
function Paddle:move(direction, dt)
    --rotate the paddle a bit in the direcction its going
    local rotationMagnitude = 0.1
    if direction == "left" then
        self.x = self.x - self.speed * dt
        --rotate the paddle a bit to the left
        self.rotation = self.rotation - rotationMagnitude
    elseif direction == "right" then
        self.x = self.x + self.speed * dt
        --rotate the paddle a bit to the right
        self.rotation = self.rotation + rotationMagnitude
    elseif direction == "stop" then
        self.rotation = 0
    end

    -- max rotation
    if self.rotation > 0 and self.rotation > 0.5 then
        self.rotation = 0.5
    elseif self.rotation < 0 and self.rotation < -0.5 then
        self.rotation = -0.5
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
    love.graphics.push() -- Save the current transformation
    love.graphics.translate(self.x + self.width / 2, self.y + self.height / 2) -- Move origin
    love.graphics.rotate(self.rotation) -- Rotate the paddle
    love.graphics.rectangle("fill", -self.width / 2, -self.height / 2, self.width, self.height)
    love.graphics.pop() -- Restore the previous transformation
end

return Paddle
