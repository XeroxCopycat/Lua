-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
    state.HybridMode:options('Normal', 'DT')
	state.CastingMode:options('Normal', 'SIRD')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Refresh', 'Regen')
	state.Weapons:options('Torcleaver', 'Resolution', 'Entropy', 'Savage', 'Judgement')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	--state.Passive = M{['description'] = 'Passive Mode', 'None', 'MP', 'Twilight'}
	--state.DrainSwapWeaponMode = M{'Always', 'Never', '300', '1000'}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
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
-- ### Enmity Set ###
    sets.Enmity = { --PDT -35/MDT -25, Enmity +43
		ammo="Sapience Orb", --Enmity +2
		head="Loess Barbuta +1", --Enmity +9~14
		body="Shab. Cuirass +1", --Enmity +6
		hands="Macabre Gaunt. +1", --Enmity +7
		legs="Zoar Subligar +1", --Enmity +6
		feet="Nyame Sollerets", --DT -7
		neck="Unmoving Collar +1", --Enmity +10
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Murky Ring", --DT -10
		right_ring="Vengeful Ring", --Enmity +3
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --PDT -10
	}

-- ### Fast cast sets ###
	sets.precast.FC = { --FC +64, QC +4 PDT -11/MDT -11
		ammo="Impatiens", --QC +2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Nyame Flanchard", --DT -8 (Sworn Brais)
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Baetyl Pendant", --FC +4
		waist="Plat. Mog. Belt", --DT -3 
		left_ear="Loquac. Earring", --FC +2
		right_ear="Malignance Earring", --FC +4
		left_ring="Kishar Ring", --FC +4
		right_ring="Lebeche Ring", --QC +2
		back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --FC +10
	}
	
  -- Fast cast sets for specific spells
    -- Impact
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
	
-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Diabolic Eye'] = {hands="Fall. Fin. Gaunt. +3"} --(Upgrade to +4)
	sets.precast.JA['Arcane Circle'] = {feet="Ig. Sollerets +2"} --(Upgrade to +4)
	sets.precast.JA['Souleater'] = {head="Ig. Burgeonet +2"} --(Upgrade to +4)
	sets.precast.JA['Weapon Bash'] = {hands="Ig. Gauntlets +2"} --(Upgrade to +4)
	sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +3"} 
	sets.precast.JA['Blood Weapon'] = {body="Fall. Cuirass +3"} --(Upgrade to +4)
	sets.precast.JA['Dark Seal'] = {head="Fall. Burgeonet +3"} --(Upgrade to +4)
	sets.precast.JA['Last Resort'] = {
		feet="Fall. Sollerets +3", --(Upgrade to +4)
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

-- ### /DNC flourishes, steps, and waltz sets ###
  -- Flourishes
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
	sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {})
	sets.precast.Flourish1['Violent Flourish'] = {}
  
  -- Steps
	sets.precast.Step = {}
	
  -- Curing Waltz
	sets.precast.Waltz = {}
	sets.precast.Waltz['Healing Waltz'] = {}

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast recast ###
	sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Nyame Flanchard",
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		neck="Baetyl Pendant",
		waist="Sailfi Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Rahab Ring",
		back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

