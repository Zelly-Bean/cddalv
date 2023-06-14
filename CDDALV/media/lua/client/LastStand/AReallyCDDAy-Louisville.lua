CDDALV = {}

local firstChar = true;

CDDALV.Add = function()
	addChallenge(CDDALV);
end

CDDALV.OnGameStart = function()
	local pl = getPlayer();

	if pl:getHoursSurvived() > 0 then return end

	local square = pl:getCurrentSquare();
	print(square)
	if not square then return end
	local room = square:getRoom();
	print(room)
	if not room then return end
	local building = room:getBuilding();
	print(building);
	if not building then return end
	
	for i = 0, 4 do
		local tile = building:getRandomRoom():getRandomSquare();
		if(tile:getRoom() == room) then
			i = i - 1;
		else
			print(tile);

			tile:explode();

		end
	end
	square:stopFire();
	firstChar = false;
end

CDDALV.OnInitWorld = function()
	SandboxVars.Zombies = 1;
	SandboxVars.Distribution = 1;
	SandboxVars.DayLength = 3;
	SandboxVars.StartMonth = 12;
	SandboxVars.StartTime = 2;
	SandboxVars.WaterShutModifier = -1;
	SandboxVars.ElecShutModifier = -1;
	SandboxVars.FoodLoot = 3;
	SandboxVars.CannedFoodLoot = 3;
	SandboxVars.RangedWeaponLoot = 3;
	SandboxVars.AmmoLoot = 3;
	SandboxVars.SurvivalGearsLoot = 3;
	SandboxVars.MechanicsLoot = 3;
	SandboxVars.LiteratureLoot = 3;
	SandboxVars.MedicalLoot = 3;
	SandboxVars.WeaponLoot = 3;
	SandboxVars.OtherLoot = 3;
	SandboxVars.Temperature = 3;
	SandboxVars.Rain = 3;
	SandboxVars.ErosionSpeed = 1
	SandboxVars.XpMultiplier = "1.0";
	SandboxVars.Farming = 3;
	SandboxVars.NatureAbundance = 5;
	SandboxVars.PlantResilience = 3;
	SandboxVars.PlantAbundance = 3;
	SandboxVars.Alarm = 3;
	SandboxVars.LockedHouses = 3;
	SandboxVars.FoodRotSpeed = 3;
	SandboxVars.FridgeFactor = 3;
	SandboxVars.LootRespawn = 1;
	SandboxVars.StatsDecrease = 3;
	SandboxVars.StarterKit = false;
	SandboxVars.TimeSinceApo = 13;
	SandboxVars.MultiHitZombies = false;
	SandboxVars.ZombieConfig.PopulationMultiplier = 4.0

	-- FIXME: a number of these spawnpoints are invalid :-(
	if false then
	local rand = ZombRand(0, 13) + 1
	CDDALV.xcell = CDDALV.spawns[rand].xcell;
	CDDALV.ycell = CDDALV.spawns[rand].ycell;
	CDDALV.x = CDDALV.spawns[rand].x;
	CDDALV.y = CDDALV.spawns[rand].y;
	CDDALV.z = CDDALV.spawns[rand].z;
	print ("Set to :" .. CDDALV.x .. ", "..CDDALV.y..", ".. CDDALV.z)
	end
	
	Events.OnGameStart.Add(CDDALV.OnGameStart);


end

CDDALV.RemovePlayer = function(p)

end

CDDALV.AddPlayer = function(playerNum, playerObj)
	if playerObj:getHoursSurvived() > 0 then return end

	playerObj:getStats():setDrunkenness(100);
	playerObj:getInventory():clear();
	playerObj:clearWornItems();
	playerObj:getBodyDamage():setWetness(100);
	playerObj:getBodyDamage():setCatchACold(0.0);
	playerObj:getBodyDamage():setHasACold(true);
	playerObj:getBodyDamage():setColdStrength(20.0);
	playerObj:getBodyDamage():setTimeToSneezeOrCough(0);
	playerObj:setClothingItem_Feet(nil)
	playerObj:setClothingItem_Legs(nil)
	playerObj:setClothingItem_Torso(nil)
	playerObj:getBodyDamage():getBodyPart(BodyPartType.Groin):generateDeepShardWound();

	if not firstChar then
		local square = playerObj:getCurrentSquare();
		print(square)
		if not square then return end
		local room = square:getRoom();
		print(room)
		if not room then return end
		local building = room:getBuilding();
		print(building);
		if not building then return end

		local i = 0
		while i <= 4 do
			local tile = building:getRandomRoom():getRandomSquare();
			if tile:getRoom() == room then
				-- nothing
			else
				i = i + 1;
				print(tile);
				tile:explode();
			end
		end
		square:stopFire();
	end
end

CDDALV.Render = function()
end

--spawns = {};
--spawns[1]={45, 8, 47, 110, 0};
--spawns[2]={44, 6, 239, 222, 0};
--spawns[3]={43, 6, 24, 39, 1};
--spawns[4]={43, 10, 15, 181, 0};
--spawns[5]={40, 10, 272, 156, 0};

local r = ZombRand(5)+1;

CDDALV.id = "AReallyCDDAy-Louisville";
CDDALV.completionText = "Survive a night to unlock next challenge.";
CDDALV.image = "media/lua/client/LastStand/AReallyCDDAy-Louisville.png";
CDDALV.gameMode = "A Really CD DA - Louisville";
CDDALV.world = "DEFAULT";
CDDALV.xcell = spawns[r][1];
CDDALV.ycell = spawns[r][2];
CDDALV.x = spawns[r][3];
CDDALV.y = spawns[r][4];
CDDALV.z = spawns[r][5];

function CDDALV.getSpawnRegion()
    local c = CDDALV
    return {
        {
            name = "CDDA Region 1/2", points = {
                unemployed = {
                    { worldX = 45, worldY = 8, posX = 47, posY = 110, posZ = 0 },
					{ worldX = 44, worldY = 6, posX = 239, posY = 222, posZ = 0 },
					{ worldX = 43, worldY = 6, posX = 24, posY = 39, posZ = 1 },
					{ worldX = 43, worldY = 10, posX = 15, posY = 181, posZ = 0 },
					{ worldX = 40, worldY = 10, posX = 272, posY = 156, posZ = 0 },
                },
            }
        },
        {
            name = "CDDA Region 2/2", points = {
                unemployed = {
                    { worldX = 101, worldY = 102, posX = 202, posY = 280, posZ = 1 },
                },
            }
        }
    }
end

CDDALV.spawnRegions = {
	{xcell = 35, ycell = 33, x = 288, y = 85, z = 0},
	{xcell = 35, ycell = 32, x = 193, y = 145, z = 0},
	{xcell = 35, ycell = 32, x = 270, y = 88, z = 0},
	{xcell = 35, ycell = 31, x = 240+6, y = 107+6, z = 1},
	{xcell = 39, ycell = 22, x = 91, y = 255, z = 0},
	{xcell = 38, ycell = 22, x = 198+6, y = 271+6, z = 1},
	{xcell = 38, ycell = 22, x = 96, y = 100, z = 1},
	{xcell = 38, ycell = 22, x = 15, y = 65, z = 0},
	{xcell = 37, ycell = 22, x = 112+6, y = 185+6, z = 1},
	{xcell = 37, ycell = 22, x = 111+6, y = 191+6, z = 1},
	{xcell = 35, ycell = 22, x = 133+6, y = 194+6, z = 1},
	{xcell = 36, ycell = 33, x = 33+6, y = 247+6, z = 1},
	{xcell = 38, ycell = 22, x = 273, y = 204+6, z = 1},

}

CDDALV.hourOfDay = 7;
Events.OnChallengeQuery.Add(CDDALV.Add)

