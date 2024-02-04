-- ════════════════════════════════════════════════════════════════════════════════════ --
-- ESX Shared
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX = exports['es_extended']:getSharedObject()

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Trusted Development || Debug-print
-- ════════════════════════════════════════════════════════════════════════════════════ --

if Trusted.Debug then
    local filename = function()
        local str = debug.getinfo(2, "S").source:sub(2)
        return str:match("^.*/(.*).lua$") or str
    end
    print("^6[SERVER - DEBUG] ^0: "..filename()..".lua started");
end

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX.RegisterUsableItem(Config.SpongeItem, function(source)
    TriggerClientEvent('Trusted:CarWashingSponge:UseItem', source)
end)

RegisterNetEvent('Trusted:CarWashingSponge:UseItem', function()
    ESX.GetPlayerFromId(source).removeInventoryItem(Config.SpongeItem, 1)
end)