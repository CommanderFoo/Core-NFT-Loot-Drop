---@class Tween
local Tween = require(script:GetCustomProperty("Tween"))

local DROP_CRATES = require(script:GetCustomProperty("DropCrates"))
local INVENTORY_ASSETS = require(script:GetCustomProperty("InventoryAssets"))
local CRATE_IMPACT_EFFECTS = script:GetCustomProperty("CrateImpactEffects")
local CRATE_OPENED_EFFECTS = script:GetCustomProperty("CrateOpenedEffects")

---@class NFT_Loop_Drop
local NFT_Loop_Drop = {

	---@type integer
	HOURS_20 = 72000,

	---@type string
	STORAGE_KEY = "nftl",

	---@class Events
	Events = {

		READY = "NFTLootDrop.Ready"

	},

	---@type table<integer, CoreObject>
	spawned_crates = {},

	---@type table
	crate_spawn_points = {},

	---@type table<CoreObject, CoreObject>
	used_drop_area = {},

	---@type table<integer, table>
	tweens = {},

	---@type table<string, BlockchainToken>
	loot = {}

}

function NFT_Loop_Drop.save_rng(player)
	local data = Storage.GetPlayerData(player)

	if(not data[NFT_Loop_Drop.STORAGE_KEY]) then
		data[NFT_Loop_Drop.STORAGE_KEY] = { c = 0, s = 0 } -- last claimed, seed
	end

	if(data[NFT_Loop_Drop.STORAGE_KEY].s == 0) then
		local seed = DateTime.CurrentTime().secondsSinceEpoch

		data[NFT_Loop_Drop.STORAGE_KEY].s = seed
	end

	Storage.SetPlayerData(player, data)

	return data[NFT_Loop_Drop.STORAGE_KEY].s
end

function NFT_Loop_Drop.can_drop_loot(player)
	local data = Storage.GetPlayerData(player)

	if(data[NFT_Loop_Drop.STORAGE_KEY] ~= nil) then
		local last_claim = data[NFT_Loop_Drop.STORAGE_KEY]
		local now = DateTime.CurrentTime().secondsSinceEpoch

		if((last_claim.c + NFT_Loop_Drop.HOURS_20) <= now) then
			return true
		end

		return false
	end

	return true
end

function NFT_Loop_Drop.get_drop_area()
	for index, point in ipairs(NFT_Loop_Drop.area_spawn_points) do
		if(not NFT_Loop_Drop.used_drop_area[point]) then
			return point
		end
	end

	return nil
end

--@TODO
function NFT_Loop_Drop.get_template(player, seed)
	local RNG = RandomStream.New(seed)

	return DROP_CRATES[1].Template
end

