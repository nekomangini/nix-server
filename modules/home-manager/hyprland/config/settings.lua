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
})
