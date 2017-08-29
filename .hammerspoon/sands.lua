local sands = {}
sands.modifiers = {}
sands.active = nil
sands.consumed = false
sands.releasing = false

sands.handles = {
  hs.eventtap.event.types.keyDown,
  hs.eventtap.event.types.keyUp
}

sands.handler = function(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  local mod = sands.modifiers[c]
  if mod then
    if event:getType() == hs.eventtap.event.types.keyDown then
      if sands.releasing then
        sands.releasing = false
      elseif sands.active then
        sands.consumed = true
      else
        sands.active = mod
        sands.consumed = false
        sands.releasing = false
        event:setKeyCode(-1)
      end
    elseif event:getType() == hs.eventtap.event.types.keyUp then
      if not sands.consumed then
        sands.releasing = true
        hs.eventtap.event.newKeyEvent(f, c, true):post()
      end
      sands.active = nil
    end
  elseif sands.active then
    for k, v in pairs(sands.active) do
      f[k] = v
    end
    event:setFlags(f)
    sands.consumed = true
  end
end

sands.eventtap = hs.eventtap.new(sands.handles, sands.handler)

sands.enable = function()
  sands.eventtap:start()
end

sands.disable = function()
  sands.eventtap:stop()
end


return sands
