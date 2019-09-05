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
		-- TODO: These two blocks are created in different versions of awsome. The first could probably be merged in to the second
		{
			rule_any= {
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
		{
			rule_any = {
				class = {
					"VirtualBox",
					"Inkscape"
				}
			},
			properties = { opacity = 1, maximized = false, floating = false }
		},

		-- Set Firefox to always map on tags number 2 of screen 1.
		-- { rule = { class = "Firefox" },
		--	 properties = { tag = tags[1][2] } },

		-- Firefox' main window is "Navigator" and should not be maximized or floating
		-- All other windows should be floating and centered on screen
		{
			rule = { class = "Firefox", instance = "Navigator" },
			properties = { opacity = 1, maximized = false, floating = false }
		},
		{
			rule = { class = "Firefox" },
			except = { instance = "Navigator" },
			properties = { maximized = false, floating = true, placement = awful.placement.centered }
		}
}