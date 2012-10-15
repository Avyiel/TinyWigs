
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gekkan", 885, 690)
mod:RegisterEnableMob(61243, 61337, 61338, 61339, 61340) -- Gekkan, Ironhide, Skulker, Oracle, Hexxer

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "yell"


end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"bosskill"}
end

function mod:OnBossEnable()
	--self:Log("SPELL_CAST_START", "SpiritGaleCast", 115289)
	--self:Log("SPELL_AURA_APPLIED", "SpiritGaleYou", 115291)
	--self:Log("SPELL_INTERRUPT", "SpiritGaleStopped", "*")

	--self:Log("SPELL_AURA_APPLIED", "EvictSoul", 115297)
	--self:Log("SPELL_AURA_REMOVED", "EvictSoulRemoved", 115297)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 61243, 61337, 61338, 61339, 61340)
end

function mod:OnEngage()
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--
--[[
function mod:SpiritGaleCast(_, spellId, _, _, spellName)
	self:Message("spirit", CL["cast"]:format(spellName), "Attention", spellId, "Alarm")
	self:Bar("spirit", CL["cast"]:format(spellName), 2, spellId)
end

function mod:SpiritGaleYou(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage("spirit", CL["underyou"]:format(spellName), "Personal", spellId, "Alert")
		self:FlashShake("spirit")
	end
end

function mod:SpiritGaleStopped(_, _, _, secSpellId, _, secSpellName)
	if secSpellId == 115289 then
		self:SendMessage("BigWigs_StopBar", self, CL["cast"]:format(secSpellName))
	end
end

function mod:EvictSoul(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Urgent", spellId, "Info")
	self:Bar(spellId, CL["other"]:format(spellName, player), 6, spellId)
	self:Bar(spellId, "~"..spellName, 41, spellId)
end

function mod:EvictSoulRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, CL["other"]:format(spellName, player))
end
]]

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 5 then
		self:Win()
	end
end
