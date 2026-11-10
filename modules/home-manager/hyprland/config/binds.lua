---@diagnostic disable: undefined-global

local mainMod = "SUPER"
local ipc = "noctalia msg "
local dirs = { h = "l", j = "d", k = "u", l = "r" }

-- Core Window Actions
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Applications & Scripts
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("dev-workspace"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("emacs-gui-hyprland"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("emacsclient --eval '(thanos/type)'"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("emacs-dired-wayland"))

-- Mouse Binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces (1-10)
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Noctalia Shell
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(ipc .. "panel-toggle session")) -- logout / reboot / shutdown menu
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard")) -- clipboard history
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper")) -- wallpaper
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher hold"))
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher hold reverse"))
hl.bind("Print", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen pick"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen all"))

-- Movement & Navigation
for key, dir in pairs(dirs) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

hl.bind(mainMod .. " + N", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + P", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + O", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + BACKSLASH", hl.dsp.focus({ workspace = "previou" }))

-- Audio Controls
local locked = { locked = true }

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), locked)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), locked)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
