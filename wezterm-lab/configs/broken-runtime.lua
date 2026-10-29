local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.font = wezterm.font 'No Such Family Anywhere'
wezterm.no_such_function()
return config