-- ### Dark magic spells ###
	sets.midcast['Dark Magic'] = { 
		ammo="Pemphredo Tathlum", 
		head="Ig. Burgeonet +2",
		body={ name="Carm. Sc. Mail +1", augments={'MP+80','INT+12','MND+12',}},
		hands="Fall. Fin. Gaunt. +3",
		legs="Heath. Flanchard +3",
		feet="Heath. Sollerets +3",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
		left_ring="Metamor. Ring +1",
		right_ring="Evanescence Ring",
		back={ name="Niht Mantle", augments={'Attack+5','Dark magic skill +8','"Drain" and "Aspir" potency +25',}},
	}

  -- Specific dark magic spell sets
	-- Absorb Spells 
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
		hands="Pavor Gauntlets",
		--feet="Rat. Sollerets +1",
		--left_ear="Mani Earring",
		--right_ear="Dark Earring",
		left_ring="Kishar Ring",
		--waist="Casso Sash",
		back="Chuparrosa Mantle",
	})
	
	-- Drain/Aspir
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		ammo="Pemphredo Tathlum",
		head="Fall. Burgeonet +3",
		body={ name="Carm. Sc. Mail +1", augments={'MP+80','INT+12','MND+12',}},
		hands="Fall. Fin. Gaunt. +3",
		legs="Heath. Flanchard +3",
		feet="Heath. Sollerets +3",
		neck="Erra Pendant",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Etiolation Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Niht Mantle", augments={'Attack+5','Dark magic skill +8','"Drain" and "Aspir" potency +25',}},
	})
	
	sets.midcast.Aspir = sets.midcast.Drain
	
	-- Dread Spikes
	sets.midcast['Dread Spikes'] = { --PDT -36/MDT -28, HP 3395
		main="Crepuscular Scythe", --"Dread Spikes" absorption +50%
		sub="Utu Grip",
		ammo="Staunch Tathlum +1", --DT -3 (Happy Egg)
		head="Hjarrandi Helm", --(Ratri Sallet +1)
		body="Heath. Cuirass +3", --DT -13, "Dread Spikes" potency +55%
		hands="Fall. Fin. Gaunt. +3", --(Ratri Gadlings +1)
		legs="Fall. Flanchard +3", --(Ratri Cuisses +1)
		feet="Ig. Sollerets +2", --(Ratri Sollerets +1)
		neck="Unmoving Collar +1", 
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5 (Tuisto Earring)
		right_ear="Etiolation Earring", --(Odnowa Earring +1 aug to R15)
		left_ring="Moonlight Ring", --DT -5
		right_ring="Gelatinous Ring +1", --PDT -7, MDT +1 (Aug to R15)
		back={ name="Niht Mantle", augments={'Attack+5','Dark magic skill +8','"Drain" and "Aspir" potency +25',}}, --(Moonlight Cape)
	}
	
	-- Endark I/II
	sets.midcast.Endark = set_combine(sets.midcast['Dark Magic'], {})
	
	-- Impact
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {
		ammo="Pemphredo Tathlum",
		head=empty,
		body="Crepuscular Cloak",
		hands="Heath. Gauntlets +2",
		left_ring="Kishar Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Izdubar Mantle",
	})
	
	-- Stun
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	
-- ### Enfeebling Magic Accuracy ###
	sets.midcast['Enfeebling Magic'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Heath. Cuirass +3",
		hands="Heath. Gauntlets +2",
		legs="Heath. Flanchard +3",
		feet="Heath. Sollerets +3",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear={ name="Heathen's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Kishar Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###
	sets.idle = { --PDT -50/MDT -48, Regen +22, Latent: Refresh +1
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		ammo="Staunch Tathlum +1", --DT -3
		head="Volte Salade", --PDT -3, MDT -7, Regen +2
		body="Sacro Breastplate", --Regen +13
		hands="Volte Moufles", --PDT -6, MDT -4, Regen +2
		legs="Heath. Flanchard +3", --DT -12
		feet="Sakpata's Leggings", --DT -6
		neck="Bathy Choker +1", --Regen +3
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --PDT -10
	}
	
  -- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, { --PDT -50/MDT -46, Regen +9, Refresh +4, Latent: Refresh +1
		head=empty,
		body="Lugra Cloak +1", --MDT -3, Regen +3, Refresh +3
		neck="Sibyl Scarf", --Refresh +1
	}) 
	
  -- Regen Set
    sets.idle.Regen = set_combine(sets.idle, {})

  -- Reraise Set
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail",})
	
  -- Weakened Set
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail",})

-- ### Resting set ###
	sets.resting = { --PDT -48/MDT -38, Regen +26, Latent: Refresh +1
		main="Crepuscular Scythe",
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		ammo="Staunch Tathlum +1", --DT -3
		head="Volte Salade", --PDT -3, MDT -7, Regen +2 
		body="Sacro Breastplate", --Regen +13
		hands="Volte Moufles", --PDT -6, MDT -4, Regen +2
		legs="Heath. Flanchard +3", --DT -12
		feet="Sakpata's Leggings", --DT -6
		neck="Bathy Choker +1", --Regen +3
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Chirich Ring +1", --Regen +2
		right_ring="Chirich Ring +1", --Regen +2
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --PDT -10
	}

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical Damage Reduction ###
 	sets.defense.PDT = { --PDT -50/MDT -50, Enemy crit hit rate -10%, Convert 2% of damage taken to MP
		ammo="Eluder's Sachet", --DT +2, Enemy crit hit rate -5%
		head="Sakpata's Helm",  --DT -7
		body="Sakpata's Plate", --DT -10
		hands="Sakpata's Gauntlets", --DT -8
		legs="Sakpata's Cuisses", --DT -9
		feet="Sakpata's Leggings", --DT -6
		neck="Loricate Torque +1", --DT -6 
		waist="Flume Belt +1", --PDT -4, Convert 2% of damage taken to MP
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Murky Ring", --DT -10
		right_ring="Warden's Ring", --PDT -3, Enemy crit hit rate -5%
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --PDT -10
	}

  -- Magical Damage Reduction
	sets.defense.MDT = set_combine(sets.defense.PDT, { --PDT -50/MDT -50, Absorb magic damage taken 5%, Occ. annul severe magic damage taken
		ammo="Staunch Tathlum +1", --DT -3
		body="Tartarus Platemail", --DT -10, Absorb magic damage taken 5%
		neck="Warder's Charm +1", 
		waist="Carrier's Sash",
		right_ring="Archon Ring", --Occasionally annuls severe magic damage taken
	})
	
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		body="Nyame Mail",
		neck="Warder's Charm +1", 
		waist="Carrier's Sash",
		right_ring="Icecrack Ring",
		back="Null Shawl",
	})
	
  -- Misc Defensive Sets
	sets.Kiting = {left_ring="Shneddick Ring",}
	sets.passive.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff['Dark Seal'] = {}

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged Set ###
	sets.engaged = { --Acc 1201, PDT -40/MDT -40, DA +38, TA +7, QA +3, Store TP +49
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Flam. Zucchetto +2", --TA +5, Store TP +6
		body="Hjarrandi Breast.", --DT -12, Store TP +10
		hands="Sakpata's Gauntlets", --DT -8, DA +6
		legs="Sakpata's Cuisses", --DT -9, DA +7
		feet="Sakpata's Leggings", --DT -6, DA +4
		neck="Vim Torque +1", --Store TP +10, Latent: Regain +20
		waist="Sailfi Belt +1", --DA +5, TA +2
		left_ear="Cessance Earring", --DA +3
		right_ear="Dedition Earring", --Store TP +8
		left_ring="Niqmaddu Ring", --QA +3
		right_ring="Moonlight Ring", --DT -5, Store TP +5
		back="Null Shawl", --DA +7, Store TP +7
	}

  -- Engaged accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, { --Acc 1217, 
		neck={ name="Abyssal Beads +2", augments={'Path: A',}}, --Store TP +7
		waist="Kentarch Belt +1", --Store TP +1~5
		right_ear="Digni. Earring", --Store TP +3
		left_ring="Chirich Ring +1", --Store TP +6
	})
	
  -- Engaged, full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		head="Heath. Bur. +3",
		body="Heath. Cuirass +3",
		hands="Heath. Gauntlets +3",
		legs="Heath. Flanchard +3",
		feet="Heath. Sollerets +3",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Schere Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	})
	
  -- Engaged Fodder Set
    sets.engaged.Fodder = set_combine(sets.engaged, {})
	
  -- DT Hybrid Set 
	sets.engaged.DT = set_combine(sets.engaged, { --PDT -50/MDT -50, DA +38, TA +7, Store TP +49
		waist="Flume Belt +1",
		left_ring="Murky Ring", --DT -10
	})

