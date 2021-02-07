timeLeft = 6000;
started = false;

function AddTime(time)
  timeLeft += time
end

function TickTimer(amt)
  if(timeLeft - amt <= 0) then
    return 0
  end
  timeLeft = timeLeft - amt
  return timeLeft
end
