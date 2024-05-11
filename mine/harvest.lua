args = {...}
turn = false -- if true, turn right, if false, turn left

maxAges = {
    ["minecraft:beetroots"] = 3,
    ["minecraft:nether_wart"] = 3,
    ["farmersdelight:tomatoes"] = 3
}

function seed()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.getItemCount(i) > 0 and turtle.getItemDetail(i, true).tags["minecraft:crops"] then
            turtle.placeDown()
            return
        end
    end
    print("No seed to plant")
    return
end

function harvest(blockData)
    maxAge = min(maxAges[blockData.state.name], 7)
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
                -- store items
                for i = 1, 16 do
                    turtle.select(i)
                    turtle.dropDown()
                end
            end
            turtle.back()
            turnAround()
        end
    end
    if not turtle.forward() then
        turnAround()
    end
end

while true do
    step()
end