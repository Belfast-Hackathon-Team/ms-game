IslandData = {}

local IslandTypes = {"Obstacle","Small","Medium","Large"}

function DrawIslands()
    if #IslandData > 0 then
      for index,island in pairs(IslandData) do
        local index = island[1]
        local x = island[2]
        local y = island[3]
        local multiplier = island[4]

        DrawSpriteBlock(index,x,y,multiplier,multiplier,false,false,DrawMode.Sprite,0,true,false)
        if not island[5] then
          DrawSprite(0, island[6], island[7], false, false, DrawMode.Sprite) --egg
        end
      end
    end
end

function GenerateIslands()
  local numIslands = math.random(1,3)
  local Islands = {}

  for i = 1,numIslands do
  local multiplier = 0
  local islandRanges = {16, 86, 156, 220} -- 16 -> 220
  local islandSpriteIndexes = {4,68}
  local islandSpriteIndex = islandSpriteIndexes[math.random(1,2)]
  local islandX = math.random(islandRanges[i],islandRanges[i+1])
  local islandY = math.random(islandRanges[i], islandRanges[i+1])
  local captured = false
  local spriteSize = 0

  if islandSpriteIndex == 4 then
    multiplier = 4
    spriteSize = {12,12}
  elseif islandSpriteIndex == 68 then
    multiplier = 8
    spriteSize = {50,50}
  end

  local eggX = islandX+math.random(1, spriteSize[1])
  local eggY = islandY+math.random(1, spriteSize[2])

  island = {islandSpriteIndex, islandX, islandY, multiplier, captured, eggX, eggY}
  Islands[i] = island
  end
  AI.IsHidden = false
  return Islands
end
