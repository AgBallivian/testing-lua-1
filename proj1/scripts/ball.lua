-- ball.lua example

-- Define the Ball object as a table
local Ball = {}
Ball.__index = Ball -- Enables "class-like" behavior

-- Constructor: Creates a new ball instance
function Ball:new(x, y, radius, dx, dy)
    local instance = setmetatable({}, Ball) -- Create a new table with Ball as its prototype
    instance.x = x
    instance.y = y
    instance.radius = radius
    instance.dx = dx
    instance.dy = dy
    return instance
end

-- Update the ball's position
function Ball:update(dt)
    local ballGravity = 500 -- Acceleration due to gravity
    self.dy = self.dy + ballGravity * dt
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

--function to delete ball
function Ball:delete()
    self = nil
end

-- Draw the ball
function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

-- Check for collision with screen boundaries
function Ball:checkBounds(screenWidth, screenHeight)
    if self.x - self.radius < 0 or self.x + self.radius > screenWidth then
        self.dx = -self.dx -- Reverse horizontal direction
    end
    if self.y - self.radius < 0 then
        self.dy = -self.dy -- Reverse vertical direction
    end
end

-- Check collision with a rectangle (e.g., paddle)
function Ball:checkCollision(rect)
    -- closest points of rectangle
    local nearestX = math.max(rect.x, math.min(self.x, rect.x + rect.width))
    local nearestY = math.max(rect.y, math.min(self.y, rect.y + rect.height))
    local dx = self.x - nearestX
    local dy = self.y - nearestY
    return (dx * dx + dy * dy) < (self.radius * self.radius)
end

function Ball:giveImpulse(direction)
    --direction is a table with x and y components
    self.dx = self.dx + direction.x
    self.dy = self.dy + direction.y
end

return Ball
