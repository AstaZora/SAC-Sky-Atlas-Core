global.ghost_conversion_tasks = {}

local blueprintStrings = {
    energyDefenseKit = "0eNrtm91u2zgQhV8l0LVciP+kLxfbpyiKQE60hbGOHMhy2iDwu9d2N7CA5RF5EKK90V3sRJ+pmaMhz4zzVm12x+552Pbj/Wa//7dav93eOVTrL5OXl99tH/b9r7cP2299u7u8N74+d9W62o7dU1VXfft0eXXY79ph9dz23a461dW2f+x+VGtx+lpXXT9ux233C3N98XrfH5823XD+gyigrp73h/M1+/7yeWfOyqtPpq5ezz+p5pM5ner/kWQuqUmRVCbJuRRJ55J0imRySSJFspkk61MkR+dOujjJ07lDpEDnDpFEQycPogSdPYiSdPogSvH50wCl+QQi1E3p7cPD8em4a8f9EIuV/w8Ux9hcjJ3FuFyMnsV4XgAoPoEXAEDJhheAACjBCwChJCsAFcVM1H3cHMb2eulM/uMUzeY/juHLNwwPX78hyrGRFlGMZx+1OCawoY5iFC9q4cE5gBc1REl6X4IoRe9LEKVpWUKUoWUJUZbPoAEox2cQoTyfQYQKfAYBSjd8BhFK8Bm8os4n/KsVWE+cQ129dMPhepH0QrsgnfPKK2Vv3qC5LOIPmY2hfWyHxWb8FpuBYr0YjMVgLAZjMRiLwVgMxmIwFoPxJwxG+hy4WIui1iJ9GPyYqRDlTUWdvHJaTm5XSmL2Me77bvW93UUFpAlPkgkSSUsyC1IpkM4EyRQo97Dm1XuIEjOP2eWI1HJcJqhJgW6P/K49dMNqPA5DN0bXNHdjIRfjwhxmakXm7suF1H2JTFE7nyRlH9Pc7K1lanriskXag8ySbJKUbUHM7K1lytqZ5IIyde2SFURkC9vNPrFTFzK7omQpkrnaTtYimavtZBmRmRXbJevIxIWk4j1bSGSmuG2yAkytyCwpWQFkrsW2s8VNZorbJivAxIjkktCOHdgtW6LDbEOTQtKNpPYk9b6mD1mRdLNNqWLdNqWLdduUKdZtm1iRRMzfNQ5iTmsc6onWONQTr3GbtiKZJJd0Irkat1GOpPMW5yg62ujONE1C0TZ0tEH/T1uahBykI32A1FGML9ZG1qFIG9k0RdrIRhRpIxtZrI1sFLl5xzNmeFkDCRlDk9Ct8bKWgORokgIkzz4gMooJxdrstinSZreiRJvdyiJtdquKtdmtZp+PaMIsr2qgIGtpElC15VWNhsieJqFwB3rjj5oJ1xQZaThRZKThZJGRhlP0aSYeHL5Yoz4bL2v0HQK6WKOxgaNlLcDJ2HlWjCJ66neh2PzIN8XmR14Umx95WWx+5GmNx2PuaY0jFXha4/DeeI2Ds7/nNY6+ccMeSETUIPnANsrjnNCwnXLAEWRXGmAk2QEGGMV2WwFHs11EwDHkoQZg6KMIUmGg+yLoyQj0UUQA+xDovgiaq4qmYedsaFGiEezsD6MkOyXDKMVO7jBKs5MpjDLsuAyjLDtUwijHTrowyrPzIIwK7JAKogQ9ycEowY6XMIqe5WCUYgdMGKXZKQxGGXY0hFF8YUelT/CVXX/kiyUyduXq+i+09XnT3JyPpevqc98N317v2v7x7u/un64/dHd/3f65tj5viuP2pbt//wL8zOeefgKVbvln",
}

