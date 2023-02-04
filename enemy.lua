local Enemy = {}

local player = require("player")

active_enemies = {}

function Enemy.create(x,y,actual_wave)

    new_enemy = {
        x = x,
        y = y,
        speed = math.log(actual_wave +5,2) + 100,
        hp = actual_wave*10,
        orientation = 1, -- 1 = direita, -1 = esquerda
        
    }

    table.insert()
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

return Enemy