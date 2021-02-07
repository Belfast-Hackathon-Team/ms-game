local timeLeft = 1000;
local started = false;

function AddTime(time)
  timeLeft += time
end

function TickTimer(amt)
  timeLeft = timeLeft - amt
  return timeLeft
end
