local component = require('component')
local sides = require('sides')
local config = require('config')
local geolyzer = component.geolyzer
local tier_handler={weed=1, beetroots=1, pumpkin=1, wheat=1,blackthorn=2, brown_mushroom=2, carrots=2, cyazint=2, dandelion=2, flax=2, melon=2, potato=2, red_mushroom=2, reed=2, rose=2, tulip=2, cocoa=3, venomilia=3, stickreed=4, corpse_plant=5, hops=5, nether_wart=5, terra_wart=5, aurelia=6, blazereed=6, corium=6, stagnium=6, cyprium=6, eatingplant=6, egg_plant=6, ferru=6, milk_wart=6, plumbiscus=6, redwheat=6, shining=6, slime_plant=6, spidernip=7, coffee=7, creeper_weed=7, meat_rose=7, tearstalks=8, wither_reed=8, oil_berries=9, ender_blossom=10, bobs_yer_unkle_ranks_berries=11, diareed=12}

local function scan()
    local rawResult = geolyzer.analyze(sides.down)

    -- AIR
    if rawResult.id == 'minecraft:air' or rawResult.id == 'GalacticraftCore:tile.brightAir' then
        return {isCrop=true, name='air'}

    elseif rawResult.id == 'IC2:crop' then

        -- EMPTY CROP STICK
        if rawResult['crop:id'] == nil then
            return {isCrop=true, name='emptyCrop'}

        -- FILLED CROP STICK
        else
            
            return {
                isCrop=true,
                name = rawResult['crop:id'],
                gr = rawResult['crop:growth'],
                ga = rawResult['crop:gain'],
                re = rawResult['crop:resistance'],
                tier = tier_handler[rawResult['crop:id']],
            }
        end

    -- RANDOM BLOCK
    else
        return {isCrop=false, name='block'}
    end
end

return {
    scan = scan
}