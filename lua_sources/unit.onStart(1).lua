--- ### unit.onstart(1) --- 
desiredOreLoadInStock = 444 --export: Maintain how much of each?
cycleTimeSeconds = 21 --export: Check connected industry how often?
forceBottomStart = true --export: when first booting, force all machines to start with OreList.T1.aluminum

version = "1.1.4"
rev_date = "12Feb2024"

function switch_product(industryID)
    local stopImmediate = false
    local stopDestructive = false
    industryID.stop(stopImmediate, stopDestructive)
    local currentItem = industryID.getOutputs()
  
    -- linked list to cycle possible recipes
    local cycleList = {}

    cycleList[OreList.T1.oxygen]	= OreList.T1.aluminum;
    cycleList[OreList.T1.aluminum]	= OreList.T1.carbon;
    cycleList[OreList.T1.carbon] 	= OreList.T1.iron;
    cycleList[OreList.T1.iron] 	    = OreList.T1.silicon;
    cycleList[OreList.T1.silicon] 	= OreList.T1.hydrogen;
    cycleList[OreList.T1.hydrogen] 	= OreList.T2.chromium;
								
    cycleList[OreList.T2.chromium]	= OreList.T2.calcium;
    cycleList[OreList.T2.calcium]	= OreList.T2.copper;	
    cycleList[OreList.T2.copper]	= OreList.T2.sodium;
    cycleList[OreList.T2.sodium]	= OreList.Default;	

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
        currentItem[1].id = OreList.Default
        end    
    
    -- handle the refiner
    industryID.setOutput(cycleList[currentItem[1].id])
    industryID.startMaintain(desiredOreLoadInStock) 

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