global.kit_to_blueprint = {
    ["energy-defense-kit"] = blueprintStrings.energyDefenseKit
}
script.on_init(function()
    global.active_blueprint_index = 1 -- Start with the first blueprint as active
    -- Other initialization code
end)

script.on_init(function()
    global.ghost_conversion_tasks = global.ghost_conversion_tasks or {}
    global.mcv = nil  -- No MCV at start.
    game.print("on_init called")
end)

script.on_configuration_changed(function()
    global.ghost_conversion_tasks = global.ghost_conversion_tasks or {}
    game.print("on_configuration_changed called")
end)

script.on_event(defines.events.on_built_entity, function(event)
    if event.created_entity.name == "mcv" then
        global.mcv = event.created_entity
        game.print("MCV entity built")
    end
end)

script.on_event(defines.events.on_player_joined_game, function(event)
    local player = game.get_player(event.player_index)
    create_buttons(player)
    game.print("Player joined game")
end)

script.on_event(defines.events.on_gui_click, function(event)
    if event.element.name == "deploy_mcv_button" then
        convert_and_deploy_kit_from_mcv(global.mcv)
    elseif event.element.name == "cycle_blueprint_button" then
        cycle_blueprints_in_mcv(global.mcv)
        deploy_imported_blueprint_from_mcv(global.mcv)
    elseif event.element.name == "confirm_build_button" then
        convert_ghosts_to_buildings(global.mcv)
    end
end)

function has_active_blueprint_book(mcv)
    local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
    for i = 1, #inventory do
        local item = inventory[i]
        if item.valid_for_read and item.is_blueprint_book then
            return true -- Found an active blueprint book
        end
    end
    return false -- No active blueprint book found
end

script.on_event(defines.events.on_tick, function(event)
    if global.ghost_conversion_tasks and next(global.ghost_conversion_tasks) then
        local tasks = global.ghost_conversion_tasks[event.tick]
        if tasks then
            for _, task in pairs(tasks) do
                convert_ghosts_to_buildings(task.mcv)
            end
            global.ghost_conversion_tasks[event.tick] = nil -- Clear the tasks for this tick
        end
    end
end)

function import_blueprint_to_mcv(blueprintString, mcv)
    game.print("import_blueprint_to_mcv function called")
    local importResult = mcv.get_inventory(defines.inventory.spider_trunk).import_stack(blueprintString)
    if importResult == 0 then
        game.print("Blueprint/book imported successfully.")
        return true
    else
        game.print("Failed to import blueprint/book. Result code: " .. importResult)
        return false
    end
end

function import_blueprint_to_mcv(blueprintString, mcv)
    game.print("import_blueprint_to_mcv function called")
    -- Ensure there's an empty slot or a designated slot in MCV's inventory for import
    local tempSlot = mcv.get_inventory(defines.inventory.spider_trunk)[1] -- Assuming slot 1 is reserved for this

    if tempSlot.can_set_stack({name = "blueprint", count = 1}) then
        -- Attempt to import the blueprint string into the temporary slot
        local importResult = tempSlot.import_stack(blueprintString)

        if importResult == 0 then
            game.print("Blueprint/book imported successfully into MCV.")
            return true
        else
            game.print("Failed to import blueprint/book. Result code: " .. tostring(importResult))
            return false
        end
    else
        game.print("Error: No available slot for importing blueprint/book.")
        return false
    end
end
function cycle_blueprints_in_mcv(mcv)
    local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
    for i = 1, #inventory do
        local item = inventory[i]
        if item.valid_for_read and item.is_blueprint_book then
            -- Cycle to the next blueprint within the book
            local book_inventory = item.get_inventory(defines.inventory.item_main)
            local active_index = item.active_index
            active_index = active_index % #book_inventory + 1 -- Cycle
            item.active_index = active_index

            -- Clear old ghosts and deploy new ones
            clear_ghosts_around_mcv(mcv)
            deploy_imported_blueprint_from_mcv(mcv)

            game.print("Cycled to blueprint #" .. active_index .. " in the book.")
            break -- Assuming only one blueprint book is handled at a time
        end
    end
