function AiPhysics()
  CalculateDistanceFromPlayer()
  FindTarget()
  CalculateAngle()
  AiMovement()
end

-- Requirements
-- Distance of ai from the Player
-- Player's Direction
-- player's Speed
--

local DistanceFromPlayer = 0
local TargetX = 0
local TargetY = 0
local Theta = 0
local IsTargetBoat = true

function AiMovement()
  SqrtTwo = 1.41421 -- Approximate Square Root of 2
  -- Change Boat Direction of Travel
  if AI.Direction == 0 then
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

local BoundaryCounter = 1

function FindTarget()
  if DistanceFromPlayer <= 70 then
    StartBattleMusic()
    IsTargetBoat = true
    TargetX = Boat.X
    TargetY = Boat.Y
  else
    if IsTargetBoat or (math.abs(AI.X - TargetX) < 10 and math.abs(AI.Y - TargetY) < 10) then -- come back to this
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

function CalculateAngle()
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
  answer = math.floor(answer)
  mod = answer%45
  if(mod < 23) then
    answer = answer - mod
  else
    answer = answer + 45 - mod
  end
  AI.Direction = answer
end
