-- monitors
hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1, transform = 3 })
hl.monitor({ output = "DVI-D-1", mode = "1920x1080@60", position = "3000x0", scale = 1 })

-- monitor setup
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "DVI-D-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "DVI-D-1", persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "7", monitor = "DVI-D-1", persistent = true })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "9", monitor = "DVI-D-1", persistent = true })
hl.workspace_rule({ workspace = "10", monitor = "DVI-D-1", persistent = true })

-- workspace rules
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

hl.window_rule({
	match = { class = "kitty" },
	no_blur = false,
	opacity = "0.82",
	workspace = 1,
})

hl.window_rule({
	match = { class = "org.kde.dolphin" },
	no_blur = false,
	opaque = "1",
	workspace = 2,
})

hl.window_rule({
	match = { class = "jetbrains-studio" },
	no_blur = false,
	opaque = "1",
	workspace = 3,
})

hl.window_rule({
	match = { class = "dev.zed.Zed" },
	no_blur = false,
	opaque = "1",
	workspace = 3,
})

hl.window_rule({
	match = { class = "brave-browser" },
	no_blur = false,
	opaque = "1",
	workspace = 4,
})

hl.window_rule({
	match = { class = "Godot" },
	no_blur = false,
	opaque = "1",
	workspace = 5,
})

hl.window_rule({
	match = { class = "joplin-app-desktop" },
	no_blur = false,
	opaque = "1",
	workspace = 6,
})

hl.window_rule({
	match = { class = "krita" },
	no_blur = false,
	opaque = "1",
	workspace = 7,
})

hl.window_rule({
	match = { class = "blender" },
	no_blur = false,
	opaque = "1",
	workspace = 7,
})

hl.window_rule({
	match = { class = "PixiEditor.Desktop" },
	no_blur = false,
	opaque = "1",
	workspace = 7,
})

hl.window_rule({
	match = { class = "vivaldi-stable" },
	no_blur = false,
	opaque = "1",
	workspace = 8,
})

hl.window_rule({
	match = { class = "Alacritty" },
	no_blur = false,
	opacity = "0.82",
	workspace = 9,
})

hl.window_rule({
	match = { class = "emacs" },
	no_blur = false,
	opacity = "0.82",
	workspace = 10,
})
