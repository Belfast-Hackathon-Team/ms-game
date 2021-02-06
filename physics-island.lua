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
    DrawSpriteBlock(island[1],island[2],island[3],island[4],island[4],false,false,DrawMode.Sprite,0,true,false)
    DrawText( "Island Pos X: "..math.floor(island[2]), MapSize.x*0.1, MapSize.y*0.1, DrawMode.UI, "large", 14 )
    DrawText( "Island Pos Y: "..math.floor(island[3]), MapSize.x*0.1, MapSize.y*0.13, DrawMode.UI, "large", 14 )
  end

end

--function CheckIfIslandExists(XRange, YRange)
  --for x,y in XRange, YRange do
--end

function GenerateIslands()
  numIslands = math.random(1,3)
  Islands = {}
  local multiplier = 0
  local islandRangesX = {} -- 16 -> 240
  local islandRanges = {16, 86, 156, 220} -- 16 -> 220
  local islandSpriteIndexes = {4,68}
  local islandSpriteIndex = islandSpriteIndexes[math.random(1,2)]

  if islandSpriteIndex == 4 then
    multiplier = 4
  elseif islandSpriteIndex == 68 then
    multiplier = 8
  end

  for i = 1,numIslands do
      island = {islandSpriteIndex, math.random(islandRanges[i],islandRanges[i+1]), math.random(islandRanges[i], islandRanges[i+1]), multiplier}
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
