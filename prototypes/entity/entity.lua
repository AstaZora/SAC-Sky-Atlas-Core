local mcvSpider = table.deepcopy(data.raw["spider-vehicle"]["spidertron"])
mcvSpider.name = "mcv"
mcvSpider.inventory_size = 1
mcvSpider.minable.result = "mcv"
mcvSpider.energy_per_move = "100kJ"
mcvSpider.energy_per_tick = "1kJ"
mcvSpider.minable.mining_time = 0.5
mcvSpider.max_health = 1000
mcvSpider.weight = 1000
-- Remove logistics and equipment
mcvSpider.logistic_slots_count = nil
mcvSpider.logistic_trash_slots_count = nil
mcvSpider.equipment_grid = nil
data:extend({mcvSpider})

local mcvSpiderRemote = table.deepcopy(data.raw["spidertron-remote"]["spidertron-remote"])
mcvSpiderRemote.name = "mcv-remote"

-- Again, use a table of tables
data:extend({mcvSpiderRemote})

--[[Possible Variations
"Surveyor Base,"
"Drill Site,"
"Resource Outpost,"
"Expeditionary Mining Rig"]]

local starport = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
starport.name = "starport"
starport.minable.result = "starport"  -- Ensure that mining the starport yields the correct item.
starport.fixed_recipe = nil  -- Remove the fixed recipe limitation.
starport.crafting_categories = {"starport-recipes"}

data:extend({starport})