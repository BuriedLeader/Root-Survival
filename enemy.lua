require("waves")

local Enemy = {}

local player = require("player")

active_enemies = {}
enemy_types = {[1] = "lettuce",[2] = "pumpkin", [3] = "onion"}


function Enemy.create(x,y,actual_wave)

    probs = waveProp(Waves[actual_wave])

    n = love.math.random()
    local type

    local old_prob = 0
    for key, values in pairs(probs) do
        if old_prob < n and n < values then
            type = key
            break
        end
        old_prob = values
    end

    new_enemy = {
        x = x,
        y = y,
        speed = math.log(actual_wave +5,2) + 100,
        hp = actual_wave*10,
        orientation = 1, -- 1 = direita, -1 = esquerda
        type = enemy_types[type],
        damage = actual_wave * 2,
        --color = 
    }

    table.insert(active_enemies,new_enemy)
end

function Enemy.animate(dt)

end

function Enemy.followPlayer ()
    
end

function Enemy.load()
    
end

function Enemy.update (dt)
    
end

function Enemy.draw ()
    for enemy in active_enemies do
        love.draw(enemy)
    end
end

function Enemy.remove()

end

function Enemy.beginContact()
    
 end

 function Enemy.attack (type)
    
 end

return Enemy