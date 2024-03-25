--- ### unit.onstart(1) ---
desiredOreLoadInStock = 777 --export: Maintain how much of each?
cycleTimeSeconds = 3.33     --export: Check connected industry how often?
forceBottomStart = true     --export: when first booting, force all machines to start with OreList.T1.aluminum

version = "1.2.3"
rev_date = "24March2024"

function switch_product(industryID)
    if industryID.getState() == IndustryStatus.running then
        return
    end

    local stopImmediate                 = false
    local stopDestructive               = false
    local currentItem                   = industryID.getOutputs()

    -- linked list to cycle possible recipes
    local cycleList                     = {}

    cycleList[OreList.T1.oxygen.pure]   = OreList.T1.aluminum.ore;
    cycleList[OreList.T1.aluminum.ore]  = OreList.T1.carbon.ore;
    cycleList[OreList.T1.carbon.ore]    = OreList.T1.iron.ore;
    cycleList[OreList.T1.iron.ore]      = OreList.T1.silicon.ore;
    cycleList[OreList.T1.silicon.ore]   = OreList.T1.hydrogen.pure;
    cycleList[OreList.T1.hydrogen.pure] = OreList.T2.chromium.ore;

    cycleList[OreList.T2.chromium.ore]  = OreList.T2.calcium.ore;
    cycleList[OreList.T2.calcium.ore]   = OreList.T2.copper.ore;
    cycleList[OreList.T2.copper.ore]    = OreList.T2.sodium.ore;
    cycleList[OreList.T2.sodium.ore]    = OreList.T3.sulfur.ore;

    cycleList[OreList.T3.sulfur.ore]    = OreList.Default;

    if currentItem == nil then
        currentItem = {}
        currentItem[1] = {}
    end

    if not cycleList[currentItem[1].id] then
        -- if the refiner was doing a batch of something else, fall back to T1
        currentItem[1].id = OreList.Default
    end

    if forceBottomStart then
        forceBottomStart = false
        currentItem[1].id = OreList.T1.aluminum.ore
    end

    -- handle the refiner
    industryID.stop(stopImmediate, stopDestructive)
    industryID.setOutput(cycleList[currentItem[1].id])
    industryID.startMaintain(desiredOreLoadInStock)

    return
end

--- ### main code

IndustryList = {}
for i = 1, 9, 1 do
    if SlotList[i] and SlotList[i].getState() ~= nil then
        table.insert(IndustryList, SlotList[i])
        SlotList[i].stop(true)
    end
end

unit.setTimer("CheckStatus", 1)
--- EOF unit.onstart(1) ---
