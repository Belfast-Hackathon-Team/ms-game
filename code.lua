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
  X = 200,
  Y = 100,
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
  EggPhysics()
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

end