function NFT_Loop_Drop.create_tween(crate, z_pos)
	local tween = Tween:new(1, { z = NFT_Loop_Drop.start_point }, { z = z_pos })

	tween:on_change(function(c)
		local pos = crate:GetWorldPosition()

		pos.z = c.z
		crate:SetWorldPosition(pos)
	end)

	tween:on_complete(function()
		tween = nil
		World.SpawnAsset(CRATE_IMPACT_EFFECTS, {
			
			networkContext = NetworkContextType.NETWORKED,
			position = crate:GetWorldPosition()
		
		})
	end)

	tween:set_easing(Tween.Easings.In_Quint)

	NFT_Loop_Drop.tweens[#NFT_Loop_Drop.tweens + 1] = tween
end

function NFT_Loop_Drop.get_loot(player)
	-- local all_tokens = {}

	local tokens = Blockchain.GetTokens({
	
		--playerId = player.id
		contractAddress = "0xca590be85a184b8ed837b28966602d543569e41f"

	})

	-- if(tokens ~= nil) then
	-- 	all_tokens = tokens:GetResults()

	-- 	print(#all_tokens, tokens.hasMoreResults)
	-- 	-- while(tokens.hasMoreResults) do
	-- 	-- 	local more_tokens = tokens:GetMoreResults()

	-- 	-- 	for index, token in ipairs(more_tokens) do
	-- 	-- 		all_tokens[#all_tokens + 1] = token
	-- 	-- 	end
	-- 	-- end

	-- 	-- print(tokens)
	-- end

	return "Magic Bars"
end

function NFT_Loop_Drop.find_asset_id(loot)
	for index, row in ipairs(INVENTORY_ASSETS) do
		if(row.loot_value == loot) then
			return row.asset
		end
	end
end

function NFT_Loop_Drop.drop_loot(player)
	local drop_area = NFT_Loop_Drop.get_drop_area()

	if(drop_area == nil) then
		return
	end

	local loot = NFT_Loop_Drop.get_loot(player)

	if(loot == nil) then
		loot = NFT_Loop_Drop.no_loot_item

		if(loot == nil or string.len(loot) == 0) then
			return
		end
	end

	local asset_id = NFT_Loop_Drop.find_asset_id(loot)

	if(not asset_id) then
		return
	end

	local seed = NFT_Loop_Drop.save_rng(player)
	local crate = World.SpawnAsset(NFT_Loop_Drop.get_template(player, seed), {

		networkContext = NetworkContextType.NETWORKED,
		position = drop_area:GetWorldPosition() + (Vector3.UP * NFT_Loop_Drop.start_point),
		rotation = drop_area:GetWorldRotation()

	})

	NFT_Loop_Drop.used_drop_area[drop_area] = 1

	crate:SetCustomProperty("Owner", player.id)
	crate:SetCustomProperty("AssetId", asset_id)

	crate.destroyEvent:Connect(function()
		NFT_Loop_Drop.spawned_crates[crate] = nil
	end)

	NFT_Loop_Drop.spawned_crates[crate] = player
	NFT_Loop_Drop.used_drop_area[drop_area] = crate

	NFT_Loop_Drop.create_tween(crate, drop_area:GetWorldPosition().z)
end

function NFT_Loop_Drop.clean_up(player)
	for crate, player in pairs(NFT_Loop_Drop.spawned_crates) do
		if(Object.IsValid(crate)) then
			for area, spawned_crate in pairs(NFT_Loop_Drop.used_drop_area) do
				if(spawned_crate == crate) then
					NFT_Loop_Drop.used_drop_area[area] = nil
					break
				end
			end

			crate:Destroy()
		end
	end
end

function NFT_Loop_Drop.open_crate(player, crate)
	local owner = crate:GetCustomProperty("Owner")
	local asset_id = crate:GetCustomProperty("AssetId")

	if(owner == player.id and #player:GetInventories() > 0) then
		World.SpawnAsset(CRATE_OPENED_EFFECTS, {

			networkContext = NetworkContextType.NETWORKED,
			position = crate:GetWorldPosition(),
			rotation = crate:GetWorldRotation()

		})

		---@class Inventory
		local the_inventory = nil

		for index, inventory in ipairs(player:GetInventories()) do
			if(inventory.name == player.name) then
				the_inventory = inventory
				break
			end
		end

		if(the_inventory ~= nil) then
			if(the_inventory:CanAddItem(asset_id, { count = 1 })) then
				the_inventory:AddItem(asset_id)
			end
		end
	end
end

function NFT_Loop_Drop.ready(player)
	if(NFT_Loop_Drop.can_drop_loot(player)) then
		NFT_Loop_Drop.drop_loot(player)
	end
end

function NFT_Loop_Drop.init(crate_spawns, start_point, no_loot_item)
	if(crate_spawns ~= nil) then
		NFT_Loop_Drop.area_spawn_points = crate_spawns:GetChildren()
	end

	NFT_Loop_Drop.no_loot_item = no_loot_item
	NFT_Loop_Drop.start_point = start_point or 1000

	if(Environment.IsClient()) then
		Task.Wait()
		Events.BroadcastToServer(NFT_Loop_Drop.Events.READY)
	elseif(Environment.IsServer()) then
		Events.ConnectForPlayer(NFT_Loop_Drop.Events.READY, NFT_Loop_Drop.ready)

		Game.playerLeftEvent:Connect(NFT_Loop_Drop.clean_up)
	end
end

function NFT_Loop_Drop.tick(dt)
	for index, tween in ipairs(NFT_Loop_Drop.tweens) do
		tween:tween(dt)
	end
end

return NFT_Loop_Drop