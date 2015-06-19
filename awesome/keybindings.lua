local awful = require("awful")
local naughty = require("naughty")
local brightness = require("brightness")

-- Reset all key mapping
globalkeys = {}
clientkeys = {}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
--	awful.key({ modkey, "Control" }, "o",      function (c) awful.client.movetoscreen(c, 0) end                        ),

	-- all minimized clients are restored
	awful.key({ modkey, "Control" }, "e",
		function()
			local tag = awful.tag.selected()
			for i=1, #tag:clients() do
				c = tag:clients()[i]
				awful.placement.no_offscreen(c)
			end
			naughty.notify({ text="Out-of-screen windows moved into screen" })
		end),

--	awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
--	awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
--	awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

--	awful.key({ modkey,           }, "j",
--		function ()
--			awful.client.focus.byidx( 1)
--			if client.focus then client.focus:raise() end
--		end),
--	awful.key({ modkey,           }, "k",
--		function ()
--			awful.client.focus.byidx(-1)
--			if client.focus then client.focus:raise() end
--		end),

	-- Layout manipulation
--	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
--	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
--	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
--	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
	awful.key({ modkey,           }, "Tab",
		function ()
			alttab.switch(1, modkey, "Tab", "ISO_Left_Tab")
		end),
	awful.key({ modkey,           }, "Tab",
		function ()
			alttab.switch(-1, modkey, "Tab", "ISO_Left_Tab")
		end),
--	awful.key({ modkey, "Control" }, "n", awful.client.restore),

	-- Prompt
	awful.key({ modkey            }, " ", function () mypromptbox[mouse.screen]:run() end),

--	awful.key({ modkey }, "Control", "r",
--		function ()
--			awful.prompt.run({ prompt = "Run Lua code: " },
--			mypromptbox[mouse.screen].widget,
--			awful.util.eval, nil,
--			awful.util.getdir("cache") .. "/history_eval")
--		end),
	globalkeys
)

clientkeys = awful.util.table.join(
--		awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
--		awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
--		awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
--		awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
--		awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
--		awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end),
--		awful.key({ modkey,           }, "m",
--				function (c)
						-- The client currently has the input focus, so it cannot be
						-- minimized, since minimized clients can't have the focus.
--						c.minimized = true
--				end)
)


globalkeys = awful.util.table.join(
	awful.key({ }, "XF86MonBrightnessDown", function () brightnesscfg.screen_down() end),     -- F1
	awful.key({ }, "XF86MonBrightnessUp",   function () brightnesscfg.screen_up()   end),     -- F2
	awful.key({ }, "XF86LaunchA",           function () revelation() end),                    -- F3
	awful.key({ }, "XF86LaunchB",           function () meep.vroom("2") end),                 -- F4
	awful.key({ }, "XF86KbdBrightnessDown", function () brightnesscfg.keyboard_down() end),   -- F5
	awful.key({ }, "XF86KbdBrightnessUp",   function () brightnesscfg.keyboard_up() end),     -- F6
	awful.key({ }, "XF86AudioPrev",         function () meep.vroom("Prev") end),              -- F7
	awful.key({ }, "XF86AudioPlay",         function () meep.vroom("Play") end),              -- F8
	awful.key({ }, "XF86AudioNext",         function () meep.vroom("Next") end),              -- F9
	awful.key({ }, "XF86AudioMute",         function () volumecfg.toggle() end),              -- F10
	awful.key({ }, "XF86AudioLowerVolume",  function () volumecfg.down() end),                -- F11
	awful.key({ }, "XF86AudioRaiseVolume",  function () volumecfg.up() end),                  -- F12
	awful.key({ }, "XF86Eject",             function () meep.vroom("Eject") end),             -- Eject

	awful.key({ }, "XF86Tools",             function () toggleontop0() end),                  -- F13
	awful.key({ }, "XF86Launch5",           function () toggleontop1() end),                  -- F14
	awful.key({ }, "XF86Launch6",           function () meep.vroom("E3") end),                -- F15

	awful.key({ }, "XF86Launch7",           function () awful.util.spawn("speedcrunch") end), -- F16
	awful.key({ }, "XF86Launch8",           function () meep.vroom("NL2") end),               -- F17
	awful.key({ }, "XF86Launch9",           function () awesome.restart() end),               -- F18
	awful.key({ }, "#197",                  function () awful.util.spawn("xscreensaver-command -lock") end), -- F19

	globalkeys
)

meep = {}
meep.vroom = function (key)
	naughty.notify({ text="Hai gaise! You just pressed: " .. key })
end

toggleontop0 = function ()
	mywibox[2].ontop = not mywibox[2].ontop;
	mytaskbar[2].ontop = not mytaskbar[2].ontop;
end

toggleontop1 = function ()
	mywibox[1].ontop = not mywibox[1].ontop;
	mytaskbar[1].ontop = not mytaskbar[1].ontop;
end
