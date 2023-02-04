--vamos adicionar os buffs


player = require("player")
buffs = {

    HealthIncrease = {
        type = "buff",
        activated = false,
        effect = function (player) player.actual_HP = player.actual_HP + player.actual_HP/10 end,
    },
    SpeedIncrease = {
        type = "buff",
        activated = false,
        effect = function (player)  player.actual_speed = player.actual_speed + player.actual_speed/10 end
    },
    DamageIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)  player.actual_damage = player.actual_damage + player.actual_damage/10 end
    },
    SuperDamageIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)  player.actual_damage = player.actual_damage + player.actual_damage*0.33 end
    },

    SuperHealthIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)   player.actual_HP = player.actual_speed + player.actual_speed*0.33 end
    },

    SuperSpeedIncrease = {
       type = "buff",
       activated = false,
       effect = function (player)  player.actual_speed = player.actual_speed + player.actual_speed*0.33 end
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