local wezterm = require("wezterm")

local os = require("os")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end


wezterm.on("trigger-vim-with-scrollback", function(window, pane)
  -- Retrieve the current viewport's text.
  -- Pass an optional number of lines (eg: 2000) to retrieve
  -- that number of lines starting from the bottom of the viewport
  local scrollback = pane:get_lines_as_text()

  -- Create a temporary file to pass to vim
  local name = os.tmpname()
  local f = io.open(name, "w+")
  if f ~= nil then
    f:write(scrollback)
    f:flush()
    f:close()
  end

  -- Open a new window running vim and tell it to open the file
  window:perform_action(
    wezterm.action({ SpawnCommandInNewTab = {
      args = { "nvim", name },
    } }),
    pane
  )
end)

wezterm.on('trigger-execute-bottom', function(window, pane)
  window:perform_action(wezterm.action.ActivatePaneDirection("Down"), pane)

  local active_pane = window:active_pane()
  -- CTRL + P and enter
  active_pane:send_text("\x10")
  active_pane:send_text("\x0D")

  window:perform_action(wezterm.action.ActivatePaneDirection("Up"), pane)
end)

local keys = {
  -- tmux like bindings
  {
    key = "%",
    mods = "LEADER|SHIFT",
    action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
  },
  { key = '"', mods = "LEADER|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "t", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
  { key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
  { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
  { key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
  { key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
  { key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
  { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
  { key = "b", mods = "LEADER", action = wezterm.action({ SendString = "\x02" }) },
  { key = "e", mods = "LEADER", action = wezterm.action({ EmitEvent = "trigger-vim-with-scrollback" }) },
  { key = 'i', mods = 'LEADER', action = wezterm.action.EmitEvent('trigger-execute-bottom'), },
}

for i = 1, 9 do
  local tabkey = { key = tostring(i), mods = "LEADER", action = wezterm.action({ ActivateTab = (i - 1) }) }
  table.insert(keys, tabkey)
end

table.insert(keys, { key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ResetFontSize});

config.use_fancy_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0}
config.freetype_load_target = "HorizontalLcd"
--color_scheme = "Catppuccin Mocha",
config.adjust_window_size_when_changing_font_size = false
config.font = wezterm.font_with_fallback({
  --"Liveoverfont",
  --"VictorMono NF",
  "JetBrains Mono Nerd Font",
  --"Operator Mono Medium",
  --"Iosevka Nerd Font",
  --"Comic Mono",
  --"scientifica",
  --"M PLUS Code Latin 60",
  --{"VictorMono Nerd Font Propo", {style="Regular"} },
  --"VictorMono Nerd Font Mono",
  --"Input Mono",
  "FiraCode Nerd Font Mono",
  "SauceCodePro Nerd Font",
  "Noto Color Emoji",
  "Symbols Nerd Font Mono",
})
--default_prog = { "/usr/bin/nu" },
--font = wezterm.font("SauceCodePro NF", {style="Normal"}),
--default_prog = { "C:\\Program Files\\nu\\bin\\nu.exe" },
config.font_size = 10
config.hide_tab_bar_if_only_one_tab = true
config.leader = { key = "g", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keys
config.mouse_bindings = {
  -- Scrolling up while holding CTRL increases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = wezterm.action.IncreaseFontSize,
  },
  -- Scrolling down while holding CTRL decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = wezterm.action.DecreaseFontSize,
  },
}

config.check_for_updates = false
config.show_update_window = false
config.enable_wayland = false

return config;
