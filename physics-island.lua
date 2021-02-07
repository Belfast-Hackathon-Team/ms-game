IslandData = {}

local IslandTypes = {"Obstacle","Small","Medium","Large"}

function DrawIslands()
  DrawText( "Island Count: "..#IslandData, 100, 170, DrawMode.UI, "large", 14 )
    if #IslandData > 0 then
      for index,island in pairs(IslandData) do
        DrawSpriteBlock(island[1],island[2],island[3],island[4],island[4],false,false,DrawMode.Sprite,0,true,false)
      end
    end
end

function GenerateIslands()
  local numIslands = math.random(0,3)
  local Islands = {}

  for i = 1,numIslands do
      local multiplier = 0
      local islandRanges = {16, 86, 156, 220} -- 16 -> 220
      local islandSpriteIndexes = {4,68}
      local islandSpriteIndex = islandSpriteIndexes[math.random(1,2)]

      if islandSpriteIndex == 4 then
        multiplier = 4
      elseif islandSpriteIndex == 68 then
        multiplier = 8
      end

      island = {islandSpriteIndex, math.random(islandRanges[i],islandRanges[i+1]), math.random(islandRanges[i], islandRanges[i+1]), multiplier}
      Islands[i] = island
  end

  return Islands
end
