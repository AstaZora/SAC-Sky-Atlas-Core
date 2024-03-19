data:extend({
    {
        type = "recipe",
        name = "arboretum-package",
        energy_required = 60,
        category = "advanced-crafting",
        ingredients = {
            {"pine-sapling", 100},
            {"birch-sapling", 100},
            {"poplar-sapling", 100},
            {"willow-sapling", 100},
            {"fertilizer", 500}
        },
        results = {
            {"arboretum-package", 1}
        },
    },
    --Rocket Parts
    {
        type = "recipe",
        name = "arboretum-rocket-part",
        energy_required = 10,
        category = "starport-recipes",
        ingredients = {
            {"solid-biofuel", 10},
            {"carbon-fiber", 10},
            {"fiberboard-circuitry", 50},
        },
        results = {
            {"rocket-part", 1}
        },
    },
    --Satellites
    {
        type = "recipe",
        name = "arboretum-satellite",
        energy_required = 60,
        category = "crafting",
        ingredients = {
            {"fiberboard-circuitry", 500},
            {"carbon-fiber", 100},
            {"research-kit", 100},
            {"biocomposite-research-kit", 100},
            {"arboretum-package", 1}
        },
        results = {
            {"arboretum-satellite", 1}
        },
    },
})