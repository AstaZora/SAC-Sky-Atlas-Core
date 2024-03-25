global.ghost_conversion_tasks = {}

local blueprintStrings = {
    energyDefenseKit = "0eNrtm91u2zgQhV8l0LVciP+kLxfbpyiKQE60hbGOHMhy2iDwu9d2N7CA5RF5EKK90V3sRJ+pmaMhz4zzVm12x+552Pbj/Wa//7dav93eOVTrL5OXl99tH/b9r7cP2299u7u8N74+d9W62o7dU1VXfft0eXXY79ph9dz23a461dW2f+x+VGtx+lpXXT9ux233C3N98XrfH5823XD+gyigrp73h/M1+/7yeWfOyqtPpq5ezz+p5pM5ner/kWQuqUmRVCbJuRRJ55J0imRySSJFspkk61MkR+dOujjJ07lDpEDnDpFEQycPogSdPYiSdPogSvH50wCl+QQi1E3p7cPD8em4a8f9EIuV/w8Ux9hcjJ3FuFyMnsV4XgAoPoEXAEDJhheAACjBCwChJCsAFcVM1H3cHMb2eulM/uMUzeY/juHLNwwPX78hyrGRFlGMZx+1OCawoY5iFC9q4cE5gBc1REl6X4IoRe9LEKVpWUKUoWUJUZbPoAEox2cQoTyfQYQKfAYBSjd8BhFK8Bm8os4n/KsVWE+cQ129dMPhepH0QrsgnfPKK2Vv3qC5LOIPmY2hfWyHxWb8FpuBYr0YjMVgLAZjMRiLwVgMxmIwFoPxJwxG+hy4WIui1iJ9GPyYqRDlTUWdvHJaTm5XSmL2Me77bvW93UUFpAlPkgkSSUsyC1IpkM4EyRQo97Dm1XuIEjOP2eWI1HJcJqhJgW6P/K49dMNqPA5DN0bXNHdjIRfjwhxmakXm7suF1H2JTFE7nyRlH9Pc7K1lanriskXag8ySbJKUbUHM7K1lytqZ5IIyde2SFURkC9vNPrFTFzK7omQpkrnaTtYimavtZBmRmRXbJevIxIWk4j1bSGSmuG2yAkytyCwpWQFkrsW2s8VNZorbJivAxIjkktCOHdgtW6LDbEOTQtKNpPYk9b6mD1mRdLNNqWLdNqWLdduUKdZtm1iRRMzfNQ5iTmsc6onWONQTr3GbtiKZJJd0Irkat1GOpPMW5yg62ujONE1C0TZ0tEH/T1uahBykI32A1FGML9ZG1qFIG9k0RdrIRhRpIxtZrI1sFLl5xzNmeFkDCRlDk9Ct8bKWgORokgIkzz4gMooJxdrstinSZreiRJvdyiJtdquKtdmtZp+PaMIsr2qgIGtpElC15VWNhsieJqFwB3rjj5oJ1xQZaThRZKThZJGRhlP0aSYeHL5Yoz4bL2v0HQK6WKOxgaNlLcDJ2HlWjCJ66neh2PzIN8XmR14Umx95WWx+5GmNx2PuaY0jFXha4/DeeI2Ds7/nNY6+ccMeSETUIPnANsrjnNCwnXLAEWRXGmAk2QEGGMV2WwFHs11EwDHkoQZg6KMIUmGg+yLoyQj0UUQA+xDovgiaq4qmYedsaFGiEezsD6MkOyXDKMVO7jBKs5MpjDLsuAyjLDtUwijHTrowyrPzIIwK7JAKogQ9ycEowY6XMIqe5WCUYgdMGKXZKQxGGXY0hFF8YUelT/CVXX/kiyUyduXq+i+09XnT3JyPpevqc98N317v2v7x7u/un64/dHd/3f65tj5viuP2pbt//wL8zOeefgKVbvln",
    aquacultureKit = "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",
}

global.kit_to_blueprint = {
    ["energy-defense-kit"] = blueprintStrings.energyDefenseKit,
    ["aquaculture-kit"] = blueprintStrings.aquacultureKit,
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
commands.add_command("create_buttons", "Create the MCV buttons", function(command)
    local player = game.get_player(command.player_index)
    if player then
        create_buttons(player)
        game.print("Buttons created")
    end
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

    -- Debugging: print out all items in the inventory
    for i = 1, #inventory do
        local stack = inventory[i]
        if stack.valid_for_read then
            game.print("Inventory slot " .. i .. ": " .. stack.name)
        end
    end

    for kitName, blueprintString in pairs(global.kit_to_blueprint) do
        game.print("Checking for kit: " .. kitName)
        local count = inventory.get_item_count(kitName)
        game.print("Count for " .. kitName .. ": " .. count)
        if count > 0 then
            game.print("Found kit: " .. kitName)
            inventory.remove({name = kitName, count = 1})  -- Remove the kit from the inventory.
            local importSuccess = import_blueprint_to_mcv(blueprintString, mcv)
            if importSuccess then
                deploy_imported_blueprint_from_mcv(mcv)
            else
                game.print("Error importing blueprint/book for " .. kitName)
                inventory.insert({name = kitName, count = 1})
            end
            -- Remove break if you want to continue checking other slots after finding a kit.
            break
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


