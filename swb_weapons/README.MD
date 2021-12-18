# SWB пушки

Колоссальная работа над переписью пушек, которые я взял черт помнит где. Очень минималистичные, компактные и оптимизированные. Возможно, в будущем даже снова вернутся на сервер, если будет нормальное количество игроков и возможности для таких эксперементов

Контент вроде тут:

https://steamcommunity.com/sharedfiles/filedetails/?id=1237973254


# ГО раздатчик
```lua
function DISP_getWeapons()
		return {
			{
				ent = "swb_357",
				name = "[Пистолет] Револьвер",
				amount = 2,
				allow = 2
			},
			{
				ent = "swb_deagle",
				name = "[Пистолет] Desert Eagle",
				amount = 1,
				allow = 1
			},
			{
				ent = "swb_fiveseven",
				name = "[Пистолет] Five-Seven",
				amount = 1,
			},
			{
				ent = "swb_glock18",
				name = "[Пистолет] Glock 18",
				amount = 2,
			},
			{
				ent = "swb_p228",
				name = "[Пистолет] P228",
				amount = 2,
			},
			{
				ent = "swb_usp",
				name = "[Пистолет] USP .45",
				amount = 2,
			},


			{
				ent = "swb_ak47",
				name = "[Автомат] AK-47",
				amount = 2,
				allow = 1
			},
			{
				ent = "swb_famas",
				name = "[Автомат] Famas F1",
				amount = 2,
			},
			{
				ent = "swb_p90",
				name = "[Автомат] FN P90",
				amount = 3,
			},
			{
				ent = "swb_galil",
				name = "[Автомат] IMI Galil ARM",
				amount = 1,
			},
			{
				ent = "swb_m4a1",
				name = "[Автомат] M4A1",
				amount = 1,
			},
			{
				ent = "swb_sg552",
				name = "[Автомат] SIG SG 552",
				amount = 1,
			},
			{
				ent = "swb_aug",
				name = "[Автомат] Steyr AUG",
				amount = 1,
			},


			{
				ent = "swb_awp",
				name = "[Снайп. винт] AWP",
				amount = 1,
				allow = 2
			},
			{
				ent = "swb_g3sg1",
				name = "[Снайп. винт] G35G/1",
				amount = 1,
				allow = 1
			},
			{
				ent = "swb_sg550",
				name = "[Снайп. винт] SIG SG 550",
				amount = 1,
				allow = 2
			},
			{
				ent = "swb_scout",
				name = "[Снайп. винт] Steyr Scout",
				amount = 3,
			},


			{
				ent = "swb_mp5",
				name = "[ПП] HK MP5",
				amount = 5,
			},
			{
				ent = "swb_ump",
				name = "[ПП] HK UMP .45",
				amount = 5,
			},
			{
				ent = "swb_mac10",
				name = "[ПП] MAC-10",
				amount = 6,
			},
			{
				ent = "swb_tmp",
				name = "[ПП] STEYR TMP",
				amount = 4,
			},


			{
				ent = "swb_xm1014",
				name = "[Дробовик] XM1014",
				amount = 2,
				allow = 1
			},
			{
				ent = "swb_m3super90",
				name = "[Дробовик] M3 Super 90",
				amount = 4,
			},


			{
				ent = "swb_m249",
				name = "[Пулемет] M249",
				amount = 1,
				allow = 2
			},
		}
	end
	
{
	"swb_usp", "swb_fiveseven", "swb_357", "swb_deagle",
	"swb_awp", "swb_scout",
	"swb_m249"
}
```

# Расширение инвентаря для отображения статы пушек
```lua
local tooltips = {}
tooltips["swb"] = function(WEP)
	local s =
	             "Имя: {name}\n" ..
	            "Урон: {damage}\n" ..
	          "Обойма: {clip}\n" ..
	          "Отдача: {recoil}\n" ..
	         "Автомат: {auto}\n" ..
	   "Выстрелов/мин: {shots_per_min}\n" ..
	"Режимов стрельбы: {fire_modes_num}"

	return s
	:gsub("{name}",   WEP.PrintName)
	:gsub("{damage}",(WEP.Shots or 1) * WEP.Damage)
	:gsub("{clip}",   WEP.Primary.ClipSize)
	:gsub("{recoil}", WEP.Recoil)
	:gsub("{auto}",   WEP.Primary.Automatic and "Да" or "Нет")
	:gsub("{shots_per_min}",  math.Round(60 / WEP.FireDelay))
	:gsub("{fire_modes_num}", #WEP.FireModes)
end
```

# Дроп с мусорок
```lua
{
	"swb_357",
	"swb_ak47",
	"swb_awp",
	"swb_deagle",
	"swb_famas",
	"swb_fiveseven",
	"swb_p90",
	"swb_g3sg1",
	"swb_glock18",
	"swb_mp5",
	"swb_ump",
	"swb_galil",
	-- "swb_knife",
	"swb_m249",
	"swb_m3super90",
	"swb_sg550",
	"swb_sg552",
	"swb_aug",
	"swb_tmp",
	"swb_xm1014",
	"swb_usp"
}
```

# Другое
- Пушка для убийств NPC зомби `swb_m3super90`
- 
