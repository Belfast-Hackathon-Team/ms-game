function ControlMusic()

end

local normalPlaying = false
local battlePlaying = false
local fasterPlaying = false

function PlayNormal()
  if not (normalPlaying) then
    PauseMusic()
    PlaySong( 0, true )
    normalPlaying = true
  end
end

function PlayBattle()
  if not (battlePlaying) then
    PauseMusic()
    PlaySong( 2, true )
    battlePlaying = true
  end
end

function PlayFaster()
  if not (fasterPlaying) then
    PauseMusic()
    PlaySong( 1, true )
    fasterPlaying = true
  end
end

function PauseMusic()
  PauseSong()
  normalPlaying = false
  battlePlaying = false
  fasterPlaying = false
end

function AnchorSound()
  PlaySound(6)
end
