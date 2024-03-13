-- Global variable initialization
global.mcv = {}
global.kit_to_blueprint_book = {
    ["energy-defense-kit"] = {
        "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"
    }
}

-- Function to track MCV placement
function track_mcv_placement(event)
    if event.created_entity.name == "mcv" then
        global.mcv = event.created_entity
    end
end

script.on_event(defines.events.on_built_entity, track_mcv_placement)

-- Updated create_buttons function to include the cycle blueprint button
function create_buttons(player)
    local top_gui = player.gui.top
    if not top_gui.deploy_mcv_button then
        top_gui.add({type = "button", name = "deploy_mcv_button", caption = "Deploy MCV"})
    end
    if not top_gui.cycle_blueprint_button then
        top_gui.add({type = "button", name = "cycle_blueprint_button", caption = "Cycle Blueprint"})
    end
end

script.on_event(defines.events.on_player_joined_game, function(event)
    create_buttons(game.get_player(event.player_index))
end)

-- Decode blueprint string to entity data
function decode_blueprint_string(blueprint_string)
    local json_string = game.decode_string(blueprint_string)
    if not json_string then return nil end -- Ensure decoding was successful
    local blueprint_table = game.json_to_table(json_string)
    return blueprint_table
end

-- Function to deploy the first blueprint from the blueprint book
function deploy_first_blueprint_from_book(blueprint_strings, mcv)
    local surface = mcv.surface
    local force = mcv.force
    local position = mcv.position

    -- Decode the first blueprint string in the book and deploy its ghosts
    local blueprint_table = decode_blueprint_string(blueprint_strings[1])
    if blueprint_table then
        deploy_ghost_entities(blueprint_table.entities, surface, position, force)
    end
end

-- Deploy ghosts based on the decoded blueprint table
function deploy_ghost_entities(entities, surface, position, force)
    for _, entity_info in ipairs(entities) do
        local ghost_position = {x = position.x + entity_info.position.x, y = position.y + entity_info.position.y}
        surface.create_entity({
            name = "entity-ghost",
            inner_name = entity_info.name,
            position = ghost_position,
            force = force,
            direction = entity_info.direction,
        })
    end
end

-- Handling GUI button clicks, including the cycle button
script.on_event(defines.events.on_gui_click, function(event)
    local player = game.players[event.player_index]
    local mcv = global.mcv

    if event.element.name == "deploy_mcv_button" and mcv then
        -- Find and deploy the first blueprint from the specified kit
        for kit_name, blueprint_strings in pairs(global.kit_to_blueprint_book) do
            local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
            if inventory.remove({name = kit_name, count = 1}) then
                deploy_first_blueprint_from_book(blueprint_strings, mcv)
                player.print("Deployed first blueprint from " .. kit_name)
                break
            end
        end
    elseif event.element.name == "cycle_blueprint_button" and mcv then
        player.print("Cycling blueprints is not implemented yet.")
        for kit_name, blueprint_strings in pairs(global.kit_to_blueprint_book) do
            global.current_blueprint_index = (global.current_blueprint_index % #blueprint_strings) + 1
            deploy_first_blueprint_from_book(blueprint_strings, mcv)
            player.print("Cycled to blueprint #" .. global.current_blueprint_index)
            break
        end
    end
end)

-- Example call after deploying a blueprint
script.on_init(function()
    global.deployments = {}
    -- Initialize other global variables as needed
end)


function decode_and_print_blueprint_entities(spidertron)
    -- Access the spidertron's trunk inventory
    local inventory = spidertron.get_inventory(defines.inventory.spider_trunk)
    if not inventory then return end  -- Early exit if no inventory

    -- Find the first blueprint or blueprint book
    for i = 1, #inventory do
        local item = inventory[i]
        if item.valid_for_read then
            if item.is_blueprint and item.is_blueprint_setup() then
                -- Handle single blueprint
                print_blueprint_entities(item)
                break
            elseif item.is_blueprint_book and item.active_index > 0 then
                -- Handle blueprint book
                local book_inventory = item.get_inventory(defines.inventory.item_main)
                local blueprint = book_inventory[item.active_index]
                if blueprint and blueprint.valid_for_read and blueprint.is_blueprint_setup() then
                    print_blueprint_entities(blueprint)
                    break
                end
            end
        end
    end
end

function print_blueprint_entities(blueprint_item)
    local blueprint_data = blueprint_item.get_blueprint_entities()
    if blueprint_data then
        for _, entity in pairs(blueprint_data) do
            game.print("Entity: " .. entity.name .. " at position (" .. entity.position.x .. ", " .. entity.position.y .. ")")
        end
    else
        game.print("No entities in blueprint.")
    end
end
