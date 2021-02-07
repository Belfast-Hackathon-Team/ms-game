-- Physics for the Player when they are on land as an egg
function EggPhysics()
  EggMovement()
end


function EggMovement()
  if not Boat.IsBoat then
    if Button(Buttons.Up, InputState.Down, 0) then
      Boat.Y = Boat.Y -1
      Boat.Direction = 0
    end

    if Button(Buttons.Down, InputState.Down, 0) then
      Boat.Y = Boat.Y + 1
      Boat.Direction = 180
    end

    if Button(Buttons.Left, InputState.Down, 0) then
      Boat.X = Boat.X -1
      Boat.Direction = 270
    end

    if Button(Buttons.Right, InputState.Down, 0) then
      Boat.X = Boat.X + 1
      Boat.Direction = 90
    end
  end
end
