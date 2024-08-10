local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Gruvbox dark, hard (base16)"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16.0

return config
