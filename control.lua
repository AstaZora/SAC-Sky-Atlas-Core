
-- Correct initialization of global variables
global.mcv = {} -- Initialize as nil to store the MCV entity
global.timeouts = {}

-- Mapping of kit names to blueprint strings or an array of strings for blueprint books
local kit_to_blueprint = {
    ["energy-defense-kit"] = {
        "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"
    }
}

-- Function to track MCV placement
local function track_mcv_placement(event)
    local entity = event.created_entity
    if entity.name == "mcv" then
        global.mcv = entity
    end
end

script.on_event(defines.events.on_built_entity, track_mcv_placement)

-- Function to create GUI buttons
local function create_buttons(player)
    local top_gui = player.gui.top
    local button_flow = top_gui["button_flow"]
    if not button_flow then
        button_flow = top_gui.add{type = "flow", name = "button_flow", direction = "horizontal"}
    end
    if not button_flow["deploy_mcv"] then
        button_flow.add{type = "button", name = "deploy_mcv", caption = "Deploy MCV", tooltip = "Deploy the MCV to build a new base"}
    end
    if not button_flow["cycle_blueprint_book_button"] then
        button_flow.add{type = "button", name = "cycle_blueprint_book_button", caption = "Cycle Blueprint Book"}
    end
end

script.on_event(defines.events.on_player_joined_game, function(event)
    local player = game.get_player(event.player_index)
    create_buttons(player)
end)

-- Updated function that converts a kit in the MCV to a blueprint or book and attempts to deploy it
function convert_kit_and_deploy_first_blueprint(mcv_entity)
    local inventory = mcv_entity.get_inventory(defines.inventory.spider_trunk)
    
    -- Iterate through the known kits and check if any are present
    for kit_name, blueprint_data in pairs(kit_to_blueprint) do
        if inventory.get_item_count(kit_name) > 0 then
            -- Remove the kit from inventory
            inventory.remove({name = kit_name, count = 1})
            
            -- Determine if the blueprint_data is a single string or an array for a book
            if type(blueprint_data) == "string" then
                -- Convert to a single blueprint and attempt to deploy
                deploy_single_blueprint(blueprint_data, mcv_entity)
            elseif type(blueprint_data) == "table" then
                -- Convert to a blueprint book and deploy the first blueprint
                deploy_blueprint_from_book(blueprint_data, mcv_entity)
            end
            
            return -- Process one kit at a time
        end
    end

    game.print("No recognizable kit found in MCV.")
end

function deploy_first_blueprint_from_kit(mcv_entity, kit_name)
    local inventory = mcv_entity.get_inventory(defines.inventory.spider_trunk)
    if inventory.get_item_count(kit_name) > 0 then
        inventory.remove({name = kit_name, count = 1})
        game.print("Kit consumed. Deploying first blueprint from kit's book.")

        local blueprint_entities = kit_to_blueprint[kit_name]
        if blueprint_entities then
            if type(blueprint_entities) == "string" then
                deploy_blueprint(blueprint_entities, mcv_entity)
            elseif type(blueprint_entities) == "table" then
                deploy_blueprint(blueprint_entities[1], mcv_entity)
            end
        else
            game.print("No blueprint data found for the kit.")
        end
    else
        game.print("Kit not found in MCV.")
    end
end

function deploy_blueprint(blueprint_string, mcv_entity)
    game.print("Deploying entities from blueprint: " .. blueprint_string)
    -- Implement the logic to decode the blueprint string and deploy the entities or ghosts
end

script.on_event(defines.events.on_gui_click, function(event)
    if event.element.name == "deploy_mcv" then
        local mcv = global.mcv
        if mcv and mcv.valid then
            deploy_first_blueprint_from_kit(mcv, "energy-defense-kit")
        else
            game.print("MCV not found.")
        end
    end
end)

script.on_event(defines.events.on_gui_click, function(event)
    if event.element.name == "deploy_mcv" then
        local mcv = global.mcv -- Make sure this accesses the correct MCV entity for the player

        if mcv and mcv.valid then
            local kit_name = "energy-defense-kit" -- Directly specifying the kit name as a string
            deploy_first_blueprint_from_kit(mcv, kit_name)
        else
            game.print("MCV not found.")
        end
    end
end)

function deploy_single_blueprint(blueprint_string, mcv_entity)
    -- Decode the blueprint string into a table of entities
    local entities = game.blueprint_string_to_blueprint_entities(blueprint_string)

    -- Place ghosts for each entity in the blueprint
    for _, entity in ipairs(entities) do
        local position = {x = mcv_entity.position.x + entity.position.x, y = mcv_entity.position.y + entity.position.y}
        game.surfaces[1].create_entity{
            name = entity.name,
            position = position,
            direction = entity.direction,
            force = mcv_entity.force,
            inner_name = entity.inner_name,
            raise_built = true,
            create_build_effect_smoke = false
        }
    end

    game.print("Deploying single blueprint from kit.")
end

function deploy_blueprint_from_book(blueprint_strings, mcv_entity)
    -- Select the first blueprint string from the provided array for deployment
    local first_blueprint_string = blueprint_strings[1]
    game.print("Deploying first blueprint from kit's book.")

    -- Decode the blueprint string into a table of entities
    local entities = game.blueprint_string_to_blueprint_entities(first_blueprint_string)

    -- Place ghosts for each entity in the blueprint
    for _, entity in ipairs(entities) do
        local position = {x = mcv_entity.position.x + entity.position.x, y = mcv_entity.position.y + entity.position.y}
        game.surfaces[1].create_entity{
            name = entity.name,
            position = position,
            direction = entity.direction,
            force = mcv_entity.force,
            inner_name = entity.inner_name,
            raise_built = true,
            create_build_effect_smoke = false
        }
    end

    game.print("Deploying first blueprint from kit's book.")
end

script.on_event(defines.events.on_gui_click, function(event)
    if event.element.name == "deploy_mcv" then
        local mcv = global.mcv
        if mcv and mcv.valid then
            deploy_first_blueprint_from_kit(mcv, "energy-defense-kit")
        else
            game.print("MCV not found.")
        end
    end
end)

-- Simplified timeout handling
script.on_event(defines.events.on_tick, function(event)
    local timeouts = global.timeouts[event.tick]
    if timeouts then
        for _, timeout in ipairs(timeouts) do
            timeout.func()
        end
        global.timeouts[event.tick] = nil
    end
end)