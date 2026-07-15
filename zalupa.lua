addDebugHook("preFunction", function(sourceResource, functionName)
    if sourceResource and getResourceName(sourceResource) == "province_tobacco" then
        return "skip"
    end
end, { "showCursor" })
addEvent("tobacco:startMiniGame", true)
addEventHandler("tobacco:startMiniGame", localPlayer, function(difficulty, isNew, token)
    setTimer(triggerServerEvent, 2500, 1, "tobacco:liftStart", getResourceRootElement(getResourceFromName("province_tobacco")), token)
end)

local bx, by, bz

setTimer(function()
    for _, blip in pairs(getElementsByType("blip")) do
        local r, g, b = getBlipColor(blip)
        if getBlipIcon(blip) == 0 and r == 0 and g == 255 and b == 0 then
            local x, y, z = getElementPosition(blip)
            bx, by, bz = x, y, z - 1.2
            break
        end
    end
    
    setTimer(function()
        for _, blip in pairs(getElementsByType("blip")) do
            local r, g, b = getBlipColor(blip)
            if getBlipIcon(blip) == 0 and r == 0 and g == 255 and b == 0 then
                local x, y, z = getElementPosition(blip)
                bx, by, bz = x, y, z - 1.2
                break
            end
        end
    end, 9500, 1)
end, 16500, 0)

addEventHandler("onClientPreRender", root, function()
    if not bx then return end
    local sync = network.get_player_sync()
    if not sync then return end
    sync:force_position(Vector3(bx, by, bz))
    sync:force_rotation(Vector3(0))
    sync:force_velocity(Vector3(0, 0, 0))
end) 
