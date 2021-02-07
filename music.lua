local normalPlaying = false
local battlePlaying = false
local fasterPlaying = false
local endPlaying = false

local fxPlaying = false

normalPlace = 0
battlePlace = 0
fasterPlace = 0

function StartBattleMusic()
  if not (battlePlaying) then
    if (normalPlaying) then
      normalPlace = SongData().pattern
    elseif (fasterPlaying) then
      fasterPlace = SongData().pattern
    end
    PlaySong(2, true, battlePlace)
    battlePlaying = true
  end
end

function StopBattleMusic()
  if(battlePlaying) then
    battlePlace = SongData().pattern
    StopSong()
    if(normalPlaying) then
      PlaySong( 0, true, normalPlace )
      fasterPlaying = false
    elseif (fasterPlaying) then
      PlaySong( 1, true, fasterPlace )
      normalPlaying = false
    end
    battlePlaying = false
  end
end

function PlayNormal()
  if not (normalPlaying) then
    StopSong()
    PlaySong( 0, true )
    normalPlaying = true
    fasterPlaying = false
  end
end

function PlayFaster()
  if not (fasterPlaying) then
    StopSong()
    PlaySong( 1, true )
    fasterPlaying = true
    normalPlaying = false
  end
end

function PlayWellerman()
  StopSong()
  PlaySong(3, true)
end

function EndGameSound(victory)
  if not (endPlaying) then
    StopSong()
    endPlaying = true
    if(victory) then
      PlaySong(4, false)
    else
      PlaySong(5, false)
    end
  end
end

function AnchorSound()
  PlaySound(6, 1)
end

function HopSound()
  if not (fxPlaying) then
    fxPlaying = true
    PlaySound(5, 1)
  end
end

function StopHopSound()
  fxPlaying = false
end
