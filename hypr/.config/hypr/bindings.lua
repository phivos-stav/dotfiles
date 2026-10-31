-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Universal select line: Home, then Shift+End, sent to the focused app.
-- Uses the same down/up split as Omarchy's universal clipboard bindings.
local function send_key_at(delay, mods, key, state)
  hl.timer(function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = state }))
  end, { timeout = delay, type = "oneshot" })
end

o.bind("SUPER + Z", "Universal select line", function()
  hl.dispatch(hl.dsp.send_key_state({ mods = "", key = "Home", state = "down" }))
  send_key_at(50, "", "Home", "up")
  send_key_at(100, "SHIFT", "End", "down")
  send_key_at(150, "SHIFT", "End", "up")
end)

-- Media controls on plain F5/F6/F7.
o.bind("F6", "Previous track", "omarchy-shell media previous", { locked = true })
o.bind("F7", "Play/pause", "omarchy-shell media playPause", { locked = true })
o.bind("F8", "Next track", "omarchy-shell media next", { locked = true })

-- Blackboard web app
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Blackboard", "omarchy-launch-webapp https://virtualcampus.euc.ac.cy/ultra/course")

-- GitHub web app (was: Signal)
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "GitHub", { webapp = "https://github.com/", focus = true })

-- Lutris
o.bind("SUPER + SHIFT + L", "Lutris", { launch = "lutris" })

-- Rofi launcher (was: Omarchy launcher)
hl.unbind("SUPER + SPACE")
o.bind("SUPER + SPACE", "Rofi launcher", "rofi -show drun")
