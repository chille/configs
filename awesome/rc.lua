require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("debian.menu")
vicious = require("vicious")



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/chille/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Execute command and return its output. You probably won't only execute commands with one
-- line of output
function execute_command(command)
   local fh = io.popen(command)
   local str = ""
   for i in fh:lines() do
      str = str .. i
   end
   io.close(fh)
   return str
end

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

require("quicklaunch")
require("volume")
require("revelation")
--require("keybindings")
require("taskbar")
require("chille")

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
	awful.layout.suit.floating,
     awful.layout.suit.tile,
     awful.layout.suit.tile.left,
     awful.layout.suit.tile.bottom,
     awful.layout.suit.tile.top,
     awful.layout.suit.fair,
     awful.layout.suit.fair.horizontal,
     awful.layout.suit.spiral,
     awful.layout.suit.spiral.dwindle,
     awful.layout.suit.max,
     awful.layout.suit.max.fullscreen,
     awful.layout.suit.magnifier,






--    awful.layout.suit.floating,
----    awful.layout.suit.fair,
----    awful.layout.suit.fair.horizontal,
----    awful.layout.suit.spiral,
----    awful.layout.suit.spiral.dwindle,
--    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
----    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "Restart awesome", awesome.restart },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "Quit awesome", awesome.quit },
}

mymainmenu = awful.menu({ items = { { "Tools", myawesomemenu },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "Open terminal", terminal },
                                    { "Logout", "/home/chille/bin/awesome/logout" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

-- }}}

-- {{{ Wibox
require("widgets")

-- Clock widget
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, " %a %d %b, %H:%M:%S ", 1)

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}

mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag)
                    )

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 16, ontop = true })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            separator,
            mytaglist[s],
            separator,
            launchbar,
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },

	-- Layout switcher
        mylayoutbox[s],

	-- Clock
        datewidget,
	separator,

	-- Systray
--        s == 2 and mysystray or nil,
	mysystray,
	separator,

	-- Volume
	volumecfg.widget,
	volicon,
	separator,

	-- File system
        fswidget,
        fsicon,
	separator,

	-- Memory
        memwidget,
        memicon,
	separator,

	-- CPU
        cpuwidget,
        cpuicon,
	separator,

	-- Network
        netwidgetup,
        upicon,
        netwidgetdn,
        dnicon,	
	separator,

	-- Music player
--	mpdwidget,

        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


require("keybindings")

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { instance = "plugin-container" },
        properties = { floating = true } },
    { rule = { instance = "operapluginwrapper-native" },
        properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    awful.titlebar.add(c, { modkey = modkey })

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.add_signal("property::fullscreen", function()
	naughty.notify({ text="Fullscreen!" })
end);

--client.add_signal("unfocus", function(c)
--        c.border_width = 0
--        naughty.notify({ text="Fullscreen!" })
--end);

-- }}}
