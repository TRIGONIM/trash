
WEP.Create("Steyr AUG","swb_aug")
	:SetIconLetter("e")
	:SetWorldModel ("models/weapons/3_rif_aug.mdl")
	:SetupViewModel("models/weapons/2_rif_aug.mdl", 70, true)
	:SetAim(Vector(3.552,-2.895,1.2), Vector(0.79,-0.057,0))
	:SetSprintData(Vector(-3.701,-7.008,0), Vector(-10.197,-63.111,-4.134))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(50)
	:SetupAmmo(30, 30, "Rifle", 5.56, 26)
	:SetCaseLength(45)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.08)
	:SetFireSound("Alt_Weapon_AUG.1")
	:SetupSpread(0.053, 0.0015, 0.05, 0.01, 0.15)
	:SetRecoil(1.05)

	:SetAutomatic(true)

	:SetMeta({
		PreventQuickScoping    = true,
		FadeDuringAiming       = true,
		MoveWepAwayWhenAiming  = true,
		SimulateCenterMuzzle   = true,
		ViewModelMovementScale = 1.15,
		VelocitySensitivity    = 2.1,
		FadeCrosshairOnAim     = true,
		SnapZoom               = true,
		DelayedZoom            = true,
		AimOverlay             = CLIENT and surface.GetTextureID("scope/gdcw_parabolicsight") or nil,
	})
:Register()

WEP.Create("SIG SG552","swb_sg552")
	:SetIconLetter("A")
	:SetWorldModel ("models/weapons/3_rif_sg552.mdl")
	:SetupViewModel("models/weapons/2_rif_sg552.mdl", 70, true)
	:SetAim(Vector(3.4,0,1.039), Vector(0,0,0))
	:SetSprintData(Vector(-3.543,-4.419,-0.241), Vector(-12.954,-58.151,10.748))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(50)
	:SetupAmmo(30, 30, "Rifle", 5.56, 24)
	:SetCaseLength(45)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.0857)
	:SetFireSound("Alt_Weapon_SG552.1")
	:SetupSpread(0.042, 0.006, 0.05, 0.01, 0.15)
	:SetRecoil(0.9)

	:SetAutomatic(true)

	:SetMeta({
		PreventQuickScoping    = true,
		FadeDuringAiming       = true,
		MoveWepAwayWhenAiming  = true,
		SimulateCenterMuzzle   = true,
		ViewModelMovementScale = 1.15,
		VelocitySensitivity    = 1.5,
		FadeCrosshairOnAim     = true,
		SnapZoom               = true,
		DelayedZoom            = true,
		AimOverlay             = CLIENT and surface.GetTextureID("scope/gdcw_parabolicsight") or nil,
	})
:Register()

WEP.Create("XM1014","swb_xm1014")
	:SetIconLetter("B")
	:SetWorldModel ("models/weapons/3_shot_xm1014.mdl")
	:SetupViewModel("models/weapons/2_shot_xm1014.mdl", 70, true)
	:SetAim(Vector(5.317,0.551,2.24), Vector(0,0,0))
	:SetSprintData(Vector(-3.701,-7.639,0.236), Vector(-9.646,-65.866,0))
	:SetMuzzle("swb_shotgun")
	:SetZoom(5)
	:SetupAmmo(7, 7, "Buckshot", 5, 10)
	:SetCaseLength(10)
	:SetupHoldTypes("shotgun","passive")
	:SetFireModes({"semi",})
	:SetFireDelay(0.2)
	:SetFireSound("Alt_Weapon_XM1014.1")
	:SetupSpread(0.036, 0.003, 0.06, 0.02, 1.03)
	:SetRecoil(2.5)

	:SetAutomatic(nil)

	:SetMeta({
		Shots = 12,

		ReloadShellInsertWait  = 0.6,
		Chamberable            = false,
		CanPenetrate           = false,
		Shell                  = "shotshell",
		ShotgunReload          = true,
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 2.2,
		ReloadFinishWait       = 0.7,
		AmmoEnt                = "item_box_buckshot_ttt",
		ReloadStartWait        = 0.6,
		ClumpSpread            = 0.012,
	})
:Register()

