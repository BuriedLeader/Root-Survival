Camera = require('libs.camera')
require('map')
require("waves")
require("chest")
local W, H = love.graphics.getDimensions()
local player = require("player")
local enemy = require("enemy")

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
    world = love.physics.newWorld(0,0,true)

    player.load()
    chest.load()
    
    MapW, MapH = Map:load()
    Map:wall(world)

end

function love.update(dt)
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

    love.graphics.print(storeTimer,100,100)
end
