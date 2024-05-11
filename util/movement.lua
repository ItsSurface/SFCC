stuck = 0

function stuckCheck()
    if turtle.detect() then
        stuck = stuck + 1
    else
        stuck = 0
    end
    if stuck > 10 then
        print("Stuck")
        return true
    end
    return false
end

function forward()
    while not turtle.forward() do
        turtle.dig()
    end

end

