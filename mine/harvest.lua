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
    for i = 16, 1, -1 do
        local details = turtle.getItemDetail(i, true)
        if details and details.count > 0 and (details.tags["c:seeds"] or nonSeedPlantables[details.name]) then
            turtle.select(i)
            turtle.placeDown()
            if ejectSeeds and details.tags["c:seeds"] and details.count > 55 then
                turtle.dropUp()
                turtle.select(1)
            elseif i ~= 16 then
                turtle.transferTo(16)
            end
            if details.count == 1 then
                turtle.select(1)
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

function nextRow()
    turn = not turn
    if turtle.forward() then
        local hasBlock, data = turtle.inspectDown()
        if not hasBlock or data.tags["minecraft:crops"] then
            return
        end 
    end
    while turtle.back() do
        hasBlock, data = turtle.inspectDown()
        if hasBlock and not data.tags["minecraft:crops"] then
            turtle.forward()
            return
        end
    end
end

function turnAround()
    if turn then
        turtle.turnRight()
        nextRow()
        turtle.turnRight()
    else
        turtle.turnLeft()
        nextRow()
        turtle.turnLeft()
    end
end

function step()
    local hasBlock, data = turtle.inspectDown()
    if hasBlock then
        if data.tags["minecraft:crops"] then
            -- if the block is a crop, harvest it
            harvest(data)
        else
            if data.tags["c:chests"] or data.tags["c:barrels"] or data.tags["c:shulker_boxes"] then
                -- if the block is a chest, barrel, or shulker box, drop all items in the inventory into it
                for i = 1, 16 do
                    turtle.select(i)
                    turtle.dropDown()
                end
                turtle.select(1)
            end
            -- if the block is not a crop, turn around
            turtle.back()
            turnAround()
            return
        end
    end
    if not turtle.forward() then
        -- if the turtle cannot move forward, turn around
        turnAround()
    end
end

while true do
    step()
end
