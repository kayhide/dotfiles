local oneshot = {}
oneshot.modifiers = {}
oneshot.active = nil
oneshot.pressed = {}

oneshot.handles = {
  hs.eventtap.event.types.keyDown,
  hs.eventtap.event.types.flagsChanged
}

oneshot.handler = function(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  local mod = oneshot.modifiers[c]
  if mod then
    oneshot.pressed[c] = not oneshot.pressed[c]
    if oneshot.active == c then
      hs.eventtap.event.newKeyEvent(f, mod, true):post()
      oneshot.active = nil
    else
      oneshot.active = oneshot.pressed[c] and c or nil
    end
  elseif oneshot.active then
    oneshot.active = nil
  end
end

oneshot.eventtap = hs.eventtap.new(oneshot.handles, oneshot.handler)

oneshot.enable = function()
  oneshot.eventtap:start()
end

oneshot.disable = function()
  oneshot.eventtap:stop()
end


return oneshot
