Waves{
    {onions=1,pumpkin=2,lettuce=3},
}
function waveProp(wave)
    local prob = {}
    local sum = 0
    for key, value in pairs(wave) do
        sum = sum +value 
        prob[key] =  sum
    end

    for key, value in pairs(prob) do
        prob[key] = prob[key] / sum
    end
    return prob
end

waveProp(wave1)