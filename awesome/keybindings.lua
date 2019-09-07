local awful = require("awful")
local naughty = require("naughty")
local brightness = require("brightness")

modkey = "Control"
globalkeys = {}

remapkeys = function (window)
	-- Change the keyboard layout in the X server
	if window == "X-terminal-emulator" or window == "Roxterm" then
		os.execute("/home/chille/configs/bin/remapkeys.sh roxterm &")
		modkey = "Mod4"
	else
		os.execute("/home/chille/configs/bin/remapkeys.sh other &")
		modkey = "Control"
	end

	-- Remap keys in Awesome
	globalkeys = awful.util.table.join(
--		awful.key({ modkey, "Control" }, "o",      function (c) awful.client.movetoscreen(c, 0) end ),

		-- all minimized clients are restored
		awful.key({ modkey, "Control" }, "e",
			function()
				local tag = awful.tag.selected()
				for i=1, #tag:clients() do
					c = tag:clients()[i]
					awful.placement.no_offscreen(c)
				end
				naughty.notify({ text="Out-of-screen windows moved into screen" })
			end
		),

		awful.key({ modkey,           }, "Tab",
			function ()
				alttab.switch(1, modkey, "Tab", "ISO_Left_Tab")
			end
		),
		awful.key({ modkey,           }, "Tab",
			function ()
				alttab.switch(-1, modkey, "Tab", "ISO_Left_Tab")
			end
		),

		-- Prompt
		awful.key({ modkey            }, " ", function () mypromptbox[mouse.screen.index]:run() end),

--		awful.key({ modkey }, "Control", "r",
--			function ()
--				awful.prompt.run({ prompt = "Run Lua code: " },
--				mypromptbox[mouse.screen.index].widget,
--				awful.util.eval, nil,
--				awful.util.getdir("cache") .. "/history_eval")
--			end
--		),

		awful.key({ }, "XF86MonBrightnessDown", function () brightnesscfg.screen_down() end),     -- F1
		awful.key({ }, "XF86MonBrightnessUp",   function () brightnesscfg.screen_up()   end),     -- F2
		awful.key({ }, "XF86LaunchA",           function () revelation() end),                    -- F3
		awful.key({ }, "XF86LaunchB",           function () togglefullscreen() end),              -- F4
		awful.key({ }, "XF86KbdBrightnessDown", function () brightnesscfg.keyboard_down() end),   -- F5
		awful.key({ }, "XF86KbdBrightnessUp",   function () brightnesscfg.keyboard_up() end),     -- F6
		awful.key({ }, "XF86AudioPrev",         function () naughty.notify({text="Prev"}) end),   -- F7
		awful.key({ }, "XF86AudioPlay",         function () naughty.notify({text="Play"}) end),   -- F8
		awful.key({ }, "XF86AudioNext",         function () naughty.notify({text="Next"}) end),   -- F9
		awful.key({ }, "XF86AudioMute",         function () volumecfg.toggle() end),              -- F10
		awful.key({ }, "XF86AudioLowerVolume",  function () volumecfg.down() end),                -- F11
		awful.key({ }, "XF86AudioRaiseVolume",  function () volumecfg.up() end),                  -- F12
		awful.key({ }, "XF86Eject",             function () naughty.notify({text="Eject"}) end),  -- Eject

		awful.key({ }, "XF86Tools",             function () toggleontop() end),                   -- F13
		awful.key({ }, "XF86Launch5",           function () naughty.notify({text="F14"}) end),    -- F14
		awful.key({ }, "XF86Launch6",           function () naughty.notify({text="F15"}) end),    -- F15

		awful.key({ }, "XF86Launch7",           function () awful.util.spawn("speedcrunch") end), -- F16
		awful.key({ }, "XF86Launch8",           function () naughty.notify({text="F17"}) end),    -- F17
		awful.key({ }, "XF86Launch9",           function () awesome.restart() end),               -- F18
		awful.key({ }, "#197",                  function () lockScreen() end)                     -- F19
	)

	for i = 1, 9 do
		globalkeys = awful.util.table.join(globalkeys,
			-- View tag only.
			awful.key({ modkey }, "#" .. i + 9,
				function ()
					local screen = mouse.screen.index
					local tag = awful.tag.gettags(screen)[i]
					if tag then
						awful.tag.viewonly(tag)
					end
				end
			),

			-- Toggle tag.
			awful.key({ modkey, "Control" }, "#" .. i + 9,
				function ()
					local screen = mouse.screen.index
					local tag = awful.tag.gettags(screen)[i]
					if tag then
						 awful.tag.viewtoggle(tag)
					end
				end
			),

			-- Move client to tag.
			awful.key({ modkey, "Shift" }, "#" .. i + 9,
				function ()
					if client.focus then
						local tag = awful.tag.gettags(client.focus.screen)[i]
						if tag then
							awful.client.movetotag(tag)
						end
					end
				end
			),

			-- Toggle tag.
			awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
				function ()
					if client.focus then
						local tag = awful.tag.gettags(client.focus.screen)[i]
						if tag then
							awful.client.toggletag(tag)
						end
					end
				end
			)
		)
	end

	-- Set keys
	root.keys(globalkeys)
end

client.connect_signal("focus", function(c)
	remapkeys(c.class)
end)

togglefullscreen = function ()
	mywibox[mouse.screen.index].visible = not mywibox[mouse.screen.index].visible;
	mytaskbar[mouse.screen.index].visible = not mytaskbar[mouse.screen.index].visible;
end

lockscreen = function ()
	awful.util.spawn("xscreensaver-command -lock")
end

remapkeys();