local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")  -- Potřebný pro tooltip

-- Vytvoření battery widgetu s ikonou blesku
local battery_widget = wibox.widget {
    {
        {
            {
                id = "battery_text",
                valign = "center",
                align = "center",
                forced_height = 80,
                widget = wibox.widget.textbox,
                markup = '<span color="#ffffff" font="Motiva Sans 22" font-weight="bold">ϟ</span>',
            },
            layout = wibox.layout.fixed.vertical
        },
        id = "background_role",
        bg = "#27ae60",
        widget = wibox.container.background,
        shape = gears.shape.octogon,
    },
    margins = 10,
    widget = wibox.container.margin
}

-- Vytvoření tooltipu
local battery_tooltip = awful.tooltip {
    objects = { battery_widget },  -- Přiřazení tooltipu k widgetu
    mode = "outside",
    valign = "right",
    margin_leftright = 5,
    margin_topbottom = 5,
}

-- Funkce pro aktualizaci stavu baterie a tooltipu
local function update_battery()
    -- Přečtení kapacity baterie
    local capacity = tonumber(io.popen("cat /sys/class/power_supply/BAT1/capacity"):read("*all"))

    -- Kontrola, zda byla kapacita správně načtena
    if capacity then
        -- Nastavení barvy na základě kapacity
        local color = "#27ae60"  -- Zelená jako výchozí barva
        if capacity >= 50 then
            color = "#27ae60" -- Zelená
        elseif capacity >= 20 then
            color = "#f39c12" -- Oranžová
        else
            color = "#c0392b" -- Červená
        end

        -- Aktualizace barvy pozadí widgetu (přístup přes id = "background_role")
        battery_widget:get_children_by_id("background_role")[1].bg = color

        -- Aktualizace textu tooltipu
        battery_tooltip.text = string.format("%d%%", capacity)
    else
        -- Pokud nelze načíst kapacitu, nastaví výchozí barvu a tooltip
        battery_widget:get_children_by_id("background_role")[1].bg = "#2b2b2b"
        battery_tooltip.text = "N/A"
    end
end

-- Timer pro pravidelnou aktualizaci widgetu a tooltipu
gears.timer {
    timeout = 30,  -- Aktualizace každých 30 sekund
    autostart = true,
    callback = update_battery
}

-- Počáteční volání aktualizační funkce
update_battery()

-- Návrat widgetu pro použití ve Wibar
return battery_widget