WEP.Create("Desert Eagle .50 AE","swb_deagle")
	:SetIconLetter("f")
	:SetWorldModel ("models/weapons/3_pist_deagle.mdl")
	:SetupViewModel("models/weapons/2_pist_deagle.mdl", 70, true)
	:SetAim(Vector(3.023,0,0.945), Vector(1.036,-0.057,0))
	:SetSprintData(Vector(-2.345,-8.233,-5.493), Vector(70,0,0))
	:SetMuzzle("swb_pistol_large")
	:SetZoom(5)
	:SetupAmmo(7, 7, "357", 11.5, 40)
	:SetCaseLength(22.8)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"semi",})
	:SetFireDelay(0.25)
	:SetFireSound("Weapon_DEagle.Single")
	:SetupSpread(0.045, 0.009, 0.06, 0.015, 0.28)
	:SetRecoil(5)

	:SetAutomatic(nil)

	:SetMeta({
		Shell                  = "smallshell",
		PosBasedMuz            = true,
		ViewModelMovementScale = 0.85,
		MuzzlePosMod           = {x = 6.5, y = 30, z = -2},
		VelocitySensitivity    = 1.7,
		AmmoEnt                = "item_ammo_revolver_ttt",
		DryFire                = true
	})
:Register()

WEP.Create("Glock 18","swb_glock18")
	:SetIconLetter("c")
	:SetWorldModel ("models/weapons/3_pist_glock18.mdl")
	:SetupViewModel("models/weapons/2_pist_glock18.mdl", 70, true)
	:SetAim(Vector(2.683,-5.336,2.608), Vector(0.296,-0.105,0))
	:SetSprintData(Vector(-2.76,-11.032,-4.137), Vector(59.402,0,0))
	:SetMuzzle("swb_pistol_small")
	:SetZoom(5)
	:SetupAmmo(18, 18, "Pistol", 9, 16)
	:SetCaseLength(19)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.05)
	:SetFireSound("Alt_Weapon_Glock.1")
	:SetupSpread(0.038, 0.013, 0.06, 0.01, 0.1)
	:SetRecoil(0.7)

	:SetAutomatic(true)

	:SetMeta({
		Shell                  = "smallshell",
		ViewModelMovementScale = 0.85,
		DryFire                = true,
		VelocitySensitivity    = 1.2,
		AmmoEnt                = "item_ammo_pistol_ttt",
		BurstCooldownMul       = 3.5,
		CanPenetrate           = false,
	})
:Register()

WEP.Create(".357 Revolver","swb_357")
	:SetIconLetter("f")
	:SetWorldModel ("models/weapons/w_357.mdl")
	:SetupViewModel("models/weapons/c_357.mdl", 55, false)
	:SetAim(Vector(-4.691,-3.958,0.66), Vector(0,-0.216,0))
	:SetSprintData(Vector(1.185,-15.796,-14.254), Vector(64.567,0,0))
	:SetMuzzle("swb_pistol_large")
	:SetZoom(5)
	:SetupAmmo(6, 6, "357", 9.1, 55)
	:SetCaseLength(33)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"double",})
	:SetFireDelay(0.45)
	:SetFireSound("Weapon_357.Single")
	:SetupSpread(0.048, 0.0075, 0.06, 0.015, 0.5)
	:SetRecoil(3)

	:SetAutomatic(nil)

	:SetMeta({
		Shell                  = "smallshell",
		ViewModelMovementScale = 0.85,
		MuzzlePosMod           = {
			y                  = 30,
			x                  = 6.5,
			z                  = -2,
				},
		Chamberable            = false,
		AmmoEnt                = "item_ammo_revolver_ttt",
		VelocitySensitivity    = 1.85,
	})
:Register()

WEP.Create("USP .45","swb_usp")
	:SetIconLetter("y")
	:SetWorldModel ("models/weapons/3_pist_usp.mdl")
	:SetupViewModel("models/weapons/2_pist_usp.mdl", 70, true)
	:SetAim(Vector(1.976,-0.042,1.34), Vector(0.425,0,0))
	:SetSprintData(Vector(-3.997,-6.459,-6.159), Vector(61.365,0,0))
	:SetMuzzle("swb_pistol_med")
	:SetZoom(5)
	:SetupAmmo(12, 12, "Pistol", 11.5, 20)
	:SetCaseLength(22.8)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"semi",})
	:SetFireDelay(0.14)
	:SetFireSound("Alt_Weapon_USP.1")
	:SetupSpread(0.04, 0.01, 0.05, 0.01, 0.16)
	:SetRecoil(0.75)

	:SetAutomatic(nil)

	:SetMeta({
		MuzzleEffectSupp       = "swb_silenced_small",
		DryFire                = true,
		CanPenetrate           = false,
		FireSoundSuppressed    = "Alt_Weapon_USP.2",
		Shell                  = "smallshell",
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 1.2,
		FadeCrosshairOnAim     = false,
		AmmoEnt                = "item_ammo_pistol_ttt",
		Suppressable           = true,
	})
