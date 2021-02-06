-- Load scripts here
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

function Init()
  BackgroundColor( 2 )
end

function Update(timeDelta)
  BoatPhysics()
  AiPhysics()
  DrawIslands()
  EggPhysics()
end

function Draw()
  RedrawDisplay()
  DrawSprite(0, Boat.X, Boat.Y, false, false, DrawMode.Sprite)
  DrawSprite(1, AI.X, AI.Y, false, false, DrawMode.Sprite)
  DrawText( Boat.Direction, 100, 100, DrawMode.UI, "large", 14 )
  DrawText( AI.Direction, 100, 200, DrawMode.UI, "large", 14 )
end