end



function deploy_active_blueprint_from_book(book_item, mcv)
    game.print("deploy_active_blueprint_from_book function called")
    local book_inventory = book_item.get_inventory(defines.inventory.item_main)
    local active_blueprint = book_inventory[book_item.active_index]
    if active_blueprint and active_blueprint.valid_for_read and active_blueprint.is_blueprint_setup() then
        deploy_blueprint_entities_as_ghosts(active_blueprint.get_blueprint_entities(), mcv)
        game.print("Deployed active blueprint from blueprint book.")
    else
        game.print("No active blueprint found in the book or it's not ready for deployment.")
    end
end

function create_buttons(player)
    local top_gui = player.gui.top
    if not top_gui.deploy_mcv_button then
        top_gui.add({type = "button", name = "deploy_mcv_button", caption = "Deploy MCV"})
    end
    if not top_gui.cycle_blueprint_button then
        top_gui.add({type = "button", name = "cycle_blueprint_button", caption = "Cycle Blueprint"})
    end
    if not top_gui.confirm_build_button then
        top_gui.add({type = "button", name = "confirm_build_button", caption = "Confirm Build"})
    end
end


function convert_and_deploy_kit_from_mcv(mcv)
    game.print("convert_and_deploy_kit_from_mcv function called")
    local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
    for kitName, _ in pairs(global.kit_to_blueprint) do
        if inventory.get_item_count(kitName) > 0 then
            inventory.remove({name = kitName, count = 1})  -- Remove the kit from the inventory.
            local blueprintString = global.kit_to_blueprint[kitName]
            if blueprintString then
                -- Import the blueprint string directly to the MCV's inventory.
                local importSuccess = import_blueprint_to_mcv(blueprintString, mcv)
                if importSuccess then
                    -- Deploy the blueprint/book from the MCV's inventory.
                    deploy_imported_blueprint_from_mcv(mcv)
                else
                    game.print("Error importing blueprint/book for " .. kitName)
                end
            else
                game.print("Blueprint/book string not found for kit: " .. kitName)
            end
            break  -- Process only one kit at a time for simplicity.
        end
    end
end

function deploy_blueprint_from_book(blueprint_string, mcv)
    game.print("deploy_blueprint_from_book function called")
    local temp_inventory = game.create_inventory(1)  -- Temporary inventory for import
    local result = temp_inventory[1].import_stack(blueprint_string)
    local success = false

    if result == 0 then
        success = true
        -- Handle the imported blueprint or book here, e.g., deploy directly or insert into MCV's inventory
    elseif result == -1 then
        game.print("Blueprint/book imported with errors.")
    else
        game.print("Failed to import blueprint/book.")
    end

    temp_inventory.destroy()  -- Clean up
    return success
end

function deploy_blueprint_from_kit(kitName, mcv)
    game.print("deploy_blueprint_from_kit function called")
    local blueprintString = global.kit_to_blueprint[kitName]
    if blueprintString then
        -- Attempt to import the blueprint/book directly to the MCV's inventory
        local importSuccess = import_blueprint_to_mcv(blueprintString, mcv)
        if importSuccess then
            -- If import is successful, attempt to deploy the imported blueprint/book
            local deploySuccess = deploy_imported_blueprint_from_mcv(mcv)
            if deploySuccess then
                game.print(kitName .. " deployed successfully.")
            else
                game.print("Error deploying from " .. kitName)
            end
        else
            game.print("Error importing blueprint/book for " .. kitName)
        end
    else
        game.print("Error: No blueprint string found for " .. kitName)
    end
end

function clear_ghosts_around_mcv(mcv)
    game.print("Clearing ghosts around MCV")
    local search_area = {
        {mcv.position.x - 100, mcv.position.y - 100},
        {mcv.position.x + 100, mcv.position.y + 100}
    }
    local ghosts = mcv.surface.find_entities_filtered{
        area = search_area,
        name = "entity-ghost",
        force = mcv.force
    }
    for _, ghost in pairs(ghosts) do
        ghost.destroy()
    end