:Register()

WEP.Create("FAMAS","swb_famas")
	:SetIconLetter("t")
	:SetWorldModel ("models/weapons/3_rif_famas.mdl")
	:SetupViewModel("models/weapons/2_rif_famas.mdl", 70, false)
	:SetAim(Vector(-2.813,-0.713,1.154), Vector(0.384,0.451,0))
	:SetSprintData(Vector(5.906,-3.386,2.44), Vector(-18.466,64.212,0))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(15)
	:SetupAmmo(20, 20, "Rifle", 5.56, 24)
	:SetCaseLength(45)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","3burst","semi",})
	:SetFireDelay(0.06)
	:SetFireSound("Alt_Weapon_FAMAS.1")
	:SetupSpread(0.05, 0.003, 0.06, 0.01, 0.1)
	:SetRecoil(1.15)

	:SetAutomatic(true)

	:SetMeta({
		FadeCrosshairOnAim     = false,
		InvertShellEjectAngle  = true,
		VelocitySensitivity    = 2,
	})
:Register()

WEP.Create("M4A1","swb_m4a1")
	:SetIconLetter("w")
	:SetWorldModel ("models/weapons/3_rif_m4a1.mdl")
	:SetupViewModel("models/weapons/2_rif_m4a1.mdl", 70, true)
	:SetAim(Vector(3.043,-1.38,0.859), Vector(0.172,0,0))
	:SetSprintData(Vector(-3.543,-2.126,-0.866), Vector(-12.954,-58.151,10.748))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(15)
	:SetupAmmo(30, 30, "Rifle", 5.56, 35)
	:SetCaseLength(45)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","3burst","semi",})
	:SetFireDelay(0.0666)
	:SetFireSound("Alt_Weapon_M4A1.1")
	:SetupSpread(0.045, 0.004, 0.06, 0.007, 0.1)
	:SetRecoil(1)

	:SetAutomatic(true)

	:SetMeta({
		MuzzleEffectSupp       = "swb_silenced",
		Instructions           = "",
		VelocitySensitivity    = 1.6,
		FadeCrosshairOnAim     = false,
		Suppressable           = true,
		FireSoundSuppressed    = "Alt_Weapon_M4A1.2",
		Purpose                = "",
	})
:Register()

WEP.Create("FN P90","swb_p90")
	:SetIconLetter("m")
	:SetWorldModel ("models/weapons/3_smg_p90.mdl")
	:SetupViewModel("models/weapons/2_smg_p90.mdl", 70, true)
	:SetAim(Vector(2.049,-1.828,0.782), Vector(0.089,0,0))
	:SetSprintData(Vector(-5.38,-3.35,1.48), Vector(-17.362,-70,0))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(15)
	:SetupAmmo(50, 50, "smg1", 5.7, 18)
	:SetCaseLength(28)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.0666)
	:SetFireSound("Alt_Weapon_P90.1")
	:SetupSpread(0.043, 0.007, 0.05, 0.01, 0.1)
	:SetRecoil(0.9)

	:SetAutomatic(true)

	:SetMeta({
		Shell                  = "smallshell",
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 1.5,
		FadeCrosshairOnAim     = false,
		BurstCooldownMul       = 3.5,
		AmmoEnt                = "item_ammo_smg1_ttt",
	})
:Register()

