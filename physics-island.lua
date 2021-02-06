function IslandPhysics()
end

--function CheckIfIslandExists(XRange, YRange)
  --for x,y in XRange, YRange do
--end

function SpawnBlock()
--- DrawSpriteBlock
-- within0,10,11,12,13,14,15,16}
  --- randomly draw a new island

  --[[ possible island solution
  256x248

  for x = 256,248 do

  end

  ]]

  newIsland = {
    ID = math.random(10,16),
    X = math.random(0, 256),
    Y = math.random(0, 248)
  }
  DrawSprite(newIsland.ID, newIsland.X, newIsland.Y, false, false, DrawMode.Sprite)
end

function SpawnIsland()
  islandSprite = math.random(10,16)
  islandLength = math.random(3,5)
  islandWidth = math.random(3,5)
  X = math.random(0,256)
  Y = math.random(0,256)
  --check if there is an Island at these tiles already
  DrawSpriteBlock(islandSprite,X,Y,islandLength,islandWidth,false,false,DrawMode.Sprite)
  DrawText( X+", "+Y , 100, 100, DrawMode.UI)
end


function Collide()
--- Boat and an Island are touching ---hashmap
-- for index, value in pairs(table name) do
end
