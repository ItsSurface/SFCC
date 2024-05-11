args = {...}

ejectSeeds = args[1] == nil and false or args[1] == "true"
turn = false -- if true, turn right, if false, turn left

maxAges = {
    ["minecraft:beetroots"] = 3,
    ["minecraft:nether_wart"] = 3,
    ["farmersdelight:tomatoes"] = 3
}
nonSeedPlantables = {
    ["minecraft:carrots"] = true,
    ["minecraft:potatoes"] = true,
    ["minecraft:nether_wart"] = true,
    ["farmersdelight:onion"] = true
}

function seed()
    for i = 1, 16 do
        local details = turtle.getItemDetail(i, true)
        if turtle.getItemCount(i) > 0 and (details.tags["c:seeds"] or nonSeedPlantables[details.name]) then
            turtle.select(i)
            turtle.placeDown()
            if ejectSeeds then
                turtle.dropUp()
            end
            return
        end
    end
    print("No seed to plant")
    return
end

function harvest(blockData)
    local maxAge = maxAges[blockData.name] or 7
    if blockData.state.age == maxAge then
        turtle.digDown()
        seed()
    end
end

function turnAround()
    if turn then
        turtle.turnRight()
        if turtle.forward() then
            turn = not turn
        end
        turtle.turnRight()
    else
        turtle.turnLeft()
        if turtle.forward() then
            turn = not turn
        end
        turtle.turnLeft()
    end
end

function step()
    hasBlock, data = turtle.inspectDown()
    if hasBlock then
        if data.tags["minecraft:crops"] then
            harvest(data)
        else
            if data.tags["c:chests"] or data.tags["c:barrels"] or data.tags["c:shulker_boxes"] then
                for i = 1, 16 do
                    turtle.select(i)
                    turtle.dropDown()
                end
            end
            turtle.back()
            turnAround()
            return
        end
    end
    if not turtle.forward() then
        turnAround()
    end
end

while true do
    step()
end
