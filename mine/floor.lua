args = {...}
if #args < 2 then
    print("Usage: floor <length> <width>")
    return
end

length = tonumber(args[1])-1
width = tonumber(args[2])
-- get the block in the first slot of the inventory, if there is none then print an error message, otherwise store the type of block in a variable and ensure that every block placed is the same type
turtle.select(1)
if turtle.getItemCount(1) == 0 then
    print("No blocks to place")
    return
end
blockType = turtle.getItemDetail(1).name

function forward()
    while not turtle.forward() do
        turtle.dig()
    end
end

function placeInvDown()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.getItemCount(i) > 0 and turtle.getItemDetail(i).name == blockType then
            turtle.placeDown()
            return
        end
    end
    print("No blocks to place")
    return
end

for i = 1, width do
    for j = 1, length do
        turtle.digDown()
        placeInvDown()
        forward()
    end
    if i % 2 == 0 then
        turtle.turnRight()
        turtle.digDown()
        placeInvDown()
        forward()
        turtle.turnRight()
    else
        turtle.turnLeft()
        turtle.digDown()
        placeInvDown()
        forward()
        turtle.turnLeft()
    end
end