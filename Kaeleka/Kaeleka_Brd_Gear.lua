function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'PDL')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'PDL')
	state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant', 'AoE')
    state.IdleMode:options('Normal', 'Regen', 'Refresh')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax', 'SubtleBlow'}
	state.Weapons:options('Savage', 'Ruthless', 'Rudras', 'Evisceration', 'Aeolian')
	
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
-- ### Precast sets to enhance JAs ###
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"} --(Upgrade to +4)
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +4"} 
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"} --(Upgrade to +4)

-- ### Fast cast gear ###
	sets.precast.FC = { --DT -10, FC +79/80
		head="Bunzi's Hat", --FC +10
		body="Inyanga Jubbah +2", --FC +14
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Aya. Cosciales +2", --DT -5, FC +6
		feet="Fili Cothurnes +3", --FC +13
		neck="Voltsurge Torque", --FC +4
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1 (Enchant. Earring +1)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Rahab Ring", --FC +2
		right_ring="Kishar Ring", --FC +4
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --DT -5, FC +10
	}
		
	sets.precast.FC.DT = set_combine(sets.precast.FC, {})

  -- Fast Cast for Specific Spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
  -- Fast Cast for Bard Songs
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
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Blurred Harp +1", ammo=empty}
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, {range="Miracle Cheer"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range="Daurdabla"})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

-- ### Step Sets for /DNC (Max. Acc.) ###
	sets.precast.Steps = { --Base Acc. 1402, DT -39
		head="Fili Calot +3", --DT -11
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3", --DT -11
		legs="Brios. Cann. +4", --DT -8
		feet="Fili Cothurnes +3", 
		neck="Null Loop", --DT -5
		waist="Null Belt",
		left_ear="Regal Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}}, --DT -4
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}

-- ### Waltz sets for /DNC (CHA/VIT) ###
	sets.precast.Waltz = { --DT -42 [PDT -50], Waltz Pot. +10%
		head="Fili Calot +3", --DT -11
		body="Bihu Just. +4", --PDT -7
		hands="Fili Manchettes +3", --DT -11
		legs="Dashing Subligar", --Waltz Pot. +10%
		feet="Fili Cothurnes +3",
		neck="Unmoving Collar +1", 
		waist="Flume Belt +1", --PDT -4
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30) 
		right_ear="Handler's Earring", --(Upgrade to +1, Aug. to R15)
		left_ring="Murky Ring", --DT -10
		right_ring="Metamor. Ring +1", --
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}}, --DT -5, (Intarabus's Cape: VIT +30, 
	}

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast Recast ###
	sets.midcast.FastRecast = {
		head="Bunzi's Hat", --FC +10
		body="Inyanga Jubbah +2", --FC +14
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Aya. Cosciales +2", --DT -5, FC +6
		feet="Fili Cothurnes +3", --FC +13
		neck="Voltsurge Torque", --FC +4
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1 (Enchant. Earring +1)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Rahab Ring", --FC +2
		right_ring="Kishar Ring", --FC +4
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --DT -5, FC +10
	}

    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

-- ### Bard songs ###
  -- Recast reduction
	sets.midcast.SongRecast = set_combine(sets.midcast.FastRecast, {legs="Fili Rhingrave +3"})
	
  -- Duration / Empyrian set procs 
	sets.midcast.SongEffect = set_combine(sets.midcast.FastRecast, { --DT - 42 [PDT -42, MDT -49], Song Duration +51%
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}}, --Song Duration +5%
		sub="Ammurapi Shield",
		head="Fili Calot +3", --DT -11, Madrigal +1
		body="Fili Hongreline +3", --Song Duration +14%, Minuet +1
		hands="Fili Manchettes +3", --DT -11, March +1
		legs="Inyanga Shalwar +2", --MDT -7, Song Duration +17%
		feet="Brioso Slippers +3", --Song Duration +15%
		neck="Mnbw. Whistle +1", --All Songs +3
		left_ear="Alabaster Earring", --DT -5
		left_ring="Murky Ring", --DT -10
	})
	
  -- Duration when dual-wielding
	sets.midcast.SongEffect.DW = set_combine(sets.midcast.SongEffect, {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub={ name="Kali"}
	})
	
  -- Song defbuff, duration/accuracy
	sets.midcast.SongDebuff = set_combine(sets.midcast.FastRecast, {
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		neck="Mnbw. Whistle +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl", --(Intarabus's Cape: CHA +30, MAtk/MAcc +20, FC +10, DT -5)
	})

  -- Song defbuff while dual-wielding
	sets.midcast.SongDebuff.DW = set_combine(sets.midcast.SongDebuff, {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub={ name="Kali"} --(Aug. to R15)
	})

  -- Song debuff, resistant
	sets.midcast.SongDebuff.Resistant = set_combine(sets.midcast.SongDebuff, { 
		body="Bihu Just. +4",
		legs="Brios. Cann. +4",
		left_ear="Regal Earring",
	})

  -- Midcast sets for specific songs	
	sets.midcast.Ballad = {range="Blurred Harp +1"}
	sets.midcast.Lullaby = {range="Gjallarhorn"}
	sets.midcast.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'] = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'] = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
	sets.midcast.Madrigal = {
		range="Gjallarhorn",
		head="Fili Calot +3",
		feet="Fili Cothurnes +3",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	sets.midcast.Etude = {range="Gjallarhorn"}
	sets.midcast.Paeon = {range="Daurdabla"}
	sets.midcast.March = {range="Gjallarhorn"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, {range="Marsyas"})
	sets.midcast.Minuet = {range="Gjallarhorn", body="Fili Hongreline +3"}
	sets.midcast.Minne = {range="Gjallarhorn"}
	sets.midcast.Carol = {range="Gjallarhorn"}
	sets.midcast.Prelude = {
		range="Gjallarhorn",
		feet="Fili Cothurnes +3",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}

	sets.midcast["Adventurer's Dirge"] = {range="Gjallarhorn"}
	sets.midcast["Sentinel's Scherzo"] = {range="Gjallarhorn", feet="Fili Cothurnes +3"}
	sets.midcast['Magic Finale'] = {range="Gjallarhorn"}
	sets.midcast.Mazurka = {range="Miracle Cheer"}
	
  -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range="Daurdabla"}

  -- Dummy songs with Daurdabla
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range="Daurdabla"})