-- ### Extra melee mode sets ###
	sets.DWMid = {waist="Reiki Yotai", left_ear="Suppanomimi"} --Dual Wield +12
	sets.DWMax = { --Dual Wield +22
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}, --Dual Wield +6
		waist="Reiki Yotai", --Dual Wield +7
		left_ear="Suppanomimi", --Dual Wield +5
		right_ear="Eabani Earring", --Dual Wield +4
	}
	sets.SubtleBlow = { --Subtle Blow +50, Subtle Blow II +5
		head="Volte Tiara", --Subtle Blow +6
		body="Sacro Breastplate", --Subtle Blow +15
		hands="Volte Mittens", --Subtle Blow +6
		neck="Bathy Choker +1", --Subtle Blow +11
		left_ear="Schere Earring", --Subtle Blow +3
		left_ring="Niqmaddu Ring", --Subtle Blow II +5
		right_ring="Chirich Ring +1", --Subtle Blow +10
	}
	
-------------------------------------------------------------------------------------------------------------------
-- Weapon Sets
-------------------------------------------------------------------------------------------------------------------
	sets.weapons.Torcleaver = {main="Caladbolg", sub="Utu Grip"}
	sets.weapons.Resolution = {main="Agwu's Claymore", sub="Utu Grip"}
	sets.weapons.Entropy = {main="Crepuscular Scythe", sub="Utu Grip"}
	sets.weapons.Savage = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.Judgement = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Default Weaponskills ###
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail", --(Ig. Cuisses +4)
		hands="Nyame Gauntlets", 
		legs="Fall. Flanchard +3", --(Upgrade to +4)
		feet="Heath. Sollerets +3",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		head="Heath. Bur. +3",
		legs="Fall. Flanchard +3",
		feet="Heath. Sollerets +3",
		waist="Fotia Belt",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
	})

