_G.love = require("love")
local Ball = require("scripts.ball")
local Paddle = require("scripts.paddle")
local Utils = require("scripts.utils")

-- Declare global game variables
local ball
local paddle
local gameUtils

function love.load()
    -- Initialize the game objects
    -- x, y, radius, dx, dy
    ball = Ball:new(math.random(100,600), 100, 10, math.random(-200,200), 0) 
    -- x, y, width, height, speed
    paddle = Paddle:new(370, 550, 60, 10, 500) 
    -- Create the game utility manager
    gameUtils = Utils:new() 
end

function love.update(dt)
    -- Update the game timer
    gameUtils:updateTime(dt)

    -- Handle paddle movement based on player input
    if love.keyboard.isDown("left") then
        paddle:move("left", dt)
    elseif love.keyboard.isDown("right") then
        paddle:move("right", dt)
    else
        paddle:move("stop", dt)
    end
    

    -- Clamp the paddle within the screen boundaries
    paddle:clamp(800) -- Assuming screen width is 800

    -- Update the ball's position and check for boundary collisions
    ball:update(dt)
    ball:checkBounds(800, 600) -- Screen width, height


    -- LA ROTACION ESTA TODA PITIADA XDXDXD ARREGLAR ESO
    -- Check for ball collision with the paddle
    if ball:checkCollision(paddle) then
        -- Calculate the impulse based on paddle's rotation
        local impulseMagnitude = math.abs(ball.dy) + 500 -- Base upward impulse
        local impulseX = math.sin(paddle.rotation) * impulseMagnitude -- Horizontal component
        local impulseY = -math.cos(paddle.rotation) * impulseMagnitude -- Vertical component
    
        -- ball:giveImpulse({x = impulseX, y = impulseY})
        gameUtils:incrementScore(1) -- Increase the score
    
        ball:giveImpulse({x = impulseX, y = -(ball.dy + 500)})
    end

    -- Handle game over if the ball falls below the screen
    if ball.y - ball.radius > 600 then
        -- gameUtils:setGameOver()
        ball:delete()
        ball = Ball:new(math.random(100,600), 100, 10, math.random(-200,200), 0)
    end
end

function love.draw()
    -- Draw the ball and paddle
    ball:draw()
    paddle:draw()

    -- Display the score and game time
    love.graphics.print("Score: " .. gameUtils.score, 10, 10)
    love.graphics.print("Time: " .. gameUtils:getFormattedTime(), 10, 30)

    -- Display a "Game Over" message if the game is over
    if gameUtils.isGameOver then
        love.graphics.printf("Game Over! Press R to Restart", 0, 300, 800, "center")
    end

    --doing some debug on screen of ball position and velocity
    love.graphics.print("Ball x: " .. ball.x, 10, 50)
    love.graphics.print("Ball y: " .. ball.y, 10, 70)
    love.graphics.print("Ball dx: " .. ball.dx, 10, 90)
    love.graphics.print("Ball dy: " .. ball.dy, 10, 110)
    
end

function love.keypressed(key)
    -- Restart the game when the player presses "R"
    -- if key == "r" and gameUtils.isGameOver then
    --     love.load()
    -- end
    if key == "r" then
        love.load()
    end
end

