-- Register a custom command for testing
commands.add_command("deployBlueprint", "Deploys the first blueprint from the newest Spidertron.", function()
    -- Initialize variable to hold the spidertron
    local spidertron = nil

    -- Find the newest spidertron by iterating through all entities named "spider-vehicle"
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
end)

function deployBlueprintEntities(blueprint, spidertron)
    local entities = blueprint.get_blueprint_entities()
    local surface = spidertron.surface
    local force = spidertron.force
    local offset = spidertron.position

    -- Check and print the number of entities to deploy
    if entities then
        game.print("Deploying " .. #entities .. " entities.")
    else
        game.print("No entities found in blueprint.")
        return
    end

    -- Deploy entities
    for _, entity in pairs(entities) do
        local position = {x = offset.x + entity.position.x, y = offset.y + entity.position.y}
        local created_entity = surface.create_entity{
            name = entity.name,
            position = position,
            direction = entity.direction,
            force = force,
        }
        if created_entity then
            game.print("Created entity: " .. entity.name)
        else
            game.print("Failed to create entity: " .. entity.name)
        end
    end
end
