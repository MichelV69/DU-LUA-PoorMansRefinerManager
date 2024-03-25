unit.stopTimer("CheckStatus")

for IndustryIndex = 1, #IndustryList do
    switch_product(IndustryList[IndustryIndex])
end

unit.setTimer("CheckStatus", cycleTimeSeconds)
--- ### unit.OnTimer(1) EOF ### ---
