--globalkeys = awful.util.table.join(
--	awful.key({ modkey,           }, "Tab",
--		function ()
--			awful.menu.menu_keys.down = { "Down", "Alt_L" }
--			local cmenu = awful.menu.clients({width=400}, {keygrabber=true, coords={x=0, y=10}})
--		end),
--)
