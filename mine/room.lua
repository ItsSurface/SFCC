args = {...}
if #args < 3 then
    print("Usage: room <length> <width> <height>")
    return
end

function mine()
    turtle.dig()
    while not turtle.forward() do
        turtle.dig()
    end
end

-- get length, width, and height from args
l = tonumber(args[1])-1
w = tonumber(args[2])
h = tonumber(args[3])

if l < 1 or w < 1 or h < 1 then
    print("Invalid dimensions")
    return
end

local direction = true
for i = 1, h do
    for j = 1, w do
        for k = 1, l do
            mine()
        end
        if j < w then
            if direction then
                turtle.turnRight()
                mine()
                turtle.turnRight()
                direction = false
            else
                turtle.turnLeft()
                mine()
                turtle.turnLeft()
                direction = true
            end
        end
    end
    if i < h then
        turtle.digUp()
        turtle.up()
        turtle.turnRight()
        turtle.turnRight()
    end
end