WEP.Create("Steyr Scout","swb_scout")
	:SetIconLetter("n")
	:SetWorldModel ("models/weapons/3_snip_scout.mdl")
	:SetupViewModel("models/weapons/2_snip_scout.mdl", 70, true)
	:SetAim(Vector(3.319,0,1.559), Vector(0,0,0))
	:SetSprintData(Vector(-7.165,-10.157,2.756), Vector(-19.017,-70,0))
	:SetMuzzle("swb_rifle_large")
	:SetZoom(70)
	:SetupAmmo(10, 10, "Sniper Rifle", 7.62, 75)
	:SetCaseLength(51)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"bolt",})
	:SetFireDelay(1.3)
	:SetFireSound("Alt_Weapon_Scout.1")
	:SetupSpread(0.055, 0.00015, 0.05, 0.05, 1.25)
	:SetRecoil(2)

	:SetAutomatic(nil)

	:SetMeta({
		PreventQuickScoping    = true,
		FadeDuringAiming       = true,
		MoveWepAwayWhenAiming  = true,
		MinZoom                = 40,
		SimulateCenterMuzzle   = true,
		FadeCrosshairOnAim     = true,
		SnapZoom               = true,
		ViewModelMovementScale = 1.15,
		VelocitySensitivity    = 2,
		AimOverlay             = CLIENT and surface.GetTextureID("scope/gdcw_parabolicsight") or nil,
		MaxZoom                = 80,
		AdjustableZoom         = true,
		DelayedZoom            = true,
	})
:Register()

WEP.Create("IMI Galil ARM","swb_galil")
	:SetIconLetter("v")
	:SetWorldModel ("models/weapons/3_rif_galil.mdl")
	:SetupViewModel("models/weapons/2_rif_galil.mdl", 70, false)
	:SetAim(Vector(-2.964,-1.611,1.527), Vector(0.041,0,0))
	:SetSprintData(Vector(5.906,-3.386,2.44), Vector(-18.466,64.212,0))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(5)
	:SetupAmmo(35, 35, "Rifle", 5.56, 24)
	:SetCaseLength(45)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.08)
	:SetFireSound("Alt_Weapon_Galil.1")
	:SetupSpread(0.045, 0.0035, 0.06, 0.007, 0.11)
	:SetRecoil(1.1)

	:SetAutomatic(true)

	:SetMeta({
		ViewModelMovementScale = 1.15,
		VelocitySensitivity    = 1.8,
	})
:Register()

WEP.Create("HK UMP .45","swb_ump")
	:SetIconLetter("q")
	:SetWorldModel ("models/weapons/3_smg_ump45.mdl")
	:SetupViewModel("models/weapons/2_smg_ump45.mdl", 70, true)
	:SetAim(Vector(2.822,-1.224,1.245), Vector(-0.044,-0.055,0.43))
	:SetSprintData(Vector(-6.378,-6.064,2.598), Vector(-17.914,-66.97,0.275))
	:SetMuzzle("swb_rifle_small")
	:SetZoom(15)
	:SetupAmmo(25, 25, "smg1", 11.5, 21)
	:SetCaseLength(22.8)
	:SetupHoldTypes("smg","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.1)
	:SetFireSound("Alt_Weapon_UMP45.1")
	:SetupSpread(0.041, 0.01, 0.05, 0.01, 0.1)
	:SetRecoil(0.8)

	:SetAutomatic(true)

	:SetMeta({
		Shell                  = "smallshell",
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 1.4,
		CanPenetrate           = false,
		BurstCooldownMul       = 3.5,
		AmmoEnt                = "item_ammo_smg1_ttt",
	})
:Register()

WEP.Create("MAC-10","swb_mac10")
	:SetIconLetter("l")
	:SetWorldModel ("models/weapons/3_smg_mac10.mdl")
	:SetupViewModel("models/weapons/2_smg_mac10.mdl", 70, true)
	:SetAim(Vector(2.49,0,1.442), Vector(0.731,0,0))
	:SetSprintData(Vector(-3.386,-3.386,2.282), Vector(-19.017,-47.126,0))
	:SetMuzzle("swb_rifle_small")
	:SetZoom(15)
	:SetupAmmo(32, 32, "smg1", 9, 20)
	:SetCaseLength(19)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"auto",})
	:SetFireDelay(0.05)
	:SetFireSound("Alt_Weapon_MAC10.1")
	:SetupSpread(0.037, 0.015, 0.05, 0.01, 0.1)
	:SetRecoil(1)

	:SetAutomatic(true)

	:SetMeta({
		Shell                  = "smallshell",
		Chamberable            = false,
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 1.4,
		FadeCrosshairOnAim     = false,
		CanPenetrate           = false,
		BurstCooldownMul       = 3.5,
		AmmoEnt                = "item_ammo_smg1_ttt",
	})
:Register()

