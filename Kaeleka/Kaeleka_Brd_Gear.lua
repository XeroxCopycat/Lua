function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
	state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
	state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant', 'AoE')
    state.IdleMode:options('Normal', 'Regen', 'Refresh')
	state.Weapons:options('Savage', 'Rudras', 'Evisceration', 'Aeolian')
	
	-- Whether to use Carn (or song daggers in general) under a certain threshhold even when weapons are locked.
	state.CarnMode = M{'Always', '300', '1000', 'Never'}

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !r gs c weapons None;gs c update')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')
	send_command('bind !f7 gs c cycle CarnMode')

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
-- Fast Cast gear
--------------------------------------
	sets.precast.FC = {
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +3",
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
		
	sets.precast.FC.DT = set_combine(sets.precast.FC, {})

--------------------------------------
-- Fast Cast for Specific Spells
--------------------------------------
  -- Cure Spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})
	
  -- Dispelga
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})

  -- Enhancing Magic Spells
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
--------------------------------------
-- Fast Cast for Bard Songs
--------------------------------------
	sets.precast.FC.BardSong = set_combine(sets.precast.FC, {head="Fili Calot +3"})
	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, {range="Gjallarhorn", ammo=empty})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong, {range="Gjallarhorn", ammo=empty})
	
	sets.precast.FC.Lullaby = {range="Gjallarhorn", ammo=empty}
	sets.precast.FC.Lullaby.Resistant = {range="Gjallarhorn", ammo=empty}
	sets.precast.FC['Horde Lullaby'] = {range="Blurred Harp +1", ammo=empty}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Blurred Harp +1", ammo=empty}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Blurred Harp +1", ammo=empty}
	sets.precast.FC['Horde Lullaby II'] = {range="Blurred Harp +1", ammo=empty}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Blurred Harp +1", ammo=empty}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Blurred Harp +1a", ammo=empty}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, {range="Miracle Cheer"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range="Daurdabla"})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +3"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

--------------------------------------
-- Step Sets for /DNC
--------------------------------------
	sets.precast.Steps = {
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Brios. Cann. +4",
		feet="Fili Cothurnes +3",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}

--------------------------------------
-- Waltz sets for /DNC
--------------------------------------
	sets.precast.Waltz = {
		head="Volte Beret",
		body="Inyanga Jubbah +2",
		hands="Regal Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Chaac Belt",
		left_ear="Loquac. Earring",
		right_ear="Handler's Earring",
		left_ring="Defending Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Solemnity Cape", --CHR Bard Cape
	}

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast
--------------------------------------
	sets.midcast.FastRecast = {
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +3",
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}

--------------------------------------
-- Midcast for specific spells
--------------------------------------
-- Utsusemi
    sets.midcast.Utsusemi = sets.midcast.FastRecast

--------------------------------------
-- Bardic Music
--------------------------------------
-- Song-specific recast reduction
	sets.midcast.SongRecast = set_combine(sets.midcast.FastRecast, {
		legs="Fili Rhingrave +3",
	})
	
-- Song duration and AF set procs
	sets.midcast.SongEffect = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub="Ammurapi Shield",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
	}
	
  -- Song duration when dual-wielding
	sets.midcast.SongEffect.DW = set_combine(sets.midcast.SongEffect, {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub={ name="Kali"}
	})
	
-- Song defbuff, duration/accuracy
	sets.midcast.SongDebuff = {
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Crepuscular Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Null Shawl",
	}

  -- Song defbuff while dual-wielding
	sets.midcast.SongDebuff.DW = set_combine(sets.midcast.SongDebuff, {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub={ name="Kali"}
	})

-- Song debuff, resistant
	sets.midcast.SongDebuff.Resistant = { 
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs="Fili Rhingrave +3",
		feet="Aya. Gambieras +2",
		neck="Mnbw. Whistle +1",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Digni. Earring",
		left_ring="Kishar Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Null Shawl",
	}

