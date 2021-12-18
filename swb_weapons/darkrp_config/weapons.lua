local wep_price_mult = 2

print("Загрузка SWB пушек")

DarkRP.createShipment("[Пистолет] Револьвер .357", {
	model = "models/weapons/w_357.mdl",
	desc = [[]],
	entity = "swb_357",
	price = 350000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_BLACK},
	category = "Пистолеты",
})

DarkRP.createShipment("[Пистолет] Desert Eagle", {
	model = "models/weapons/w_pist_deagle.mdl",
	desc = [[]],
	entity = "swb_deagle",
	price = 330000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пистолеты",
})

DarkRP.createShipment("[Пистолет] Five-Seven", {
	model = "models/weapons/w_pist_fiveseven.mdl",
	desc = [[Обойма из 20 патронов, почти без отдачи]],
	entity = "swb_fiveseven",
	price = 295000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пистолеты",
})

DarkRP.createShipment("[Пистолет] Glock 18", {
	model = "models/weapons/w_pist_glock18.mdl",
	desc = [[Обойма из 18 патронов, 2 режима стрельбы]],
	entity = "swb_glock18",
	price = 270000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_BLACK},
	category = "Пистолеты",
})

DarkRP.createShipment("[Пистолет] P228", {
	model = "models/weapons/w_pist_p228.mdl",
	desc = [[Обойма из 15 патронов, довольно громкий]],
	entity = "swb_p228",
	price = 250000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пистолеты",
})

DarkRP.createShipment("[Пистолет] USP .45", {
	model = "models/weapons/w_pist_usp.mdl",
	desc = [[Обойма из 12 патронов, вместо прицела приближение (наоборот удобно), умеренная отдача]],
	entity = "swb_usp",
	price = 210000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пистолеты",
})

---------------------------------------------------------------------------------------------------------------------------------------------

DarkRP.createShipment("[Автомат] AK-47", {
	model = "models/weapons/w_rif_ak47.mdl",
	desc = [[Обойма из 30 патронов, 2 режима стрельбы, дамаг 30, но отдачей управлять довольно сложно]],
	entity = "swb_ak47",
	price = 1150000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_BLACK},
	category = "Автоматы",

	spine = true,
})

DarkRP.createShipment("[Автомат] Famas F1", {
	model = "models/weapons/w_rif_famas.mdl",
	desc = [[Обойма из 20 патронов, сильный разброс, вместо прицена приближение (удобно)]],
	entity = "swb_famas",
	price = 530000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Автоматы",

	spine = true,
})

DarkRP.createShipment("[Автомат] FN P90", {
	model = "models/weapons/w_smg_p90.mdl",
	desc = [[Обойма из 50 патронов, 2 режима стрельбы, вместо прицела приближение (удобно), не очень большой разброс]],
	entity = "swb_p90",
	price = 570000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Автоматы",

	spine = true,
})

DarkRP.createShipment("[Автомат] IMI Galil ARM", {
	model = "models/weapons/w_rif_galil.mdl",
	desc = [[Обойма из 35 патронов, 2 режима, средняя отдача, неплохой прицел, довольно громкий]],
	entity = "swb_galil",
	price = 750000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_BLACK},
	category = "Автоматы",

	spine = true,
})

DarkRP.createShipment("[Автомат] M4A1", {
	model = "models/weapons/w_rif_m4a1.mdl",
	desc = [[Обойма из 30 патронов, 3 режима стрельбы, приближение вместо прицела, довольно большой разброс, дамаг: 24, но проще калаша]],
	entity = "swb_m4a1",
	price = 950000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Автоматы",

	spine = true,
})

DarkRP.createShipment("[Автомат] SIG SG 552", {
	model = "models/weapons/w_rif_sg552.mdl",
	desc = [[Обойма из 30 патронов, оптический прицел, дамаг: 24, разброс примерно как у калаша]],
	entity = "swb_sg552",
	price = 850000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Автоматы",

	spine = true,
})

DarkRP.createShipment("[Автомат] Steyr AUG", {
	model = "models/weapons/w_rif_aug.mdl",
	desc = [[Обойма из 30 патронов, оптический прицел, отдача чуть больше, чем у SIG SG 552, но можно научиться управлять. Дамаг: 26]],
	entity = "swb_aug",
	price = 850000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Автоматы",

	spine = true,
})

