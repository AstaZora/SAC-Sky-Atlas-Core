data:extend({
    {
        type = "recipe",
        name = "starport_recipe",
        enabled = true,
        energy_required = 10,
        ingredients = {
            {"iron-plate", 10},
            {"copper-plate", 5},
            {"rocket-fuel", 1}
        },
        result = "starport_item",
        result_count = 1,
        main_product = "",
        icon = "__your_mod_name__/graphics/icons/starport_icon.png",
        icon_size = 32,
        subgroup = "production",
        order = "d[rocket-silo]-a[starport]"
    }
})

data.raw.recipe["starport_recipe"].results = {
    {type = "item", name = "starport_item", amount = 1},
    {type = "item", name = "extra_item", amount = 5}
}