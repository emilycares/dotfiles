local wezterm = require("wezterm")

local keys = {
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
	{ key = "a", mods = "LEADER", action = wezterm.action({ SendString = "\x02" }) },
}

for i = 1, 9 do
	local tabkey = { key = tostring(i), mods = "LEADER", action = wezterm.action({ ActivateTab = (i - 1) }) }
	table.insert(keys, tabkey)
end

return {
	font = wezterm.font("SauceCodePro Nerd Font"),
	default_prog = { "/usr/bin/fish" },
	--font = wezterm.font("SauceCodePro NF", {style="Normal"}),
	--default_prog = { "C:\\Program Files\\nu\\bin\\nu.exe" },
	font_size = 9,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = keys,
}
