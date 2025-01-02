-- utils.lua

-- Define the Utils module as a table
local Utils = {}
Utils.__index = Utils

-- Constructor: Creates a new game utility manager
function Utils:new()
    local instance = setmetatable({}, Utils)
    instance.score = 0       -- Player's score
    instance.gameTime = 0    -- Game time in seconds
    instance.isGameOver = false -- Track game over state
    return instance
end

-- Increment the score
function Utils:incrementScore(points)
    self.score = self.score + (points or 1) -- Increment by 1 if points not specified
end

-- Update the game timer
function Utils:updateTime(dt)
    self.gameTime = self.gameTime + dt
end

-- Mark the game as over
function Utils:setGameOver()
    self.isGameOver = true
end

-- Reset the game state
function Utils:reset()
    self.score = 0
    self.gameTime = 0
    self.isGameOver = false
end

-- Get the formatted game time
function Utils:getFormattedTime()
    local minutes = math.floor(self.gameTime / 60)
    local seconds = math.floor(self.gameTime % 60)
    return string.format("%02d:%02d", minutes, seconds)
end

return Utils
