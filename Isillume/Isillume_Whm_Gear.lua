-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.CastingMode:options('Normal', 'Resistant', 'SIRD', 'DT')
    state.IdleMode:options('Normal', 'Refresh', 'RefreshDT', 'Regen', 'RegenDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'DualWeapons', 'MeleeWeapons')
	state.WeaponskillMode:options('Normal', 'Fodder')

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

-------------------------------------------------------------------------------------------------------------------
-- Start Defining the Sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------
-- ## Fast cast sets for spells ##	
    sets.precast.FC = { --FC +38~40, QC +2
		ammo="Impatiens", --QC +2
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --FC +10
		body="Inyanga Jubbah +2", --FC +13
		feet="Regal Pumps +1", --FC +5~7
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Fast Cast"+10',}}, --FC +10
	}

  -- Fast cast, damage taken	
	sets.precast.FC.DT = {}
    
  -- Enhancing magic fast cast
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
    
  -- Healing Magic fast cast
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		left_ear="Nourish. Earring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Fast Cast"+10',}},
	})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure
	
  -- Specific fast cast sets
    -- Impact
	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {})
	
	-- Dispelga
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})

-- ## Precast sets to enhance JAs ##
    sets.precast.JA.Benediction = {}

-- ## Waltz set for /DNC (CHA + VIT) ##
    sets.precast.Waltz = {}

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------   
-- ## Fast Recast ## 
	sets.midcast.FastRecast = { --FC +38~40
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --FC +10
		body="Inyanga Jubbah +2", --FC +13
		feet="Regal Pumps +1", --FC +5~7
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Sortiarius Earring",
		right_ear="Hearty Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Archon Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Fast Cast"+10',}}, --FC +10
	}
	
-- ## Dark Magic ## 
	sets.midcast['Dark Magic'] = {}

	sets.midcast.Bio = set_combine(sets.midcast['Dark Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Dark Magic']
	
    sets.midcast.Drain = {}
    sets.midcast.Drain.Resistant = {}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}
	sets.midcast.Stun.Resistant = {}
		
	sets.midcast.Dispel = {}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})

-- ## Divine Magic ## 
	sets.midcast['Divine Magic'] = {}
	sets.midcast.Holy = {}

-- ## Elemental Magic ## 
	sets.midcast['Elemental Magic'] = {}
	sets.midcast['Elemental Magic'].Resistant = {}
	sets.midcast.Impact = {}

-- ## Enfeebling Magic ## 
	sets.midcast['Enfeebling Magic'] = {}
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
  -- Specific enfeebling magic sets
  -- Dia
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	
  -- Elemental enfeebles
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

  -- INT based enfeebles
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

  -- MND based enfeebles
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

-- ## Enhancing Magic ## 
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		hands="Inyan. Dastanas +1", --Enhancing Magic +18
		legs="Shedir Seraweels", --Enhancing Magic +15
	})

  -- Specific Enhancing magic spells
    -- Barspells
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Cleric's Pantaln.",
	})
	
	-- Auspice
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	-- Protect
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	
	-- Regen
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		head="Inyanga Tiara +1",
		body="Cleric's Bliaut",
	})
	
	-- Shell
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

-- ## Healing Magic ##
-- Base healing magic set
	sets.midcast['Healing Magic'] = sets.midcast.FastRecast
	
  -- Specific healing magic spells
	-- Cure
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], { --CMP +11, Cure Pot +51/50, Cure Pot II +0, CST -15%, Enmity -18
		main="Chatoyant Staff",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		hands={ name="Vanya Cuffs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		back="Solemnity Cape",
	})
	
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Fast Cast"+10'}},
	})
	
	sets.midcast.LightWeatherCure = {}
	sets.midcast.LightWeatherCureSolace = {}
	sets.midcast.LightDayCureSolace = {}
	sets.midcast.LightDayCure = {}
	sets.midcast.Cure.DT = {}
	
	-- Curaga
	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	sets.midcast.LightWeatherCuraga = {}
	sets.midcast.LightDayCuraga = {}
	
	-- Cursna 
	sets.midcast.Cursna = { --Cursna +80
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --Cursena +5
		neck="Debilis Medallion", --Cursna +15
		left_ring="Haoma's Ring", --Cursna +15
		right_ring="Menelaus's Ring", --Cursna +20
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+11 /Mag. Eva.+11',}}, --Cursna +25
	}

	-- Erase
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {})

	-- Full Cure
	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	-- Status Removal	
	sets.midcast.StatusRemoval = {}
  
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {w})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {})

