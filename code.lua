-- Load sprites here

-- Load scenes here

Player = {
  X = 100,
  Y = 50,
  DeltaX = 0,
  DeltaY = 0,
}

function Init()
  BackgroundColor( 2 )
end

function PlayerMovement()
  Player.DeltaX *= 0.9
  Player.DeltaY *= 0.9
  if Button( Buttons.Up, InputState.Down, 0 ) then
    Player.DeltaY = -1
  end
  if Button( Buttons.Down, InputState.Down, 0 ) then
    Player.DeltaY = 1
  end
  if Button( Buttons.Right, InputState.Down, 0 ) then
    Player.DeltaX = 1
  end
  if Button( Buttons.Left, InputState.Down, 0 ) then
    Player.DeltaX = -1
  end
  Player.Y = Player.Y + Player.DeltaY
  Player.X = Player.X + Player.DeltaX
end

function Update(timeDelta)
  PlayerMovement()
end

function Draw()
  RedrawDisplay()
  DrawSprite(0, Player.X, Player.Y, false, false, DrawMode.Sprite)
end
