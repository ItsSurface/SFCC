args = {...}
if #args < 2 then
    print("Usage: floor <length> <width>")
    return
end

length = tonumber(args[1])
width = tonumber(args[2])

function forward()
    while not turtle.forward() do
        turtle.dig()
    end
end

function placeInvDown()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.getItemCount(i) > 0 then
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
        turtle.forward()
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