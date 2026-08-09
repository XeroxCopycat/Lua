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
    state.Weapons:options('Masamune', 'ShiningOne', 'ProcWeapon')
    
	
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
-- ### Enmity set ###
	sets.Enmity = { --PDT -50/MDT -44, Enmity +39~44
		ammo="Sapience Orb", --Enmity +2
		head="Loess Barbuta +1", --DT -10, Enmity +9~14
		body="Nyame Mail", --DT -9
		hands="Macabre Gaunt. +1", --Enmity +7
		legs="Zoar Subligar +1", --Enmity +6
		feet="Nyame Sollerets", --DT -7
		neck="Unmoving Collar +1", --Enmity +10
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Friomisi Earring", --Enmity +2
		left_ring="Murky Ring", --DT -10
		right_ring="Vengeful Ring", --Enmity +3
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --PDT -10
	}

-- ### Fast cast sets for spells ###
    sets.precast.FC = { --FC +26, QC +4, PDT -42/MDT -32
		ammo="Impatiens", --QC +2
		head="Kasuga Kabuto +3", --DT -10
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Nyame Flanchard", --DT -8
		legs="Kasuga Haidate +3", --DT -11
		neck="Baetyl Pendant", --FC +4
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Loquac. Earring", --FC +2
		right_ear="Etiolation Earring", --FC +1
		left_ring="Rahab Ring", --FC +2
		right_ring="Lebeche Ring", --QC +2
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --PDT -10 (Ambu Capt w/ FC +10)
	}

-- ### Precast sets to enhance JAs ###
  -- Meditate
	sets.precast.JA.Meditate = {
		head="Wakido Kabuto +1", --(Upgrade to +4)
		--hands="Sakonji Kote +1", --(Upgrade to +4)
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"} --(Upgrade to +4)
	--sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"} --(Upgrade to +4)
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +3"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +3"}
	
-- ### Ranged attack, preshot ###
    sets.precast.RA = {
		range="Exalted Bow",
		ammo="Stone Arrow",
		head="Volte Tiara", --Snapshot +3
		body="Volte Harness", --Snapshot +2
		hands="Volte Mittens", --Snapshot +2
		legs="Volte Tights", --Snapshot +5
		feet="Volte Spats", --Snapshot +2
		waist="Yemaya Belt", --Rapid Shot +
		left_ring="Crepuscular Ring", --Snapshot +3
	}

-- ### /DNC Step sets ###
	sets.precast.Steps = { -- Acc 1501
		ammo="Hasty Pinion +1",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Kasuga Haidate +3",
		feet="Kas. Sune-Ate +3",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Domin. Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}

-- ### /DNC Waltz sets ###
  -- Curing Waltz
    sets.precast.Waltz = { --VIT +201, CHA +166, Waltz Pot. +10%
		ammo="Staunch Tathlum +1",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Dashing Subligar",
		feet="Kas. Sune-Ate +3",
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Alabaster Earring",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --(Ambu Cape w/ VIT, FC, DT)
	}
	
  -- Healing Waltz
    sets.precast.Waltz['Healing Waltz'] = {}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast Recast Set ###
	sets.midcast.FastRecast = {
		ammo="Sapience Orb", --FC +2
		head="Kasuga Kabuto +3", --DT -10
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Nyame Flanchard", --DT -8
		legs="Kasuga Haidate +3", --DT -11
		neck="Baetyl Pendant", --FC +4
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Loquac. Earring", --FC +2
		right_ear="Etiolation Earring", --FC +1
		left_ring="Rahab Ring", --FC +2
		right_ring="Lebeche Ring", --QC +2
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --PDT -10 (Ambu Capt w/ FC +10)
	}
	
  -- Fast Recast for Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	
-- ### Ranged Attack / Midshot ###
    sets.midcast.RA = {
		range="Exalted Bow",
		ammo="Stone Arrow",
        head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck="Vim Torque +1",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Crepuscular Ring",
		right_ring="Chirich Ring +1",
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
	
-- ### Dark magic (Used for /DRK Amninon only) ###
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Kasuga Haidate +3",
		feet="Kas. Sune-Ate +3",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Crepuscular Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	})

