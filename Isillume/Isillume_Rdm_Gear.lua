function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc')
    state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Match','Proc')
	state.AutoBuffMode:options('Off','Auto','AutoMelee')
	state.CastingMode:options('Normal','Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal','PDT','MDT','DTHippo')
    state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Naegling','DualWeapons','DualWeaponsAcc','DualEvisceration','DualClubs','DualAeolian','DualProcDaggers','EnspellOnly','EnspellDW')

		-- Additional local binds
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
-- Start Defining the Sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast cast sets for spells	
--------------------------------------
	sets.precast.FC = {}
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})

--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
	sets.precast.JA['Chainspell'] = {}

--------------------------------------
-- Steps sets for /DNC
--------------------------------------


--------------------------------------
-- Waltz set for /DNC (CHA + VIT)
--------------------------------------
	sets.precast.Waltz = {}
	sets.precast.Waltz['Healing Waltz'] = {}


-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------   
--------------------------------------
-- Fast Recast
--------------------------------------
	sets.midcast.FastRecast = {}

--------------------------------------
-- Dark Magic
--------------------------------------
-- Base dark magic set
	sets.midcast['Dark Magic'] = {}

-- Specific Dark Magic spells
  -- Aspir
	sets.midcast.Aspir = {}

  -- Bio
  	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
  
  -- Drain
    sets.midcast.Drain = sets.midcast.Aspir

  -- Impact
	sets.midcast.Impact = {}
  
  -- Stun
	sets.midcast.Stun = {}
	
  -- Stun w/ magic acc
	sets.midcast.Stun.Resistant = {}

--------------------------------------
-- Divine Magic
--------------------------------------
-- Base Divine Magic set
	sets.midcast['Divine Magic'] = {}
	
--------------------------------------
-- Elemental Magic
--------------------------------------
	sets.midcast['Elemental Magic'] = {}	
    sets.midcast['Elemental Magic'].Resistant = {}
    sets.midcast['Elemental Magic'].Fodder = {}
    sets.midcast['Elemental Magic'].Proc = {}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
		
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}

--------------------------------------
-- Enfeebling Magic
-------------------------------------- 
-- Base Enfeebling Magic sets
	sets.midcast['Enfeebling Magic'] = {neck="Duelist's Torque +2"}
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {})

-- Specific Enfeebling Magic sets
  -- Bind
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling, {})
	sets.midcast.Bind.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- Break
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling, {})
	sets.midcast.Break.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
  
  -- Dia
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
  
  -- Dispel
	sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
	
  -- Distract (skill based)
	sets.midcast['Distract III'] = sets.midcast['Enfeebling Magic']
	sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
  -- Frazzle (skill based)
	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle III'] = sets.midcast['Enfeebling Magic']
	sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
  -- Silence
	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Silence.Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
  -- Sleep
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Sleep.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
		

sets.buff.Saboteur = {}

--------------------------------------
-- Enhancing Magic
--------------------------------------
-- Base enhancing magic set
	sets.midcast['Enhancing Magic'] = {}
	
	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = {}
		
-- Specific enhancing magic spells
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
  -- Aquaveil
	sets.midcast.Aquaveil = {}
	
  -- Bar-spell
	sets.midcast.BarElement = {}
	
  -- Boost stat
	sets.midcast.BoostStat = {}
	
  -- Temper (skill based)
	sets.midcast.Temper = sets.midcast['Enhancing Magic']
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {})
	
  -- Enspell (skill based)
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {})
	
  -- Refresh
	sets.midcast.Refresh = {}
	sets.Self_Refresh = {}
  
  -- Stoneskin
	sets.midcast.Stoneskin = {}
	
  -- Protect
	sets.midcast.Protect = {}
	
  -- Shell
	sets.midcast.Shell = {}
	
--------------------------------------
-- Healing Magic
--------------------------------------
	sets.midcast['Healing Magic'] = {}
	
-- Specific Healing Magic sets
  -- Cure
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], {})
	sets.midcast.Curaga = sets.midcast.Cure
	
  -- Cure when applied to self
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	
  -- Cursna
	sets.midcast.Cursna = {}

  -- Status removal spells
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

