local function Heal()
    local player = GetPlayerPed(-1)
    local maxHealth = GetEntityMaxHealth(player)
    SetEntityHealth(player, maxHealth)
end

RegisterNetEvent("txp_players:heal")
AddEventHandler("txp_players:heal", function()
    Heal()
end)
