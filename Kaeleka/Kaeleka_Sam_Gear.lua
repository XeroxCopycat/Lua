-- Setup vars that are user-dependent.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'Regain', 'Regen', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Masamune', 'ShiningOne', 'Malevolance', 'ProcWeapon')
    
	
	-- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind !backspace input /ja "Third Eye" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !@^` gs c cycle Stance')
	send_command('bind !r gs c set skipprocweapons false;gs c weapons ProcWeapon;gs c set WeaponskillMode Proc;gs c update')
	send_command('bind ^r gs c set skipprocweapons true;gs c weapons Default;gs c set WeaponskillMode Normal;gs c update')
	send_command('bind ^q gs c weapons Bow;gs c update')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

-------------------------------------------------------------------------------------------------------------------
-- Start defining the sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Enmity set
--------------------------------------
	sets.Enmity = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body="Kasuga Domaru +3",
		hands="Macabre Gaunt. +1",
		legs="Zoar Subligar +1",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Friomisi Earring",
		left_ring="Murky Ring",
		right_ring="Vengeful Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

--------------------------------------
-- Fast cast sets for spells
--------------------------------------
    sets.precast.FC = { --FC +28/80
		ammo="Sapience Orb", --FC +2
		head="Nyame Helm",
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque", --FC +4
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring",
		right_ring="Rahab Ring", --FC +2
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --(Fast Cast Cape)
	}

--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
-- Meditate
	sets.precast.JA.Meditate = {
		head="Wakido Kabuto +1", --Upgrade to +4
		--hands="Sakonji Kote +1", --Upgrade to +4
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
-- Warding Circle
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"} --Upgrade to +4
    
-- Blade Bash
	--sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"} --Upgrade to +4
	
-- Sekkanoki
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +3"}
	
-- Sengikori
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +3"}

--------------------------------------	
-- Ranged Attack / Preshot
--------------------------------------
    sets.precast.RA = {
		range="Exalted Bow",
		ammo="Stone Arrow",
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet="Volte Spats",
		waist="Yemaya Belt",
		left_ring="Crepuscular Ring",
	}

--------------------------------------
-- Waltz sets
--------------------------------------
-- Curing Waltz
    sets.precast.Waltz = {
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Dashing Subligar",
		feet="Kas. Sune-Ate +3",
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Handler's Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
-- Healing Waltz
    sets.precast.Waltz['Healing Waltz'] = {}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast Set
--------------------------------------
    sets.midcast.FastRecast = {
		ammo="Sapience Orb", --FC +2
		head="Nyame Helm",
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque", --FC +4
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring",
		right_ring="Rahab Ring", --FC +2
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --(Fast Cast Cape)
	}
	
-- Fast Recast for Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	
--------------------------------------
-- Ranged Attack / Midshot
--------------------------------------
    sets.midcast.RA = {
		range="Exalted Bow",
		ammo="Stone Arrow",
        head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet="Volte Spats",
		neck="Combatant's Torque",
		waist="Yemaya Belt",
		left_ear="Alabaster Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Crepuscular Ring",
		back="Null Shawl",
	}
	
-- Ranged Attack / Midshot Acc
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Kasuga Kote +3",
	})
	
-- Ranged Attack / Midshot FullAcc
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA, {})
	
-- Ranged Attack / Midshot Fodder
	sets.midcast.RA.Fodder = set_combine(sets.midcast.RA, {})
	
-- Ranged Attack / Midcast Subtle Blow
	sets.midcast.RA.SubtleBlow = set_combine(sets.midcast.RA, {})

-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Base Idle Set
--------------------------------------
    sets.idle = { --DT -50, Regen +17
		ammo="Staunch Tathlum +1", --DT -3
		head="Nyame Helm", --DT -7 (Null Masque)
		body="Sacro Breastplate", --Regen +13
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8 (Clem. Haidate)
		feet="Nyame Sollerets", --DT -7
		neck="Bathy Choker +1", --Regen +3
		waist="Plat. Mog. Belt", --DT -3 (Null Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --(Regen cape)
	}

-- Regain set
	sets.idle.Regain = set_combine(sets.idle, {
		--head="Null Masque", --(Wakido Kabuto +4)
		body="Makora Meikogai",
	})
	
-- Regen set
	sets.idle.Regen = set_combine(sets.idle, {
		head="Twilight Helm", --(Null Masque)
		left_ear="Dawn Earring",
		left_ring="Chirich Ring +1",
	})
	
-- Refresh set
	-- sets.idle.refresh = set_combine(sets.idle, {})
	
-- Reraise Set
	--sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail",})
	
-- Weakened set
    --sets.idle.Weak = {head="Twilight Helm", body="Twilight Mail"}
    

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical Damage Reduction
--------------------------------------
    sets.defense.PDT = {
		ammo="Eluder's Sachet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	--sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
	
-- Magical Damage Reduction
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
		back="Null Shawl",
	})
	
	--sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
	
-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		left_ring="Vengeful Ring",
		right_ring="Icecrack Ring",
		back="Null Shawl",
	})

--------------------------------------
-- Misc. Defensive Sets
--------------------------------------
	sets.Kiting = {left_ring="Shneddick Ring"}
	--sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="Volte Cap", body="Volte Jupon", waist="Chaac Belt"})
	sets.DayIdle = {left_ear="Dawn Earring"}
	sets.NightIdle = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Offense Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged Set
    sets.engaged = {
		ammo="Aurgelmir Orb", --(Aurgelmir Orb +1)
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Wakido Kote +3", --(Tatena. Gote +1)
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, 
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Kentarch Belt +1", --(Sweordfatas +1)
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

-- Engaged accuracy set
    sets.engaged.Acc = set_combine(sets.engaged, {
		ammo="Coiste Bodhar",
		feet="Tatena. Sune. +1",
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})

-- Engaged full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		ammo="Amar Cluster",
		feet="Wakido Sune. +3",
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})
	
-- Subtle Blow set
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		hands="Volte Mittens", --(Ken. Tekko +1)
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Digni. Earring",
		right_ring="Chirich Ring +1",
	})
    
-- Hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, {
		ammo="Coiste Bodhar",
		hands="Nyame Gauntlets",
		feet="Nyame Sollerets",
		back="Null Shawl",
	})

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gear
--------------------------------------
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Sakonji Do. +4",
		hands="Kasuga Kote +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Regal Ring", --(Epaminondas's Ring)
		right_ring="Cornelia's Ring", 
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    
-- Weaponskill accuracy gear
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
-- Weaponskill fodder gear
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {feet="Kas. Sune-Ate +3", right_ring="Sroda Ring"})
	
-- Weaponskill DT gear
	sets.precast.WS.DT = set_combine(sets.precast.WS, {})

--------------------------------------
-- Bow Weaponskills
--------------------------------------
-- Apex Arrow
	sets.precast.WS['Apex Arrow'] = {}
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})
	
--------------------------------------
-- Great Katana Weaponskills
--------------------------------------
-- Tach: Ageha
    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Kasuga Haidate +3",
		feet="Kas. Sune-Ate +3",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Moonshade Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	})
	
-- Tachi: Fudo
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
-- Tachi: Gekko
	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
-- Tachi: Jinpu
	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
	})
	
	sets.precast.WS['Tachi: Jinpu'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Jinpu'].Fodder = set_combine(sets.precast.WS.Fodder, {})

-- Tacki: Kasha
	sets.precast.WS['Tacki: Kasha'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tacki: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tacki: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

-- Tachi: Koki
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Koki'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Koki'].Fodder = set_combine(sets.precast.WS.Fodder, {})

-- Tachi: Mumei
	sets.precast.WS['Tachi: Mumei'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Mumei'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Mumei'].Fodder = set_combine(sets.precast.WS.Fodder, {})

-- Tachi: Shoha
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		left_ring="Niqmaddu Ring",
	})
    
	sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {
		ammo="Crepuscular Pebble",
		legs="Mpaca's Hose",
		left_ring="Niqmaddu Ring",
	})

-- Tachi: Yukikaze
	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})

--------------------------------------
-- Polearm Weaponskills
--------------------------------------
-- Impulse Drive
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {})
    sets.precast.WS['Impulse Drive'].Fodder = set_combine(sets.precast.WS['Impulse Drive'], {})
	
-- Sonic Thrust
	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Sonic Thrust'].Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS['Sonic Thrust'].Fodder = set_combine(sets.precast.WS, {})
	
-- Stardiver
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear="Schere Earring",
		right_ring="Niqmaddu Ring",
	})
		
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS, { })
    sets.precast.WS['Stardiver'].Fodder = set_combine(sets.precast.WS, { })

--------------------------------------
-- Misc. weaponskill sets
--------------------------------------
	sets.Skillchain = {
		head="Mpaca's Cap",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.MaxTP = {left_ear="Thrud Earring", right_ear="Lugra Earring +1",}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	sets.AccDayMaxTPWSEars = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	sets.DayMaxTPWSEars = {left_ear="Thrud Earring", right_ear="Brutal Earring"}
	sets.AccDayWSEars = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	sets.DayWSEars = {left_ear="Thrud Earring", right_ear="Moonshade Earring"}

-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
	sets.weapons.Masamune = {main="Masamune", sub="Utu Grip"}
	sets.weapons.ShiningOne = {main="Shining One", sub="Utu Grip"}
	--sets.weapons.Malevolance = {main="Malevolance", sub="Malevolance"}
	
-------------------------------------------------------------------------------------------------------------------
-- Misc. sets
-------------------------------------------------------------------------------------------------------------------
-- Resting sets
    sets.resting = {}


-- Treasure Hunter	
	sets.TreasureHunter = {
		head="Volte Cap",
		body="Volte Jupon",
		legs="Volte Hose",	
	}
	
-- Cure received
	sets.Cure_Received = {waist="Gishdubar Sash", legs="Flamma Dirs +2"}
	
-- Vs. Doomed
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	
-- Vs. Sleep
	sets.buff.Sleep = {neck="Vim Torque +1"}
	
-- Hasso
	sets.buff.Hasso = {hands="Wakido Kote +3"}
	
-- Meikyo Shisui
    --sets.buff['Meikyo Shisui'] = {feet="Sak. Sune-Ate +1"}
    
-- Sekkanoki
	sets.buff.Sekkanoki = {hands="Kasuga Kote +3"}
	
-- Sengikori
    sets.buff.Sengikori = {feet="Kas. Sune-Ate +3"}
	
-- Third Eye	
	sets.buff['Third Eye'] = {} --legs="Sakonji Haidate +3"
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 13)
	elseif player.sub_job == 'DRG' then
		set_macro_page(3, 13)
	else
		set_macro_page(1, 13)
	end
end

-- Auto WS List
	autows_list = {
		['Masamune']='Tachi: Fudo',
		--['Kusanage']='Tachi: Mumei',
		['ShiningOne']='Stardiver',
		['Malevolance']='Aeolian Edge',
	}