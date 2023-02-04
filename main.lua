Camera = require('libs.camera')
local W, H = love.graphics.getDimensions()
local player = require "player"

local parede = {}

azul_mar = {89/255,215/255,1}
-- Player = {
--     x = W/2,
--     y = H/2,
--     speed = 150,
-- }
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

function love.load()
    cam = Camera()
	cam:setFollowStyle('LOCKON')
    MapW = 2000
    MapH = 1000
    world = love.physics.newWorld(0,0,true)

    parede[1] = objetos_staticos(200,350,200,75,world)
    player.load()
    -- Player.w = 10
end

--function Player:move(dt)
    -- if love.keyboard.isDown("w") then
    --     self.y = self.y - self.speed*dt 
    -- elseif love.keyboard.isDown("s") then
    --     self.y = self.y + self.speed*dt 
    -- elseif love.keyboard.isDown("d") then
    --     self.x = self.x + self.speed*dt 
    -- elseif love.keyboard.isDown("a") then
    --     self.x = self.x - self.speed*dt
    -- end 

    --x, y = love.mouse.getPosition()
    -- print(x,y)

--end

function love.update(dt)
    world:update(dt)
    if dt > 0.040 then return end
    -- Player:move(dt)
    px ,py = player.body:getPosition()  
    cam:update(dt)
	cam:follow(px,py)

    if cam.x < W/2 then
		cam.x = W/2
	end

	if cam.y < H/2 then
		cam.y = H/2
	end

    if cam.x > MapW/2 then
		cam.x = MapW/2
	end

	if cam.y > MapH/2 then
		cam.y = MapH/2
	end

    player.update(dt)
end

function desenha_cenario(cenario,cor,translucidez)
    love.graphics.setColor(cor,translucidez or 1)
    for i = 1, #cenario do
      if cenario[i].body:isDestroyed() == false then
        love.graphics.polygon("fill",cenario[i].body:getWorldPoints(cenario[i].shape:getPoints()))
      end
    end
end

function love.draw()
    cam:attach()
    love.graphics.setColor(0.5,0.5,1)
    love.graphics.rectangle("fill",0,0,MapW,MapH)
    love.graphics.setColor(1,0.5,0)
    --love.graphics.circle('fill',Player.x,Player.y,Player.w)
    -- love.graphics.rectangle('fill',20,20,20,500)
    desenha_cenario(parede,azul_mar)
    player.draw()
    cam:detach()
end