-- ### Dark Magic (DT, MAcc, Dark Magic Skill) ###
	sets.midcast['Dark Magic'] = {
		main="Naegling",
		sub="Ammurapi Shield",
		head="Fili Calot +3",
		body="Bihu Just. +4",
		hands="Fili Manchettes +3",
		legs="Brios. Cann. +4",
		feet="Fili Cothurnes +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Regal Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back="Null Shawl",
	}
	
-- ### Divine Magic (DT, MAcc, Divine Magic Skill) ###
	sets.midcast['Divine Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Fili Calot +3",
		body="Bihu Just. +4",
		hands="Fili Manchettes +3",
		legs="Brios. Cann. +4",
		feet="Fili Cothurnes +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Regal Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	}

-- ### Enfeebling Magic (DT, MAcc, Enfeebling Magic Skill) ###
	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		range="Daurdabla",
		body="Cohort Cloak +1",
		hands="Fili Manchettes +3",
		legs="Brios. Cann. +4",
		feet="Fili Cothurnes +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Regal Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Murky Ring",
		right_ring="Kishar Ring",
		back="Null Shawl",
	}

-- ### Enhancing Magic (DT, Enh. Magic Duration/Skill) ###
	sets.midcast['Enhancing Magic'] = { --DT 
		main="Daybreak",
		sub="Ammurapi Shield", --Enh. Magic Duration +10%
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Inyan. Dastanas +2",
		legs="Shedir Seraweels", 
		feet="Nyame Sollerets", --DT -7
		neck="Melic Torque",
		waist="Embla Sash", --Enh. Magic Duration +10%
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}}, --DT -4
		left_ring="Murky Ring", --DT -10 (Stikini Ring +1)
		right_ring="Kishar Ring", --(Stikini Ring +1)
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	
-- ### Elemental Magic (DT, Matk/Macc, MAB) ###
	sets.midcast['Elemental Magic'] = {
		main="Naegling",
		sub="Ammurapi Shield",
		body="Cohort Cloak +1",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Acuity Belt +1", --(Aug. to R15)
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape", --(Upgrade to +1, Aug. to R15)
	}
		
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
-- ### Healing Magic (DT, Cure Pot. I/II, Healing Magic Skill, MND) ###
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecast, { --DT -50, Cure Pot. +50%, Healing Magic Skill +20
		main="Daybreak", --Cure Pot. +30%
		sub="Ammurapi Shield",
		head="Nyame Helm", --DT -7
		body="Bunzi's Robe", --Cure Pot. +15%
		hands="Inyan. Dastanas +2", --MDT -4, Magic Skills +20
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Null Belt",
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}}, --DT -4
		left_ring="Murky Ring", --DT -10
		right_ring="Kishar Ring", 
		back="Solemnity Cape", --DT -4, Cure Pot. +7%
	})
		
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {})
	sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {right_ring="Menelaus's Ring", waist="Witful Belt"})
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###
	sets.idle = { --DT -50, Regen +14, Refresh +3, Latent: Refresh +1
		main="Mpaca's Staff", --Refresh +2
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		head="Nyame Helm", --DT -7 (Null Masque)
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Fili Cothurnes +3", --Mv. Speed +18%, Regen +4
		neck="Bathy Choker +1", --Regen +3
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Chirich Ring +1", --Regen +2
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --DT -5 (Intarabus's Cape: FC +10, Regen +5)
	}

  -- Regain set
	sets.idle.Regain = set_combine(sets.idle, {}) --(Null Masque)
  
  -- Regen set
	sets.idle.Regen = set_combine(sets.idle, { --DT -32, Regen +20, Refresh +1
		body="Fili Hongreline +3", --Regen +5
		left_ring="Chirich Ring +1", --Regen +2
	})
	
  -- Refresh set
	sets.idle.Refresh = set_combine(sets.idle, { --DT -24, Refresh +6~7, Latent: Refresh +1, Regen +3, Mv. Speed +18%
		head="Volte Beret", --Refresh +1 (Null Masque)
		hands="Volte Gloves", --Refresh +1
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Volte Gaiters", --Refresh +1
		neck="Sibyl Scarf", --Refresh +1
		waist="Fucho-no-obi", --Latent: Refresh +1
		right_ring="Shneddick Ring", --Mv. Speed +18%
	})
	
-- ### Resting set ###
	sets.Resting = { --Regen +14, Refresh +8~9, Latent: Refresh +1
		main="Mpaca's Staff", --Refresh +2
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		head="Volte Beret", --Refresh +1 (Null Masque)
		body="Fili Hongreline +3", --Regen +5
		hands="Volte Gloves", --Refresh +1
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Volte Gaiters", --Refresh +1
		neck="Sibyl Scarf", --Refresh +1
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring",
		right_ear="Infused Earring", --Regen +1
		left_ring="Chirich Ring +1", --Regen +2
		right_ring="Chirich Ring +1", --Regen +2
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --DT -5 (Intarabus's Cape: FC +10, Regen +5)
	}
	
-- ### Misc. idle sets ###
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
	sets.defense.PDT = {
		head="Nyame Helm", 
		body="Nyame Mail", --(Adamantine Armor)
		hands="Nyame Gauntlets", 
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}

  -- Magical damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})

  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Hearty Earring",
		right_ear="Eabani Earring",
		left_ring="Vengeful Ring",
		right_ring="Warden's Ring",
	})

