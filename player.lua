require "bullets"


local player = {} 
local W, H = love.graphics.getDimensions()
local timer = 0
local timerStandart = 0.5

player_buffs = {}
player_items = {}

function player.load()
    player.radius = 10
    player.body = love.physics.newBody(world,W/2,H/2,'dynamic')
    player.shape = love.physics.newCircleShape(player.radius)
    player.fixture = love.physics.newFixture(player.body,player.shape,1)
    player.fixture:setFriction(0)
    player.body:setFixedRotation(true)
    player.base_damage = 5
    player.current_damage = player.base_damage
    player.base_HP = 10
    player.base_speed = 150
    player.actual_speed = player.base_speed
    player.fixture:setUserData("player")
    player.life = player.base_HP
    player.invencible = false
    player.invencible_timer = 1
    player.score = 0
    player.radius = 10
    player.current_weapon = 0 -- valor somente para deixar a variável criada
    player.AddContent(items.YellowBananaGun)
    player.AddContent(items.GreenOnionSword)
    player.fire = true
    player.dead = false
    player.name = "Player one"
    player.img = love.graphics.newImage("assets/player/StandingCarrot1.png")

    if player.fire then
        player.current_weapon = player_items[1]
    else
        player.current_weapon = player_items[2]
    end
end

function player.draw_info()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line",5,5,155,40)
    love.graphics.setColor(1,0,0)
    local current_life = ((player.life)*150)/player.base_HP
    love.graphics.rectangle("fill",5,5,current_life+5,40)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill',45,50,75,20)
    love.graphics.setColor(0.8,0,0.5)
    love.graphics.print(player.score, 50,50)
end

function move (letra)
    if love.keyboard.isDown(letra) then
        return true
    end
    return false
end

function player_move(dt)
    --local velocidade = 150
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

    player.body:setLinearVelocity(move_x*player.actual_speed,move_y*player.actual_speed)

end

function player:update(dt)

    player_move(dt)
    
    if player.fire then
        if love.mouse.isDown(1) and timer <= 0.01 then
            local x,y = player.body:getPosition()
            local mx, my = cam:toWorldCoords(love.mouse.getPosition())
            Bullets:new(x,y,mx,my,player.radius)
            player.invencible_timer = player.invencible_timer - dt
            if player.invencible_timer <= 0 then
                player.invencible = false
                player.invencible_timer = 1
            end
            timer = timerStandart
        end

    else 
        if love.mouse.isDown(1) and timer <= 0.01 then
            
        end
    end

   -- if love.mouse.isDown(2) and timer <=1 then
        -- player.fire = not player.fire
        -- if player.current_weapon == player_items[1] then
        --     player.current_weapon = player_items[2]
        -- else
        --     player.current_weapon = player_items[1]
        -- end

    -- end

    if #player_buffs > 0 then
        player.ActivateBuffs(player_buffs)
    end

    Bullets:update(dt,self)
    timer = timer - dt
end

function player.draw()
    x,y = player.body:getPosition()
    love.graphics.setColor(1,1,1)
    --love.graphics.circle("fill",x,y,player.radius)
    love.graphics.draw(player.img,x,y,0,0.35,0.35,player.img:getWidth()/2,player.img:getHeight()/2)
    if player.current_weapon ~= 0 then
        if player.current_weapon == player_items[1] then
            love.graphics.draw(player.current_weapon.img,x+15,y,0,0.1,0.1,player.current_weapon.img:getWidth()/2,player.current_weapon.img:getHeight()/2)
        else
            love.graphics.draw(player.current_weapon.img,x+10,y-10,0,0.1,0.1,player.current_weapon.img:getWidth()/2,player.current_weapon.img:getHeight()/2)
        end
    end
    love.graphics.setColor({81/255,38/255,107/255})
    Bullets:draw()
end

function player.AddContent(content)
    if content.type == "buff" then
        table.insert(player_buffs,content)
        print("adicionei buff")
    elseif content.type == "item" then
        table.insert(player_items,content)
         if #player_items == 0 then
            player.current_weapon = player_items[player.equipped_weapon]
         end
    end
end


function player.ActivateBuffs(buff_list)
    for i, buff in ipairs(buff_list) do
        if buff.activated == false then
            buff.effect(player)
            buff.activated = true
        end
    end
end

return player