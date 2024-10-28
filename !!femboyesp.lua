-- femboy esp

local femboy = render.load_image('primordial\\scripts\\femboy.jpg')

local opacity = menu.add_slider("opacity", "opacity", 0, 255)
opacity:set(255)

-- Debug to check what type `femboy` actually is
print("Type of femboy:", type(femboy))

local function render_image_on_enemy()
    local local_player = entity_list.get_local_player()  -- Get the local player
    if not local_player then return end  -- Ensure local player is valid

    local enemies_only = entity_list.get_players(true)  -- Get all enemy players

    for _, player in pairs(enemies_only) do
        if player ~= nil and player:is_alive() then  -- Ensure player is valid and alive
            local position = player:get_hitbox_pos(e_hitboxes.BODY)  -- Get the head position

            -- Convert head position to 2D screen coordinates
            local screen_pos = render.world_to_screen(position)
            if screen_pos then  -- Check if position is on-screen
                -- Calculate distance between local player and enemy
                local distance = (local_player:get_hitbox_pos(e_hitboxes.HEAD) - player:get_hitbox_pos(e_hitboxes.HEAD)):length()

                -- Scale size based on distance (adjust the scaling factor as needed)
                local scale_factor = 1000 / distance
                local width = 30 * scale_factor
                local height = 60 * scale_factor

                -- Adjust the screen position to center the image on the head
                local centered_pos = vec2_t(screen_pos.x - width / 2, screen_pos.y - height / 2)

                -- Render the texture at the centered position with scaled size
                render.texture(femboy.id, centered_pos, vec2_t(width, height), color_t(255, 255, 255, opacity:get()))
            end
        end
    end
end

-- Register the function to be called every frame
callbacks.add(e_callbacks.PAINT, render_image_on_enemy)
