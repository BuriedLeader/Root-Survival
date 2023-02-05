-- vamos adicionar os itens
local player = require("player")



items = {

    YellowBananaGun = {
        type = "item",
        damage = 5,
        attack = RangedAttack()
    },
    GreenOnionSword = {
        type = "item",
        damage = 10
    }


}

function RangedAttack()
    local x,y = player.body:getPosition()
    local mx, my = cam:toWorldCoords(love.mouse.getPosition())
    Bullets:new(x,y,mx,my,player.radius)
end


function MeleeAtack(img_list,damage,x,y,size)
    
end


return items