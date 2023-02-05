local json = require("libs/json")

local scores = json.decode(love.filesystem.read("s.json"))

function saveScores()
    local filehandle = io.open("s.json", "w+")
    filehandle:write(json.encode(scores))
    filehandle:close()
end

function getScores()
    -- sort scores
    table.sort(scores, function(a,b) return a[2] > b[2] end)
    -- return top 10
    return {unpack(scores,1,10)}
end

function addScore(name,score)
    table.insert(scores, {name,score})
    saveScores()
end