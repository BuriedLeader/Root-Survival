Map = {}
sti = require "libs/sti"

function Map:load()
    map = sti("assets/map.lua", {"box2d"})
    Map.saveSpawn = 1
    return map.width*map.tilewidth, map.height*map.tileheight
end

function Map:getCenter()
    return map.width*map.tilewidth/2, map.height*map.tileheight/2
end

function Map:wall()
    for i,v in ipairs(map.layers["colider"].objects) do
        Map.obj = {}
        Map.obj.body = love.physics.newBody(world, v.x + v.width/2, v.y + v.height/2, "static")
        Map.obj.shape = love.physics.newRectangleShape(v.width, v.height)
        Map.obj.fixture = love.physics.newFixture(Map.obj.body, Map.obj.shape, 1)
        Map.obj.fixture:setUserData("colider")
    end
end

function Map:update(dt)
    map:update(dt)
    
end

function Map:draw()
    map:drawLayer(map.layers["floor"])
end

function Map:drawForest()
    love.graphics.setColor(1, 1, 1)
    map:drawLayer(map.layers["forest"])
    for i,v in ipairs(map.layers["black"].objects) do
        love.graphics.setColor(57/255, 45/255, 70/255)
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    end
    love.graphics.setColor(1, 1, 1)
end

function Map:spawns()
    local spawns = {}
    for i,v in ipairs(map.layers["black"].objects) do
        spawns[i] = {x = v.x, y = v.y, w = v.width, h = v.height}
    end
    test = math.random(1, #spawns)
    if test == Map.saveSpawn then
        test = test + 1
        if test > #spawns then
            test = 1
        end
    end
    Map.saveSpawn = test
    return spawns[test]
end