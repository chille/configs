globalkeys = awful.util.table.join(
--	awful.key({ modkey,           }, "Tab",
--		function ()
--			awful.menu.menu_keys.down = { "Down", "Alt_L" }
--			local cmenu = awful.menu.clients({width=400}, {keygrabber=true, coords={x=0, y=10}})
--		end),


	-- all minimized clients are restored
	awful.key({ modkey,           }, "e",
		function()
			local tag = awful.tag.selected()
			for i=1, #tag:clients() do
				c = tag:clients()[i]
				awful.placement.no_offscreen(c)
			end
			naughty.notify({ text="Out-of-screen windows moved into screen" })
		end)
)
