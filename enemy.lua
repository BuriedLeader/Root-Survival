--require("waves")

local Enemy = {}

local player = require("player")

active_enemies = {}
enemy_types = {[1] = "lettuce",[2] = "pumpkin", [3] = "onion"}


function Enemy.create(x,y,actual_wave)

    -- probs = waveProp(Waves[actual_wave])

    -- n = love.math.random()
    -- local type

    -- local old_prob = 0
    -- for key, values in pairs(probs) do
    --     if old_prob < n and n < values then
    --         type = key
    --         break
    --     end
    --     old_prob = values
    -- end

    local new_enemy = {
        x = x,
        y = y,
        speed = math.log(actual_wave +5,2) + 100,
        hp = actual_wave*10,
        orientation = 1, -- 1 = direita, -1 = esquerda
        type = enemy_types[type],
        damage = actual_wave * 2,
        radius = 15,
        --color = 
    }

    new_enemy.body = love.physics.newBody(world,new_enemy.x,new_enemy.y,'kinematic')
    new_enemy.shape = love.physics.newCircleShape(radius)
    new_enemy.fixture = love.physics.newFixture(new_enemy.body,new_enemy.shape,1)
    new_enemy.fixture:setFriction(0)
    new_enemy.body:setFixedRotation(true)

    table.insert(active_enemies,new_enemy)
end

function Enemy.animate(dt)

end

function Enemy.followPlayer (dt)
    player_x,player_y = player.body:getPosition()

end

function Enemy.load()
    Enemy.create(500,500,1)
end

function Enemy.update (dt)
    
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