-- ### Specific weaponskill sets ###
  -- Club Weaponskills
	-- Judgement
	sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Judgement'].PDL = set_combine(sets.precast.WS.Fodder, {})
	
  -- Great Sword Weaponskills
	-- Ground Strike
	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Ground Strike'].PDL = set_combine(sets.precast.WS.PDL, {})
	
	-- Resolution
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar", 
		head="Heath. Bur. +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Nyame Flanchard",
		feet="Sakpata's Leggings",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		right_ring="Sroda Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --(Ambu cape w/ STR, DA)
	})
    
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS['Resolution'], {
		legs="Sakpata's Cuisses",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
	})
	
	-- Torcleaver
    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {})
    
	sets.precast.WS['Torcleaver'].Fodder = set_combine(sets.precast.WS['Torcleaver'], {})
	
  -- Scythe Weaponskills
	-- Catastrophe
	
	-- Cross Reaper
	
	-- Entropy
	sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Heath. Bur. +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	})
	
	sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Entropy'].PDL = set_combine(sets.precast.WS['Entropy'], {
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		right_ear={ name="Heathen's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Sroda Ring",
	})	
	
	-- Origin
	
	-- Quietus
	
  -- Sword Weaponskills
	--Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Malignance Earring",
		left_ring="Cornelia's Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
	
  --Savage Blade
	sets.precast.WS["Savage Blade"] = {
		legs="Nyame Flanchard",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
	
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {})	
	
	sets.precast.WS["Savage Blade"].PDL = set_combine(sets.precast.WS["Savage Blade"], {
		right_ear={ name="Heathen's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		right_ring="Sroda Ring",
	})
	
-- ### Misc. weaponskill swaps if at 3000 TP ###
	--sets.MaxTP = {left_ear="Lugra Earring +1", right_ear="Lugra Earring",}
	--sets.AccMaxTP = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.AccDayMaxTPWSEars = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.DayMaxTPWSEars = {left_ear="Ishvara Earring", right_ear="Brutal Earring",}
	--sets.AccDayWSEars = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.DayWSEars = {left_ear="Moonshade Earring", right_ear="Brutal Earring",}

------------------------------------------------------------------------------------------------------------
-- Misc. gear sets
------------------------------------------------------------------------------------------------------------
-- ### Gear that needs to be worn to actively enhance a current player buff. ###
	sets.buff.Souleater = {}
	
-- ### Vs. Debuff gear ###
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})

  -- Sleep
	sets.buff.Sleep = {neck="Vim Torque +1"}

-- ### Treasure hunter gear ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		waist="Chaac Belt",
	})
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
		if player.sub_job == 'SAM' then
			set_macro_page(1, 8)
		elseif player.sub_job == 'WAR' then
			set_macro_page(2, 8)
		elseif player.sub_job == 'DRG' then
			set_macro_page(3, 8)
		elseif player.sub_job == 'DNC' then
			set_macro_page(4, 8)
		elseif player.sub_job == 'NIN' then
			set_macro_page(5, 8)
		else
			set_macro_page(5, 19)
	end
end