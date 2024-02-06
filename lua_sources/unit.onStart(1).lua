--- ### unit.onstart(1) --- 
desiredOreLoadInStock = 222 --export: Maintain how much of each?
cycleTimeSeconds = 11       --export: Check connected industry how often?
version = "1.1.1"
rev_date = "05Feb2024"

function switch_product(industryID)
    local currentItem = industryID.getOutputs()

    -- linked list to cycle possible recipes
    local cycleList = {}

    cycleList[OreList.T1.aluminum]	= OreList.T1.carbon;
    cycleList[OreList.T1.carbon] 	= OreList.T1.iron;
    cycleList[OreList.T1.iron] 		= OreList.T1.silicon;
    cycleList[OreList.T1.silicon] 	= OreList.T2.chromium;
								
    cycleList[OreList.T2.chromium]	= OreList.T2.calcium;
    cycleList[OreList.T2.calcium]	= OreList.T2.copper;	
    cycleList[OreList.T2.copper]	= OreList.T2.natron;
    cycleList[OreList.T2.sodium]	= OreList.T1.aluminum;	

    if not cycleList[currentItem[1].id] then
        -- if the refiner was doing a batch of something else, fall back to T1
        currentItem[1].id = OreList.T1.aluminum
        end

    -- handle the refiner
    industryID.stop(true)
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

unit.setTimer("CheckStatus",3)
	
--- EOF unit.onstart(1) --- 