mytaskbar = {}
mytasklist = {}

mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              -- This will also un-minimize
                                              -- the client, if needed
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end))

for s = 1, screen.count() do
	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(function(c)
		return awful.widget.tasklist.label.currenttags(c, s)
		end,
	mytasklist.buttons)

	-- Add the taskbar to bottom of screen
	mytaskbar[s] = awful.wibox({ position = "bottom", name = "mystatusbar", ontop = true })
	mytaskbar[s].widgets = { mytasklist[s], layout = awful.widget.layout.horizontal.leftright }
	mytaskbar[s].screen = s
end
