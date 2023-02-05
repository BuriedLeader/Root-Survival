require "bullets"
local player = {} 
local W, H = love.graphics.getDimensions()
local timer = 0

player_buffs = {}
player_items = {}

function player.load()
    radius = 10
    player.body = love.physics.newBody(world,W/2,H/2,'dynamic')
    player.shape = love.physics.newCircleShape(radius)
    player.fixture = love.physics.newFixture(player.body,player.shape,1)
    player.fixture:setFriction(0)
    player.body:setFixedRotation(true)
    player.base_damage = 5
    player.actual_damage = player.base_damage
    player.base_HP = 10
    player.actual_HP = player.base_HP
    player.base_speed = 150
    player.actual_speed = player.base_speed
    player.fixture:setUserData("player")
    player.life = 10
    player.invencible = false
    player.invencible_timer = 1
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
<<<<<<< HEAD
    player.body:setLinearVelocity(150,200)
    player_move(dt)
=======
    player_move()
>>>>>>> 0692baea5832432538139add9a0ba74cedb0381d
    if love.mouse.isDown(1) and timer <= 0.5 then
        local x,y = player.body:getPosition()
        local mx, my = cam:toWorldCoords(love.mouse.getPosition())
        Bullets:new(x,y,mx,my,radius)
        timer = 1
    end
    if player.invencible then
        print(player.invencible_timer)
        player.invencible_timer = player.invencible_timer - dt
        if player.invencible_timer <= 0 then
            player.invencible = false
            player.invencible_timer = 1
        end
    end
    timer = timer - dt
    Bullets:update(dt,self)
end

function player.draw()
    x,y = player.body:getPosition()
    love.graphics.setColor(0,1,0)
    love.graphics.circle("fill",x,y,radius)
    love.graphics.setColor({81/255,38/255,107/255})
    Bullets:draw()
end

function player.AddContent(content)
    if content.type == "buff" then
        table.insert(player_buffs,content)
        print("adicionei buff")
    elseif content.type == "item" then
        table.insert(player_items,content)
        print("adicionei item")
    end
end

function player.RemoveContent(content)
    
end



return player