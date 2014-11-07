scriptId = 'com.kao.2048'

app = 'com.google.Chrome'
title = '2048'

function activeAppName()
  return activeApp
end

function onForegroundWindowChange(app, title)
  local wantActive = false
  activeApp = ''
  if app == 'com.google.Chrome' and title == '2048' then
    myo.debug 'Game 2048 detected!'
    wantActive = true
    activeApp = 'Chrome'
  end

  return wantActive
  -- return true
end

MOVE_TIMEOUT = 750
sinceLastMove = 0

function onPeriodic()
  local now = myo.getTimeMilliseconds()

  if (now - sinceLastMove) > MOVE_TIMEOUT then
    local y = myo.getPitch()
    myo.debug('y:' .. y)

    if y < -0.25 then
      myo.debug('down!')
      myo.keyboard('down_arrow', 'press')
    elseif y > 0.25 then
      myo.debug('up!')
      myo.keyboard('up_arrow', 'press')
    end
    sinceLastMove = now
  end

end

function onPoseEdge(pose, edge)
  if (pose == 'waveOut') then
    myo.debug('right')
    myo.keyboard('right_arrow', 'press')
  elseif (pose == 'waveIn') then
    myo.debug('left')
    myo.keyboard('left_arrow', 'press')
  end
end

