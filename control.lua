-- Correct initialization of global variables
global.mcv = {} -- Initialize as nil to store the MCV entity
global.timeouts = {}

-- Function to track MCV placement
local function track_mcv_placement(event)
    local entity = event.created_entity
    if entity.name == "mcv" then
        global.mcv = entity
    end
end

-- Event handler for entity placement
script.on_event(defines.events.on_built_entity, track_mcv_placement)
script.on_event(defines.events.on_robot_built_entity, track_mcv_placement)

local function deploy_mcv(player, mcv)
    if not (mcv and mcv.valid) then
        player.print("No MCV found or it's invalid.")
        return
    end

    -- Example: Deploying a structure where the MCV is located
    local position = mcv.position
    local surface = mcv.surface
    local force = player.force
    local deployed_structure = surface.create_entity({
        name = "assembling-machine-1",  -- Example entity, replace with your desired entity
        position = position,
        force = force
    })

    if deployed_structure then
        player.print("MCV deployed successfully.")
        -- Optionally, you could remove the MCV after deployment
        -- mcv.destroy()
    else
        player.print("Failed to deploy MCV.")
    end
end


local function cycle_blueprint_book_button(player, mcv)
    if not (mcv and mcv.valid) then
        player.print("No MCV found or it's invalid.")
        return
    end

function convert_kit_to_blueprint_book(mcv, player)
    local inventory = mcv.get_inventory(defines.inventory.chest)
    if inventory and inventory.remove({name = "energy-defense-kit", count = 1}) then
        -- Assuming the blueprint book is successfully inserted
        local book = inventory.insert({name = "blueprint-book", count = 1})
        if book then
            player.print("Blueprint book created in MCV.")
            -- Here you would programmatically insert blueprints into the book.
            -- This part is tricky because Factorio's API at my last update does not support directly manipulating blueprint books this way.
            -- You'd likely need to manually handle the book creation and blueprint insertion outside the game,
            -- then have the player insert the book already prepared, or use commands to setup the book.
        else
            player.print("Failed to insert blueprint book into MCV.")
        end
    else
        player.print("No 'energy-defense-kit' found in the MCV.")
    end
end

end



-- Event handler for GUI clicks
script.on_event(defines.events.on_gui_click, function(event)
    local player = game.get_player(event.player_index)
    local element = event.element
    local mcv = global.mcv -- Adjust based on how you're tracking MCVs

    if element.name == "deploy_mcv" then
        deploy_mcv(player, mcv)
    elseif element.name == "cycle_blueprint_book_button" then
        cycle_blueprint_book_button(player, mcv)
    end
end)

-- Function to create GUI buttons
local function create_buttons(player)
    local top_gui = player.gui.top

    -- Create or get the flow container
    local button_flow = top_gui["button_flow"]
    if not button_flow then
        button_flow = top_gui.add{type = "flow", name = "button_flow", direction = "horizontal"}
    end

    -- Add the deploy button
    if not button_flow["deploy_mcv"] then
        button_flow.add{type = "button", name = "deploy_mcv", caption = "Deploy MCV", tooltip = "Deploy the MCV to build a new base"}
    end

    -- Add the blueprint book button
    if not button_flow["cycle_blueprint_book_button"] then
        button_flow.add{type = "button", name = "cycle_blueprint_book_button", caption = "Cycle Blueprint Book"}
    end
end

-- Event handler for player joining the game
script.on_event(defines.events.on_player_joined_game, function(event)
    local player = game.get_player(event.player_index)
    create_buttons(player)
end)

-- Simplified timeout handling (ensure your usage of timeouts is necessary and optimized)
script.on_event(defines.events.on_tick, function(event)
    local timeouts = global.timeouts[event.tick]
    if timeouts then
        for _, timeout in ipairs(timeouts) do
            timeout.func()
        end
        global.timeouts[event.tick] = nil
    end
end)

-- Function to set a timeout
function set_timeout(func, delay)
    local trigger_tick = game.tick + delay
    if not global.timeouts[trigger_tick] then
        global.timeouts[trigger_tick] = {}
    end
    table.insert(global.timeouts[trigger_tick], {func = func})
end