-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
	state.CastingMode:options('Normal', 'SIRD')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Refresh', 'Regen', 'Reraise')
	state.Weapons:options('Greatsword', 'Scythe', 'Sword', 'Club')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode' ,'None'}
	state.Passive = M{['description'] = 'Passive Mode', 'None', 'MP', 'Twilight'}
	state.DrainSwapWeaponMode = M{'Always', 'Never', '300', '1000'}

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
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, -PDT -10
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
	
	
	--------------------------------------
	-- Miscellaneous Midcast Sets
	--------------------------------------
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	

	--------------------------------------
	-- Weapon Sets
	--------------------------------------
	sets.weapons.Greatsword = {main="Caladbolg", sub="Utu Grip"}
	sets.weapons.Scythe = {main="Crepuscular Scythe", sub="Utu Grip"}
	sets.weapons.Sword = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.Club = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default Weaponskills
	--------------------------------------
    sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {right_ear="Telos Earring"})

	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		right_ear="Heath. Earring",
		right_ring="Sroda Ring",
	})


	--------------------------------------
	-- Club Weaponskills
	--------------------------------------
	-- Judgement
	sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {
		feet="Heath. Sollerets +3",
	})
	
	
	sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	
	sets.precast.WS['Judgement'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	--------------------------------------
	-- Great Sword Weaponskills
	--------------------------------------	
	-- Resolution
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Heath. Bur. +3",
		feet="Heath. Sollerets +3",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Sroda Ring",
	})
    
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    
	sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS['Resolution'], {
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		waist="Fotia Belt",
		right_ear={ name="Heathen's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
	})
	
	
	-- Shockwave
	sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {waist="Fotia Belt"})
	
	
	-- Torcleaver
    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
		feet="Heath. Sollerets +3",
		waist="Fotia Belt",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-8%',}},
	})
    
	sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {})
	
    sets.precast.WS['Torcleaver'].Fodder = set_combine(sets.precast.WS['Torcleaver'], {
		head="Heath. Burgeon. +3",
		waist="Fotia Belt",
		left_ring="Sroda Ring",
	})
	
	
	--------------------------------------
	-- Scythe Weaponskills
	--------------------------------------
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
	
	sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'], {})
	
	sets.precast.WS['Entropy'].Fodder = set_combine(sets.precast.WS['Entropy'], {
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
	

	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	--Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS, {
		head="Pixie Hairpin +1",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
	
	
	--Savage Blade
	sets.precast.WS["Savage Blade"] = {
		feet="Heath. Sollerets +3",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
	
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"], {})
	
	sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {
		left_ring="Sroda Ring",
	})
	
    
-------------------------------------------------------------------------------------------------------------------    
-- Sets to return to when not performing an action.
-------------------------------------------------------------------------------------------------------------------           
    --------------------------------------
	-- Resting Set
	--------------------------------------
    sets.resting = {}


	--------------------------------------
	-- Swaps when using WS at 3000 TP
	--------------------------------------
	--sets.MaxTP = {left_ear="Lugra Earring +1", right_ear="Lugra Earring",}
	--sets.AccMaxTP = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.AccDayMaxTPWSEars = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.DayMaxTPWSEars = {left_ear="Ishvara Earring", right_ear="Brutal Earring",}
	--sets.AccDayWSEars = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.DayWSEars = {left_ear="Moonshade Earring", right_ear="Brutal Earring",}


-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Base Idle Set
	--------------------------------------
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	
	-- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {head=empty, body="Lugra Cloak +1", neck="Sibyl Scarf"})
	

	-- Regen Set
    sets.idle.Regen = set_combine(sets.idle, {
		head="Volte Salade",
		body="Sacro Breastplate",
		hands="Volte Moufles",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		right_ring="Chirich Ring +1",
	})


	-- Reraise Set
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail",})
	

	-- Weakened Set
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail",})


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical Damage Reduction
	--------------------------------------
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	--sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm", body="Twilight Mail"})

	
	--------------------------------------
	-- Magical Damage Reduction
	--------------------------------------
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})

	--sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
	
	
	--------------------------------------
	-- Magic Evasion
	--------------------------------------
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		back="Solemnity Cape",
	})
	
	
	--------------------------------------
	-- Misc Defensive Sets
	--------------------------------------
	sets.Kiting = {left_ring="Shneddick Ring",}
	sets.passive.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff['Dark Seal'] = {}
	
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Engaged Set
	--------------------------------------
	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Cessance Earring",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	-- Engaged/Accuracy Set
	sets.engaged.Acc = set_combine(sets.engaged, {left_ear="Telos Earring"})
	
	-- Engaged Fodder Set
    sets.engaged.Fodder = set_combine(sets.engaged, {})
	
	--------------------------------------
	-- DT Hybrid Set
	--------------------------------------
	sets.engaged.DT = set_combine(sets.engaged, {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		right_ring="Defending Ring",
	})
	
	-- DT Hybrid / Acc Set
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {left_ear="Telos Earring"})
	
	-- DT Hybrid / Fodder Set
	sets.engaged.Fodder.DT = set_combine(sets.engaged.DT, {})
	
	
-------------------------------------------------------------------------------------------------------------------
-- Special Sets
-------------------------------------------------------------------------------------------------------------------
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 8)
end