---------------------------------------------------------------------------------------------------------------------------------------------

DarkRP.createShipment("[Снайп. винт] AWP", {
	model = "models/weapons/w_snip_awp.mdl",
	desc = [[Славноизвестная мощная снайперская винтовка. Вы можете знать ее по всем CS. Обойма из 10 патронов, 90 дамага]],
	entity = "swb_awp",
	price = 2000000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Снайперки",

	spine = true,
})

DarkRP.createShipment("[Снайп. винт] G35G/1", {
	model = "models/weapons/w_snip_g3sg1.mdl",
	desc = [[20 патронов в обойме, автоматическая, 48 единиц в дамаге. 2 режима стрельбы. В паре со скорострельностью просто нагиб пушка]],
	entity = "swb_g3sg1",
	price = 1337228 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Снайперки",

	spine = true,
})

DarkRP.createShipment("[Снайп. винт] SIG SG 550", {
	model = "models/weapons/w_snip_sg550.mdl",
	desc = [[30 патров в обойме, автоматическая, 28 ед. дамага, 2 режима стрельбы, довольно громкая, но крутая]],
	entity = "swb_sg550",
	price = 1200000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_BLACK},
	category = "Снайперки",

	spine = true,
})

DarkRP.createShipment("[Снайп. винт] Steyr Scout", {
	model = "models/weapons/w_snip_scout.mdl",
	desc = [[Обойма из 10 патронов, примерно выстрел в секунду, дамаг 48]],
	entity = "swb_scout",
	price = 870000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Снайперки",

	spine = true,
})

---------------------------------------------------------------------------------------------------------------------------------------------

DarkRP.createShipment("[ПП] HK MP5", {
	model = "models/weapons/w_smg_mp5.mdl",
	desc = [[3 режима стрельбы, обойма на 30 патронов, заметный прицел, 18 дамага]],
	entity = "swb_mp5",
	price = 435000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пистолеты-пулеметы",
})

DarkRP.createShipment("[ПП] HK UMP .45", {
	model = "models/weapons/w_smg_ump45.mdl",
	desc = [[25 патронов в обойме, 21 ед. дамага, 2 режима стрельбы, малая отдача, но кривоватый прицел]],
	entity = "swb_ump",
	price = 475000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пистолеты-пулеметы",
})

DarkRP.createShipment("[ПП] MAC-10", {
	model = "models/weapons/w_smg_mac10.mdl",
	desc = [[32 патрика на обойму, 20 дамага, единственный режим стрельбы, зум вместо прицела, большой разброс, который частично можно научиться контроллировать]],
	entity = "swb_mac10",
	price = 350000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_BLACK},
	category = "Пистолеты-пулеметы",
})

DarkRP.createShipment("[ПП] STEYR TMP", {
	model = "models/weapons/w_smg_tmp.mdl",
	desc = [[30 патронов, 18 дамага, быстрый, тихий, контроллируемая отдача, 2 режима стрельбы]],
	entity = "swb_tmp",
	price = 500000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пистолеты-пулеметы",
})

---------------------------------------------------------------------------------------------------------------------------------------------

DarkRP.createShipment("[Дробовик] XM1014", {
	model = "models/weapons/w_shot_xm1014.mdl",
	desc = [[7 патронов, скорострельный, 10 дамага на дробинку, можно выносить двери несколькими выстрелами]],
	entity = "swb_xm1014",
	price = 750000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Дробовики",

	spine = true,
})

DarkRP.createShipment("[Дробовик] M3 Super 90", {
	model = "models/weapons/w_shot_m3super90.mdl",
	desc = [[8 патронов, но довольно медленный. 12 дробинок по 10 дамага, можно выхерить дверь]],
	entity = "swb_m3super90",
	price = 690000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Дробовики",

	spine = true,
})

---------------------------------------------------------------------------------------------------------------------------------------------

DarkRP.createShipment("[Пулемет] M249", {
	model = "models/weapons/w_mach_m249para.mdl",
	desc = [[100 патронов. Автоматическая стрельба и стрельба одиночными, 24 дамага на пулю.]],
	entity = "swb_m249",
	price = 3000000 * wep_price_mult,
	amount = 5,
	allowed = {TEAM_GUN},
	category = "Пулеметы",

	spine = true,
})