-- Misc. Defense Sets
	--sets.Kiting = {left_ring="Shneddick Ring"}
	
  
	--sets.TPEat = {neck="Chrys. Torque"}

-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged Sets ###
	sets.engaged = { --DT -20, DA +20, Store TP +62
		head="Bunzi's Hat", --DT -7 (Aug. to R30)
		body="Volte Harness", --Store TP +10 (Rev. Platemail, Aug. to R30)
		hands="Bunzi's Gloves", --DT -8, DA +8 (Aug. to R30)
		legs="Volte Tights", --Store TP +8
		feet="Volte Spats", --Store TP +6
		neck={ name="Bard's Charm +2", augments={'Path: A',}}, --Store TP +7
		waist="Reiki Yotai", --Dual Wield +7, Store TP +4
		left_ear="Dedition Earring", --Store TP +8
		right_ear="Brutal Earring", --DA +5, Store TP +1
		left_ring="Moonlight Ring", --DT -5, Store TP +5
		right_ring="Chirich Ring +1", --Store TP +6
		back="Null Shawl", --DA +7, Store TP +7
	}
	
  -- Engaged, accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, {
		left_ear="Telos Earring",
	})
	
  -- Engaged, full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		head="Fili Calot +3",
		body="Bihu Just. +4",
		hands="Fili Manchettes +3",
		legs="Brios. Cann. +4",
		feet="Fili Cothurnes +3",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Regal Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
