---@diagnostic disable: undefined-global

hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	hl.exec_cmd("/run/current-system/sw/libexec/polkit-kde-authentication-agent-1")
	hl.exec_cmd("alacritty")
	hl.exec_cmd("dev-workspace")
	hl.exec_cmd("dolphin")
	hl.exec_cmd("emacs --daemon")
	-- hl.exec_cmd("systemctl --user start emacs.service")
end)