end

function deploy_imported_blueprint_from_mcv(mcv)
    game.print("deploy_imported_blueprint_from_mcv function called")
    local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
    for i = 1, #inventory do
        local item = inventory[i]
        if item.valid_for_read then
            if item.is_blueprint_book then
                -- Clear previous ghosts before deploying new ones
                clear_ghosts_around_mcv(mcv)
                
                game.print("Processing blueprint book")
                local active_index = item.active_index
                local book_inventory = item.get_inventory(defines.inventory.item_main)
                if active_index and active_index > 0 and active_index <= #book_inventory then
                    local blueprint = book_inventory[active_index]
                    if blueprint.valid_for_read and blueprint.is_blueprint_setup() then
                        game.print("Deploying entities from the active blueprint in the book")
                        local success = deploy_blueprint_entities_as_ghosts(blueprint.get_blueprint_entities(), mcv)
                        if success then
                            game.print("Entities deployed successfully")
                            return true
                        else
                            game.print("Failed to deploy entities")
                            return false
                        end
                    end
                end
            elseif item.is_blueprint and item.is_blueprint_setup() then
                -- Clear previous ghosts before deploying new ones
                clear_ghosts_around_mcv(mcv)
                
                game.print("Deploying entities from single blueprint")
                local success = deploy_blueprint_entities_as_ghosts(item.get_blueprint_entities(), mcv)
                if success then
                    game.print("Entities deployed successfully")
                    return true
                else
                    game.print("Failed to deploy entities")
                    return false
                end
            end
        end
    end
    game.print("No valid blueprint or book found to deploy")
    return false
end



function deploy_blueprint_entities_as_ghosts(blueprint_entities, mcv)
    local surface = mcv.surface
    local force = mcv.force
    local mcv_position = mcv.position

    -- Calculate the center of the blueprint
    local min_x, max_x, min_y, max_y = math.huge, -math.huge, math.huge, -math.huge
    for _, entity in ipairs(blueprint_entities) do
        min_x = math.min(min_x, entity.position.x)
        max_x = math.max(max_x, entity.position.x)
        min_y = math.min(min_y, entity.position.y)
        max_y = math.max(max_y, entity.position.y)
    end
    local center_x = (min_x + max_x) / 2
    local center_y = (min_y + max_y) / 2

    -- Deploy entities adjusted to the MCV's position
    for _, entity in ipairs(blueprint_entities) do
        local adjusted_position = {
            x = mcv_position.x + entity.position.x - center_x,
            y = mcv_position.y + entity.position.y - center_y
        }
        surface.create_entity({
            name = "entity-ghost",
            inner_name = entity.name,
            position = adjusted_position,
            force = force,
            direction = entity.direction,
        })
    end
    game.print("Blueprint entities deployed as ghosts.")
end


function convert_ghosts_to_buildings(mcv)
    game.print("convert_ghosts_to_buildings function called")
    -- Define the area around the MCV where you want to search for ghosts
    local search_radius = 50 -- Adjust this value as needed
    local area = {
        {mcv.position.x - search_radius, mcv.position.y - search_radius},
        {mcv.position.x + search_radius, mcv.position.y + search_radius}
    }

    local ghosts = mcv.surface.find_entities_filtered{area = area, name = "entity-ghost", force = mcv.force}
    for _, ghost in ipairs(ghosts) do
        local revive_result = ghost.revive({raise_revive = true})
        if revive_result then
            -- Optional: Handle successful revival, e.g., logging or resource management
        end
    end

    -- Clear the MCV's inventory after building
    clear_mcv_inventory(mcv)
end

function clear_mcv_inventory(mcv)
    local inventory = mcv.get_inventory(defines.inventory.spider_trunk)
    if inventory then
        inventory.clear()
        game.print("MCV inventory cleared.")
    end
end