-------------------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base Idle Set ###
	sets.idle = { --PDT -50/MDT -43, Regen +4?, Sphere: Regain +5
		ammo="Staunch Tathlum +1", --DT -3
		head="Twilight Helm", --Regen +?? (Null Masque)
		body="Makora Meikogai", --Sphere: Regain +5
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Bathy Choker +1", --Regen +3
		waist="Plat. Mog. Belt", --DT -3 (Null Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --PDT -10, (Ambu Cape with VIT, FC +10, Regen +5)
	}

  -- Regain set
	sets.idle.Regain = set_combine(sets.idle, {})
	
  -- Regen set
	sets.idle.Regen = set_combine(sets.idle, { --PDT -35/MDT -28, Regen +20
		body="Sacro Breastplate", --Regen +13
		left_ear="Dawn Earring", --Daytime: Regen +1
		left_ring="Chirich Ring +1", --Regen +2
	})
	
  -- Refresh set
	sets.idle.refresh = set_combine(sets.idle, {
		neck="Sibyl Scarf", --Refresh +1
	})
	
  -- Reraise Set
	--sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail",})
	
  -- Weakened set
    --sets.idle.Weak = {head="Twilight Helm", body="Twilight Mail"}
	
-- ### Resting set ###
	sets.resting = {
		ammo="Staunch Tathlum +1",
		head="Twilight Helm",
		body="Sacro Breastplate",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical Damage Reduction ###
    sets.defense.PDT = {
		main="Masamune",
		sub="Utu Grip",
		ammo="Eluder's Sachet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Handler's Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
  -- Magical Damage Reduction
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		body="Tartarus Platemail",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Hearty Earring",
		right_ring="Archon Ring",
		back="Null Shawl",
	})
	
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Hearty Earring",
		right_ring="Icecrack Ring",
		back="Null Shawl",
	})
	
-- ### Misc. Defensive Sets ###
	sets.Kiting = {left_ring="Shneddick Ring"}

-------------------------------------------------------------------------------------------------------------------
-- Offense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged Set ###
    sets.engaged = { --PDT -45/MDT -35, Acc 1328, Store TP +82, Zanshin +36
		ammo="Aurgelmir Orb",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck="Moonlight Nodowa",
		waist="Sailfi Belt +1", --(Sweordfatalis +1)
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Takaha Mantle", augments={'STR+3','"Zanshin"+5','"Store TP"+2',}},
	}

  -- Engaged accuracy set
    sets.engaged.Acc = set_combine(sets.engaged, { --Acc 1387, Store TP +75, Zanshin +31
		waist="Kentarch Belt +1",
		left_ear="Domin. Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})

  -- Engaged full accuracy set (Work in Progress)
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
    
  -- Hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, { --PDT -50/MDT -50, Acc 1343, Store TP +66, Zanshin +31
		left_ear="Alabaster Earring",
		left_ring="Murky Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, 
    })
	
  -- Extra melee mode sets, apply on top of melee sets
	sets.engaged.SubtleBlow = set_combine(sets.engaged, { --Subtle Blow +50, Subtle Blow II +5
		head="Ken. Jinpachi +1",
		body="Flamma Korazin +2",
		left_ear="Digni. Earring",
		right_ear="Schere Earring", 
	})

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill gear ###
    sets.precast.WS = {
		ammo="Aurgelmir Orb", --(Aurgelmir Orb +1)
		head="Mpaca's Cap", --(Augment to R30)
		body="Sakonji Do. +4",
		hands="Kasuga Kote +3",
		legs="Nyame Flanchard", --(Augment to R30)
		feet="Nyame Sollerets", --(Augment to R30)
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Cornelia's Ring", 
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    
  -- Weaponskill accuracy gear 
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
  -- Weaponskill full accuracy gear
	sets.precast.WS.FullAcc =set_combine(sets.precast.WS, {})
	
  -- Weaponskill physical damage limit gear
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {feet="Kas. Sune-Ate +3", right_ring="Sroda Ring"})
	
  -- Weaponskill proc gear (low WS damage set for proc'ing)
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {})

-- ### Specific weaponskill gear sets ###
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
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Moonshade Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	})
	
    -- Tachi: Fudo (Uses default WS set as base)
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

  -- Polearm Weaponskills
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

-- ### Misc. weaponskill sets ###
  -- Skillchain bonus gear
	sets.Skillchain = {}
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
	
-------------------------------------------------------------------------------------------------------------------
-- Misc. sets
-------------------------------------------------------------------------------------------------------------------
-- ### Gear that needs to be worn to actively enhance a current player buff. ###
	sets.buff.Hasso = {hands="Wakido Kote +3"} --(Upgrade to +4)
	sets.buff['Meikyo Shisui'] = {} --(Sak. Sune-Ate +4)
	sets.buff.Sekkanoki = {hands="Kasuga Kote +3"}
	sets.buff.Sengikori = {feet="Kas. Sune-Ate +3"}
	sets.buff['Third Eye'] = {} --(Sakonji Haidate +4)
	
-- ### Gear that is equiped to counteract specific debuffs ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		--right_ring="Purity Ring",
	})
	
	sets.buff.Sleep = {neck="Vim Torque +1"}
	
-- ### Treasure Hunter ###	
	sets.TreasureHunter = {
		head="Volte Cap", --Treasure Hunter +1
		body="Volte Jupon", --Treasure Hunter +1
		waist="Chaac Belt", --Treasure Hunter +1
	}
	
-- Cure received
	sets.Cure_Received = {waist="Gishdubar Sash", legs="Flamma Dirs +2"}
	

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 13)
	elseif player.sub_job == 'DRG' then
		set_macro_page(3, 13)
	elseif player.sub_job == 'DRK' then
		set_macro_page(4, 13)
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