Camera = require('libs.camera')
local W, H = love.graphics.getDimensions()

Player = {
    x = W/2,
    y = H/2,
    speed = 300,
}

function love.load()
    cam = Camera()
	cam:setFollowStyle('LOCKON')

    Player.w = 10
end

function Player:move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed*dt 
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.speed*dt 
    elseif love.keyboard.isDown("d") then
        self.x = self.x + self.speed*dt 
    elseif love.keyboard.isDown("a") then
        self.x = self.x - self.speed*dt
    end 

    x, y = love.mouse.getPosition()
    print(x,y)

end

function love.update(dt)
    Player:move(dt)
    cam:update(dt)
	cam:follow(Player.x,Player.y)

    if cam.x < W/2 then
		cam.x = W/2
	end

	if cam.y < H/2 then
		cam.y = H/2
	end
end

function love.draw()
    cam:attach()
    love.graphics.setColor(0.5,0.5,1)
    love.graphics.rectangle("fill",0,0,2000,1000)
    love.graphics.setColor(1,0.5,0)
    love.graphics.circle('fill',Player.x,Player.y,Player.w)
    cam:detach()
end