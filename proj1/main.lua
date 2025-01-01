_G.love = require("love")

function love.load()
    print("Hello, World!")
end

function love.update(dt)
end

function love.draw()
    love.graphics.print("Hello, World!", 400, 300)
end
