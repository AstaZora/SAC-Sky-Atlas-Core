
-- Register a custom command for testing
commands.add_command("deployBlueprint", "Prints entities from the selected blueprint in the newest Spidertron's inventory.", function()
    -- Initialize variable to hold the spidertron
    local spidertron = nil

    -- Find the newest spidertron by iterating through all entities of type "spider-vehicle"
    for _, entity in pairs(game.surfaces['nauvis'].find_entities_filtered{type = "spider-vehicle"}) do
        if not spidertron or (entity.created and spidertron.created_tick and entity.created_tick > spidertron.created_tick) then
            spidertron = entity
        end
    end

    if not spidertron then
        game.print("Spidertron not found.")
        return
    end

    -- Access the spidertron's trunk inventory
    local inventory = spidertron.get_inventory(defines.inventory.spider_trunk)
    if not inventory then
        game.print("Spidertron has no inventory.")
        return
    end

    -- Find and process the first blueprint or blueprint book
    for i = 1, #inventory do
        local item = inventory[i]
        if item.valid_for_read then
            if item.is_blueprint and item.is_blueprint_setup() then
                -- Process a single blueprint
                process_blueprint_entities(item, spidertron)
                break
            elseif item.is_blueprint_book then
                -- Process a blueprint from a blueprint book
                local active_index = item.active_index
                local book_inventory = item.get_inventory(defines.inventory.item_main)
                if active_index and active_index > 0 and active_index <= #book_inventory then
                    local blueprint = book_inventory[active_index]
                    if blueprint and blueprint.valid_for_read and blueprint.is_blueprint_setup() then
                        process_blueprint_entities(blueprint, spidertron)
                        break
                    end
                end
            end
        end
    end
end)
-- Function to process and deploy entities from a blueprint item
function process_blueprint_entities(item, spidertron)
    -- Extract blueprint entities
    local blueprint_entities
    if item.is_blueprint_setup() then
        blueprint_entities = item.get_blueprint_entities()
    end

    if not blueprint_entities or #blueprint_entities == 0 then
        game.print("No entities found in blueprint.")
        return
    end

    -- Deploy the entities as ghosts centered around the spidertron
    deploy_blueprint_entities_as_ghosts(blueprint_entities, spidertron)
end

-- Function to deploy blueprint entities as ghosts, with centering based on spidertron's position
function deploy_blueprint_entities_as_ghosts(blueprint_entities, spidertron)
    local surface = spidertron.surface
    local force = spidertron.force
    local spidertron_position = spidertron.position

    -- Optional: Calculate the center point of the blueprint entities if needed
    local sum_x, sum_y, count = 0, 0, 0
    for _, entity in ipairs(blueprint_entities) do
        sum_x = sum_x + entity.position.x
        sum_y = sum_y + entity.position.y
        count = count + 1
    end
    local center_x, center_y = sum_x / count, sum_y / count

    -- Deploy each entity, adjusting its position relative to the spidertron's position and the calculated center
    for _, entity in ipairs(blueprint_entities) do
        local adjusted_position = {
            x = spidertron_position.x + entity.position.x - center_x,
            y = spidertron_position.y + entity.position.y - center_y
        }

        surface.create_entity({
            name = "entity-ghost",
            inner_name = entity.name,
            position = adjusted_position,
            force = force,
            direction = entity.direction,
        })
    end
end
