-- Eggsplorers
-- Load scripts here
LoadScript("music")
LoadScript("timer")
LoadScript("physics-boat")
LoadScript("physics-island")
LoadScript("physics-egg")
LoadScript("physics-ai")
-- Load scenes here

Boat = {
---properties of a Raft
  Height = 0, --- check against pixel art
  Width = 0, -- check against pixel art
  Speed = 0.1,
  MaxSpeed = 1.5,
  MinSpeed = 0.1,
  IsAnchored = false,
  IsAtIsland = false,
  IsBoat = true,

  X = 100,
  Y = 50,
  DeltaX = 0,
  DeltaY = 0,
  Direction = 0, -- 0 == North, 90 == East, 180 == South, 270 == West#
  Score = 0,

}

AI = {
  --QuadgrantBoundaries = {{{10, 122}, {10, 110}}, {{142, 254}, {10, 110}}, { {142, 254}, {10, 110} }, { {10, 122}, {142, 254} } }
  --SpawnQuadrant = math.random(1, 4) -- 1 representing the top left of the map going clockwise
  X = 40, --math.random(QuadgrantBoundaries[SpawnQuadrant][1][1], QuadgrantBoundaries[SpawnQuadrant][1][2]),
  Y = 220, --math.random(QuadgrantBoundaries[SpawnQuadrant][2][1], QuadgrantBoundaries[SpawnQuadrant][2][2]),
  Speed = Boat.MaxSpeed * 0.5,
  DeltaX = 0,
  DeltaY = 0,
  Direction = 0, -- 0 == North, 90 == East, 180 == South, 270 == West#
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
  Direction = 0, -- 0 == North, 90 == East, 180 == South, 270 == West
}

ListOfActiveIslands = {}
local TimeLeft = 1
GameStarted = false
GameFinished = false
local TimeLeft = 6000
GameStarted = false
GameFinished = false

function Init()
  BackgroundColor( 2 )
  PlayWellerman()
  GameStarted = false
  GameFinished = false
end

function Update(timeDelta)
  if not (GameStarted) and not (GameFinished) then
    StartScreen()
    return
  elseif (GameFinished) then
    EndScreen()
    return
  end
  BoatPhysics()
  AiPhysics()
  EggPhysics()
  CheckTime()
end

function CheckTime()
  if(TimeLeft > 0) then
    TimeLeft = TickTimer(1.3)
    if(TimeLeft <= 15) then
      PlayFaster()
    end
    PlayNormal()
  else
    GameFinished = true
  end
end

function DrawCompass()
  MapSize = TilemapSize()
  DrawText( "N", (MapSize.x/2)-10, 10, DrawMode.UI, "large", 1 )
  DrawText( "S", (MapSize.x/2)-10, MapSize.Y*0.88, DrawMode.UI, "large", 1 )
  DrawText( "W", MapSize.x + 15, (MapSize.Y/2)-10, DrawMode.UI, "large", 1 )
  DrawText( "E", MapSize.x * 0.95, (MapSize.Y/2)-10, DrawMode.UI, "large", 1 )
end

function DrawScore()
  DrawText("Egg Basket: "..Boat.Score,6, 0, DrawMode.UI, "medium", 15,-3)
end

function Draw()
  if not (GameStarted) and not (GameFinished) then
    DrawStartScreen()
    return
  elseif (GameFinished) then
    DrawEndScreen()
    return
  end
  RedrawDisplay()
  DrawSpriteBlock(32,AI.X,AI.Y,2,2,false,false,DrawMode.Sprite,0,true,false)
  DrawText( AI.Direction, 100, 200, DrawMode.UI, "large", 15 )
  DrawCompass()
  DrawIslands()
  ChangeBoatSprite()
  DrawScore()
  DrawText( string.format("Time: %.0f", (TimeLeft / 100)), 210, 0, DrawMode.UI, "medium", 15, -3 )
end

function StartScreen()
  if Button(Buttons.B, InputState.Down, 0) then
    GameStarted = true
  end
end

function DrawStartScreen()
  DrawText("Press B To Start", 60, 450, DrawMode.UI, "large", 1)
  DrawText("Welcome to Eggsplorers!", 40, 30, DrawMode.UI, "large",1)
  DrawText("Controls: ", 90, 50, DrawMode.UI, "large", 1)
  DrawText("Up    ->  Accelerate", 45, 70, DrawMode.UI, "medium", 1)
  DrawText("Down  ->  Deccelerate", 45, 80, DrawMode.UI, "medium", 1)
  DrawText("Right ->  Turn right", 45, 90, DrawMode.UI, "medium", 1)
  DrawText("Left  ->  Turn left", 45, 100, DrawMode.UI, "medium", 1)
  DrawText("B     ->  Drop anchor", 45, 110, DrawMode.UI, "medium", 1)
  DrawText("Help as many of your brethren eggscape", 10, 130, DrawMode.UI, "medium", 1, -2)
  DrawText("as possible in 60 seconds. Sail around", 10, 140, DrawMode.UI, "medium", 1, -2)
  DrawText("the islands to find them!", 50, 150, DrawMode.UI, "medium", 1, -2)
  DrawText("P.S: Watch out for the Kraken!", 40, 170, DrawMode.UI, "medium", 1, -2)
end

function EndScreen(victory)
  if Button(Buttons.B, InputState.Down, 0) then
    -- TODO: end screen functions
  end
  EndGameSound(victory)
end

function  DrawEndScreen()
  local y = 30
  local x = 0
  RedrawDisplay()
  DrawText("Game Over!", 90, 20, DrawMode.UI, "large", 1)
  for i=0,Boat.Score-1,1 do
    if (i % 10 == 0) then
      y= y + 10
      x = 0
    end
    DrawSprite(0, ((x*10)+70), y, false, false, DrawMode.Sprite)
    x = x + 1
  end
  DrawText(string.format("You helped %d eggs escape",Boat.Score), 30, y+20, DrawMode.UI, "large", 1)
end
