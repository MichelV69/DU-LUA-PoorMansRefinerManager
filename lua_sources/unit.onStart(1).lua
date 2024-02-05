--- ### unit.onstart(1) --- 
desiredOreLoadInStock = 222 --export: Maintain how much of each?
cycleTimeSeconds = 11       --export: Check connected industry how often?
version = "1.1.0"
rev_date = "05Feb2024"

function switch_product(industryID)
    -- first, turn the running timer off
    unit.stopTimer("CheckStatus")

    local currentItem = industryID.getOutputs()

    -- linked list to cycle possible recipes
    local cylcleList = {}

    cylcleList[OreList.T1.aluminum]	= OreList.T1.carbon;
    cylcleList[OreList.T1.carbon] 	= OreList.T1.iron;
    cylcleList[OreList.T1.iron] 	= OreList.T1.silicon;
    cylcleList[OreList.T1.silicon] 	= OreList.T2.chromium;
	
	
	cylcleList[OreList.T2.chromium]	= OreList.T2.calcium;
    cylcleList[OreList.T2.calcium]	= OreList.T2.copper;	
    cylcleList[OreList.T2.copper]	= OreList.T2.natron;
    cylcleList[OreList.T2.natron]	= OreList.T1.aluminum;	

    if not cylcleList[currentItem[1].id] then
        -- if the refiner was doing a batch of something else, fall back to T1
        currentItem = OreList.T1.aluminum
        end

    -- handle the refiner
    industryID.stop(true)
    industryID.setOutput(cylcleList[currentItem[1].id])
    industryID.startMaintain(desiredOreLoadInStock) 

    end
	
--- ### main code

IndustryList = {}
for i = 1, 9, 1 do
  if SlotList[i] and SlotList[i].getState() ~= nil then
    table.insert(LightsList, SlotList[i])
    SlotList[i].stop(true)
  end
end

unit.setTimer("CheckStatus",21)

	
--- EOF unit.onstart(1) --- 