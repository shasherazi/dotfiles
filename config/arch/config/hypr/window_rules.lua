hl.window_rule({ match = { class = "^(kitty)$" }, float = true, size = { "(monitor_w*0.8)", "(monitor_h*0.8)" } })
hl.window_rule({ match = { class = "^(Alacritty)$" }, float = true, size = { "(monitor_w*0.8)", "(monitor_h*0.8)" } })

hl.window_rule({ match = { class = "^(firefox)$" }, opaque = false })
hl.window_rule({ match = { class = "^(blender)$" }, opaque = false })
hl.window_rule({ match = { class = "^(brave-browser)$" }, opaque = false })
hl.window_rule({ match = { class = "^(krita)$" }, opaque = false })
hl.window_rule({ match = { class = "^(mpv)$" }, opaque = false })

hl.window_rule({ match = { class = "^(firefox)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(brave-browser)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(vesktop)$" }, workspace = "6" })

-- windowrule = match:class ^(jetbrains-.*)$, match:title ^(win[0-9]+)$, float on
-- windowrule = match:class ^(jetbrains-.*)$, match:title ^(win[0-9]+)$, no_focus on

-- windowrule = match:class .*, idle_inhibit fullscreen # for lutris games basically
-- windowrule = match:class ^(Emulator)$, no_dim on # for android studio emulators
-- windowrule = match:title ^(Picture-in-Picture)$, no_dim on # for youtube pip
