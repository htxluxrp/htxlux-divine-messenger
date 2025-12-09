local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('htxlux-divine:CanSeeMessenger', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb(false) return end

    local cid = Player.PlayerData.citizenid

    for _, allowed in ipairs(Config.AllowedCitizenIds) do
        if cid == allowed then
            cb(true)
            return
        end
    end

    cb(false)
end)
