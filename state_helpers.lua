local waywall = require("waywall")
local res = require("res_helpers")
local options = require("options")

local M = {}

-- Lock the scrollwheel if unpaused ingame
M.set_scroll = function(state)
    if state.screen == "inworld" and state.inworld == "unpaused" then
		-- waywall.exec("swaymsg input type:pointer scroll_factor 0.0")
		-- for i = 0, 150, 1 do
		-- 	waywall.exec("jay input device " .. i .. " set-px-per-wheel-scroll 0")
		-- end
		waywall.exec("jay input device 48 set-px-per-wheel-scroll 0")
    else
		-- waywall.exec("swaymsg input type:pointer scroll_factor 1.0")
		-- for i = 0, 150, 1 do
		-- 	waywall.exec("jay input device " .. i .. " set-px-per-wheel-scroll 15")
		-- end
		waywall.exec("jay input device 48 set-px-per-wheel-scroll 15")
    end
end

-- Disable sway keybinds if unpaused ingame
M.set_binds = function(state)
    if state.screen == "inworld" and state.inworld ~= "paused" then
		waywall.exec("ydotool key -d 0 194:1 194:0")
		-- waywall.exec("swaymsg mode \"binds_disabled\"")
    else
		waywall.exec("ydotool key -d 0 193:1 193:0")
		-- waywall.exec("swaymsg mode \"default\"")
    end
end

-- Run world joining commands if joining a world
M.join_world_check = function(prev_state, new_state, callback)
	if waywall.profile() == "ranked" then
		return
	end
	if prev_state.screen ~= "inworld" and new_state.screen == "inworld" then
		callback()
	end
end

-- Run world leaveing commands if leaving a world
M.leave_world_check = function(prev_state, new_state, callback)
	if prev_state.screen == "inworld" and new_state.screen ~= "inworld" then
		callback()
	end
end

-- ==== STATE CHECKER ====
M.instance_state_checker = function()
	local prev_state = waywall.state()
	
	return function()
		local new_state = waywall.state()

		-- some weird possible bug fix i found in jingle code
		-- jingle/instance/statetracker line ~130
		if prev_state.screen == "previewing" and new_state.screen == "generating" then
			new_state.screen = "previewing"
		end

		if options.AUTO_REENABLE_REMAPS then
			waywall.set_remaps(options.REMAPS)
		end

		if options.DYNAMIC_SCROLL_LOCK then
			M.set_scroll(new_state)
		end

		if options.DYNAMIC_SWAY_BINDS then
			M.set_binds(new_state)
		end

		if options.JOIN_WORLD_EVENTS then
			M.join_world_check(prev_state, new_state, function() waywall.exec(options.NORMAL_JOIN) end)
		end

		if options.LEAVE_WORLD_EVENTS then
			M.leave_world_check(prev_state, new_state, function()
				waywall.set_resolution(0, 0)
				res.res_disable()
				-- SEEDQUEUE:
				-- waywall.show_floating(false)
				-- RANKED:
				-- waywall.show_floating(true)
				-- waywall.sleep(150)
				-- waywall.exec(options.NORMAL_LEAVE)
				-- waywall.sleep(150)
				-- waywall.show_floating(false)
			end)
		end

		prev_state = new_state
	end
end

return M
