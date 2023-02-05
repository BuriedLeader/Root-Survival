local game = {}
Camera = require('libs.camera')
require('map')
require("waves")
require("chest")
require('viewScores')
local W, H = love.graphics.getDimensions()
local player = require("player")
local enemy = require("enemy")

local parede = {}

function objetos_staticos (x,y,w,h,mundo)
    local objeto = {
      x = x,
      y = y,
      w = w,
      h = h
    }   
    objeto.body = love.physics.newBody(mundo,x,y,"static")
    objeto.shape = love.physics.newPolygonShape(0,0,0,h,w,0,w,h)
    objeto.fixture = love.physics.newFixture(objeto.body,objeto.shape,1)
    return objeto
end

function game.load()
    love.graphics.setBackgroundColor({0/255,0/255,0})
    cam = Camera()
	cam:setFollowStyle('LOCKON')
    world = love.physics.newWorld(0,0,true)

    player.load()
    --chest.load()
    
    MapW, MapH = Map:load()
    Map:wall(world)

    pause = false
    pause_timer = 0

    -- load music
    music = love.audio.newSource("assets/ggj.mp3", "stream")
    music:setLooping(true)
    music:setVolume(0.5)
    music:play()

    -- load gameOver sound
    gameOverSound = love.audio.newSource("assets/gameOver.mp3", "stream")
    gameOverSound:setLooping(false)
    gameOverSound:setVolume(0.5)

    isPlayed = false

end

function game.update(dt)
    if pause == false and not player.dead and not isSaveName and not viewTotalScore then
        world:update(dt)
        if dt > 0.040 then return end
        px ,py = player.body:getPosition()  
        cam:update(dt)
        cam:follow(px,py)

        if cam.x < W/2 then
            cam.x = W/2
        end

        if cam.y < H/2 then
            cam.y = H/2
        end

        if cam.x > MapW - W/2  then
            cam.x = MapW - W/2
        end

        if cam.y > MapH - H/2 then
            cam.y = MapH - H/2
        end
        player:update(dt)
        chest.update(dt)
        enemy.update(dt)

        WavesCount:Spawn(enemy,Map,dt)
    end

    
    pause_timer = pause_timer + dt
    
end


function desenha_cenario(cenario,cor,translucidez)
    love.graphics.setColor(cor,translucidez or 1)
    for i = 1, #cenario do
      if cenario[i].body:isDestroyed() == false then
        love.graphics.polygon("fill",cenario[i].body:getWorldPoints(cenario[i].shape:getPoints()))
      end
    end
end

function game.draw()
    cam:attach()
    love.graphics.setColor(1,1,1)
    Map:draw()
    love.graphics.setColor(0.5,0.5,1)

    love.graphics.setColor(1,0.5,0)
    love.graphics.setColor(1,1,1)
    enemy.draw()
    player.draw()
    chest.draw()
    Map:drawForest()
    cam:detach()
    player.draw_info()
    --love.graphics.print(storeTimer,100,100)
    if pause then
        love.graphics.setColor(0,0,0,0.85)
        love.graphics.rectangle('fill',0,0,W,H)
        love.graphics.setColor(1,1,1)
        drawCenteredText(0,0,W,H,'PAUSE')
    end

    if love.keyboard.isDown('tab') then
        viewDraw()
    end

    if player.dead then
        music:stop()
        if not isPlayed then
            gameOverSound:play()
            isPlayed = true
        end

        if isSaveName then
            love.graphics.setColor(0,0,0,0.85)
            love.graphics.rectangle('fill',0,0,W,H)
            love.graphics.setColor(1,1,1)
            love.graphics.rectangle('fill',
                textbox.x, textbox.y,
                textbox.width, textbox.height)
        
            love.graphics.printf(textbox.text,
                textbox.x, textbox.y,
                textbox.width, 'left')
            love.graphics.print('Press Enter to save your score',W/2-font:getWidth('Press Enter to save your score')/2,H/2-font:getHeight()/2+font:getHeight()*2)
            love.graphics.setColor(0,0,0)
            love.graphics.print(textbox.text,W/2-font:getWidth(textbox.text)/2,H/2-font:getHeight()/2+font:getHeight()*3)
            love.graphics.setColor(1,1,1)
        else
            love.graphics.setColor(0,0,0,1)
            love.graphics.rectangle('fill',0,0,W,H)
            love.graphics.setColor(1,1,1)
            -- cemtralize text Game Over in screen
            love.graphics.print('Game Over',W/2-font:getWidth('Game Over')/2,H/2-font:getHeight()/2)
            -- draw score on next line
    
            love.graphics.print('Score: '..player.score,W/2-font:getWidth('Score: '..player.score)/2,H/2-font:getHeight()/2+font:getHeight())
            
            if love.keyboard.isDown('return') or love.keyboard.isDown('space') then
                isSaveName = true
            end
        end

        if isSaveName and love.keyboard.isDown('return') and timerGameOver < 0 and not viewTotalScore  then
            player.name = textbox.text
            addScore(player.name,player.score)
            saveScores()
            viewTotalScore = true
            timerGameOver = 120
        elseif isSaveName  then
            timerGameOver = timerGameOver - 1
        end

        if viewTotalScore then
            viewDrawCenter()
            if timerGameOver < 0 and (love.keyboard.isDown('return') or love.keyboard.isDown('space'))  then
                love.event.quit('restart')
            else
                timerGameOver = timerGameOver - 1
            end
        end
        
    end

end

function game.keypressed(key)
    
end

function game.keyreleased(key)
    
    if key == 'escape' and pause_timer > 1 then
        pause = not pause
        pause_timer = 0
    end

end

function game.mousereleased(x,y,button)
    if button == 2 then
        player.fire = not player.fire
    end
end

function game.mousepressed(x,y,button)
    
end

return game