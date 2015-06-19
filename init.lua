local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local grid = require "mjolnir.bg.grid"
local screens = require "mjolnir.screen"
local alert = require "mjolnir.alert"
local hints = require "mjolnir.th.hints"

grid.GRIDHEIGHT = 4
grid.GRIDWIDTH = 4

positions = {
  top        = { x=0, y=0, w=grid.GRIDWIDTH, h=(grid.GRIDHEIGHT/2) },
  btm        = { x=0, y=2, w=grid.GRIDWIDTH, h=(grid.GRIDHEIGHT/2) },
  left       = { x=0, y=0, w=(grid.GRIDWIDTH/2), h=grid.GRIDHEIGHT },
  right      = { x=(grid.GRIDWIDTH/2), y=0, w=(grid.GRIDWIDTH/2), h=grid.GRIDHEIGHT },

  top_left   = { x=0, y=0, w=2, h=2 },
  top_right  = { x=2, y=0, w=2, h=2 },
  btm_left   = { x=0, y=2, w=2, h=2 },
  btm_right  = { x=2, y=2, w=2, h=2 },

  fullscreen = {x=0, y=0, w=4, h=4}
}


pos_bindings = {
  ['top_left']   = { wo_num='1', with_num='pad7' },
  ['top_right']  = { wo_num='2', with_num='pad9' },
  ['btm_left']   = { wo_num='3', with_num='pad1' },
  ['btm_right']  = { wo_num='4', with_num='pad3' },
  ['top']        = { wo_num='up', with_num='pad8' },
  ['btm']        = { wo_num='down', with_num='pad2' },
  ['left']       = { wo_num='left', with_num='pad4' },
  ['right']      = { wo_num='right', with_num='pad6' },
  ['fullscreen'] = { wo_num='f', with_num='pad5' }
}

function pos_window(position)
  local win = window.focusedwindow()
  grid.set(win, position, win:screen())
end

for pos,bindings in pairs(pos_bindings) do
  hotkey.bind({ "alt", "shift" }, bindings.wo_num, function() pos_window(positions[pos]) end)
  hotkey.bind({ "cmd" }, bindings.with_num, function() pos_window(positions[pos]) end)
end

hotkey.bind({ "cmd" }, "e", hints.windowHints)

hotkey.bind({ "alt", "shift" }, "]", grid.pushwindow_nextscreen)
hotkey.bind({ "alt", "shift" }, "[", grid.pushwindow_prevscreen)