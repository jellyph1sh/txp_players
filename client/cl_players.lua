local function Heal()
    local player = GetPlayerPed(-1)
    local maxHealth = GetEntityMaxHealth(player)
    SetEntityHealth(player, maxHealth)
end

local function TeleportToBlip(blip)
    local found, z = false, 0.0
    local player = GetPlayerPed(-1)
    local x, y = table.unpack(GetBlipCoords(blip))
    DoScreenFadeOut(1000)
    Wait(1000)
    while not found do
        RequestCollisionAtCoord(x, y, z)
        found, ground = GetGroundZFor_3dCoord(x, y, z, false)
        z = z + 5
        Wait(0)
    end
    SetEntityCoords(player, x, y, ground, true, false, false)
    DoScreenFadeIn(1000)
end

RegisterNetEvent("txp_players:heal")
AddEventHandler("txp_players:heal", function()
    Heal()
end)

RegisterNetEvent("txp_players:teleportwaypoint")
AddEventHandler("txp_players:teleportwaypoint", function()
    if IsWaypointActive() then
        wpBlip = GetFirstBlipInfoId(8)
        TeleportToBlip(wpBlip)
    else
        TriggerEvent("chat:addMessage", {
            color = {255, 0, 0},
            multiline = false,
            args = {"[ERROR]", "No active waypoint!"}
        })
    end
end)

TriggerEvent('chat:addSuggestion', '/tp', 'Teleport player at you.', {{name="server_id", help="Enter the server ID."}})
TriggerEvent('chat:addSuggestion', '/tpto', 'Teleport you to player.', {{name="server_id", help="Enter the server ID."}})
TriggerEvent('chat:addSuggestion', '/tpwp', 'Teleport you at your waypoint.', nil)
TriggerEvent('chat:addSuggestion', '/heal', 'Heal targeted player.', {{name="server_id", help="Enter the server ID."}})
