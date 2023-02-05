local game = {}
Camera = require('libs.camera')
require('map')
require("waves")
require("chest")
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
    
    cam = Camera()
	cam:setFollowStyle('LOCKON')
    world = love.physics.newWorld(0,0,true)

    player.load()
    --chest.load()
    
    MapW, MapH = Map:load()
    Map:wall(world)

    pause = false
    pause_timer = 0
end

function game.update(dt)
    if pause == false then
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
    love.graphics.print(storeTimer,100,100)
    if pause then
        love.graphics.setColor(0,0,0,0.85)
        love.graphics.rectangle('fill',0,0,W,H)
        love.graphics.setColor(1,1,1)
        love.graphics.print('PAUSE',W/2-15,H/2-15)
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