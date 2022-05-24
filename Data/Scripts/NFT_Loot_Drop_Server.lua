---@class NFT_Loop_Drop
local NFT_Loop_Drop = require(script:GetCustomProperty("NFT_Loot_Drop_API"))

---@type Folder
local CRATE_SPAWN_POINTS = script:GetCustomProperty("CrateSpawnPoints"):WaitForObject()

---@type number
local CRATE_ZSTART_POINT = script:GetCustomProperty("CrateZStartPoint")

local CRATE_ZSTART_POINT = script:GetCustomProperty("CrateZStartPoint")

---@type string
local NO_LOOT_ITEM = script:GetCustomProperty("NoLootItem")


NFT_Loop_Drop.init(CRATE_SPAWN_POINTS, CRATE_ZSTART_POINT, NO_LOOT_ITEM)

function Tick(dt)
	NFT_Loop_Drop.tick(dt)
end