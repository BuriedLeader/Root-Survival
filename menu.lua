local menu = {}

function menu.load()
    love.graphics.setBackgroundColor({89/255,215/255,1})
end   

function menu.update(dt)
    
end

function menu.draw() 
    -- 960,540 
    love.graphics.setColor({128/255, 128/255, 128/255})
    love.graphics.rectangle('fill',380,250,200,50)
    love.graphics.setColor(0,0,0)
    drawCenteredText(380,250,200,50, "START")
end

function menu.keypressed(key)
    
end

function menu.keyreleased(key)
    
end

function menu.mousepressed(x,y,button)
    local mx, my = love.mouse.getPosition( )
    if button == 1 and verify_region(mx,my,430,250,100,75) then
        goToGame()
    end
end

return menu