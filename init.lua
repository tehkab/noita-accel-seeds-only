dofile_once("data/scripts/lib/coroutines.lua")
dofile_once( "data/scripts/lib/utilities.lua")
dofile_once("data/scripts/items/potion_starting.lua")

function OnModPostInit()
    --this doesnt actually run async(?), not sure why
    --but it generates the output okay nevertheless
    --at the cost of appearing to hang (with nolla's fun error screen) while loading :)
    async(test_all_seeds())
end

function test_all_seeds()
    local f = io.open("mods/accel-seeds-only/test-seed-list","w")
    local frame = GameGetFrameNum()
    io.output(f)
    for new_seed=1,0x7FFFFFFF do
        SetWorldSeed(new_seed)
        --i dont exactly know *why* these constants but they give the correct results
        SetRandomSeed(-4.5,-4)
        if potion_a_materials() == "magic_liquid_movement_faster" then
            f:write(new_seed .. "\n")
        end

        if GameGetFrameNum() ~= frame then
            frame = GameGetFrameNum()
            if 0 == (frame % 30) then
                GamePrint("tested seed " .. new_seed)
            end
        end
    end
    f:close()
end
