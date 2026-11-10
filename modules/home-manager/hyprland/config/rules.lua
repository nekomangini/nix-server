---@diagnostic disable: undefined-global

-- Monitors
hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1, transform = 3 })
hl.monitor({ output = "DVI-D-1", mode = "1920x1080@60", position = "3000x0", scale = 1 })

-- Workspaces per monitor
local monitor_workspaces = {
	["HDMI-A-1"] = { 1, 2, 3, 4, 5 },
	["DVI-D-1"] = { 6, 7, 8, 9, 10 },
}

for monitor, list in pairs(monitor_workspaces) do
	for _, ws in ipairs(list) do
		hl.workspace_rule({ workspace = tostring(ws), monitor = monitor, persistent = true })
	end
end

-- Noctalia
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

hl.layer_rule({
	name = "noctalia",
	match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-- Opaque apps: { class, workspace }
local opaque_apps = {
	{ "org.kde.dolphin", 2 },
	{ "org.kde.gwenview", 3 },
	{ "jetbrains-studio", 4 },
	{ "dev.zed.Zed", 4 },
	{ "joplin-app-desktop", 5 },
	{ "vivaldi-stable", 5 },
	{ "krita", 6 },
	{ "blender", 7 },
	{ "PixiEditor.Desktop", 7 },
	{ "brave-browser", 8 },
	{ "Godot", 8 },
}

for _, app in ipairs(opaque_apps) do
	hl.window_rule({ match = { class = app[1] }, opaque = true, workspace = tostring(app[2]) })
end

-- Transparent apps: { class, workspace }
local transparent_apps = {
	{ "^kitty$", 1 },
	{ "^Alacritty$", 9 },
	{ "^([Ee]macs)$", 10 },
}

for _, app in ipairs(transparent_apps) do
	hl.window_rule({ match = { class = app[1] }, opacity = "0.82", workspace = tostring(app[2]) })
end

-- Emacs floating scratchpad: must come AFTER the loop so it overrides workspace 10
hl.window_rule({
	match = { class = "^([Ee]macs)$", title = "^(emacs-float)$" },
	float = true,
	center = true,
	workspace = "unset",
})
