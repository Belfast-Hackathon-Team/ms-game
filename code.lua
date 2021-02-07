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
local TimeLeft = 6000

function Init()
  BackgroundColor( 2 )
  PlayNormal()
end

function Update(timeDelta)
  BoatPhysics()
  AiPhysics()
  EggPhysics()
  TimeLeft = TickTimer(1.3)
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
  RedrawDisplay()
  DrawSprite(1, AI.X, AI.Y, false, false, DrawMode.Sprite)
  DrawText( AI.Direction, 100, 200, DrawMode.UI, "large", 15 )
  DrawCompass()
  DrawIslands()
  ChangeBoatSprite()
  DrawScore()
  DrawText( string.format("Time: %.0f", (TimeLeft / 100)), 210, 0, DrawMode.UI, "medium", 15, -3 )
end
