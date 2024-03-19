data:extend({
    {
        type = "item",
        name = "mcv",
        icon = "__base__/graphics/icons/spidertron.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "transport",
        order = "b[personal-transport]-c[spidertron]-a[spider]",
        place_result = "mcv",
        stack_size = 1
    },
    {
        type = "item",
        name = "starport",
        icon = "__base__/graphics/icons/rocket-silo.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "transport",
        order = "b[mcv]",
        stack_size = 1,
        place_result = "starport"
    },
    --Packages
    {
        type = "item",
        name = "arboretum-package",
        icon = "__base__/graphics/icons/wooden-chest.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "transport",
        order = "b[arboretum-package]",
        stack_size = 10
    },
    --Conversion Kits
    {
        type = "item",
        name = "arboretum-satellite",
        icon = "__base__/graphics/icons/satellite.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "transport",
        order = "b[arboretum-satelitte]",
        stack_size = 1,
        rocket_launch_product = {"aquaculture-kit", 1}
    },
})