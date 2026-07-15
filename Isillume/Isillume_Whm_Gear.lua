-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow', 'PDL')
    state.CastingMode:options('Normal', 'Resistant', 'SIRD', 'DT')
    state.IdleMode:options('Normal', 'Refresh', 'RefreshDT', 'Regen', 'RegenDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Club', 'Staff')
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
-- ### Fast cast sets for spells ###	
    sets.precast.FC = { --FC +52~54, QC +2
		ammo="Impatiens", --QC +2
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --FC +10 (Ebers Cap +3)
		body="Inyanga Jubbah +2", --FC +14
		hands="Aya. Manopolas +2", --(Fanatic Gloves)
		legs="Aya. Cosciales +2", --FC +6 (Volte Brais)
		feet="Regal Pumps +1", --FC +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --FC +5/10 (Aug to R25)
		waist="Carrier's Sash", --(Witful Belt)
		left_ear="Alabaster Earring", --(Malignance Earring)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring", --(Lebeche Ring)
		right_ring="Mephitas's Ring +1", --(Kishar Ring)
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Mag. Evasion+15',}}, --FC +10 (Perimede Cape)
	}

  -- Fast cast, damage taken	
	sets.precast.FC.DT = set_combine(sets.precast.FC, {
		hands="Aya. Manopolas +2", --DT -3
		legs="Aya. Cosciales +2", --DT -5, FC +6
		neck="Loricate Torque +1", --DT -6
		back="Solemnity Cape", --DT -4
	})
    
  -- Enhancing magic fast cast
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { --Enh. Magic Skill 472/500
		hands="Inyan. Dastanas +2", --Magic Skill +20
		legs="Piety Pantaloons +3", --Enhancing Skill +26
		feet="Theo. Duckbills", --Enhancing Skill +15
	})
		
	-- Stoneskin
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
    
  -- Healing Magic fast cast
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		legs="Ebers Pant. +1", --Converts 6% of cure amount to MP (Upgrade to +3)
	})
	
  -- Fast cast sets for specific spells
	-- Cure spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], { --FC 41/80, CST 36
		main="Raetic Rod +1",
		sub="Sors Shield", --CST -5%
		legs="Ebers Pant. +1", --CST -13%, Converts 6% of cure amount to MP (Upgrade to +3)
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --CST -15%
		right_ear="Nourish. Earring", --CST -3
	})
  
	-- Dispelga
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})
	
    -- Impact
	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {})
	
	-- Status removal spells
	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure

-- ### Precast sets to enhance JAs ###
    sets.precast.JA.Benediction = {body="Piety Bliaut +1"}
	sets.precast.JA.Devotion = {head="Piety Cap +1"}
	sets.precast.JA.Martyr = {hands="Piety Mitts +1"}

-- ### Waltz set for /DNC (CHA + VIT) ###
    sets.precast.Waltz = {}

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------   
-- ### Fast Recast ### 
	sets.midcast.FastRecast = { --FC +52~54, QC +2
		ammo="Impatiens", --QC +2 (Sapience Orb)
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --FC +10 (Ebers Cap +3)
		body="Inyanga Jubbah +2", --FC +14
		hands="Aya. Manopolas +2", 
		legs="Aya. Cosciales +2", --FC +6 (Volte Brais)
		feet="Regal Pumps +1", --FC +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --FC +5/10 (Aug to R25)
		waist="Carrier's Sash", --(Witful Belt)
		left_ear="Alabaster Earring", --(Malignance Earring)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring", --(Lebeche Ring)
		right_ring="Mephitas's Ring +1", --(Kishar Ring)
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Mag. Evasion+15',}}, --FC +10 (Perimede Cape)
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
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --Divine Magic +20
		hands="Inyan. Dastanas +2", --Magic Skill +20
		legs="Theo. Pantaloons", --Divine Magic +17
	})
	
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

-- ### Enhancing Magic ### 
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		hands="Inyan. Dastanas +1", --Magic skills +20
		legs="Piety Pantaln. +1", --Enhancing Magic +22
	})

  -- Specific Enhancing magic spells
    -- Barspells
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Piety Pantaln.", --Elemental resist spells +30
	})
	
	-- Auspice
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels"})

	-- Protect
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	
	-- Regen
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], { --Regen potency +50%
		head="Inyanga Tiara +2", --Regen potency +14%
		body="Piety Bliaut +1", --Regen potency +36%
	})
	
	-- Shell
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels"})

