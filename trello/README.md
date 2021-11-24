Эта штука управляла [доской персонала](https://staff.trigon.im).

Записывала наигранное время, кол-во входов и тд

Удалена по ненадобности


## `lua/autorun/trello.lua`:

```lua
TRL = TRL or {}

local function include(p)
	includeSV("trello/" .. p)
end

local function includeFolder(p)
	for _,f in pairs(file.Find("trello/" .. p .. "/*.lua","LUA")) do
		include(p .. "/" .. f)
	end
end


include("objects/__core.lua")
includeFolder("objects")
include("core.lua")

LoadModules("trello/modules", "TRELLO")
```