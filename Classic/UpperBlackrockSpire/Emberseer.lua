--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pyroguard Emberseer", 229)
if not mod then return end
mod:RegisterEnableMob(9816)
mod:SetAllowWin(true)
mod.dungeonId = 9816

--------------------------------------------------------------------------------
-- Locals
--

local addsDead = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "Pyroguard Emberseer"

	L.start_trigger = "begins to regain its strength"

	L.add = "Add deaths"
	L.add_desc = "Anounces when a Blackhand Incarcerator dies"
	L.add_icon = "Interface\\Icons\\ability_rogue_feigndeath"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"add",
	}
end

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Death("Win", 9816)
	self:Death("JailerDeath", 10316) -- Blackhand Incarcerator
end

function mod:OnEngage()
	-- No need to reset `addsDead` since wiping on the boss doesn't repsawn them
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg:find(L.start_trigger, nil, true) then
		self:Bar("warmup", 64)
	end
end

function mod:GuardDeath()
	addsDead = addsDead + 1
	self:Message2("add", "green", L.add_killed:format(addsDead, 8), L.guard_icon)
end
