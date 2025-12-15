-- Setup vars that are user-dependent.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'Regen', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('GreatKatana', 'Polearm', 'ProcWeapon')
    
	
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
-- Enmity set
	sets.Enmity = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body="Nyame Mail",
		hands="Macabre Gaunt. +1",
		legs="Zoar Subligar +1",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Friomisi Earring",
		right_ear="Alabaster Earring",
		left_ring="Vengeful Ring",
		right_ring="Murky Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head="Nyame Helm",
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
-- Precast sets to enhance JAs
  -- Meditate
	sets.precast.JA.Meditate = {
		head="Wakido Kabuto +1",
		--hands="Sakonji Kote +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
  -- Warding Circle
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    
  -- Blade Bash
	--sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	
  -- Sekkanoki
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +3"}
	
  -- Sengikori
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +3"}
	
  -- Ranged Attack / Preshot
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

	-- Waltz sets
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
	
    sets.precast.Waltz['Healing Waltz'] = {}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- Fast Recast Set
    sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head="Kasuga Kabuto +3",
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Ioskeha Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
		left_ring="Rahab Ring",
		right_ring="Murky Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
-- Fast Recast for Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	

-- Ranged Attack / Midshot
    sets.midcast.RA = {
		range="Exalted Bow",
		ammo="Stone Arrow",
        ammo="Sapience Orb",
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet="Volte Spats",
		neck="Combatant's Torque",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
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
-- Base Idle Set
    sets.idle = {
		ammo="Eluder's Sachet",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Nyame Gauntlets",
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Warden's Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
-- Regen set
	sets.idle.Regen = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		head="Twilight Helm",
		body="Sacro Breastplate",
		neck="Bathy Choker +1",
		left_ear="Dawn Earring",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --Regen cape
	})
	
-- Regain set
	sets.idle.Regain = set_combine(sets.idle, {
		--head="Null Masque",
		body="Makora Meikogai",
		right_ring="Murky Ring",
	})
	
-- Reraise Set
	--sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail",})
	
-- Weakened set
    --sets.idle.Weak = {head="Twilight Helm", body="Twilight Mail"}
    

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- Physical Damage Reduction
    sets.defense.PDT = {
		ammo="Eluder's Sachet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Warden's Ring",
		right_ring="Murky Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	--sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
	
-- Magical Damage Reduction
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ring="Archon Ring",
		back="Null Shawl",
	})
	
	--sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
	
-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ring="Icecrack Ring",
		right_ring="Vengeful Ring",
		back="Null Shawl",
	})
	
-- Misc. Defensive Sets
	sets.Kiting = {left_ring="Shneddick Ring"}
	--sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Offense Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged Set
    sets.engaged = {
		ammo="Aurgelmir Orb", --Aurgelmir Orb +1
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Kasuga Domaru +3",
		hands="Wakido Kote +3", -- Tatenashi Gote +1
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck="Vim Torque +1",
		waist="Kentarch Belt +1", --Sweordfatales +1
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, -- Takaha Mantle
	}

-- Engaged accuracy set
    sets.engaged.Acc = set_combine(sets.engaged, {})

-- Engaged full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
-- Subtle Blow set
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		waist="Kentarch Belt +1",
		left_ear="Schere Earring",
		right_ear="Digni. Earring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})
    
-- Hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, {
		ammo="Aurgelmir Orb",
		head="Kasuga Kabuto +3",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		left_ring="Chirich Ring +1",
		right_ring="Murky Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- Default weaponskill gear
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
		right_ear="Thrud Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    
-- Default WS accuracy gear
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
-- Default WS fodder gear
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {feet="Kas. Sune-Ate +3", right_ring="Sroda Ring"})
	
-- Bow Weaponskills
  -- Apex Arrow
	sets.precast.WS['Apex Arrow'] = {}
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})
	
-- Great Katana Weaponskills
  -- Tach: Ageha
    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Kasuga Haidate +3",
		feet="Kas. Sune-Ate +3",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Crepuscular Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Null Shawl",
	})
	
  -- Tachi: Fudo
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
  -- Tachi: Jinpu
	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		right_ear="Schere Earring",
		right_ring="Niqmaddu Ring",
	})
	
	sets.precast.WS['Tachi: Jinpu'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Jinpu'].Fodder = set_combine(sets.precast.WS.Fodder, {
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		right_ring="Sroda Ring"
	})
	
  -- Tachi: Koki
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear="Schere Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Niqmaddu Ring",
	})
	
	sets.precast.WS['Tachi: Koki'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Koki'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  -- Tachi: Shoha
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		body="Nyame Mail",
		legs="Mpaca's Hose",
		feet="Kas. Sune-Ate +3",
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
	})
    
	sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    
	sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {
		ammo="Crepuscular Pebble",
		legs="Mpaca's Hose",
		left_ring="Niqmaddu Ring",
	})

-- Polearm Weaponskills
  -- Impulse Drive
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {})
    sets.precast.WS['Impulse Drive'].Fodder = set_combine(sets.precast.WS['Impulse Drive'], {})

	--------------------------------------
	-- Swaps when using WS at 3000 TP
	--------------------------------------
	sets.MaxTP = {left_ear="Thrud Earring", right_ear="Lugra Earring +1",}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	sets.AccDayMaxTPWSEars = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	sets.DayMaxTPWSEars = {left_ear="Thrud Earring", right_ear="Brutal Earring",}
	sets.AccDayWSEars = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	sets.DayWSEars = {left_ear="Thrud Earring", right_ear="Moonshade Earring",}

    --------------------------------------
    -- Sets to return to when not performing an action.
    --------------------------------------
    -- Resting sets
    sets.resting = {}

-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
	sets.weapons.GreatKatana = {main="Masamune", sub="Utu Grip"}
	sets.weapons.Polearm = {main="Shining One", sub="Utu Grip"}
	
-------------------------------------------------------------------------------------------------------------------
-- Misc. sets
-------------------------------------------------------------------------------------------------------------------
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
		set_macro_page(2, 12)
	elseif player.sub_job == 'DRG' then
		set_macro_page(3, 12)
	else
		set_macro_page(1, 12)
	end
end

-- Auto WS List
	autows_list = {}