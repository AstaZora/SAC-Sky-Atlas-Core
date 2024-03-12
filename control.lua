-- Correct initialization of global variables
global.mcv = {} -- Initialize as nil to store the MCV entity

-- Add the button to the player's GUI when they join the game
script.on_event(defines.events.on_player_joined_game, function(event)
    local player = game.players[event.player_index]
    if not player.gui.top["show_clusters_button"] then
        player.gui.top.add{type="button", name="deploy_mcv", caption="Deploy MCV", tooltip="Deploy the MCV to build a new base"}
    end
end)

-- Monitor the construction of entities to identify MCV
script.on_event(defines.events.on_built_entity, function(event)
    local entity = event.created_entity
    --game.print("Entity built: " .. (entity and entity.valid and entity.name or "nil"))
    if entity and entity.valid and entity.name == "mcv" then
        game.print("MCV (Spidertron) created")
        global.mcv = entity -- Store the MCV entity
    end
end)

-- Handle button click
script.on_event(defines.events.on_gui_click, function(event)
    if event.element.name == "deploy_mcv" and global.mcv and global.mcv.valid then
        local mcv = global.mcv
        local position = mcv.position
        local force = mcv.force
        local surface = mcv.surface
        game.print{"Attempting to Place Assembler at: ", position}

        
        -- Move the MCV slightly
        mcv.teleport({mcv.position.x + 1, mcv.position.y + 1})
        local position = {x = math.floor(mcv.position.x + 0.5), y = math.floor(mcv.position.y + 0.5)}
        game.print{"MCV position: ", position.x, position.y}

        -- Create the assembler at the MCV's original position
        local building = surface.create_entity{
            name = "assembling-machine-1",
            position = position,
            force = force
        }

        -- Create solar panels to the north, east, south, and west of the assembler
        local directions = {{0, -1.5}, {1.5, 0}, {0, 1.5}, {-1.5, 0}}
        for _, direction in ipairs(directions) do
            surface.create_entity{
                name = "solar-panel",
                position = {position.x + direction[1]*2, position.y + direction[2]*2},
                force = force
            }
        end

        -- Create accumulators at the corners of the assembler
        local corners = {{-2, -2}, {3, -2}, {-2.5, 2.5}, {3, 3}}
        for i, corner in ipairs(corners) do
            -- Replace the first accumulator with a substation
            local entity_name = i == 1 and "substation" or "accumulator"
            surface.create_entity{
                name = entity_name,
                position = {position.x + corner[1], position.y + corner[2]},
                force = force
            }
        end

        game.print("Building: " .. (building and building.valid and building.name or "nil"))

        if building and building.valid then
            game.print("Building deployed")

            -- Destroy the MCV
            mcv.destroy()
            game.print("MCV destroyed")

            -- Clear the reference to the destroyed MCV
            global.mcv = nil
        else
            game.print("Failed to deploy building")
        end
    else
        game.print("No MCV to deploy")
    end
end)