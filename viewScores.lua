require 'scores'

add = {name = "Player", score = 1000}

addScore(add.name, add.score)


local scores = getScores()

font = love.graphics.newFont("fonts/CompassPro.ttf", 20)

local w,h = love.graphics.getDimensions()

function viewDraw()
    love.graphics.setFont(font)
    love.graphics.setColor(1,1,1,0.5)
    love.graphics.rectangle("fill", 0, 80, 300, 260)
    love.graphics.setColor(0.3,0.1,0.1)
    love.graphics.print("Name", 50 , 100)
    love.graphics.print("Score", 200, 100)
    love.graphics.setColor(0.1,0.1,0.1)
    for i, v in ipairs(scores) do
        love.graphics.print(v[1], 50, 100 + i * 20)
        love.graphics.print(v[2], 200, 100 + i * 20)
    end
    love.graphics.setColor(1,1,1)
end

function viewDrawCenter()
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("fill", 0, 0, w, h)
    love.graphics.setFont(font)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", w/2 - 150, h/2 - 130, 300, 260)
    love.graphics.setColor(0.3,0.1,0.1)
    love.graphics.print("Name", w/2 - 100 , h/2 - 110)
    love.graphics.print("Score", w/2 + 50, h/2 - 110)
    love.graphics.setColor(0.1,0.1,0.1)
    for i, v in ipairs(scores) do
        love.graphics.print(v[1], w/2 - 100, h/2 - 110 + i * 20)
        love.graphics.print(v[2], w/2 + 50, h/2 - 110 + i * 20)
    end
    love.graphics.setColor(1,1,1)

    -- print try again button

    love.graphics.setColor(0.3,0.1,0.1)
    love.graphics.rectangle("fill", w/2 - font:getWidth('Press return to try again')/2 - 10, h/2 + 200, font:getWidth('Press return to try again')+20, 40)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Press return to try again", w/2 - font:getWidth('Press return to try again')/2, h/2 + 200 + 10)

end
timerGameOver = 120
viewTotalScore = false
isSaveName = false
textbox = {
    text = "",
    x = w/2-100,
    y = h/2-font:getHeight()/2+font:getHeight()*3,
    width = 200,
    height = 20,
    active = false,
    cursor = 0,
    cursorTimer = 0,
    cursorOn = true,
    textOffset = 0,
    textLimit = 10,
}

-- saveScores()