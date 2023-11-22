dofile_once("data/scripts/items/potion_starting.lua")

function OnMagicNumbersAndWorldSeedInitialized()
    local new_seed = tonumber(StatsGetValue("world_seed"))
    for tries=0,1000 do --should be plenty of tries; but want to 'time out' if something goes wrong too
        SetWorldSeed(new_seed)
        --i dont exactly know *why* these constants but they give the correct results
        SetRandomSeed(-4.5,-4)
        if potion_a_materials() == "magic_liquid_movement_faster" then
            break
        end

        new_seed = new_seed + 1
        if new_seed > 0x7FFFFFFF then --32b signed limit of seed
            new_seed = 1
        end
    end
end
