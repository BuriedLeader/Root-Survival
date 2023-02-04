chest = {img = love.graphics.newImage("assets/chest/teste.jpg")}

chest.__index = chest

items = require("items")
buffs = require("buffs")
player = require("player")

active_chests = {}

function chest.create(x,y,content)

    new_chest = {
       x = x,
       y = y,
       content = content,
       state = "closed",
       touched = false,
       radius = 15
    }

    new_chest.body = love.physics.newBody(world,new_chest.x,new_chest.y,'static')
    new_chest.shape = love.physics.newCircleShape(new_chest.radius)
    new_chest.fixture = love.physics.newFixture(new_chest.body,new_chest.shape,1)
    new_chest.fixture:setFriction(0)
    new_chest.fixture:setUserData("chest")
    new_chest.body:setFixedRotation(true)

    table.insert(active_chests,new_chest)
end


function chest.draw()
    for i,chest in ipairs(active_chests) do
        local x,y = chest.body:getPosition()
        love.graphics.circle("fill",x,y,15)
    end
end

function distanceCalculator(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

function chest:open()
    self.state = "opened"
end

function DetectPlayer(chest)
    px,py = player.body:getPosition()
        
    x = chest.body:getX()
    y = chest.body:getY()
    
    local distancia = distanceCalculator(x,y,px,py)
    if distancia <= (player.radius + chest.radius + 5) and chest.touched == false then
        player.AddContent(chest.content)
        chest.touched = true
    elseif distancia > (player.radius + chest.radius + 6) and distancia < (player.radius + chest.radius + 10) and chest.state == "closed" then 
        chest.state = "opened"
    end

end

function chest.update (dt)

    for i,chest in ipairs(active_chests) do
        DetectPlayer(chest)
    end 

end

function chest.load()
    chest.create(400,400,buffs.SpeedIncrease)
end

return chest