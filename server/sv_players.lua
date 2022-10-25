local function sendChatMessage(src, prefix, msg, choosenColor)
    TriggerClientEvent("chat:addMessage", src, {
        args = {
            prefix,
            msg
        },
        color = choosenColor
    })
end

local function TeleportPlayerTo(player, targetPlayer)
    local x, y, z = table.unpack(GetEntityCoords(targetPlayer))
    SetEntityCoords(player, x, y, z - 1, true, false, false, false)
end

local function TeleportPlayerToVehicle(player, targetVeh)
    for i = -1, 8, 1 do
        if GetPedInVehicleSeat(targetVeh, i) then
            TaskWarpPedIntoVehicle(player, targetVeh, seatIndex)
            return false
        end
    end
    return true
end

RegisterCommand("tp", function(src, args)
    if #args == 0 then
        sendChatMessage(src, "[ERROR]", "Missing arguments!", {255, 0, 0})
    elseif #args > 1 then
        sendChatMessage(src, "[ERROR]", "Too many arguments!", {255, 0, 0})
    elseif GetPlayerPed(args[1]) == 0 then
        sendChatMessage(src, "[ERROR]", "Invalid target id!", {255, 0, 0})
    else
        local targetId = args[1]
        local player = GetPlayerPed(src)
        local targetPlayer = GetPlayerPed(targetId)
        local playerVeh = GetVehiclePedIsIn(player, false)
        if targetVeh == 0 then
            TeleportPlayerTo(targetPlayer, player)
        else
            error = TeleportPlayerToVehicle(targetPlayer, playerVeh)
            if error then
                sendChatMessage(src, "[ERROR]", "Problem during teleportation!", {255, 0, 0})
            end
        end
    end
end, true)

RegisterCommand("tpto", function(src, args)
    if #args == 0 then
        sendChatMessage(src, "[ERROR]", "Missing arguments!", {255, 0, 0})
    elseif #args > 1 then
        sendChatMessage(src, "[ERROR]", "Too many arguments!", {255, 0, 0})
    elseif GetPlayerPed(args[1]) == 0 then
        sendChatMessage(src, "[ERROR]", "Invalid target id!", {255, 0, 0})
    else
        local targetId = args[1]
        local player = GetPlayerPed(src)
        local targetPlayer = GetPlayerPed(targetId)
        local targetVeh = GetVehiclePedIsIn(targetPlayer, false)
        if targetVeh == 0 then
            TeleportPlayerTo(player, targetPlayer)
        else
            error = TeleportPlayerToVehicle(player, targetVeh)
            if error then
                sendChatMessage(src, "[ERROR]", "Problem during teleportation!", {255, 0, 0})
            end
        end
    end
end, true)