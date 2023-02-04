--require("waves")

local Enemy = {}

local player = require("player")

active_enemies = {}
enemy_types = {[1] = "lettuce",[2] = "pumpkin", [3] = "onion"}

smart = {
    onions=function()
        
    end,
    pumpkin=function()
        
    end,
    lettuce=function(self,dt)
        px,py = player.body:getPosition()
        
        x = self.body:getX() - px
        y = self.body:getY() - py
    
        -- normalize

        if x ~= 0 and y ~= 0 then
            local normalize = math.sqrt(x^2 + y^2)
            x = -x / normalize
            y = -y / normalize
        end

        self.body:setLinearVelocity(x*self.speed*dt,y*self.speed*dt)
    end
}

speeds = {
    onions = 30000,
    pumpkin = 20000,
    lettuce = 20000
}

function Enemy.create(x,y,actual_wave,type)

    local new_enemy = {
        x = x,
        y = y,
        originX = x,
        originY = y,
        speed = math.log(actual_wave +16,2) + speeds[type] + 10*math.random(),
        hp = actual_wave*10,
        orientation = 1, -- 1 = direita, -1 = esquerda
        type = type,
        damage = actual_wave * actual_wave/2 + 3,
        radius = 15,
        --color = 
    }

    new_enemy.smart = smart[type]
    new_enemy.body = love.physics.newBody(world,new_enemy.x,new_enemy.y,'kinematic')
    new_enemy.shape = love.physics.newCircleShape(radius)
    new_enemy.fixture = love.physics.newFixture(new_enemy.body,new_enemy.shape,1)
    new_enemy.fixture:setFriction(0)
    new_enemy.fixture:setUserData("enemy")
    new_enemy.body:setFixedRotation(true)

    table.insert(active_enemies,new_enemy)
end

function Enemy.animate(dt)

end

function Enemy.followPlayer (dt)
    player_x,player_y = player.body:getPosition()

end

-- function Enemy.load()
--     Enemy.create(500,500,1,"lettuce")
--     Enemy.create(300,300,1,"lettuce")
-- end

function distanceCalculator(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

function Enemy.update (dt)
    for i,enemy in ipairs(active_enemies) do
        test = true
        if distanceCalculator(enemy.body:getX(),enemy.body:getY(),enemy.originX,enemy.originY) > 200 then
            enemy.body:setType("dynamic")
        end

        contacts = enemy.body:getContacts()
        if contacts then
            for i,contact in ipairs(contacts) do
                if player.life <= 0 then
                    love.event.quit()
                end
                if contact:getFixtures():getUserData() == "player" and not player.invencible then
                    player.life = player.life - enemy.damage
                    --table.remove(active_enemies,i)
                    player.invencible = true
                end
            end
        end

        enemy.smart(enemy,dt)
    end
end

function Enemy.draw ()
    for i,enemy in ipairs(active_enemies) do
        local x,y = enemy.body:getPosition()
        love.graphics.circle("fill",x,y,enemy.radius)
    end
end

function Enemy.remove()

end

function Enemy.beginContact()

end

function Enemy.attack (type)
end

return Enemy