IslandData = nil

local IslandTypes = {"Obstacle","Small","Medium","Large"}

local dictionarySize = 0
local IslandLocations = {

}

function DrawIslands()
  if IslandData == nil then
    IslandData = GenerateIslands()
  end

    for index,island in pairs(IslandData) do
      DrawSpriteBlock(island[1],island[2],island[3],4,4,false,false,DrawMode.Sprite,0,true,false)
      DrawText( "Island Pos X: "..math.floor(island[2]), MapSize.x*0.1, MapSize.y*0.1, DrawMode.UI, "large", 14 )
      DrawText( "Island Pos Y: "..math.floor(island[3]), MapSize.x*0.1, MapSize.y*0.13, DrawMode.UI, "large", 14 )
    end

  -- local spriteID = IslandData[1]
  -- local X = IslandData[2]
  -- local Y = IslandData[3]
  --
  -- DrawSprite(spriteID,X,Y,false,false,DrawMode.Sprite)
  -- DrawText( "Island Pos X: "..X, 100, 50, DrawMode.UI, "large", 14)
  -- DrawText( "Island Pos Y: "..Y, 100, 150, DrawMode.UI, "large", 14)
end

--function CheckIfIslandExists(XRange, YRange)
  --for x,y in XRange, YRange do
--end

function GenerateIslands()
  numIslands = math.random(1,3)
  Islands = {}
  local islandRangesX = {} -- 16 -> 240
  local islandRanges = {16, 86, 156, 220} -- 16 -> 220

  for i = 1,numIslands do
      island = {4, math.random(islandRanges[i],islandRanges[i+1]), math.random(islandRanges[i], islandRanges[i+1])}
      Islands[i] = island
  end

  return Islands
end



--function Collide(Boat)
--- Boat and an Island are touching ---hashmap
-- for index, value in pairs(table name) do
--check if along perimeter
--for k,v in pairs(t) do
--    if(t)
--end
--end
