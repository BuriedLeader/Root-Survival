--vamos adicionar os buffs


buffs = {

    HealthIncrease = {
        type = "buff",
        activated = false,
        img = love.graphics.newImage("assets/buffs/health.png"),
        effect = function (player) 
            player.base_HP = player.base_HP*1.1
            player.life = player.base_HP
        end
    },
    SpeedIncrease = {
        type = "buff",
        activated = false,
        img = love.graphics.newImage("assets/buffs/speed.png"),
        effect = function (player)  player.current_speed = player.current_speed*1.1 end
    },
    DamageIncrease = {
       type = "buff",
       activated = false,
       img = love.graphics.newImage("assets/buffs/damage.png"),
       effect = function (player)  player.current_damage = player.current_damage*1.1 end
    },
    SuperDamageIncrease = {
       type = "buff",
       activated = false,
       img = love.graphics.newImage("assets/buffs/super_speed.png"),
       effect = function (player)  player.current_damage = player.current_damage*1.3 end
    },

    SuperHealthIncrease = {
       type = "buff",
       activated = false,
       img = love.graphics.newImage("assets/buffs/super_health.png"),
       effect = function (player)  
            player.base_HP = player.base_HP*1.3
            player.life = player.base_HP
        end
    },

    SuperSpeedIncrease = {
       type = "buff",
       activated = false,
       img = love.graphics.newImage("assets/buffs/super_speed.png"),
       effect = function (player)  player.current_speed = player.current_speed*1.3 end
    }

}

buffs_rate = {
    HealthIncrease = 70/300,
    SpeedIncrease =  70/300,
    DamageIncrease = 70/300,
    SuperDamageIncrease = 30/300,
    SuperHealthIncrease = 30/300,
    SuperSpeedIncrease = 30/300
}

-- select a random buff
function selectRandomBuff()
    local random = math.random()
    local sum = 0
    for k,v in pairs(buffs_rate) do
        sum = sum + v
        if random <= sum then
            return k
        end
    end
end

return buffs