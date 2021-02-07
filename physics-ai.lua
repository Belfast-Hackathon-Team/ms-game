local DistanceFromPlayer = 0
local TargetX = 0
local TargetY = 0
local Theta = 0
local IsTargetBoat = true
local RawAngle = 0

function AiPhysics()
  if AI.IsHidden then
    AI.X = -20
    AI.Y = -20
    return
  end
  CalculateDistanceFromPlayer()
  FindTarget()
  if not CheckIslandBoundsAI() then
    CalculateAngle(true)
  end
  AiMovement()
  CheckPlayerCollison()
end

-- Requirements
-- Distance of ai from the Player
-- Player's Direction
-- player's Speed

function CheckPlayerCollison()
  if (math.abs(AI.X - Boat.X) < 10) and (math.abs(AI.Y - Boat.Y) < 10) then
    Boat.Score = Boat.Score - 1
    AI.IsHidden = true
  end
end

-- X coord of island: island[2]
-- Y coord of island: island[3]
-- Multipler of island: island[4]

AngleLock = false -- used to lock boat on a path around an island
AngleValue = -1

function CheckIslandBoundsAI() -- This is kinda lazy
  local SpriteSize = SpriteSize()
  if IslandData != nil then
    for index,island in pairs(IslandData) do
      if AI.X >= island[2] -15 and AI.X <= island[2] + SpriteSize.X*island[4] then
        if AI.Y >= island[3] -15 and AI.Y <= island[3] + SpriteSize.Y*island[4] then
          if AngleLock then
            AI.Direction = AngleValue
            return true
          end
          -- Horizontal wall collison
          if (math.abs(AI.Y - island[3]) < 5) or (math.abs(AI.Y - island[3] - SpriteSize.Y*island[4]) < 5) then
            CalculateAngle(false) -- Calculates the raw angle
            if RawAngle <= 180 then
              AI.Direction = 90
            else
              AI.Direction = 270
            end
          else
            -- Vertical wall collison
            CalculateAngle(false) -- Calculates the raw angle
            if RawAngle >= 270 or RawAngle <= 90 then
              AI.Direction = 0
            else
              AI.Direction = 180
            end
          end
          AngleValue = AI.Direction
          AngleLock = true
          return true
        end
      end
    end
  end
  if AngleLock then
    AI.Direction = AngleValue
  end
  AngleLock = false
  return false
end

function AiMovement()
  SqrtTwo = 1.41421 -- Approximate Square Root of 2
  -- Change Boat Direction of Travel
  if AI.Direction == 0 or AI.Direction == 360 then
    -- North
    AI.DeltaX = 0
    AI.DeltaY = - AI.Speed
  elseif AI.Direction == 45 then
    -- North East
    AI.DeltaX = AI.Speed / SqrtTwo
    AI.DeltaY = - AI.Speed / SqrtTwo
  elseif AI.Direction == 90 then
    -- East
    AI.DeltaX = AI.Speed
    AI.DeltaY = 0
  elseif AI.Direction == 135 then
    -- South East
    AI.DeltaX = AI.Speed / SqrtTwo
    AI.DeltaY = AI.Speed / SqrtTwo
  elseif AI.Direction == 180 then
    -- South
    AI.DeltaX = 0
    AI.DeltaY = AI.Speed
  elseif AI.Direction == 225 then
    -- South West
    AI.DeltaX = - AI.Speed / SqrtTwo
    AI.DeltaY = AI.Speed / SqrtTwo
  elseif AI.Direction == 270 then
    -- West
    AI.DeltaX = - AI.Speed
    AI.DeltaY = 0
  elseif AI.Direction == 315 then
    -- North West
    AI.DeltaX = - AI.Speed / SqrtTwo
    AI.DeltaY = - AI.Speed / SqrtTwo
  end
  AI.Y = AI.Y + AI.DeltaY
  AI.X = AI.X + AI.DeltaX
end

function Retarget()
  IsTargetBoat = true
end

local BoundaryCounter = 1

function FindTarget()
  if DistanceFromPlayer <= 70 and not Boat.IsAtIsland then
    StartBattleMusic()
    IsTargetBoat = true
    TargetX = Boat.X
    TargetY = Boat.Y
  else
    if IsTargetBoat or (math.abs(AI.X - TargetX) < 10 and math.abs(AI.Y - TargetY) < 10) then -- come back to this
      ValidCoords = false
      while not ValidCoords do
        ValidCoords = true
        if BoundaryCounter == 1 then
          TargetX = math.random(20, 112)
          TargetY = math.random(20, 100)
        elseif BoundaryCounter == 2 then
          TargetX = math.random(152, 244)
          TargetY = math.random(20, 112)
        elseif BoundaryCounter == 3 then
          TargetX = math.random(152, 244)
          TargetY = math.random(142, 234)
        elseif BoundaryCounter == 4 then
          TargetX = math.random(20, 112)
          TargetY = math.random(142, 234)
        end
        if IslandData != nil then
          local SpriteSize = SpriteSize()
          for index,island in pairs(IslandData) do
            if TargetX >= island[2] -25 and TargetX <= island[2] + SpriteSize.X*island[4] then
              if TargetY >= island[3] -25 and TargetY <= island[3] + SpriteSize.Y*island[4] then
                ValidCoords = false
              end
            end
          end
        end
      end
      if BoundaryCounter == 4 then
        BoundaryCounter = 0
      end
      BoundaryCounter = BoundaryCounter + 1
      IsTargetBoat = false
      StopBattleMusic()
    end
  end
end

function CalculateDistanceFromPlayer()
  x = AI.X - Boat.X
  y = AI.Y - Boat.Y
  x *= x
  y *= y
  DistanceFromPlayer = math.sqrt(x + y)
end

function CalculateAngle(RoundAngle)
  boatSpeedMultiplier = 5
  Speed = Boat.Speed * boatSpeedMultiplier

  x = AI.X - TargetX
  y = AI.Y - TargetY
  --x = math.abs(x)
  --y = math.abs(y)
  angle1 = math.atan(y/x)
  angle2 = math.rad(90) - angle1
  Theta = angle2

  -- if IsTargetBoat then
  --   Theta = Theta + Boat.Direction
  -- end

  Theta = Theta + (Boat.Direction * (math.pi / 180))
  temp = (DistanceFromPlayer^2) + (Speed^2) - (2 * DistanceFromPlayer * Speed * math.cos(Theta))
  temp = math.sqrt(temp)
  omega = math.asin((Speed * math.sin(Theta))/temp)

  answer = math.pi - omega - angle2
  -- answer = math.deg(answer)
  answer = answer * (180 / math.pi)
  if(x > 0) then
    answer += 180
  end

  -- rounding
  if RoundAngle then
    answer = math.floor(answer)
    mod = answer%45
    if(mod < 23) then
      answer = answer - mod
    else
      answer = answer + 45 - mod
    end
    AI.Direction = answer
  else
    RawAngle = answer
  end
end
