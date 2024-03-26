# DU-LUA-PoorMansRefinerManager
## Dual Universe - LUA - Industry Utility - Refiners

Monitors up to eight refiners from a single Programming Board and automatically cycles them to doing something useful if they are idle due to "jam" or "maintain - satisfied (pending)" conditions.

Based on original code found at https://du-creators.org/makers/Cozzmo/ship/Poor%20man%27s%20refiner , suspected to be orphanware.

You can set the amount of material to be maintained via `[Right Click] -> Advanced -> Edit LUA Parameters`.

Parameters Available Are:

  * Desired Ore Load In Stock (default: 1111)
  * Cycle Time In Seconds (default: 3.33)
  * Force Bottom Start (default: Yes)
