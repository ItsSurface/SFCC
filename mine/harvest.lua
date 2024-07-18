args = {...}

ejectSeeds = args[1] == nil and false or args[1] == "true"
-- set axis to x to make the turtle move along the x-axis, set it to z to make the turtle move along the z-axis. nil will prevent the turtle from checking its axis
axis = args[2]
debug = args[3] == nil and false or args[3] == "true"

turn = false -- if true, turn right, if false, turn left

maxAges = {
    ["minecraft:beetroots"] = 3,
    ["minecraft:nether_wart"] = 3,
    ["farmersdelight:tomatoes"] = 3
}
nonSeedPlantables = {
    ["minecraft:carrot"] = true,
    ["minecraft:potato"] = true,
    ["minecraft:nether_wart"] = true,
    ["farmersdelight:onion"] = true
}

function debugPrint(message)
    if debug then
        print(message)
    end
end

function fuelCheck()
    if turtle.getFuelLevel() < 10 then
        print("Out of fuel")
        return false
    end
    return true
end

function gpsAxisCheck()
    debugPrint("Checking axis")
    if axis == nil then
        return
    end
    x, y, z = gps.locate()
    if not turtle.forward() then
        turtle.back()
        x2, y2, z2 = gps.locate()
        turtle.forward()
    else 
        x2, y2, z2 = gps.locate()
        turtle.back()
    end
    if axis == "x" and x ~= x2 then
        turtle.turnRight()
    end
    if axis == "z" and z ~= z2 then
        turtle.turnRight()
    end
end

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
    debugPrint("Moving to next row")
    turn = not turn
    if turtle.forward() then
        local hasBlock, data = turtle.inspectDown()
        if not hasBlock or data.tags["minecraft:crops"] then
            return true
        end 
    end
    turtle.turnRight()
    turtle.turnRight()
    while turtle.forward() do
        hasBlock, data = turtle.inspectDown()
        if hasBlock and not data.tags["minecraft:crops"] then
            turtle.back()
            return false
        end
    end
    return false
end

function turnAround()
    if turn then
        debugPrint("Turning right")
        turtle.turnRight()
        nextRow()
        turtle.turnRight()
    else
        debugPrint("Turning left")
        turtle.turnLeft()
        nextRow()
        turtle.turnLeft()
    end
end

function step()
    local hasBlock, data = turtle.inspectDown()
    debugPrint("Block: " .. (hasBlock and data.name or "none"))
    if hasBlock then
        if data.tags["minecraft:crops"] then
            debugPrint("Harvesting")
            -- if the block is a crop, harvest it
            harvest(data)
        else
            debugPrint("Not a crop")
            if data.tags["c:chests"] or data.tags["c:barrels"] or data.tags["c:shulker_boxes"] then
                debugPrint("Dropping items")
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
    debugPrint("Moving forward")
    if not turtle.forward() then
        -- if the turtle cannot move forward, turn around
        turnAround()
    end
end

while true do
    step()
    if not fuelCheck() then

        sleep(10)
    end
end
