-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Desk layout, left to right: Samsung, Lenovo, laptop.
-- Externals are matched by description because their DP-N names change between docks.
hl.monitor({ output = "desc:Lenovo Group Limited LEN T27i-10 V5MY5537", mode = "1920x1080@60", position = "3970x120", scale = 1 })
hl.monitor({ output = "desc:Samsung Electric Company Odyssey G5 HK2Y404787", mode = "2560x1440@59.95", position = "1922x-63", scale = 1.25 })

-- Laptop panel: on by default, off when two external monitors are connected.
local LAPTOP = "eDP-1"

local function external_count(ignore)
  local n = 0
  for _, m in ipairs(hl.get_monitors()) do
    if m.name ~= LAPTOP and m.name ~= ignore then
      n = n + 1
    end
  end
  return n
end

local function update_laptop(ignore)
  hl.monitor({
    output = LAPTOP,
    mode = "preferred",
    position = "5890x0",
    scale = 1.25,
    disabled = external_count(ignore) >= 2,
  })
end

update_laptop() -- applies on startup and on every config reload

hl.on("hyprland.start", function() update_laptop() end)

hl.on("monitor.added", function(m)
  if m.name ~= LAPTOP then update_laptop() end
end)

hl.on("monitor.removed", function(m)
  if m.name ~= LAPTOP then update_laptop(m.name) end
end)

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })