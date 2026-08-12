-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow', 'PDL')
    state.CastingMode:options('Normal', 'Resistant', 'SIRD', 'DT')
    state.IdleMode:options('Normal', 'Refresh', 'RefreshDT', 'Regen', 'RegenDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Maxentius', 'Chatoyant')
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

-----------------------------------------------------------------------------------------------------------
-- Start Defining the Sets
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-- Precast Sets
-----------------------------------------------------------------------------------------------------------
-- ### Fast cast sets for spells ###	
    sets.precast.FC = { --FC +60~62, QC +7
		--main="Queller Rod", -- (Cait Palug Hammer)
		--sub="Archduke's Shield", -- (Chanter's Shield)
		ammo="Impatiens", --QC +2
		head="Ebers Cap +2", --FC +10
		body="Inyanga Jubbah +2", --FC +14
		hands={ name="Fanatic Gloves", augments={'MP+10','Healing magic skill +2','"Conserve MP"+1',}}, --(Augment w/ FC +7)
		legs="Aya. Cosciales +2", --FC +6
		feet="Regal Pumps +1", --FC +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --FC +10
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", -- (Malignance Earring)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring", 
		right_ring="Lebeche Ring", --QC +2
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10 (Permiade Cape)
	}

-- Fast cast, damage taken	
	sets.precast.FC.DT = {}
    
-- ### Enhancing magic fast cast ###
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
		
	-- Stoneskin
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
    
-- ### Healing Magic Fast Cast ###
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, { --FC (HMCT) +73~75
		main="Vadose Rod", --Healing Magic Casting time -5%
		legs="Ebers Pant. +3", --Healing Magic Casting Time -14%
	})
	
-- ### Cure Spell Fast Cast
	-- Cure spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC, { --FC (HMCT + CST) +80
		main="Vadose Rod", --Healing Magic Casting Time -5%
		head="Piety Cap +3", --CST -12%
		legs="Ebers Pant. +3", --Healing Magic Casting Time -14%
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Cure Spellcasting Time -7%
		left_ear="Nourish. Earring", --Cure Spellcasting Time -3%
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
    sets.precast.JA.Benediction = {body="Piety Bliaut +3"}
	sets.precast.JA.Devotion = {head="Piety Cap +3"}
	sets.precast.JA.Martyr = {hands="Piety Mitts +3"}

-- ### Waltz set for /DNC (CHA + VIT) ###
    sets.precast.Waltz = {}

-----------------------------------------------------------------------------------------------------------
-- Midcast Sets
-----------------------------------------------------------------------------------------------------------
-- ### Fast Recast ### 
	sets.midcast.FastRecast = { --FC +60~62
		ammo="Impatiens",
		head="Ebers Cap +2", --FC +10
		body="Inyanga Jubbah +2", --FC +14
		hands={ name="Fanatic Gloves", augments={'MP+10','Healing magic skill +2','"Conserve MP"+1',}}, --(Fanatic Gloves w/ FC)
		legs="Aya. Cosciales +2", --FC +6
		feet="Regal Pumps +1", --FC +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --FC +10
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring",
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring",
		right_ring="Lebeche Ring", --QC +2
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10
	}
	
-- ## Dark Magic ## 
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		body="Ebers Bliaut +2",
		hands="Inyan. Dastanas +2",
		legs="Ebers Pant. +3",
		feet="Inyan. Crackows +2",
		waist="Refoccilation Stone",
		right_ear="Magnetic Earring",
		left_ring="Murky Ring", --(Evanescence Ring)
		right_ring="Archon Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
	})

  -- Specific Dark Magic spells
    -- Bio/Bio II
	sets.midcast.Bio = set_combine(sets.midcast['Dark Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Dark Magic']
	
	-- Drain
    sets.midcast.Drain = {}
    sets.midcast.Drain.Resistant = {}

	-- Aspir
    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    -- Stun
	sets.midcast.Stun = {}
	sets.midcast.Stun.Resistant = {}
		
-- ## Divine Magic ## 
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands={ name="Fanatic Gloves", augments={'MP+10','Healing magic skill +2','"Conserve MP"+1',}},
		legs="Ebers Pant. +3",
		feet="Inyan. Crackows +2",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Refoccilation Stone",
		right_ring="Inyanga Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
	})
	
  -- Specific Divine Magic Spells
    -- Banish/II/III
	sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {})
	
	-- Holy
	sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], {
		hands="Piety Mitts +3",
	})
	
	-- Repose
	sets.midcast.Repose = set_combine(sets.midcast['Divine Magic'], {
		hands="Piety Mitts +3",
	})

-- ### Elemental Magic ### 
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands={ name="Fanatic Gloves", augments={'MP+10','Healing magic skill +2','"Conserve MP"+1',}},
		legs="Ebers Pant. +3",
		feet="Inyan. Crackows +2",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Refoccilation Stone",
		right_ear="Sortiarius Earring",
		right_ring="Inyanga Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
	})
	
	sets.midcast['Elemental Magic'].Resistant = {}
	
  -- Elemental enfeebles
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
  -- Specific Elemental Magic Spells
    -- Impact
	sets.midcast.Impact = {}

-- ### Enfeebling Magic ### 
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		body="Theo. Bliaut +2",
		hands="Piety Mitts +3",
		legs="Ebers Pant. +3",
		feet="Piety Duckbills +3",
		waist="Refoccilation Stone",
		right_ring="Inyanga Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
	})
	
	sets.midcast['Enfeebling Magic'].Resistant = {}
	
  -- INT based enfeebles
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

  -- MND based enfeebles
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
		
  -- Specific enfeebling magic sets
    -- Dia
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	
    -- Dispel
	sets.midcast.Dispel = {}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})
	
-- ### Enhancing Magic ### 
	sets.midcast['Enhancing Magic'] = {
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2", --Magic skill +20
		legs="Piety Pantaln. +3", --Enh. magic skill +26, Elemental resist spell +36
		feet="Ebers Duckbills +2", --Enh. magic skill +30
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Alabaster Earring",
		right_ear="Loquac. Earring",
		left_ring="Murky Ring",
		right_ring="Mephitas's Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}

  -- Specific Enhancing magic spells
	-- Auspice
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +2"})
	
	-- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod", 
		legs="Shedir Seraweels",
	})

	-- Barspells
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands="Ebers Mitts +2",
	})
	
	-- Protect
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
		feet="Theo. Duckbills +2", --Enh. magic duration +5%
		right_ring="Sheltered Ring",
	})
	
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
		feet="Theo. Duckbills +2", --Enh. magic duration +5%
		right_ring="Sheltered Ring",
	})
	
	-- Regen
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], { --Regen Potency +66, Regen Duration +43, Enh. Magic Duration +5% 
		head="Inyanga Tiara +2", --Regen pot. +14
		body="Piety Bliaut +3", --Regen pot. +52
		hands="Ebers Mitts +1", --Regen duration +22
		legs="Th. Pant. +3", --Regen duration +24
		feet="Theo. Duckbills +2", --Enhancing magic duration +5%
	})
	
	-- Shell
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {
		feet="Theo. Duckbills +2", --Enh. magic duration +5%
		right_ring="Sheltered Ring",
	})
	
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
		feet="Theo. Duckbills +2", --Enh. magic duration +5%
		right_ring="Sheltered Ring",
	})
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir Seraweels",
		feet="Theo. Duckbills +2", --Enh. magic duration +5%
	})

-- ### Healing Magic ###
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecast, { --CPot +55/50, CPotII +21, Conserve MP +12, Enmity -58~62
		main="Raetic Rod +1", --Cure Pot. +23, Cure Pot. II +10, Cure +50, 
		sub="Archduke's Shield", --(Thuellaic Ecu +1)
		ammo="Impatiens", --(Pemphedo Tathlum)
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Cure Pot. +11, Set: Cure Pot. II +4, Enmity -6
		body="Theo. Bliaut +2", --Cure Pot. II +3, Enmity -5 (Upgrade to +4)
		hands="Theophany Mitts +3", --Cure Pot. II +4, Enmity -7 (Upgrade to +4)
		legs="Ebers Pant. +3", --Convert 8% of cure amount to MP
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Cure Pot. +11, Enmity -12, Conserve MP +7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --Cure Pot. +10, Enmity -25
		waist="Witful Belt",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Magnetic Earring", --Conserve MP +5
		left_ring="Murky Ring", --DT -10
		right_ring="Mephitas's Ring +1", --Enmity -3~7
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	})
	
  -- Specific healing magic spells
	-- Cure
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], {})
	
	-- Cure with Afflatius Solace active
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {})
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
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'], { --Cursna +112, Divine Veil +22
		head="Ebers Cap +2", --Divine Veil +24
		hands="Fanatic Gloves", --Cursna +15
		legs="Th. Pant. +3", --Cursna +17
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --Cursna +5
		neck="Debilis Medallion", --Cursna +15
		left_ring="Haoma's Ring", --Cursna +15
		right_ring="Menelaus's Ring", --Cursna +20
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --Cursna +25
	})

	-- Erase
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {})

	-- Full Cure
	sets.midcast['Full Cure'] = sets.midcast.FastRecast['Healing Magic']
	
	-- Status Removal	
	sets.midcast.StatusRemoval = set_combine(sets.midcast['Healing Magic'], {
		head="Ebers Cap +2", --Divine Veil +24
	}) 
  
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
	sets.ConserveMP = { --Conserve MP +17
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, 
		left_ear="Magnetic Earring", 
		back="Solemnity Cape",
	}
	
	sets.midcast.Teleport = sets.ConserveMP
	
-- ### Gear for Magic Burst mode. ###
    sets.MagicBurst = {
		right_ring="Mujin Band",
	}
		
-----------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-----------------------------------------------------------------------------------------------------------
-- ## Idle sets ##
	sets.idle = { --Refresh +8~9, Regen +4, PDT -25/MDT -29, Mv. Speed +18%
		main="Queller Rod",
		sub="Archduke's Shield",
		ammo="Impatiens",
		head="Inyanga Tiara +2",
		body="Ebers Bliaut +2",
		hands="Inyan. Dastanas +2",
		legs="Assid. Pants +1",
		feet="Inyan. Crackows +2",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Shneddick Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {})
	
	sets.idle.Regen = set_combine(sets.idle, {right_ring="Sheltered Ring"})

-- ## Resting Sets ##
	sets.resting = set_combine(sets.idle, {})

-----------------------------------------------------------------------------------------------------------
-- Defense Sets
-----------------------------------------------------------------------------------------------------------
-- ## Physical damage taken ##
	sets.defense.PDT = { --DT -37/50
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Ebers Mitts +2",
		legs="Ebers Pant. +3",
		feet="MGF Ledelsens +1",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Shneddick Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
  -- ## Magic damage taken ##
	sets.defense.MDT = set_combine(sets.defense.PDT, {})
	
  -- ## Magic evasion ##
    sets.defense.MEVA = set_combine(sets.defense.PDT, {})

-----------------------------------------------------------------------------------------------------------
-- Engaged Sets
-----------------------------------------------------------------------------------------------------------
-- ## Engaged sets, single wield ##
	sets.engaged = {}
	
    sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	sets.engaged.PDL = set_combine(sets.engaged, {})
	
  -- Engaged hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, {})
	
-- ## Engaged sets, dual wield ##
	sets.engaged.DW = {}
    sets.engaged.DW.Acc = {}

-----------------------------------------------------------------------------------------------------------
-- Weapon sets
-----------------------------------------------------------------------------------------------------------
-- ## Weapons sets ##
	sets.weapons.None ={main=empty, sub=empty}
	sets.weapons.Maxentius = {main="Maxentius", sub="Archduke's Shield"}
	sets.weapons.Chatoyant = {main="Chatoyant Staff", sub="Enki Strap"}

-----------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-----------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------
-- Misc. Sets
-----------------------------------------------------------------------------------------------------------
-- Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +2"}
	
-- Reive mark, worn within colonization/lair reives
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {
		neck="Arciela's Grace +1",
	})

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