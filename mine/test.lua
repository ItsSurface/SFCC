args = {...}
if #args < 1 then
    print("Usage: testmine <# of blocks to move and break>")
    return
end

for i = 1, tonumber(args[1]) do
    turtle.dig()
    turtle.digUp()
    turtle.digDown()
    turtle.forward()
end