-- grab seeds from the chest in front of the turtle when necessary, if there are no seeds left then wait 5 seconds on loop until the chest is refilled.
-- drop the seeds down into the composter until its full and more cant be added
-- suck the bonemeal from the composter and drop it in the chest above

while true do
    turtle.select(1)
    if turtle.getItemCount(1) == 0 then
        while not turtle.suck() do
            os.sleep(5)
        end
    end
    if not turtle.dropDown() then
        turtle.suckDown()
        -- loop throgugh the inventory and find the first slot with bonemeal in it
        for i = 1, 16 do
            if turtle.getItemCount(i) > 0 and turtle.getItemDetail(i).name == "minecraft:bone_meal" then
                turtle.select(i)
                turtle.dropUp()
                break
            end
        end
    end
end