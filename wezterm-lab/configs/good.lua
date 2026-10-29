local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 14.0
config.color_scheme = 'Builtin Solarized Dark'
config.window_background_opacity = 0.95

config.keys = {
  {
    key = 'F9',
    mods = 'NONE',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

return config
