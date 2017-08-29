local key = hs.keycodes.map

local sands = require('sands')
sands.modifiers[key.space] = {shift = true}
sands.enable()


local oneshot = require('oneshot')
oneshot.modifiers[key.rightcmd] = key.kana
oneshot.modifiers[key.cmd] = key.eisu
oneshot.enable()
