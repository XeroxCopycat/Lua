function user_job_setup()
	
-- ### Options: Override default values ###
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match','Proc')
	state.AutoBuffMode:options('Off', 'Auto', 'AutoMelee')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'DTHippo')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Naegling','DualWeapons','DualWeaponsAcc','DualEvisceration','DualClubs','DualAeolian','DualProcDaggers','EnspellOnly','EnspellDW')

-- ### Additional local binds ###
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
	send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
	send_command('bind !r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons none')
	send_command('bind !q gs c set skipprocweapons false;gs c set weapons DualProcDaggers;gs c set weaponskillmode proc')
	
	select_default_macro_book()
end

function init_gear_sets()

-------------------------------------------------------------------------------------------------------------------
-- START DEFINING THE SETS
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- PRECAST SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Chainspell'] = {}
	
-- ### Fast cast sets for spells ###
	sets.precast.FC = { --FC +47/80, QC +7
		ammo="Impatiens", --QC +2
		head="Atrophy Chapeau +3", --FC +16
		body="Duelist's Tabard", --FC +10
		hands="Jhakri Cuffs +2", --Set: FC +9
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Loricate Torque +1",
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Loquac. Earring", --FC +2
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --FC +7
		left_ring="Jhakri Ring",
		right_ring="Lebeche Ring", --QC +2
	}
		
	--sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
	--sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Sacro Bulwark"})
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

-------------------------------------------------------------------------------------------------------------------
-- MIDCAST SETS
-------------------------------------------------------------------------------------------------------------------	
-- ### Fast recast set ###
	sets.midcast.FastRecast = {}
	
-- ### Dark magic ###
	sets.midcast['Dark Magic'] = {}
	
  -- Specific dark magic spells
	sets.midcast.Aspir = {}
	sets.midcast.Bio = set_combine(sets.TreasureHunter)
	sets.midcast.Drain = {}
	sets.midcast.Stun = {}
	sets.midcast.Stun.Resistant = {}

-- ### Divine magic ###
	sets.midcast['Divine Magic'] = {}

-- ### Elemental magic ###
	sets.midcast['Elemental Magic'] = {}
    sets.midcast['Elemental Magic'].Resistant = {}
    sets.midcast['Elemental Magic'].Fodder = {}
    sets.midcast['Elemental Magic'].Proc = {}
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
  -- Specific elemental magic spells
	sets.midcast.Impact = {}
	
  -- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	
-- ### Enfeebling magic ###
	sets.midcast['Enfeebling Magic'] = {}
	sets.midcast['Enfeebling Magic'].Resistant = {}
	sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.SkillBasedEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {})
	
  -- Specific enfeebling magic spells
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Bind.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Break.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Distract III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Silence.Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Sleep.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})

-- ### Enhancing magic ###
	sets.midcast['Enhancing Magic'] = {}
	sets.buff.ComposureOther = {}
	
  -- Specific enhancing magic spells
  -- NOTE: Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works. Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {}
	sets.midcast.Refresh = {}
	sets.midcast.Aquaveil = {}
	sets.midcast.BarElement = {}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {})
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {})
	sets.midcast.BoostStat = {}
	sets.midcast.Stoneskin = {}
	sets.midcast.Protect = {}
	sets.midcast.Shell = {}

  -- Misc. enhancing magic sets
	sets.Self_Refresh = {}
  
-- ### Healing magic ###
	sets.midcast['Healing Magic'] = {}
	
  -- Specific healing magic spells
	sets.midcast.Cure = {}
	sets.midcast.Cursna = {}
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	sets.midcast.Curaga = sets.midcast.Cure
	
  -- Misc. healing magic sets
	sets.Self_Healing = {}
	sets.Cure_Received = {}	
	
