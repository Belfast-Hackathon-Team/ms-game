-- Load scripts here
LoadScript("music")
LoadScript("timer")
LoadScript("physics-boat")
LoadScript("physics-island")
LoadScript("physics-egg")
LoadScript("physics-ai")
--LoadScript("boat-cannon")
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

  X = 100,
  Y = 50,
  DeltaX = 0,
  DeltaY = 0,
  Direction = 0 -- 0 == North, 90 == East, 180 == South, 270 == West#

}

AI = {
  --QuadgrantBoundaries = {{{10, 122}, {10, 110}}, {{142, 254}, {10, 110}}, { {142, 254}, {10, 110} }, { {10, 122}, {142, 254} } }
  --SpawnQuadrant = math.random(1, 4) -- 1 representing the top left of the map going clockwise
  X = 40, --math.random(QuadgrantBoundaries[SpawnQuadrant][1][1], QuadgrantBoundaries[SpawnQuadrant][1][2]),
  Y = 220, --math.random(QuadgrantBoundaries[SpawnQuadrant][2][1], QuadgrantBoundaries[SpawnQuadrant][2][2]),
  Speed = Boat.MaxSpeed * 0.5,
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
local TimeLeft = 0

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
  DrawText( "N", (MapSize.x/2)-10, 10, DrawMode.UI, "large", 14 )
  DrawText( "S", (MapSize.x/2)-10, MapSize.Y*0.88, DrawMode.UI, "large", 14 )
  DrawText( "W", MapSize.x + 15, (MapSize.Y/2)-10, DrawMode.UI, "large", 14 )
  DrawText( "E", MapSize.x * 0.95, (MapSize.Y/2)-10, DrawMode.UI, "large", 14 )
end

function DrawBoatPos()
  DrawText( "Pos X: "..math.floor(Boat.X), MapSize.x*0.01, MapSize.y*0.01, DrawMode.UI, "small", 14 )
  DrawText( "Pos Y: "..math.floor(Boat.Y), MapSize.x*0.01, MapSize.y*0.04, DrawMode.UI, "small", 14 )
end

function Draw()
  RedrawDisplay()
  DrawSprite(1, AI.X, AI.Y, false, false, DrawMode.Sprite)
  DrawText( Boat.Direction, 100, 100, DrawMode.UI, "large", 14 )
  DrawText( AI.Direction, 100, 200, DrawMode.UI, "large", 14 )
  DrawCompass()
  DrawIslands()
  ChangeBoatSprite()
  DrawBoatPos()
  DrawText( string.format("Time: %.0f", (TimeLeft / 100)), 25, 50, DrawMode.UI, "large", 14 )
end
