while true do
    turtle.select(1)
    if turtle.getItemCount(1) == 0 then
        while not turtle.suck() do
            os.sleep(5)
        end
    end
    if not turtle.dropDown() then
        turtle.suckDown()
        for i = 1, 16 do
            if turtle.getItemCount(i) > 0 and turtle.getItemDetail(i).name == "minecraft:bone_meal" then
                turtle.select(i)
                turtle.dropUp()
                break
            end
        end
    end
end