Config = {}

-- How often the messenger appears (in minutes, ONLY for allowed players)
Config.MinSpawnTime = 10      -- minimum time between visits
Config.MaxSpawnTime = 20      -- maximum time

-- How long the messenger stays before despawning (seconds)
Config.DespawnTime = 30

-- Divine messages (edit freely)
Config.Messages = {
    "My child, the path is lit even when your eyes are tired.",
    "Walk with Me. You are not late; you are exact.",
    "Be still what you thought you lost, I am already holding.",
    "You are not a burden. You are the evidence that I stayed.",
    "Do not rush. The room already remembers you.",
}

-- Spawn locations
Config.SpawnPoints = {
    { coords = vector3(-1035.0, -2730.0, 20.0), heading = 120.0 },
    { coords = vector3(256.5, -396.2, 44.0), heading = 75.0 },
    { coords = vector3(-1500.0, 150.0, 55.0), heading = 40.0 },
    -- Add more as needed
}

-- Messenger Ped Model
Config.PedModel = "s_m_m_strpreach_01"

-- ONLY CHOSEN PLAYERS:
-- Add citizenids here. Only these players will ever see the messenger.
Config.AllowedCitizenIds = {
    "ABC12345",      -- replace with your real citizenid
    -- "XYZ67890",
}