WEP.Create("Steyr TMP","swb_tmp")
	:SetIconLetter("d")
	:SetWorldModel ("models/weapons/3_smg_tmp.mdl")
	:SetupViewModel("models/weapons/2_smg_tmp.mdl", 70, true)
	:SetAim(Vector(2.599,-2.385,2.026), Vector(0,-0.129,0.291))
	:SetSprintData(Vector(-6.693,-6.378,2.282), Vector(-17.914,-49.882,0))
	:SetMuzzle("swb_silenced_small")
	:SetZoom(15)
	:SetupAmmo(30, 30, "smg1", 9, 18)
	:SetCaseLength(19)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.0666)
	:SetFireSound("Weapon_TMP.Single")
	:SetupSpread(0.037, 0.013, 0.05, 0.007, 0.1)
	:SetRecoil(0.7)

	:SetAutomatic(true)

	:SetMeta({
		Shell                  = "smallshell",
		NoStockMuzzle          = true,
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 1.3,
		FadeCrosshairOnAim     = false,
		CanPenetrate           = false,
		BurstCooldownMul       = 3.5,
		AmmoEnt                = "item_ammo_smg1_ttt",
	})
:Register()

WEP.Create("SIG SG550","swb_sg550")
	:SetIconLetter("o")
	:SetWorldModel ("models/weapons/3_snip_sg550.mdl")
	:SetupViewModel("models/weapons/2_snip_sg550.mdl", 70, true)
	:SetAim(Vector(3.44,0,1.399), Vector(0,0,0))
	:SetSprintData(Vector(-4.961,-5.907,3.227), Vector(-17.914,-65.316,-6.34))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(70)
	:SetupAmmo(30, 30, "Rifle", 5.56, 28)
	:SetCaseLength(45)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"semi",})
	:SetFireDelay(0.0857)
	:SetFireSound("Alt_Weapon_SG550.1")
	:SetupSpread(0.055, 0.00025, 0.05, 0.01, 0.15)
	:SetRecoil(1.1)

	:SetAutomatic(nil)

	:SetMeta({
		PreventQuickScoping    = true,
		PosBasedMuz            = true,
		FadeDuringAiming       = true,
		MoveWepAwayWhenAiming  = true,
		MinZoom                = 40,
		DelayedZoom            = true,
		SimulateCenterMuzzle   = true,
		MaxZoom                = 80,
		ViewModelMovementScale = 1.15,
		VelocitySensitivity    = 2.2,
		SnapZoom               = true,
		MuzzlePosMod           = {
			y                  = 55,
			x                  = 7,
			z                  = -3,
				},
		AdjustableZoom         = true,
		FadeCrosshairOnAim     = true,
		AimOverlay             = CLIENT and surface.GetTextureID("scope/gdcw_parabolicsight") or nil,
	})
:Register()

WEP.Create("P228","swb_p228")
	:SetIconLetter("c")
	:SetWorldModel ("models/weapons/3_pist_p228.mdl")
	:SetupViewModel("models/weapons/2_pist_p228.mdl", 70, true)
	:SetAim(Vector(2.519,2.793,1.399), Vector(0.115,0.083,0))
	:SetSprintData(Vector(-2.437,-6.748,-5.019), Vector(59.777,0,0))
	:SetMuzzle("swb_pistol_small")
	:SetZoom(5)
	:SetupAmmo(15, 15, "Pistol", 9, 17)
	:SetCaseLength(19)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"semi",})
	:SetFireDelay(0.13)
	:SetFireSound("Alt_Weapon_P228.1")
	:SetupSpread(0.036, 0.0115, 0.06, 0.01, 0.15)
	:SetRecoil(0.7)

	:SetAutomatic(nil)

	:SetMeta({
		Shell                  = "smallshell",
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 1.2,
		CanPenetrate           = false,
		AmmoEnt                = "item_ammo_pistol_ttt",
	})
:Register()