-- ### Engaged set, dual-wield ###
	sets.engaged.DW = {
		range="Daurdabla", --(Linos, Aug. w/ QA, Store TP)
		head="Bunzi's Hat", --DT -7 (Aug. to R30)
		body="Volte Harness", --Store TP +10 (Rev. Platemail, Aug. to R30)
		hands="Bunzi's Gloves", --DT -8, DA +8 (Aug. to R30)
		legs="Volte Tights", --Store TP +8
		feet="Volte Spats", --Store TP +6
		neck={ name="Bard's Charm +2", augments={'Path: A',}}, --Store TP +7
		waist="Reiki Yotai", --Dual Wield +7, Store TP +4
		left_ear="Dedition Earring", --Store TP +8
		right_ear="Brutal Earring", --DA +5, Store TP +1
		left_ring="Petrov Ring", --DA +1, Store TP +5
		right_ring="Chirich Ring +1", --Store TP +6
		back="Null Shawl", --DA +7, Store TP +7
	}
	
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {left_ear="Telos Earring"})
	
	sets.engaged.DW.FullAcc = set_combine(sets.engaged.DW, {
		head="Fili Calot +3",
		body="Bihu Just. +4",
		hands="Fili Manchettes +3",
		legs="Brios. Cann. +4",
		feet="Fili Cothurnes +3",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Regal Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
-- ### Engaged, DT hybrid sets ###
	sets.engaged.DT = set_combine(sets.engaged, {
		head="Bunzi's Hat",
		body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		legs="Fili Rhingrave +3",
		feet="Volte Spats",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Moonlight Ring",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
	sets.engaged.DT.DW = set_combine(sets.engaged.DW, {
		left_ear="Alabaster Earring",
		left_ring="Murky Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}}, --(Intarabus's Cape: DEX +30, Atk/Acc +20, DA +10, DT -5)
	})
	
-- ### Extra melee modes applied on top of melee sets ###	
	sets.DWMid = { --Dual Wield +21
		right_ear="Eabani Earring", --Dual Wield +4
		waist="Reiki Yotai", --Dual Wield +7, Store TP +4
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}}, --Dual Wield +10
	}
	
	sets.DWMax = { --Dual Wield +26
		left_ear="Suppanomimi", --Dual Wield +5
		right_ear="Eabani Earring", --Dual Wield +4
		waist="Reiki Yotai", --Dual Wield +7, Store TP +4
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}}, --Dual Wield +10
	}
	
	sets.SubtleBlow = { --Subtle Blow +50
		head="Volte Tiara", --Subtle Blow +6
		body="Volte Harness", --Subtle Blow +10
		hands="Volte Mittens", --Subtle Blow +6
		legs="Volte Tights", --Subtle Blow +8
		left_ring="Chirich Ring +1", --Subtle Blow +10
		right_ring="Chirich Ring +1", --Subtle Blow +10
	}

---------------------------------------------------------------------------------------------------------------
-- Weapons and Weaponskill sets
---------------------------------------------------------------------------------------------------------------
-- ### Weaspon sets ###
	sets.weapons.Savage = {main="Naegling", sub="Centovente"}
	sets.weapons.Ruthless = {main="Mpu Gandring", sub="Centovente"}
	sets.weapons.Rudras = {main="Aeneas", name="Centovente"} --(Twashtar)
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Aeolian = {main="Centovente", sub="Daybreak"}
	--sets.weapons.Mordant = {main="Carnwenhan, sub="Crepuscular Knife"}

-- ### Default weaponskill gear ###
	sets.precast.WS = {
		head="Nyame Helm",
		body="Bihu Just. +4",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Sroda Ring",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {neck={ name="Bard's Charm +2", augments={'Path: A',}},})


  -- Dagger Weaponskills
	-- Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		back={ name="Intarabus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
    -- Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head="Blistering Sallet +1",
		legs="Zoar Subligar +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Mache Earring +1",
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}, --(Dex/Crit)
	})
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Evisceration'], {})
	
    -- Rudra's Storm
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		right_ear="Domin. Earring +1", --(Hoxne Earring, MR 7+)
		left_ring="Ilabrat Ring",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS["Rudra's Storm"], {})
	
-- Ruthless Stroke
	sets.precast.WS['Ruthless Stroke'] = set_combine(sets.precast.WS, {
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		right_ear="Domin. Earring +1", --(Hoxne Earring, MR 7+)
		right_ring="Ilabrat Ring",
		back="Alabaster Mantle",
	})
	
	sets.precast.WS['Ruthless Stroke'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Ruthless Stroke'], {})
	
  -- Sword Weaponskills
	-- Savage Blade (uses default WS set as base)
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Savage Blade'], {})

-- ### Weaponskill swaps when using WS at 3000 TP ###
	sets.MaxTP = {left_ear="Ishvara Earring", right_ear="Telos Earring",}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Telos Earring"}


---------------------------------------------------------------------------------------------------------------
-- Miscellaneous sets
---------------------------------------------------------------------------------------------------------------
-- ### Gear equipped when buff effects received ###
  -- Refresh Received
	sets.Self_Refresh = {waist="Gishdubar Sash", back="Grapevine Cape"}
	sets.Phalanx = {}
	
-- ### Gear equiped when debuffs are applied ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
    sets.buff.Sleep = set_combine(sets.buff.Sleep, {})

-- Treasure Hunter ger
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		waist="Chaac Belt",
	})
end

---------------------------------------------------------------------------------------------------------------
-- End file
---------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
	function select_default_macro_book()
		if player.sub_job == 'NIN' then
			set_macro_page(1, 10)
		elseif player.sub_job == 'DNC' then
			set_macro_page(2, 10)
		elseif player.sub_job == 'WHM' then
			set_macro_page(3, 10)
		else
			set_macro_page(1, 10)
	end
end
	
-- Auto Weaponskill List
	autows_list = {
		['Savage']='Savage Blade',
		['Ruthless']='Ruthless Stroke',
		['Rudras']="Rudra's Storm",
		['Evisceration']="Evisceration",
		['Aeolian']='Aeolian Edge'
	}
	

