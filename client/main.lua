-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Trusted Development || Debug-print
-- ════════════════════════════════════════════════════════════════════════════════════ --

if Trusted.Debug then
    local filename = function()
        local str = debug.getinfo(2, "S").source:sub(2)
        return str:match("^.*/(.*).lua$") or str
    end
    print("^6[CLIENT - DEBUG] ^0: "..filename()..".lua gestartet");
end

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

ClearPedTasks(PlayerPedId())

RegisterNetEvent('Trusted:CarWashingSponge:UseItem', function()
    local ped <const> = PlayerPedId()
    local minDistance = math.huge
    local vehicle = nil

    for _, veh in pairs(GetGamePool('CVehicle')) do
        local vehEntity = GetEntityCoords(veh)
        local pedEntity = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(vehEntity, pedEntity)

        if distance < minDistance then
            minDistance = distance
            vehicle = veh
        end
    end

    if not vehicle or minDistance > 4 then
        Visual.ShowHelp(Config.Text['not_near_vehicle'], true)
        return
    end

    TriggerServerEvent('Trusted:CarWashingSponge:UseItem')

    local isWasing = true

    CreateThread(function()
        while isWasing do
            Wait(0)
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
        end
    end)

    local vehicleCoords <const> = GetEntityCoords(vehicle)
    local vehicleHeading <const> = GetEntityHeading(vehicle)
    local vehicleVector4 <const> = vec4(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehicleHeading)
    local min <const>, max <const> = GetModelDimensions(GetEntityModel(vehicle))
    local width <const> = (0 - min.x) + (max.x)
    local length <const> = (0 - min.y) + (max.y)

    local directions <const> = {
        Math.GetForwardFromCoords(vehicleVector4, (length / 2) + 0.2),
        Math.GetForwardFromCoords(vehicleVector4, width - 0.8, 180.0),
        Math.GetForwardFromCoords(vehicleVector4, -(length / 2) - 0.4),
        Math.GetForwardFromCoords(vehicleVector4, width - 0.8, 0.0)
    }
    local headings <const> = {
        vehicleHeading - 180,
        vehicleHeading - 90,
        vehicleHeading,
        vehicleHeading + 90
    }

    for i = 1, #directions do
        local x, y, z = table.unpack(directions[i])

        TaskGoStraightToCoord(ped, x, y, z, 1.0, 5000, headings[i], 0.5)
        Wait(5000)

        local spongeProp <const> = Game.SpawnObjectAtCoords('prop_sponge_01', x, y, z, 0.0, true)
        Game.PlayAnimation("timetable@floyd@clean_kitchen@base", "base", 49)
        AttachEntityToEntity(spongeProp, ped, GetPedBoneIndex(ped, 57005), 0.15, 0.0, -0.01, 90.0, 0.0, 0.0, true, true, false, true, 1, true)

        Wait(Config.WashTime / 4)

        ClearPedTasks(ped)
        DeleteEntity(spongeProp)
        Wait(450)
    end

    SetVehicleDirtLevel(vehicle, GetVehicleDirtLevel(vehicle) / 4)
    isWasing = false
end)