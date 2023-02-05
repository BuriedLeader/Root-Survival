--vamos adicionar os buffs


player = require("player")
buffs = {

    HealthIncrease = {
        type = "buff",
        activated = false,
        effect = function (player) 
            player.base_HP = player.base_HP*1.1
            player.life = player.life + player.base_HP*0.1
        end
    },
    SpeedIncrease = {
        type = "buff",
        activated = false,
        effect = function (player)  player.actual_speed = player.actual_speed*1.1 end
    },
    DamageIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)  player.actual_damage = player.actual_damage*1.1 end
    },
    SuperDamageIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)  player.actual_damage = player.actual_damage*1.3 end
    },

    SuperHealthIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)  
            player.base_HP = player.base_HP*1.3
            player.life = player.life + player.base_HP*0.3
        end
    },

    SuperSpeedIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)  player.actual_speed = player.actual_speed*1.3 end
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


return buffs