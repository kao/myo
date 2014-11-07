scriptId = 'com.kao.spotify'

-- Unlock mechanism
function unlock()
  unlocked = true
  extendUnlock()
end

function extendUnlock()
  unlockedSince = myo.getTimeMilliseconds()
end

-- Callbacks
function onPoseEdge(pose, edge)
  -- Unlock
  myo.debug('pose: ' .. pose .. ' || edge: ' .. edge)
  myo.debug('----')

  if pose == 'fist' then
    if edge == 'off' then
      unlock()
    elseif edge == 'on' and not unlocked then
      myo.vibrate('short')
      myo.vibrate('short')
      extendUnlock()
    end
  end

  if pose == 'waveIn' or pose == 'waveOut' then
    if unlocked and edge == 'on' then
      if pose == 'waveIn' then
        myo.keyboard('f8', 'press')
      else
        myo.keyboard('up_arrow', 'press')
      end

      myo.vibrate('short')
      extendUnlock()
    end
  end

  if pose == 'fingersSpread' then
    myo.keyboard('return', 'press')
  end

end


function onPeriodic()
  local foo
end

function onForegroundWindowChange(app, title)
  local wantActive = false
  activeApp = ''

  if app == 'com.spotify.music' then
    myo.debug('Spotify detected')
    wantActive = true
    activeApp = 'Spotify'
  end

  return wantActive
end

function activeAppName()
  -- Return the active app name determined in onForegroundWindowChange
  myo.debug(activeApp)
  return activeApp
end

function onActiveChange(isActive)
  if not isActive then
    unlocked = false
  end
end