-------------------------------------------------------------------------------------------------------------------
-- IDLE AND RESTING SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Idle sets ###
	sets.idle = {
		main="Kaja Sword",
		sub="Archduke's Shield",
		ammo="Impatiens",
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Shneddick Ring",
		back="Solemnity Cape",
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {})
	
	sets.idle.Regain = set_combine(sets.idle, {})
	
	sets.idle.Regen = set_comine(sets.idle, {
		main="Chatoyant Staff", 
		sub="Oneiros Grip", 
		right_ring="Sheltered Ring",
	})
	
	sets.idle.Weakened = set_combine(sets.idle, {right_ring="Sheltered Ring"})
	
-- ### Resting sets ###
	sets.resting = {
		main="Chatoyant Staff", 
		sub="Oneiros Grip", 
		right_ring="Sheltered Ring"}

-------------------------------------------------------------------------------------------------------------------
-- DEFENSE SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
	sets.defense.PDT = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Archon Ring",
		back="Solemnity Cape",
	}
	
  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})
	
  -- Magic evasion
    sets.defense.MEVA = {}
	
 -- ### Misc. defensive sets ###
	sets.Kiting = {}
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

-------------------------------------------------------------------------------------------------------------------
-- OFFENSE SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged, single wield ###
	sets.engaged = {}	
	sets.engaged.EnspellOnly = {}
	sets.engaged.Acc = {}	
	sets.engaged.FullAcc = {}
	sets.engaged.DT = {}

-- ### Engaged, dual wield ###
	sets.engaged.DW = {}
	sets.engaged.DW.Acc = {}
	sets.engaged.DW.FullAcc = {}
	sets.engaged.DW.DT = {}

-------------------------------------------------------------------------------------------------------------------
-- WEAPONS & WEAPONSKILL SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Weapons sets ###
	sets.weapons.Savage = {main="Kaja Sword", sub="Archduke's Shield"}
	sets.weapons.DualSavage = {main="Kaja Sword", sub="Thibron"}
	sets.weapons.Evisceration = {main="Tauret", sub="Almace"}
	sets.weapons.Aeolian = {main="Tauret", sub="Bunzi's Rod"}
	sets.weapons.BlackHalo = {main="Maxentius", sub="Archduke's Shield"}
	sets.weapons.Enspell = {main="Norgish Dagger",sub="Aern Dagger"}
	sets.weapons.DualEnspell = {main="Blurred Knife +1", sub="Atoyac"}
	
	
-- ### Weaponskill sets ###
  -- Default weaponskill sets
	sets.precast.WS = {}
	sets.precast.WS.PDL = {}
	sets.precast.WS.Proc = 	{}
	
  -- Specific weaponskill sets
	-- Dagger  
	sets.precast.WS['Aeolian Edge'] = {}
	sets.precast.WS['Evisceration'] = {}

    -- Sword
	sets.precast.WS['Chant Du Cygne'] = {}
	sets.precast.WS['Requiescat'] = {}
	sets.precast.WS['Red Lotus Blade'] = {}
	sets.precast.WS['Sanguine Blade'] = {}
	sets.precast.WS['Seraph Blade'] = {}
	sets.precast.WS['Savage Blade'] = {}
	
-- ### Auto weaponskill lists ###
	autows_list = {
		['Savage']='Savage Blade',
		['DualSavage']='Savage Blade'
		['Evisceration']='Evisceration',
		['BlackHalo']='Black Halo',
		['Aeolian']='Aeolian Edge',
		['EnspellDW']='Sanguine Blade'
	}

-------------------------------------------------------------------------------------------------------------------
-- MISC. SETS
-------------------------------------------------------------------------------------------------------------------
-- Sets for special buff conditions on spells.		
	sets.buff.Saboteur = {}
	sets.HPDown = {}
    sets.HPCure = {}

-- ### Convert elemental damage done to MP ###	
	sets.RecoverMP = {}

-- ### Treasure hunter ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
-- ### Vs. debuff ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})
	
-- ### Sublimation (/SCH) ### 
    sets.buff.Sublimation = {}
    sets.buff.DTSublimation = {}
end

-- ### Select default macro book on initial load or subjob change. ###
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(4, 8)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 8)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 8)
	else
		set_macro_page(3, 8)
	end
end

