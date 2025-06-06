function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
	state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant', 'AoE')
    state.IdleMode:options('Normal', 'Refresh', 'Regen')
	state.Weapons:options('None', 'Naegling', 'Aeneas', 'DualAeneas', 'DualNaegling', 'DualTauret', 'DualAeolian')
	-- Whether to use Carn (or song daggers in general) under a certain threshhold even when weapons are locked.
	state.CarnMode = M{'Always', '300', '1000', 'Never'}

	--gear.melee_jse_back = {name="Intarabus's Cape",augments={'Accuracy+20 Attack+20'}}
	--gear.magic_jse_back = {name="Intarabus's Cape",augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Miracle Cheer'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
	
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
---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Single handed weapons
	--------------------------------------
	sets.weapons.Aeneas = {main="Aeneas", sub="Ammurapi Shield"}
	sets.weapons.Naegling = {main="Naegling", sub="Ammurapi Shield"}
	sets.weapons.DualAeneas = {main="Aeneas", sub="Gleti's Knife"}
	sets.weapons.DualNaegling = {main="Naegling", sub="Gleti's Knife"}
	sets.weapons.DualTauret = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.DualAeolian = {main="Tauret", sub="Daybreak"}

    --sets.buff.Sublimation = {waist="Embla Sash"}
    --sets.buff.DTSublimation = {waist="Embla Sash"}
	
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
		waist="Witful Belt",
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
	sets.precast.FC.BardSong = set_combine(sets.precast.FC, {range="Miracle Cheer", ammo=empty, head="Fili Calot +3"})
	
	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, {range="Miracle Cheer", ammo=empty})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong, {range="Miracle Cheer", ammo=empty})
	sets.precast.FC.Lullaby = {range="Miracle Cheer", ammo=empty}
	sets.precast.FC.Lullaby.Resistant = {range="Miracle Cheer", ammo=empty}
	sets.precast.FC['Horde Lullaby'] = {range="Miracle Cheer", ammo=empty}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Miracle Cheer", ammo=empty}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Miracle Cheer", ammo=empty}
	sets.precast.FC['Horde Lullaby II'] = {range="Miracle Cheer", ammo=empty}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Miracle Cheer", ammo=empty}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Miracle Cheer", ammo=empty}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, {range="Miracle Cheer"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	--sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	--sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

	--------------------------------------
	-- Precast sets to enhance JAs
	--------------------------------------
	--sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	--sets.precast.JA.Troubadour = {body="Bihu Jstcorps +1"}
	--sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

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
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	--------------------------------------
	-- Fast recast for general spells
	--------------------------------------
	-- Cure Spells
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
		waist="Gishdubar Sash", 
		right_ear="Mendi. Earring", 
		left_ring="Menelaus's Ring",
		right_ring="Lebeche Ring",
	})
	
	-- Curaga
	sets.midcast.Curaga = sets.midcast.Cure
	
	-- Cure & Healing Received
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	
	-- Self Refresh
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
	-- Enhancing Magic
	--sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		--head="Telchine Cap",neck="Voltsurge Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		--body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		--back=gear.magic_jse_back,waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {	waist="Siegel Sash"})
		
	-- Elemental Magic
	--sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		--head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		--body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		--back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	--sets.midcast['Elemental Magic'].Resistant = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		--head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		--body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		--back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
	
	-- Cursna
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
		right_ring="Menelaus's Ring",
		waist="Witful Belt",
	})
		
	--sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})
	
	--------------------------------------
	-- Fast recast for specific spells
	--------------------------------------
	-- Cure received
	sets.Cure_Received = {waist="Gishdubar Sash"}
	
	-- Utsusemi
    sets.midcast.Utsusemi = sets.midcast.FastRecast

	--------------------------------------
	-- Fast recast for specific songs
	--------------------------------------
	-- Ballad
	sets.midcast.Ballad = {range="Miracle Cheer", legs="Fili Rhingrave +3"}
	
	-- Lullabies
	sets.midcast.Lullaby = {range="Miracle Cheer"}
	sets.midcast.Lullaby.Resistant = {range="Miracle Cheer"}
	sets.midcast['Horde Lullaby'] = {range="Miracle Cheer"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Miracle Cheer"}
	sets.midcast['Horde Lullaby'].AoE = {range="Miracle Cheer"}
	sets.midcast['Horde Lullaby II'] = {range="Miracle Cheer"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Miracle Cheer"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Miracle Cheer"}
	
	--Madrigal
	sets.midcast.Madrigal = {
		range="Miracle Cheer",
		head="Fili Calot +3",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	--Paeon
	sets.midcast.Paeon = {range="Blurred Harp +1"}
	
	--March
	sets.midcast.March = {range="Miracle Cheer", hands="Fili Manchettes +3"}
	
	-- Honor March
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, {range="Marsyas"})
	
	-- Minuet
	sets.midcast.Minuet = {range="Miracle Cheer", body="Fili Hongreline +3"}
	
	-- Minne
	sets.midcast.Minne = {range="Miracle Cheer"}
	
	-- Carol
	sets.midcast.Carol = {range="Miracle Cheer"}
	
	--Prelude
	sets.midcast.Prelude = {
		range="Miracle Cheer",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	--Scherzo
	sets.midcast["Sentinel's Scherzo"] = {range="Miracle Cheer", feet="Fili Cothurnes +3"}
	
	-- Finale
	sets.midcast['Magic Finale'] = {range="Miracle Cheer"}
	
	-- Mazurka
	sets.midcast.Mazurka = {range="Miracle Cheer"}
	
	--------------------------------------
	-- Song buff duration and AF set procs
	--------------------------------------
	sets.midcast.SongEffect = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub="Ammurapi Shield",
		body="Fili Hongreline +3",
		legs="Inyanga Shalwar +2",
	}
	
	sets.midcast.SongEffect.DW = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		--sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
	} --Only weapons in this set. This set is overlayed onto SongEffect

	--------------------------------------
	-- Song defbuffs (duration primary, accuracy secondary)
	-------------------------------------- 
	sets.midcast.SongDebuff = {
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Fili Cothurnes +3",
		neck="Mnbw. Whistle +1",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Crepuscular Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Null Shawl",
	}
		
	sets.midcast.SongDebuff.DW = {} --Only weapons in this set. This set is overlayed onto  SongDebuff

	-------------------------------------- 
	-- Song defbuffs (accuracy primary, duration secondary)
	-------------------------------------- 
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

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +3",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
		
	-- Cast spell with normal gear, except using Daurdabla instead
    --sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-------------------------------------- 
	-- Dummy song with Daurdabla
	-------------------------------------- 
    -- sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Standard idle set
	--------------------------------------
	sets.idle = {
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Dawn Earring",
		left_ring="Shneddick Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	--------------------------------------
	-- Refresh set
	--------------------------------------
	sets.idle.Refresh = {
		head="Volte Beret",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Volte Gloves",
		legs="Assid. Pants +1",
		feet="Volte Gaiters",
		neck="Sibyl Scarf",
		waist="Fucho-no-Obi",
		left_ear="Eabani Earring",
		right_ear="Dawn Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	--------------------------------------
	-- Regen set
	--------------------------------------
	sets.idle.Regen = set_combine(sets.idle.Refresh, {
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Fili Rhingrave +3",
		feet="Fili Cothurnes +3",
		neck="Sanctity Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Dawn Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --Regen cape
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical damage taken
	--------------------------------------
	sets.defense.PDT = {
		head="Fili Calot +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Fili Manchettes +3",
		legs="Fili Rhingrave +3",
		feet="Fili Cothurnes +3",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Dawn Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
	}

	--------------------------------------
	-- Magical damage taken
	--------------------------------------
	sets.defense.MDT = set_combine(sets.defense.PDT, {})
	
	--------------------------------------
	-- Magic Evasion
	--------------------------------------
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Hearty Earring",
		left_ring="Icecrack Ring",
	})

	--------------------------------------
	-- Misc. Defense Sets
	--------------------------------------
	sets.Kiting = {left_ring="Shneddick Ring"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.TPEat = {neck="Chrys. Torque"}


-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- Engaged Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Engaged sets, Single Wield
	--------------------------------------
	sets.engaged = {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet="Volte Spats",
		neck="Null Loop",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Mache Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {})
	
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	
	--------------------------------------
	-- Engaged sets, Dual Wield
	--------------------------------------
	sets.engaged.DW = {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet="Volte Spats",
		neck="Null Loop",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Eabani Earring",
		left_ring="Chirich Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.FullAcc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.SubtleBlow = set_combine(sets.engaged.DW, {})
	
---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default weaponskill gear
	--------------------------------------
	sets.precast.WS = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
		
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		right_ear="Mache Earring +1",
	})
	
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		right_ring="Sroda Ring",
	})
	
	--------------------------------------
	-- Dagger Weaponskills
	--------------------------------------
	-- Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Aurist's Cape",
	}
	
	-- Evisceration
	sets.precast.WS['Evisceration'] = {
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body={ name="Nyame Mail", augments={'Path: B',}}, --relic +3 body
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}}, --Lustrado feet
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Mache Earring +1",
		left_ring="Cornelia's Ring",
		right_ring="Ilabrat Ring",
		back="Null Shawl",
	}
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'].Acc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
	-- Rudra's Storm
	sets.precast.WS["Rudra's Storm"] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}}, --relic +3 body
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Null Loop", --bard neck +2
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Mache Earring +1", --dominance earring +1
		left_ring="Cornelia's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"].Acc, {})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
	-- Ruthless Stroke
	
	
	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	sets.precast.WS['Savage Blade'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}}, --bard relic +3
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
		back="Null Shawl", --Str/WS cape
	}
	
	--------------------------------------
	-- Swap to these on Moonshade using WS if at 3000 TP
	--------------------------------------
	sets.MaxTP = {left_ear="Ishvara Earring", right_ear="Telos Earring",}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	
	--------------------------------------
	-- Auto WS List
	--------------------------------------
	autows_list = {
		['Naegling']='Savage Blade',
		['Aeneas']="Rudra's Storm",
		['DualWeapons']="Rudra's Storm",
		['DualNaegling']='Savage Blade',
		['DualTauret']='Evisceration',
		['DualAeolian']='Aeolian Edge'
	}
end

---------------------------------------------------------------------------------------------------------------
-- Miscellaneous
---------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 10)
end


