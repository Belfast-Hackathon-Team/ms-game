function BoatPhysics()
  CheckIslandBounds()
  CheckEggBounds()
  BoatMovement()
  CheckMapBounds()
end

local forbidden = "none"
local MapSize = TilemapSize()
local SpriteSize = SpriteSize()

function CheckIslandBounds()
  if #IslandData > 0 then
    for index,island in pairs(IslandData) do
      if Boat.X >= island[2] -5 and Boat.X <= island[2] + SpriteSize.X*island[4] and Boat.Y >= island[3] -5 and Boat.Y <= island[3] + SpriteSize.Y*island[4] then
        Boat.IsAtIsland = true
        break
      else
        Boat.IsAtIsland = false
      end
    end
  end
end

function CheckEggBounds()
  for index,island in pairs(IslandData) do
    if (math.abs(Boat.X - island[6]) < 10) and (math.abs(Boat.Y - island[7]) < 10 ) and not island[5] then
      Boat.Score = Boat.Score + 1
      island[5] = true
      CollectEggSound()
      break
    end
  end
end

function ChangeBoatSprite()
  if Boat.IsAtIsland then
    DrawSpriteBlock(34,Boat.X,Boat.Y,2,2,false,false,DrawMode.Sprite,0,true,false)
    Boat.IsBoat = false --makes them an egg
    Boat.Speed = 0.5
    HopSound()
  else
    Boat.IsBoat = true
    StopHopSound()
    -- Change Sprite for direction
    if Boat.Direction == 0 then
      DrawSpriteBlock(128,Boat.X,Boat.Y,1,2,false,false,DrawMode.Sprite,0,true,false)
    elseif Boat.Direction == 45 then
      DrawSpriteBlock(226,Boat.X,Boat.Y,2,2,false,false,DrawMode.Sprite,0,true,false)
    elseif Boat.Direction == 90 then
      DrawSpriteBlock(64,Boat.X,Boat.Y,2,1,false,false,DrawMode.Sprite,0,true,false)
    elseif Boat.Direction == 135 then
      DrawSpriteBlock(194,Boat.X,Boat.Y,2,2,false,false,DrawMode.Sprite,0,true,false)
    elseif Boat.Direction == 180 then
      DrawSpriteBlock(129,Boat.X,Boat.Y,1,2,false,false,DrawMode.Sprite,0,true,false)
    elseif Boat.Direction == 225 then
      DrawSpriteBlock(192,Boat.X,Boat.Y,2,2,false,false,DrawMode.Sprite,0,true,false)
    elseif Boat.Direction == 270 then
      DrawSpriteBlock(112,Boat.X,Boat.Y,2,1,false,false,DrawMode.Sprite,0,true,false)
    elseif Boat.Direction == 315 then
      DrawSpriteBlock(224,Boat.X,Boat.Y,2,2,false,false,DrawMode.Sprite,0,true,false)
    end
  end
end

function RefreshMap()
  IslandData = GenerateIslands()
  DrawIslands()
  Retarget() -- Retargets the AI boat
  DrawText("P.S!", 40, 40, DrawMode.UI, "medium", math.random(1,10), -2)
  AI.X = math.random(30,150)
  AI.Y = math.random(30,150)
  if #IslandData >0 then
    for index,island in pairs(IslandData) do
      if AI.X >= island[2] -5 and AI.X <= island[2] + SpriteSize.X*island[4] and AI.Y >= island[3] -5 and AI.Y <= island[3] + SpriteSize.Y*island[4] then
        AI.X = AI.X + math.random(-10,10)
        AI.Y = AI.Y + math.random(-10,10)
      end
    end
  end
end

function CheckMapBounds()
  if (Boat.X + SpriteSize.X > MapSize.x) and not (forbidden == "right") then
    -- Boat has went right of the map
    forbidden = "left"
    Boat.X = 0
    RefreshMap()
  elseif Boat.X < 0 and not (forbidden == "left") then
    -- Boat has went left of the map
    forbidden = "right"
    Boat.X = MapSize.X - SpriteSize.X
    RefreshMap()
  elseif (Boat.Y + (SpriteSize.Y * 2) + 8 > MapSize.Y) and not (forbidden == "down") then
    -- Boat has went below map
    forbidden = "up"
    Boat.Y = 0
    RefreshMap()
  elseif Boat.Y < 0 and not (forbidden == "up") then
    -- Boat above map
    forbidden = "down"
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
  if Boat.IsBoat then
    Boat.DeltaX = Boat.Speed
    Boat.DeltaY = Boat.Speed

    if Button(Buttons.B, InputState.Down, 0) and Boat.Speed > 0 and Boat.Speed <= Boat.MinSpeed + 0.1 then
      Boat.IsAnchored = true
      Boat.Speed = 0
    end

    if Boat.Speed > 0 then
      Boat.IsAnchored = false
    end

    -- Stops you going back to where you came from
    if(Boat.X > MapSize.x) and (forbidden == "right") then
      ChangeDirection(-45)
    elseif (Boat.X < 0) and (forbidden == "left") then
      ChangeDirection(-45)
    elseif (Boat.Y + (SpriteSize.Y * 2) + 8 > MapSize.Y) and (forbidden == "down")  then
      ChangeDirection(-45)
    elseif (Boat.Y < 0) and (forbidden == "up") then
      ChangeDirection(-45)
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
end
