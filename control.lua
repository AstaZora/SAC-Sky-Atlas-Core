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

-- Function to create GUI buttons
function create_buttons(player)
    local top_gui = player.gui.top
    if not top_gui.deploy_mcv_button then
        top_gui.add({type = "button", name = "deploy_mcv_button", caption = "Deploy MCV"})
    end
    if not top_gui.cycle_blueprint_button then
        top_gui.add({type = "button", name = "cycle_blueprint_button", caption = "Cycle Blueprint"})
    end
end

-- Function to handle GUI button click
function on_gui_click(event)
    local mcv = global.mcv

    if event.element.name == "deploy_mcv_button" then
        -- Handle MCV deployment
        convert_kit_and_deploy_first_blueprint(mcv, player)
    elseif event.element.name == "cycle_blueprint_button" and mcv then
        -- Cycle through blueprints in the book
        cycle_and_deploy_next_blueprint(mcv, player)
    end
end

-- Convert kit in MCV to a blueprint or book and deploy first blueprint
function convert_kit_and_deploy_first_blueprint(mcv, player)
    local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
    for kit_name, blueprint_strings in pairs(global.kit_to_blueprint_book) do
        if inventory.get_item_count(kit_name) > 0 then
            inventory.remove({name = kit_name, count = 1}) -- Remove the kit
            -- Convert to blueprint book and deploy the first blueprint
            deploy_first_blueprint_from_book(blueprint_strings, mcv, player)
            break -- Process one kit at a time
        end
    end
end

-- Function to deploy the first blueprint from the blueprint book
function deploy_first_blueprint_from_book(blueprint_strings, mcv, player)
    local surface = mcv.surface
    local force = player.force
    local position = mcv.position -- You might want to adjust the position

    -- Deploy the first blueprint in the book
    local first_blueprint_string = blueprint_strings[1]
    local decoded_table = decode_blueprint_string(first_blueprint_string)
    local prepared_table = prepare_blueprint_for_deployment(decoded_table)
    deploy_blueprint_ghosts(prepared_table, surface, position, force)
    player.print("Deployed first blueprint from kit's book.")
end

-- Function to simulate deploying a blueprint string as ghosts
function deploy_blueprint_ghosts(blueprint_table, surface, position, force)
    for _, entity_info in ipairs(blueprint_table.entities or {}) do
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

-- Decode blueprint string to entity data
function decode_blueprint_string(blueprint_string)
    local json_string = game.decode_string(blueprint_string)
    local blueprint_table = game.json_to_table(json_string)
    return blueprint_table
end

-- Prepare blueprint for deployment
function prepare_blueprint_for_deployment(blueprint_table)
    -- Example: Modify positions or filter entities here
    return blueprint_table
end

-- Cycle through blueprints in a book and deploy next
function cycle_and_deploy_next_blueprint(mcv, player)
    local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
    local blueprint_book = inventory.find_item_stack("blueprint-book")
    if blueprint_book then
        local blueprint_book_data = blueprint_book.get_blueprint_book()
        local active_index = blueprint_book.active_index
        local blueprints = blueprint_book_data.blueprints
        local next_index = active_index + 1
        if next_index > #blueprints then
            next_index = 1
        end
        blueprint_book.active_index = next_index
        local blueprint = blueprints[next_index]
        local decoded_table = decode_blueprint_string(blueprint)
        local prepared_table = prepare_blueprint_for_deployment(decoded_table)
        deploy_blueprint_ghosts(prepared_table, mcv.surface, mcv.position, player.force)
    end
end

-- Event subscriptions
script.on_event(defines.events.on_built_entity, track_mcv_placement)
script.on_event(defines.events.on_player_joined_game, function(event)
    create_buttons(game.players[event.player_index])
end)
script.on_event(defines.events.on_gui_click, on_gui_click)
