local WEAPON = {}
WEAPON.__index = WEAPON

-- Должно быть вызвано в конце
function WEAPON:Register()
	local cl = self.class
	self.class = nil
	weapons.Register(self,cl)
end

function WEAPON:SetWorldModel(sModel)
	self.WorldModel = sModel
	return self
end

function WEAPON:SetupViewModel(sModel,iFov,bFlip)
	self.ViewModel     = sModel
	self.ViewModelFOV  = iFov
	self.ViewModelFlip = bFlip
	return self
end

function WEAPON:SetIconLetter(sLetter)
	if CLIENT then
		self.IconLetter = sLetter
		killicon.AddFont(self.class, "SWB_KillIcons", self.IconLetter, Color(255,80,0, 150))
	end

	return self
end

function WEAPON:SetAim(pos,ang)
	if CLIENT then
		self.AimPos = pos
		self.AimAng = ang
	end

	return self
end

function WEAPON:SetZoom(amount)
	if CLIENT then
		self.ZoomAmount = amount
	end

	return self
end

function WEAPON:SetMuzzle(effect)
	if CLIENT then
		self.MuzzleEffect = effect
	end

	return self
end

function WEAPON:SetSprintData(pos,ang)
	if CLIENT then
		self.SprintPos = pos
		self.SprintAng = ang
	end

	return self
end

function WEAPON:SetSprintData(pos,ang)
	if CLIENT then
		self.SprintPos = pos
		self.SprintAng = ang
	end

	return self
end

function WEAPON:FadeCrosshair(PlayBackRate,PlayBackRateSV)
	self.FadeCrosshairOnAim = true

	self.PlayBackRate   = PlayBackRate
	self.PlayBackRateSV = PlayBackRateSV

	return self
end

function WEAPON:SetupAmmo(iClipSize, iDefClip, sAmmoType, dBulletDiameter, iDamage)
	self.BulletDiameter = dBulletDiameter
	self.Damage = iDamage

	self.Primary.ClipSize    = iClipSize
	self.Primary.DefaultClip = iDefClip
	self.Primary.Ammo        = sAmmoType

	return self
end

-- Длина ствола. Юзается для подсчета эффективного расстояния стрельбы вместе с BulletDiameter
function WEAPON:SetCaseLength(iCaseLength)
	self.CaseLength = iCaseLength
	return self
end

function WEAPON:SetupHoldTypes(sNormal,sWhenRun)
	self.NormalHoldType = sNormal
	self.RunHoldType    = sWhenRun
	return self
end

function WEAPON:SetFireModes(tFireModes)
	self.FireModes = tFireModes
	return self
end

function WEAPON:SetFireDelay(iFireDelay)
	self.FireDelay = iFireDelay
	return self
end

function WEAPON:SetFireSound(sFireSound)
	self.FireSound = Sound(sFireSound)
	return self
end

function WEAPON:SetRecoil(iRecoil) -- отдача
	self.Recoil = iRecoil
	return self
end

function WEAPON:SetFireModes(tFireModes)
	self.FireModes = tFireModes
	return self
end

function WEAPON:SetupSpread(HipSpread, AimSpread, MaxSpreadInc, SpreadPerShot, SpreadCooldown)
	self.HipSpread = HipSpread
	self.AimSpread = AimSpread
	self.MaxSpreadInc = MaxSpreadInc
	self.SpreadPerShot = SpreadPerShot
	self.SpreadCooldown = SpreadCooldown
	return self
end



function WEAPON:SetAutomatic(bAutomatic)
	self.Primary.Automatic = bAutomatic
	return self
end

function WEAPON:SetMeta(t)
	for k,v in pairs(t) do
		self[k] = v
	end

	return self
end



WEP = WEP or setmetatable({},{__call = function(self,...)
	return self.Create(...)
end})

function WEP.Create(name,class)
	local OBJ = setmetatable({
		class = class,

		Base = "swb_base",

		Category = "TG Weapons",
		Author   = "Spy and _AMD_",
		Contact  = "amd@default.im",

		Spawnable      = true,
		AdminSpawnable = true,

		Slot = 4,
		SlotPos = 0,

		Chamberable = true,
		Shell = "mainshell",

		Primary = {
			Automatic = false
		},
	},WEAPON)

	if CLIENT then
		OBJ.PrintName = name

		OBJ.DrawCrosshair   = false
		OBJ.CSMuzzleFlashes = true
	end

	if SERVER then
		OBJ.Shots      = 1 -- выстрелов за раз
		OBJ.DeployTime = 1 -- время подготовки пушки к первому выстрелу
	end

	return OBJ
end