-- Midcast sets for specific songs	
  -- Ballad
	sets.midcast.Ballad = {range="Blurred Harp +1"}
	
  -- Lullabies
	sets.midcast.Lullaby = {range="Gjallarhorn"}
	sets.midcast.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'] = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'] = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
	
  -- Madrigal
	sets.midcast.Madrigal = {
		range="Gjallarhorn",
		head="Fili Calot +3",
		feet="Fili Cothurnes +3",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
  --Etude
	sets.midcast.Etude = {range="Gjallarhorn"}
	
  --Paeon
	sets.midcast.Paeon = {range="Daurdabla"}
	
  --March
	sets.midcast.March = {range="Gjallarhorn"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, {range="Marsyas"})
	
  -- Minuet
	sets.midcast.Minuet = {range="Gjallarhorn", body="Fili Hongreline +3"}
	
  -- Minne
	sets.midcast.Minne = {range="Gjallarhorn"}
	
  -- Carol
	sets.midcast.Carol = {range="Gjallarhorn"}
	
  -- Prelude
	sets.midcast.Prelude = {
		range="Gjallarhorn",
		feet="Fili Cothurnes +3",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
  -- Dirge
	sets.midcast["Adventurer's Dirge"] = {range="Gjallarhorn"}
	
  -- Scherzo
	sets.midcast["Sentinel's Scherzo"] = {range="Gjallarhorn", feet="Fili Cothurnes +3"}
	
  -- Finale
	sets.midcast['Magic Finale'] = {range="Gjallarhorn"}
	
  -- Mazurka
	sets.midcast.Mazurka = {range="Miracle Cheer"}
	
-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range="Daurdabla"}

-- Dummy song with Daurdabla
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range="Daurdabla"})

--------------------------------------
-- Dark Magic
--------------------------------------
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Fili Rhingrave +3",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Metamor. Ring +1",
		right_ring="Evanescence Ring",
		back="Null Shawl",
	})
	
--------------------------------------
-- Divine Magic
-------------------------------------- 
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Fili Rhingrave +3",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Metamor. Ring +1",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	})

--------------------------------------
-- Enfeebling Magic
-------------------------------------- 
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Daybreak",
		sub="Ammurapi Shield",
		body="Cohort Cloak +1",
		hands="Fili Manchettes +3",
		legs="Fili Rhingrave +3",
		feet="Fili Cothurnes +3",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	})

--------------------------------------
-- Enhancing Magic
--------------------------------------	
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		hands="Inyan. Dastanas +2",
		legs="Shedir Seraweels",
		neck="Melic Torque",
		waist="Embla Sash",
		left_ring="Rahab Ring", --(Stikini Ring +1)
		right_ring="Kishar Ring", --(Stikini Ring +1)
	})
	
-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
	})
	
-- Refresh Received
	-- Self Refresh
	sets.Self_Refresh = {waist="Gishdubar Sash"}

--------------------------------------
-- Elemental Magic
--------------------------------------
	sets.midcast['Elemental Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Crepuscular Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Null Shawl",
	}
		
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
--------------------------------------
-- Healing Magic
--------------------------------------
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecast, {
		body="Bunzi's Robe",
		legs="Chironic Hose",
		neck="Loricate Torque +1",
		left_ring="Lebeche Ring",
		right_ring="Menelaus's Ring",
		back="Solemnity Cape",
	})
		
-- Cure Spells
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {})
	
-- Curaga
	sets.midcast.Curaga = sets.midcast.Cure
	
-- Cursna
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {right_ring="Menelaus's Ring", waist="Witful Belt"})
	
-- Cure & Healing Received
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	
-- Status Removal
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
-- Base idle set
	sets.idle = { --DT -40, Regen +17
		head="Fili Calot +3", --DT -11 (Null Masque)
		body="Fili Hongreline +3", --Regen +5
		hands="Fili Manchettes +3", --DT -11
		legs="Fili Rhingrave +3", --DT -13
		feet="Fili Cothurnes +3", --Regen +4, MV +18%
		neck="Bathy Choker +1", --Regen +3
		waist="Plat. Mog. Belt", --(Null Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Chirich Ring +1", --Regen +2
		right_ring="Chirich Ring +1", --Regen +2
		back="Null Shawl", --(Bard Regen cape)
	}

-- Regen set
	sets.idle.Regen = set_combine(sets.idle, {})
	
-- Refresh set
	sets.idle.Refresh = set_combine(sets.idle, { --DT 19, MDT -35, Refresh +6~7, Latent: Refresh +1
		head="Inyanga Tiara +2", --MDT -5, Set: Refresh +3 (Null Masque)
		body="Inyanga Jubbah +2", --MDT -8, Set: Refresh +3 (Kaykaus Bliaut +1)
		hands="Volte Gloves", --Refresh +1
		legs="Assid. Pants +1", --Refresh +1~+2
		feet="Inyan. Crackows +2", --MDT -3, Set: Refresh +3
		neck="Sibyl Scarf", --Refresh +1
		waist="Fucho-no-Obi", --Latent: Refresh +1
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}}, --DT -4
		left_ring="Murky Ring", --DT -10 (Stikini Ring +1)
		right_ring="Shneddick Ring", --MV +18% (Stikini Ring +1)
		back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical damage taken
--------------------------------------
	sets.defense.PDT = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back="Null Shawl",
	}

