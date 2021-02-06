function BoatPhysics()
  BoatMovement()
  CheckMapBounds()
  CheckIslandBounds()
end

function CheckIslandBounds()
  --IslandData {spriteid, x, y}
  -- 16X16 island
  DrawText( Boat.IsAtIsland, 100, 50, DrawMode.UI, "large", 14)
  Boat.IsAtIsland = false
  if IslandData != nil then
    for index,island in pairs(IslandData) do
      if Boat.X < island[2] + 16 and Boat.X > island[2] - 5 then
        if Boat.Y < island[3] + 16 and Boat.Y > island[3] - 5 then
          Boat.IsAtIsland = true
        end
      end
    end
  end
end

function RefreshMap()
  IslandData = nil
  DrawIslands()
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

function HasValue(table, valueToCheck)
  if table[valueToCheck] == true then
    return true
  end
end

function Insert(table, valueToInsert)
  table[valueToInsert] = true
end

function Remove(table, valueToRemove)
  table[valueToRemove] = false
end

function BoatMovement()
  Boat.DeltaX = Boat.Speed
  Boat.DeltaY = Boat.Speed

  if Button(Buttons.B, InputState.Down, 0) and Boat.Speed > 0 and Boat.Speed <= Boat.MinSpeed + 0.1 then
    Boat.IsAnchored = true
    Boat.Speed = 0
  end

  if Boat.Speed > 0 then
    Boat.IsAnchored = false
  end

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
