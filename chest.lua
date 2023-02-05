chest = {}

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
       radius = 15,
       opened_img = love.graphics.newImage("assets/chest/opened_chest.png"),
       closed_img = love.graphics.newImage("assets/chest/closed_chest.png")
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
    love.graphics.setColor(1,1,1)
    for i,chest in ipairs(active_chests) do
        print(chest.state)
        
        if chest.touched == false then
            if chest.state == "closed" then
                local x,y = chest.body:getPosition()
                love.graphics.draw(chest.closed_img,x,y,0,0.5,0.5,chest.closed_img:getWidth()/2,chest.closed_img:getHeight()/2)
            else
                local x,y = chest.body:getPosition()
                love.graphics.draw(chest.opened_img,x,y,0,0.5,0.5,chest.opened_img:getWidth()/2,chest.opened_img:getHeight()/2)
                love.graphics.draw(chest.content.img,x,y,0,0.5,0.5,chest.content.img:getWidth()/2,chest.content.img:getHeight()/2)
            end
        end
    end
end

function distanceCalculator(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

function DetectPlayer(chest)
    if chest.touched == false then   
        px,py = player.body:getPosition()
        
        x = chest.body:getX()
        y = chest.body:getY()
        
        local distancia = distanceCalculator(x,y,px,py)
        if distancia <= (player.radius + chest.radius + 5) and chest.touched == false and chest.state == "opened" then
            player.AddContent(chest.content)
            chest.touched = true
            chest.body:destroy()
            love.audio.play(Sounds.open)
            
        elseif distancia > (player.radius + chest.radius + 6) and distancia < (player.radius + chest.radius + 10) and chest.state == "closed" then 
            chest.state = "opened"
        end
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

function chest.new(content)
    content = content or selectRandomBuff()
    content = buffs[content]
    -- get center of map
    local x,y = Map.getCenter()
    -- set 100 pixels away form player in direction of center
    local px,py = player.body:getPosition()
    local dx = x - px
    local dy = y - py
    local distance = math.sqrt(dx*dx + dy*dy)
    local nx = px + dx/distance * 300
    local ny = py + dy/distance * 300
    -- create chest
    -- print(nx..","..ny)
    chest.create(nx,ny,content)
end

return chest