-------------------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Idle sets
--------------------------------------
	sets.idle = {}
	
  -- Refresh set
	sets.idle.Refresh = set_combine(sets.idle, {head="Duelist's Chapeau", body="Jhakri Robe +2"})
	
  -- Regain set
	sets.idle.Regain = set_combine(sets.idle, {})
	
  -- Regen set
	sets.idle.Regen = set_combine(sets.idle, {})
	
  -- Weakened Set
	sets.idle.Weak = {}
	
  -- Kiting Set
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

--------------------------------------
-- Resting Sets
--------------------------------------
	sets.resting = {}

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical damage taken
--------------------------------------
	sets.defense.PDT = { --DT -12/50
		head="Aya. Zucchetto +1", --DT -2
		hands="Aya. Manopolas +1", --DT -2
		feet="Aya. Gambieras +1", --DT -2
		neck="Loricate Torque +1", --DT -6
		back="Archon Cape", --(RDM DT Cape)
	}
	
	sets.defense.NukeLock = sets.midcast['Elemental Magic']

  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		right_ring="Archon Ring",
	})

  -- Magic evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		right_ring="Archon Ring",
	})
	
--------------------------------------
-- Misc. defensive sets
--------------------------------------
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged sets, single wield
	sets.engaged = {
		head="Aya. Zucchetto +1",
		body="Jhakri Robe +2",
		hands="Aya. Manopolas +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		left_ring="Jhakri Ring",    
	}
	
	sets.engaged.EnspellOnly = {}
	sets.engaged.Acc = {}
	sets.engaged.FullAcc = {}
	
  -- Single wield hybrid DT sets
	sets.engaged.EnspellOnly.DT = {}
	sets.engaged.DT = {}
	sets.engaged.Acc.DT = {}
	sets.engaged.FullAcc.DT = {}
	
-- Engaged sets, dual wield
	sets.engaged.DW = {}
	sets.engaged.DW.EnspellOnly = {}
	sets.engaged.DW.Acc = {}
	sets.engaged.DW.FullAcc = {}
		
  -- Dual wield hybrid DT sets
	sets.engaged.DW.DT = {}
	sets.engaged.DW.EnspellOnly.DT = {}
	sets.engaged.DW.Acc.DT = {}
	sets.engaged.DW.FullAcc.DT = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Weapons Sets
-------------------------------------------------------------------------------------------------------------------
-- Single wield sets
	sets.weapons.Savage = {main="Kaja Sword", sub="Buckler", ammo=empty}
	
-- Dual wield sets
	sets.weapons.SavageTP= {}
	sets.weapons.AeolianTP = {}
	sets.weapons.EviscerationTP = {}
	sets.weapons.DualClubs = {}
	sets.weapons.DualAlmace = {}
	
-- Enspell weapons
	sets.weapons.Enspell = {}
	sets.weapons.EnspellDW = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill set
--------------------------------------
	sets.precast.WS = {}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {})
	
--------------------------------------
-- Club weaponskills
--------------------------------------

--------------------------------------
-- Dagger weaponskills
--------------------------------------
  -- Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {}
  
  -- Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
	
--------------------------------------
-- Sword weaponskills
--------------------------------------
  -- Chant Du Cygne
	sets.precast.WS['Chant Du Cygne'] = {}

  -- Sanguine Blade
	sets.precast.WS['Sanguine Blade'] = {}

  -- Savage Blade
	sets.precast.WS['Savage Blade'] = {}

  -- Requiescat
	sets.precast.WS['Requiescat'] = {}

-------------------------------------------------------------------------------------------------------------------
-- Misc. Sets
------------------------------------------------------------------------------------------------------------------- 
--------------------------------------
-- Kiting
--------------------------------------

--------------------------------------
-- Phalanx Applied
--------------------------------------

--------------------------------------
-- Treasure Hunter
--------------------------------------

--------------------------------------
-- Vs. Debuffs
--------------------------------------
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
  -- Sleep
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})

--------------------------------------
-- /SCH Sublimation
--------------------------------------
    sets.buff.Sublimation = {}
    sets.buff.DTSublimation = {}
end

-- Select default macro book on initial load or subjob change.
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