WEP.Create("HK MP5","swb_mp5")
	:SetIconLetter("x")
	:SetWorldModel ("models/weapons/3_smg_mp5.mdl")
	:SetupViewModel("models/weapons/2_smg_mp5.mdl", 70, true)
	:SetAim(Vector(2.049,-1.828,0.782), Vector(0.089,0,0))
	:SetSprintData(Vector(-4.075,-5.47,-0.237), Vector(-5.073,-57.223,-0.276))
	:SetMuzzle("swb_rifle_small")
	:SetZoom(15)
	:SetupAmmo(30, 30, "smg1", 9, 18)
	:SetCaseLength(19)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","3burst","semi",})
	:SetFireDelay(0.075)
	:SetFireSound("Alt_Weapon_MP5Navy.1")
	:SetupSpread(0.04, 0.008, 0.05, 0.01, 0.1)
	:SetRecoil(0.8)

	:SetAutomatic(true)

	:SetMeta({
		Shell                  = "smallshell",
		PosBasedMuz            = true,
		ViewModelMovementScale = 0.85,
		MuzzlePosMod           = {
			y                  = 30,
			x                  = 5,
			z                  = -4,
				},
		VelocitySensitivity    = 1.5,
		AmmoEnt                = "item_ammo_smg1_ttt",
		BurstCooldownMul       = 3.5,
		CanPenetrate           = false,
	})
:Register()

WEP.Create("M3 Super 90","swb_m3super90")
	:SetIconLetter("k")
	:SetWorldModel ("models/weapons/3_shot_m3super90.mdl")
	:SetupViewModel("models/weapons/2_shot_m3super90.mdl", 70, true)
	:SetAim(Vector(2.686,0,1.08), Vector(0.428,0,0))
	:SetSprintData(Vector(-3.701,-7.639,0.236), Vector(-9.646,-65.866,0))
	:SetMuzzle("swb_shotgun")
	:SetZoom(5)
	:SetupAmmo(8, 8, "Buckshot", 5, 10)
	:SetCaseLength(10)
	:SetupHoldTypes("shotgun","passive")
	:SetFireModes({"semi",})
	:SetFireDelay(1)
	:SetFireSound("Alt_Weapon_M3.1")
	:SetupSpread(0.036, 0.003, 0.06, 0.02, 1.03)
	:SetRecoil(2.5)

	:SetAutomatic(nil)

	:SetMeta({
		Shots = 12,

		ReloadShellInsertWait  = 0.6,
		Chamberable            = false,
		CanPenetrate           = false,
		ReloadFinishWait       = 1.1,
		Shell                  = "shotshell",
		ShotgunReload          = true,
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 2.2,
		AmmoEnt                = "item_box_buckshot_ttt",
		ShellOnEvent           = true,
		ReloadStartWait        = 0.6,
		ClumpSpread            = 0.01,
	})
:Register()

WEP.Create("M249 Para","swb_m249")
	:SetIconLetter("z")
	:SetWorldModel ("models/weapons/3_mach_m249para.mdl")
	:SetupViewModel("models/weapons/2_mach_m249para.mdl", 70, false)
	:SetAim(Vector(-3.743,-1.346,1.539), Vector(0,0,0))
	:SetSprintData(Vector(3.779,-5.84,0.165), Vector(-8.655,57.168,0))
	:SetMuzzle("swb_rifle_med")
	:SetZoom(15)
	:SetupAmmo(100, 100, "Rifle", 5.56, 24)
	:SetCaseLength(45)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.075)
	:SetFireSound("Alt_Weapon_M249.1")
	:SetupSpread(0.055, 0.004, 0.06, 0.007, 0.1)
	:SetRecoil(1.1)

	:SetAutomatic(true)

	:SetMeta({
		InvertShellEjectAngle  = true,
		Chamberable            = false,
		VelocitySensitivity    = 2.5,
	})
:Register()

WEP.Create("FN Five-seveN","swb_fiveseven")
	:SetIconLetter("u")
	:SetWorldModel ("models/weapons/3_pist_fiveseven.mdl")
	:SetupViewModel("models/weapons/2_pist_fiveseven.mdl", 70, true)
	:SetAim(Vector(2.687,0,1.12), Vector(1.598,0,0))
	:SetSprintData(Vector(-1.098,-7.132,-5.106), Vector(59.402,0,0))
	:SetMuzzle("swb_pistol_med")
	:SetZoom(5)
	:SetupAmmo(20, 20, "Pistol", 5.7, 20)
	:SetCaseLength(28)
	:SetupHoldTypes("Pistol","normal")
	:SetFireModes({"semi",})
	:SetFireDelay(0.145)
	:SetFireSound("Alt_Weapon_FiveSeven.1")
	:SetupSpread(0.04, 0.009, 0.06, 0.01, 0.15)
	:SetRecoil(0.95)

	:SetAutomatic(nil)

	:SetMeta({
		CanPenetrate           = false,
		Shell                  = "smallshell",
		AmmoEnt                = "item_ammo_pistol_ttt",
		ViewModelMovementScale = 0.85,
		VelocitySensitivity    = 1.3,
	})
