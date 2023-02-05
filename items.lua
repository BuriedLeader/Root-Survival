-- vamos adicionar os itens
local player = require("player")



items = {

    YellowBananaGun = {
        type = "item",
        damage = 5,
        img = love.graphics.newImage("assets/items/BananaGun/YellowBananaGun.png")
    },
    GreenOnionSword = {
        type = "item",
        damage = 10,
        img = love.graphics.newImage("assets/items/GreenOnionSword/GreenOnionSword.png")
    }


}


return items