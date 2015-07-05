local naughty = require("naughty")
local awful = require("awful")

move_windows_left = function()
	naughty.notify({ text="Move windows left" })

	-- Get windows from screen 2
	local all = client.get(2)
	for i = 1, #all do
		local c = all[i]
		local ctags = c:tags()
--		awful.client.movetoscreen(c, 1)
		local tag = awful.tag.gettags(1)[5]
		--awful.client.movetotag(tag, c)

		for j = 1, #ctags do
--			awful.client.toggletag(ctags[j], c)
		end

		-- Move to screen 1
--		c.screen = 1

		-- Restore tags from screen 2
--		c:tags(ctags)

	naughty.notify({ text="Window" .. c.class .. " is on tag " })
	for j = 1, #ctags do
		local res = ""
		if ctags[j] == true then
			res = "true"
		else
			res = "false"
		end
		id = awful.tag.getidx(ctags[j])
		naughty.notify({ text="#" .. j .. ":" .. res .. " id:" .. id})
	end
	end
end

move_windows_right = function()
	naughty.notify({ text="Move windows right" })
end

move_windows_inside = function()
--	naughty.notify({ text="Move windows inside" })

	for s = 1, screen.count() do
		local all = client.get(s)
		for i = 1, #all do
			local c = all[i]

			-- Get screen width
			local screen_width = 1680
			local border_width = 2
			local max_width    = screen_width - border_width

			-- Get window getometry
			local g = c:geometry()

			-- Do not allow windows to be wider than screen
			-- A window that is on the right screen and is to wide to fit will be placed with the left side of the window on the left screen. We do not want this behavior
			if g.width > max_width then
				g.width = max_width
				c:geometry(g)
			end

	--		naughty.notify({ text="Window: " .. c.class .. "(" .. g.width .. ")" })
			awful.placement.no_offscreen(c)
		end
	end
end