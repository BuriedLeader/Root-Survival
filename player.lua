require "bullets"
local player = {} 
local W, H = love.graphics.getDimensions()
local timer = 0

function player.load()
    radius = 10
    player.body = love.physics.newBody(world,W/2,H/2,'dynamic')
    player.shape = love.physics.newCircleShape(radius)
    player.fixture = love.physics.newFixture(player.body,player.shape,1)
    player.fixture:setFriction(0)
    player.body:setFixedRotation(true)
    player.hit = 5
end

function move (letra)
    if love.keyboard.isDown(letra) then
        return true
    end
    return false
end

function player_move(dt)
    local velocidade = 150
    move_x = 0
    move_y = 0

    if move('a') then
        move_x = move_x - 1
    end

    if move('d') then
        move_x = move_x + 1
    end

    if move('w') then
        move_y = move_y - 1
    end

    if move('s') then
        move_y = move_y + 1
    end

    if move_x ~= 0 and move_y ~= 0 then
        local normalize = math.sqrt(2)
        move_x = move_x / normalize
        move_y = move_y / normalize
    end

    player.body:setLinearVelocity(move_x*velocidade,move_y*velocidade)
end

function player:update(dt)
    player.body:setLinearVelocity(150,200)
    player_move()
    if love.mouse.isDown(1) and timer <= 0.5 then
        local x,y = player.body:getPosition()
        local mx, my = cam:toWorldCoords(love.mouse.getPosition())
        Bullets:new(x,y,mx,my,radius)
        timer = 1
    end
    timer = timer - dt
    Bullets:update(dt,self)
end

function player.draw()
    x,y = player.body:getPosition()
    love.graphics.setColor(0,1,0)
    love.graphics.circle("fill",x,y,radius)

    Bullets:draw()
end

return player