-- Load sprites here

-- Load scenes here
Boat = {
---properties of a Raft
  Height = 0, --- check against pixel art
  Width = 0, -- check against pixel art
  Speed = 0.1,
  MaxSpeed = 1.5,
  MinSpeed = 0.1,

  X = 100,
  Y = 50,
  DeltaX = 0,
  DeltaY = 0,
  Direction = 0 -- 0 == North, 90 == East, 180 == South, 270 == West#

}

-- makeshift inheritance
-- Raft = {
--   Raft.Height = Boat.Height
-- }

Player = {
  X = 100,
  Y = 50,
  DeltaX = 0,
  DeltaY = 0,
  Direction = 0 -- 0 == North, 90 == East, 180 == South, 270 == West
}

ListOfActiveIslands = {}

function Init()
  BackgroundColor( 2 )
end

function CheckConstantVelocity()
  --
  return Boat.Weight
end

function CheckMapBounds()
  local MapSize = TilemapSize()
  local SpriteSize = SpriteSize()

  if Boat.X + SpriteSize.X > MapSize.x then
    -- Boat has went right of the map
    Boat.X = 0
    RefreshMap()
  elseif Boat.X < 0 then
    -- Boat has went left of the map
    Boat.X = MapSize.X - SpriteSize.X
    RefreshMap()
  elseif Boat.Y + (SpriteSize.Y * 2) + 8 > MapSize.Y then
    -- Boat has went below map
    Boat.Y = 0
    RefreshMap()
  elseif Boat.Y < 0 then
    -- Boat above map
    Boat.Y = MapSize.Y - (SpriteSize.Y * 2) - 8
    RefreshMap()
  end
end

function RefreshMap()
   BackgroundColor(2)
end

function ChangeDirection(DirectionalChange)
  Boat.Direction = Boat.Direction + DirectionalChange
  if Boat.Direction == 360 then
    Boat.Direction = 0
  end
  if Boat.Direction < 0 then
    Boat.Direction = 315
  end

  -- Change Sprite for direction
  if Boat.Direction == 0 then
    -- North
  elseif Boat.Direction == 45 then
    -- North East
  elseif Boat.Direction == 90 then
    -- East
  elseif Boat.Direction == 135 then
    -- South East
  elseif Boat.Direction == 180 then
    -- South
  elseif Boat.Direction == 225 then
    -- South West
  elseif Boat.Direction == 270 then
    -- West
  elseif Boat.Direction == 315 then
    -- North West
  end

end

local KeysPressed = {}

function HasValue(table, val)
  for _,Keys in pairs(table) do
    if Keys == val then
      return true
    end
  end
end

function Insert(table, val)
  local index = 0
  for k,_ in pairs(table) do
    index = index + 1
  end
  table[index+1] = val
end

function Remove(table, val)
  for index,v in pairs(table) do
    if v == val then
      table[index] = nil
    end
  end
end

function BoatMovement()
  Boat.DeltaX = Boat.Speed
  Boat.DeltaY = Boat.Speed

  --[[
  we can either move    N,            NE,         E,        SE,          S,         SW,                 W,          NW
  we can either move (0, -1), (0.707, -0.707), (1, 0), (0.707, 0.707), (0,1), (-0.707,0.707),         (-1,0),      (-0.707, -0.707)
  ]]
  SqrtTwo = 1.41421 -- Approximate Square Root of 2
  -- Change Boat Direction of Travel
  if Boat.Direction == 0 then
    -- North
    Boat.DeltaX = 0
    Boat.DeltaY = - Boat.Speed
  elseif Boat.Direction == 45 then
    -- North East
    Boat.DeltaX = Boat.Speed / SqrtTwo
    Boat.DeltaY = - Boat.Speed / SqrtTwo
  elseif Boat.Direction == 90 then
    -- East
    Boat.DeltaX = Boat.Speed
    Boat.DeltaY = 0
  elseif Boat.Direction == 135 then
    -- South East
    Boat.DeltaX = Boat.Speed / SqrtTwo
    Boat.DeltaY = Boat.Speed / SqrtTwo
  elseif Boat.Direction == 180 then
    -- South
    Boat.DeltaX = 0
    Boat.DeltaY = Boat.Speed
  elseif Boat.Direction == 225 then
    -- South West
    Boat.DeltaX = - Boat.Speed / SqrtTwo
    Boat.DeltaY = Boat.Speed / SqrtTwo
  elseif Boat.Direction == 270 then
    -- West
    Boat.DeltaX = - Boat.Speed
    Boat.DeltaY = 0
  elseif Boat.Direction == 315 then
    -- North West
    Boat.DeltaX = - Boat.Speed / SqrtTwo
    Boat.DeltaY = - Boat.Speed / SqrtTwo
  end

  --buttons down
  if Button( Buttons.Right, InputState.Down, 0 ) then
    if not HasValue(KeysPressed, "right") then
      Insert(KeysPressed, "right")
      ChangeDirection(45)
    end
  end
  if Button( Buttons.Left, InputState.Down, 0 ) then
    if not HasValue(KeysPressed, "left") then
      Insert(KeysPressed, "left")
      ChangeDirection(-45)
    end
  end



  if Button(Buttons.Up, InputState.Down, 0) then
    if Boat.Speed < Boat.MaxSpeed then
      Boat.Speed = Boat.Speed + 0.01
    end
  end

  if Button(Buttons.Down, InputState.Down, 0) then
    if Boat.Speed > Boat.MinSpeed then
      Boat.Speed = Boat.Speed - 0.01
    end
  end

  -- buttons up
  if Button( Buttons.Right, InputState.Released, 0 ) then
    Remove(KeysPressed, "right")
  end
  if Button( Buttons.Left, InputState.Released, 0 ) then
    Remove(KeysPressed, "left")
  end

  Boat.Y = Boat.Y + Boat.DeltaY
  Boat.X = Boat.X + Boat.DeltaX
end

function Update(timeDelta)
  BoatMovement()
  CheckMapBounds()
end

function Draw()
  RedrawDisplay()
  DrawSprite(0, Boat.X, Boat.Y, false, false, DrawMode.Sprite)
  DrawText( Boat.Direction, 100, 100, DrawMode.UI, "large", 14 )
end

--function CheckIfIslandExists(XRange, YRange)
  --for x,y in XRange, YRange do
--end

function SpawnIsland()
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

function Collide()
--- Boat and an Island are touching
-- for index, value in pairs(table name) do
end
