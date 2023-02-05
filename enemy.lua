--require("waves")

local Enemy = {}

local player = require("player")

active_enemies = {}
enemy_types = {[1] = "lettuce",[2] = "pumpkin", [3] = "onion"}

smart = {
    onions=function(self,dt)
        self.test = self.test or false

        px,py = player.body:getPosition()
        
        x = self.body:getX() - px
        y = self.body:getY() - py

        local normalize = 1000
    
        if x ~= 0 and y ~= 0 then
            normalize = math.sqrt(x^2 + y^2)
            x = -x / normalize
            y = -y / normalize
        end

        if normalize > 100 then
            self.test  = true
            self.body:setLinearVelocity(x*self.speed,y*self.speed) 
        else
            if self.test then
                self.body:setLinearVelocity(x*2*self.speed,y*2*self.speed)
                self.test = false
            end
        end
        self.SaveX = px
        self.SaveY = py

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

        self.body:setLinearVelocity(x*self.speed,y*self.speed)
    end
}

speeds = {
    onions = 50,
    pumpkin = 50,
    lettuce = 50
}

imgs = {
    onions = love.graphics.newImage("assets/enemies/onion.png"),
    pumpkin = love.graphics.newImage("assets/enemies/pumpkin.png"),
    lettuce = love.graphics.newImage("assets/enemies/lettuce.png")
}

scores = {
    onions = 15,
    pumpkin = 10,
    lettuce = 5
}

colors = {
    onions = {1,1,1},
    pumpkin = {255/255,114/255,0/255},
    lettuce = {0/255, 66/255,37/255}
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
    new_enemy.shape = love.physics.newCircleShape(new_enemy.radius)
    new_enemy.fixture = love.physics.newFixture(new_enemy.body,new_enemy.shape,1)
    new_enemy.fixture:setFriction(0)
    new_enemy.fixture:setUserData("enemy")
    new_enemy.body:setFixedRotation(true)

    table.insert(active_enemies,new_enemy)
end

function Enemy.animate(dt)

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

        player.invencible_timer = player.invencible_timer - dt

        if player.invencible_timer <= 0 then
            player.invencible = false
            player.invencible_timer = 1
        end

        contacts = enemy.body:getContacts()
        if contacts then
            for i,contact in ipairs(contacts) do
                if player.life <= 0 then
                    player.dead = true
                    addScore(player.name,player.score)
                end
                if contact:getFixtures():getUserData() == "player" and not player.invencible then
                    player.life = player.life - enemy.damage
                    love.audio.play(Sounds.hit)
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
        love.graphics.setColor(colors[enemy.type])
        local x,y = enemy.body:getPosition()
        love.graphics.draw(imgs[enemy.type],x,y,0,1,1,imgs[enemy.type]:getWidth()/2,imgs[enemy.type]:getHeight()/2)
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