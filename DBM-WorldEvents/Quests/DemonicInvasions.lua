local mod	= DBM:NewMod("DemonInvasions", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17204 $"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 238005 234660",
	"RAID_BOSS_WHISPER"
)
mod.noStatistics = true

local specWarnBombardment			= mod:NewSpecialWarningDodge(235085, nil, nil, nil, 3, 2)
local specWarnCataclysmicForceNova	= mod:NewSpecialWarningDodge(238005, nil, nil, nil, 4, 2)
local specWarnDreadBeam				= mod:NewSpecialWarningDodge(234660, nil, nil, nil, 4, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 238005 then
		specWarnCataclysmicForceNova:Show()
		specWarnCataclysmicForceNova:Play("runout")
	elseif spellId == 234660 then
		specWarnDreadBeam:Show()
		specWarnDreadBeam:Play("shockwave")
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:235085") then
		specWarnBombardment:Show()
		specWarnBombardment:Play("watchstep")
	end
end