:Register()

WEP.Create("G3SG1","swb_g3sg1")
	:SetIconLetter("i")
	:SetWorldModel ("models/weapons/3_snip_g3sg1.mdl")
	:SetupViewModel("models/weapons/2_snip_g3sg1.mdl", 70, true)
	:SetAim(Vector(3.319,0,1.159), Vector(0,0,0))
	:SetSprintData(Vector(-5.277,-5.592,1.338), Vector(-15.157,-57.048,0))
	:SetMuzzle("swb_rifle_large")
	:SetZoom(70)
	:SetupAmmo(20, 20, "Sniper Rifle", 7.62, 48)
	:SetCaseLength(51)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.12)
	:SetFireSound("Alt_Weapon_G3SG1.1")
	:SetupSpread(0.055, 0.0002, 0.05, 0.01, 0.15)
	:SetRecoil(1.6)

	:SetAutomatic(true)

	:SetMeta({
		InvertShellEjectAngle  = true,
		FadeDuringAiming       = true,
		MoveWepAwayWhenAiming  = true,
		MinZoom                = 40,
		AimOverlay             = CLIENT and surface.GetTextureID("scope/gdcw_parabolicsight") or nil,
		SimulateCenterMuzzle   = true,
		DelayedZoom            = true,
		MaxZoom                = 80,
		ViewModelMovementScale = 1.15,
		VelocitySensitivity    = 2.2,
		FadeCrosshairOnAim     = true,
		SnapZoom               = true,
		AdjustableZoom         = true,
		PreventQuickScoping    = true,
	})
:Register()

WEP.Create("AWP","swb_awp")
	:SetIconLetter("r")
	:SetWorldModel ("models/weapons/3_snip_awp.mdl")
	:SetupViewModel("models/weapons/2_snip_awp.mdl", 70, true)
	:SetAim(Vector(3.552,-2.895,1.2), Vector(0.79,-0.057,0))
	:SetSprintData(Vector(-2.599,-8.11,-0.709), Vector(0,-62.559,0))
	:SetMuzzle("swb_sniper")
	:SetZoom(70)
	:SetupAmmo(10, 10, "Sniper Rifle", 8.58, 130)
	:SetCaseLength(69.2)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"bolt",})
	:SetFireDelay(1.5)
	:SetFireSound("Alt_Weapon_AWP.1")
	:SetupSpread(0.06, 0.0001, 0.05, 0.05, 1.44)
	:SetRecoil(5)

	:SetAutomatic(nil)

	:SetMeta({
		PreventQuickScoping    = true,
		FadeDuringAiming       = true,
		MoveWepAwayWhenAiming  = true,
		MinZoom                = 40,
		SimulateCenterMuzzle   = true,
		FadeCrosshairOnAim     = true,
		SnapZoom               = true,
		ViewModelMovementScale = 1.25,
		VelocitySensitivity    = 2.2,
		AimOverlay             = CLIENT and surface.GetTextureID("scope/gdcw_parabolicsight") or nil,
		MaxZoom                = 80,
		AdjustableZoom         = true,
		DelayedZoom            = true,
	})
:Register()

WEP.Create("AK-47","swb_ak47")
	:SetIconLetter("b")
	:SetWorldModel ("models/weapons/3_rif_ak47.mdl")
	:SetupViewModel("models/weapons/2_rif_ak47.mdl", 70, true)
	:SetAim(Vector(3.552,-2.895,1.2), Vector(0.79,-0.057,0))
	:SetSprintData(Vector(-3.701,-7.008,0.865), Vector(-10.197,-63.111,-4.134))
	:SetMuzzle("swb_rifle_med")
	:SetZoom()
	:SetupAmmo(30, 30, "Rifle", 7.62, 30)
	:SetCaseLength(39)
	:SetupHoldTypes("ar2","passive")
	:SetFireModes({"auto","semi",})
	:SetFireDelay(0.1)
	:SetFireSound("Alt_Weapon_AK47.1")
	:SetupSpread(0.04, 0.005, 0.06, 0.007, 0.13)
	:SetRecoil(1.2)

	:SetAutomatic(true)

	:SetMeta({
		ViewModelMovementScale = 1.15,
		VelocitySensitivity    = 1.6,
	})
:Register()