-- ## Misc. midcast sets ##
    sets.Kiting = {}
    sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
-- ## Situational sets: Gear that is equipped on certain targets ##
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

-- ## Conserve Mp set for spells that don't need anything else, for set_combine. ##
	sets.ConserveMP = { --CMP +11
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --CMP +6
		back="Solemnity Cape", --CMP +5
	}
	
	sets.midcast.Teleport = sets.ConserveMP
	
-- ## Gear for Magic Burst mode. ##
    sets.MagicBurst = {}
		
-------------------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-------------------------------------------------------------------------------------------------------------------
-- ## Idle sets ##
	sets.idle = { --Refresh +2~3 (+1 Latent Refresh), Regen +2
		main="Chatoyant Staff",
		sub="Onerios Grip", --Regen +1, Latent: Refresh +1
		body="Cleric's Bliaut", --Refresh +1
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Herald's Gaiters", --MV +12%
		neck="Loricate Torque +1",
		right_ring="Sheltered Ring" --Regen +1
		waist="Carrier's Sash",
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {})
	
	sets.idle.Regen = set_combine(sets.idle, {right_ring="Sheltered Ring"})

-- ## Resting Sets ##
	sets.resting = { --Refresh +2~3
		main="Chatoyant Staff",
		body="Cleric's Bliaut", --Refresh +1
		legs="Assid. Pants +1", --Refresh +1~2
		right_ring="Sheltered Ring" --Regen +1
	}

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ## Physical damage taken ##
	sets.defense.PDT = { --DT -16/50
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --DT -1
		feet="MGF Ledelsens +1", --DT -5
		neck="Loricate Torque +1", --DT -6
		back="Solemnity Cape", --DT -4
	}
	
  -- ## Magic damage taken ##
	sets.defense.MDT = set_combine(sets.defense.PDT, {neck="Warder's Charm +1", right_ring="Archon Ring"})
	
  -- ##Magic evasion ##
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1", 
		waist="Carrier's Sash",
		right_ear="Hearty Earring",
		right_ring="Archon Ring",
	})

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- ## Engaged sets, single wield ##
	sets.engaged = {}
    sets.engaged.Acc = {}
	
-- ## Engaged sets, dual wield ##
	sets.engaged.DW = {}
    sets.engaged.DW.Acc = {}

-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
-- ## Weapons sets ##
	sets.weapons.None ={}
	sets.weapons.MeleeWeapons = {}
	sets.weapons.DualWeapons = {}

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- Default weaponskill sets
    sets.precast.WS = {}
    sets.precast.WS.Fodder = {}
    sets.precast.WS.Dagan = {}
	sets.MaxTP = {}
	sets.MaxTP.Dagan = {}

-- Club weaponskills
    --sets.precast.WS['Flash Nova'] = {}

-- Staff weaponskills
    --sets.precast.WS['Mystic Boon'] = {}

-------------------------------------------------------------------------------------------------------------------
-- Misc. Sets
------------------------------------------------------------------------------------------------------------------- 
-- Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}

-- Sublimation for /SCH
    sets.buff.Sublimation = {}
    sets.buff.DTSublimation = {}

-- Vs. Debuffs
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
  -- Sleep
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end

autows_list = {['DualWeapons']='Realmrazer',['MeleeWeapons']='Realmrazer'}