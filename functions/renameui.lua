--Kek said: You can tweak the values through generate_ui,  could test it out on the fossils since they overwrite that. Also zorua changes the name, so that's another reference

function make_rename_button(card)
    local rename_button = nil
    if card.area and card.area.config.type == 'joker' then
        rename_button = {n=G.UIT.C, config={align = "cl"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cl",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'rename_card', func = 'can_rename_card'}, nodes={
                {n=G.UIT.B, config = {w=0.1,h=0.6}},
                {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.5}, nodes={
                    {n=G.UIT.T, config={text = "RENAME", colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                }}
            }},
            }}
    end
    local t = {
        n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
            {n=G.UIT.R, config={align = 'cl'}, nodes={
                rename_button
            }},
        }},
    }}
    return t
end