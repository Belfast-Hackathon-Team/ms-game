-- Load scripts here
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

function Update(timeDelta)
  BoatPhysics()
  AiPhysics()
  IslandPhysics()
  EggPhysics()
end

function Draw()
  RedrawDisplay()
  DrawSprite(0, Boat.X, Boat.Y, false, false, DrawMode.Sprite)
  DrawText( Boat.Direction, 100, 100, DrawMode.UI, "large", 14 )
  DrawText( Boat.IsAnchored, 100, 200, DrawMode.UI, "large", 14 )
end
