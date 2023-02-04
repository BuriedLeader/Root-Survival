--vamos adicionar os buffs


player = require("player")
buffs = {

    HealthIncrease = {
        type = "buff",
        activated = false,
        effect = function (player) player.actual_HP = player.actual_HP + player.actual_HP/10     end
    },
    SpeedIncrease = {
        type = "buff",
        activated = false,
        effect = function (player)  player.actual_speed = player.actual_speed + player.actual_speed/10    end
    },

    BaseDamageIncrease = {
       type = "buff",
        activated = false,
        effect = function (player)  player.actual_damage = player.actual_damage + player.actual_damage/10    end
    },

    SuperBaseDamageIncrease = {
       type = "buff",
        activated = false,
        effect = function (player)  player.actual_damage = player.actual_damage + player.actual_damage*0.33    end
    },

    SuperHealthIncrease = {
       type = "buff",
        activated = false,
        effect = function (player)   player.actual_HP = player.actual_speed + player.actual_speed*0.33   end
    },

    SuperSpeedIncrease = {
       type = "buff",
        activated = false,
        effect = function (player)  player.actual_speed = player.actual_speed + player.actual_speed*0.33    end
    }



}


return buffs