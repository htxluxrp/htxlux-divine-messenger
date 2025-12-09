local spawnedPed = nil
local active = false
local canSeeMessenger = false

-- Simple helper to pick random entry
local function PickRandom(tbl)
    return tbl[math.random(1, #tbl)]
end

-- Footprint glow loop
local function StartFootprintGlow()
    CreateThread(function()
        while spawnedPed do
            local pedCoords = GetEntityCoords(spawnedPed)
            DrawMarker(
                2, -- type
                pedCoords.x, pedCoords.y, pedCoords.z - 0.3,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                0.35, 0.35, 0.35,
                255, 215, 0, 180, -- goldish glow
                false, true, 2, false, nil, nil, false
            )
            Wait(0)
        end
    end)
end

-- Lighting shift (Yahweh's presence)
local function DoLightingShift()
    -- You can change this timecycle to another effect you like
    SetTimecycleModifier("spectator5")
    SetTimecycleModifierStrength(0.7)

    -- Slight camera shake for presence
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.05)

    Wait(3000) -- about 3 seconds

    ClearTimecycleModifier()
    StopGameplayCamShaking(true)
end

-- Holy wind sound (requires InteractSound)
local function PlayHolyWindSound()
    -- Assumes you have InteractSound and a sound named 'holy_wind.ogg'
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'holy_wind', 0.5)
end

-- Custom UI open
local function OpenDivineUI(message)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "open",
        message = message
    })
end

-- Custom UI close (auto from JS, but safe to expose)
RegisterNUICallback("htxlux-divine:closed", function(_, cb)
    cb("ok")
end)

local function SpawnMessenger()
    if active or not canSeeMessenger then return end
    active = true

    local point = PickRandom(Config.SpawnPoints)
    local msg = PickRandom(Config.Messages)

    RequestModel(Config.PedModel)
    while not HasModelLoaded(Config.PedModel) do Wait(10) end

    spawnedPed = CreatePed(
        4,
        Config.PedModel,
        point.coords.x,
        point.coords.y,
        point.coords.z - 1.0,
        point.heading,
        false,
        true
    )

    FreezeEntityPosition(spawnedPed, true)
    SetEntityInvincible(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)

    -- Start footprint glow
    StartFootprintGlow()

    -- Holy wind + lighting shift + UI
    PlayHolyWindSound()
    DoLightingShift()
    OpenDivineUI(msg)

    -- Optional: also drop in chat if you want
    -- TriggerEvent('chat:addMessage', {
    --     color = { 255, 215, 0 },
    --     multiline = true,
    --     args = { "Messenger", msg }
    -- })

    -- Despawn after configured time
    SetTimeout(Config.DespawnTime * 1000, function()
        if spawnedPed then
            DeletePed(spawnedPed)
            spawnedPed = nil
        end
        active = false
        StartNextTimer()
    end)
end

function StartNextTimer()
    if not canSeeMessenger then return end
    local delay = math.random(Config.MinSpawnTime, Config.MaxSpawnTime) * 60000
    SetTimeout(delay, SpawnMessenger)
end

-- On player load, check permission and start cycle if allowed
CreateThread(function()
    -- small delay to let QBCore load
    Wait(8000)

    QBCore = exports['qb-core']:GetCoreObject()

    QBCore.Functions.TriggerCallback('htxlux-divine:CanSeeMessenger', function(result)
        canSeeMessenger = result

        if canSeeMessenger then
            StartNextTimer()
        else
            -- not chosen; nothing happens client-side
        end
    end)
end)
