local awful = require("awful")
local beautiful = require("beautiful")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
		-- All clients will match this rule.
		{
			rule = { },
			properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				raise = true,
				keys = clientkeys,
				buttons = clientbuttons
			}
		},

		-- Prevent applications from running maximized
		{
			rule = {
				class = {
					"MPlayer",
					"pinentry",
					"gimp"
				}
			},
			properties = {
				floating = true
			}
		},


		-- Set Firefox to always map on tags number 2 of screen 1.
		-- { rule = { class = "Firefox" },
		--	 properties = { tag = tags[1][2] } },


		{
			rule = { class = "Firefox" },
			properties = { opacity = 1, maximized = false, floating = false }
		},
		{
			rule = { class = "VirtualBox" },
			properties = { opacity = 1, maximized = false, floating = false }
		},
		{
			rule = { class = "Inkscape" },
			properties = { opacity = 1, maximized = false, floating = false }
		},
}