local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local icon_path = "/home/slanja/.config/awesome/icons/myicon.svg"

local icon_widget = wibox.widget {
    {
        {
            -- loading svg image
            image = gears.surface.load_uncached(icon_path),
            widget = wibox.widget.imagebox,
        },
        margins = 10, 
        widget = wibox.container.margin,
    },
    resize = true,
    widget = wibox.container.background,
}

local function on_click()
    awful.spawn("kitty")
end

-- adding mouse listener
icon_widget:buttons(gears.table.join(
    awful.button({}, 1, on_click)
))

return icon_widget