--------------------------------------
-- Magical damage taken
--------------------------------------
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})

--------------------------------------
-- Magic Evasion
--------------------------------------
	sets.defense.MEVA = set_combine(sets.defense.PDT, {})

--------------------------------------
-- Misc. Defense Sets
--------------------------------------
  -- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}
	
  -- Latent Refresh
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.TPEat = {neck="Chrys. Torque"}

-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Engaged Sets
--------------------------------------
	sets.engaged = {
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		legs="Zoar Subligar +1",
		feet="Volte Spats",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	}
	
  -- Engaged, accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, {
		waist="Kentarch Belt +1",
	})
	
  -- Engaged, full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
  -- Engaged, subtle blow set
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet="Volte Spats",
		neck="Bathy Choker +1",
		left_ear="Digni. Earring",
	})
	
  -- Engaged, DT hybrid set
	sets.engaged.DT = set_combine(sets.engaged, {
		head="Bunzi's Hat",
		legs="Fili Rhingrave +3",
		feet="Nyame Sollerets",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Telos Earring",
		left_ring="Murky Ring", -- Moonlight Ring
		right_ring="Moonlight Ring", 
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	})

---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
	sets.weapons.Savage = {main="Naegling", sub={ name="Centovente", augments={'TP Bonus +1000',}},}
	sets.weapons.Rudras = {main="Aeneas", sub={ name="Centovente", augments={'TP Bonus +1000',}},}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Aeolian = {main={ name="Centovente", augments={'TP Bonus +1000',}}, sub="Daybreak"}
	
---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gear
--------------------------------------
	sets.precast.WS = {
		head="Nyame Helm",
		body="Bihu Just. +4",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Regal Earring", --(Hoxne Earring, R6+)
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring", --(Epaminondas's Ring)
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {right_ring="Sroda Ring"})

--------------------------------------
-- Dagger Weaponskills
--------------------------------------
-- Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Shiva Ring +1",
		back={ name="Intarabus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
-- Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head="Blistering Sallet +1",
		legs="Zoar Subligar +1",
		feet="Aya. Gambieras +2", -- Lustrado Leggings +1 (?)
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear="Mache Earring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}, -- (Bard Dex/Crit cape)
	})
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'].Acc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
-- Mordant Rime
	
-- Rudra's Storm
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		right_ear="Domin. Earring +1",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"].Acc, {})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
-- Ruthless Stroke
	sets.precast.WS['Ruthless Stroke'] = set_combine(sets.precast.WS, {
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		right_ear="Domin. Earring +1", --(Hoxne Earring, R6+)
		right_ring="Ilabrat Ring",
		back="Alabaster Mantle",
	})
	
--------------------------------------
-- Sword Weaponskills
--------------------------------------
-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
		
-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {left_ear="Ishvara Earring", right_ear="Telos Earring",}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Telos Earring"}


---------------------------------------------------------------------------------------------------------------
-- Miscellaneous sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Kiting
--------------------------------------
    sets.Kiting = {}

--------------------------------------
-- Phalanx applied
--------------------------------------

--------------------------------------
-- Treasure Hunter
--------------------------------------
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		waist="Chaac Belt",
	})
	
--------------------------------------
-- Vs. Debuffs
--------------------------------------
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
    
-- Resting sets
    sets.resting = {}
end

-- Select default macro book on initial load or subjob change.
	function select_default_macro_book()
		if player.sub_job == 'NIN' then
			set_macro_page(1, 10)
		elseif player.sub_job == 'DNC' then
			set_macro_page(2, 10)
		else
			set_macro_page(1, 6)
	end
end
	
-- Auto Weaponskill List
	autows_list = {
		['Savage']='Savage Blade',
		['Rudras']="Rudra's Storm",
		['Evisceration']="Evisceration",
		['Aeolian']='Aeolian Edge'
	}
	

