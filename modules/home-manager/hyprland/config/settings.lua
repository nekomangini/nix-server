---@diagnostic disable: undefined-global

hl.config({
	general = { gaps_in = 5, gaps_out = 10 },
	decoration = {
		rounding = 5,
		rounding_power = 2,
		active_opacity = 0.91,
		inactive_opacity = 0.91,
		shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
		blur = { enabled = true, xray = true, size = 3, passes = 2, vibrancy = 0.1696 },
	},
	animations = { enabled = true },
	-- animations = { enabled = false },
})

-- Fast, simple window open/close
-- hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "default", style = "popin 90%" })
-- hl.animation({ leaf = "workspaces", enabled = true, speed = 8, bezier = "default", style = "slidefade 5%" })
-- hl.animation({ leaf = "border", enabled = false })
-- hl.animation({ leaf = "fade", enabled = false })

-- Curves (must be defined before the animations that use them)
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1 }, { 0.68, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })

-- Windows: pop in softly, close a bit quicker, glide when moving/resizing
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "easeOutCubic", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "easeOutQuint" })

-- Fade (pairs nicely with popin)
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "almostLinear" })

-- Border color change on focus
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "easeOutQuint" })

-- Workspace switching
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slidefade 8%" })
