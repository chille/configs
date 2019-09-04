local awful = require("awful")

mytaskbar = {}
mytasklist = {}

mytasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() then
				awful.tag.viewonly(c:tags()[1])
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({ }, 3, function ()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({
				theme = { width = 250 }
			})
		end
	end)
)

for s = 1, screen.count() do
	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)


	-- Add the taskbar to bottom of screen
	mytaskbar[s] = awful.wibox({ position = "bottom", name = "mystatusbar", screen = s, ontop = true })
	mytaskbar[s]:set_widget( mytasklist[s] )
end