-- ### Healing Magic ###
-- Base healing magic set
	sets.midcast['Healing Magic'] = sets.midcast.FastRecast 
	
  -- Specific healing magic spells
	-- Cure
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], { --Cure Potency +69/50, Cure Pot. II +10, "Cure" +50, Conserve MP +22
		main="Raetic Rod +1", --Cure Pot. +23, Cure Pot. II +10, "Cure" +50
		sub="Archduke's Shield",
		ammo="Impatiens", --SIRD -10
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --Cure Pot. +10, Conserve MP +6
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --Cure Pot. +7
		hands={ name="Vanya Cuffs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --Cure Pot. +7
		legs="Ebers Pant. +1" --Converts 6% of cure amount to MP (Upgrade to +3)
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --Cure Pot. +5, Conserve MP +6 (Theo. Duckbills +4) 
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --Cure Pot. +10
		waist="Carrier's Sash",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Magnetic Earring", --Conserve MP +5, SIRD -8
		left_ring="Murky Ring", --DT -10, SIRD -3
		right_ring="Mephitas's Ring +1",
		back="Solemnity Cape", --Cure Pot. +7, Conserve MP +5, DT -4
	})
	
	-- Cure with Afflatius Solace active
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {
		feet="Piety Duckbills +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Mag. Evasion+15',}},
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
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --Cursna +5
		neck="Debilis Medallion", --Cursna +15
		left_ring="Haoma's Ring", --Cursna +15
		right_ring="Menelaus's Ring", --Cursna +20
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Mag. Evasion+15',}}, --Cursna +25
	}

	-- Erase
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
	})

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
	sets.ConserveMP = { --Conserve MP +28
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --Conserve MP +6
		legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --Conserve MP +6
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --Conserve MP +6
		right_ear="Magnetic Earring", --Conserve MP +5
		back="Solemnity Cape", --Conserve MP +5
	}
	
	sets.midcast.Teleport = sets.ConserveMP
	
-- ## Gear for Magic Burst mode. ##
    sets.MagicBurst = {}
		
-------------------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-------------------------------------------------------------------------------------------------------------------
-- ## Idle sets ##
	sets.idle = { --Refresh +5-6, DT -31
		main="Queller Rod", --Refresh +1
		sub="Archduke's Shield", --Refresh +1
		head="Aya. Zucchetto +2", --DT -3
		body="Piety Bliaut +1", --Refresh +2
		hands="Aya. Manopolas +2", --DT -3
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Herald's Gaiters",
		neck="Loricate Torque +1", --DT -6
		waist="Carrier's Sash", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Hearty Earring",
		left_ring="Murky Ring", --DT -10
		right_ring="Archon Ring",
		back="Solemnity Cape", --DT -4
	}
	
	sets.idle.Refresh = set_combine(sets.idle, { --Refresh +6~7, DT -25
		head="Inyanga Tiara +2",
		hands="Inyan. Dastanas +2",
	})
	
	sets.idle.Regen = set_combine(sets.idle, {right_ring="Sheltered Ring"})

-- ## Resting Sets ##
	sets.resting = set_combine(sets.idle, { --Refresh +7~8, DT -25
		head="Inyanga Tiara +2",
		hands="Inyan. Dastanas +2",
		feet="Inyan. Crackows +2",
	})

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ## Physical damage taken ##
	sets.defense.PDT = { --DT -47/50
		head="Aya. Zucchetto +2", --DT -3
		body="Ayanmo Corazza +2", --DT -6
		hands="Aya. Manopolas +2", --DT -3
		legs="Aya. Cosciales +2", --DT -5
		feet="MGF Ledelsens +1", --DT -5
		neck="Loricate Torque +1", --DT -6
		waist="Carrier's Sash",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Hearty Earring",
		left_ring="Murky Ring", --DT -10
		right_ring="Archon Ring",
		back="Solemnity Cape", --DT -4
	}
	
  -- ## Magic damage taken ##
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1", 
		waist="Carrier's Sash",
	})
	
  -- ##Magic evasion ##
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		sub="Archduke's Shield",
		neck="Warder's Charm +1", 
		waist="Carrier's Sash",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Mag. Evasion+15',}},
	})

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- ## Engaged sets, single wield ##
	sets.engaged = {
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
	}
	
    sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	sets.engaged.PDL = set_combine(sets.engaged, {})
	
  -- Engaged hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, {})
	
-- ## Engaged sets, dual wield ##
	sets.engaged.DW = {}
    sets.engaged.DW.Acc = {}

-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
-- ## Weapons sets ##
	sets.weapons.None ={main=empty, sub=empty}
	sets.weapons.Club = {main="Raetic Rod +1", sub="Sors Shield"}
	sets.weapons.Staff = {main="Chatoyant Staff", sub=empty}

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
	set_macro_page(3, 1)
end

autows_list = {['DualWeapons']='Realmrazer',['MeleeWeapons']='Realmrazer'}