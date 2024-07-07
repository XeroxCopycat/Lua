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
	--------------------------------------
	-- Enmity Set
	--------------------------------------
    sets.Enmity = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body={ name="Odyss. Chestplate", augments={'Accuracy+24 Attack+24','"Store TP"+7','AGI+2','Attack+2',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+1','"Dbl.Atk."+4','Attack+14',}},
		neck="Unmoving Collar +1",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Vengeful Ring",
		back="Impassive Mantle",
	}
	
	--------------------------------------
	-- Precast Sets to enhance JAs
	--------------------------------------
	--sets.precast.JA['Diabolic Eye'] = {hands="Fall. Fin. Gaunt. +3"}
	--sets.precast.JA['Arcane Circle'] = {feet="Ig. Sollerets +3"}
	--sets.precast.JA['Souleater'] = {head="Ig. Burgeonet +3"}
	--sets.precast.JA['Weapon Bash'] = {hands="Ig. Gauntlets +3"}
	sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +2"}
	--sets.precast.JA['Blood Weapon'] = {body="Fall. Cuirass +3"}
	--sets.precast.JA['Dark Seal'] = {head="Fall. Burgeonet +3"}
	sets.precast.JA['Last Resort'] = {
		--feet="Fallen's Sollerets +3",
		back="Ankou's Mantle",
	}
                   
	--------------------------------------
	-- Waltz Sets
	--------------------------------------
	-- Curing Waltz
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
    
	-- Steps
	sets.precast.Step = {}
	
	-- Flourishes
	sets.precast.Flourish1 = {}
		   
	--------------------------------------
	-- Fast Cast Sets for Spells
	--------------------------------------
	sets.precast.FC = {
		ammo="Impatiens",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Odyss. Chestplate", augments={'Accuracy+24 Attack+24','"Store TP"+7','AGI+2','Attack+2',}},
		--body="Fall. Cuirass +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
	}

	--------------------------------------
	-- Fast Cast Set for Impact
	--------------------------------------
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
		

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Fast Recast Set
	--------------------------------------
	sets.midcast.FastRecast = {
		ammo="Impatiens",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Odyss. Chestplate", augments={'Accuracy+24 Attack+24','"Store TP"+7','AGI+2','Attack+2',}},
		--body="Fall. Cuirass +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
	}
                   
	--------------------------------------
	-- Dark Magic Accuracy
	--------------------------------------
	sets.midcast['Dark Magic'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Malignance Earring",
		left_ring="Evanescence Ring",
		right_ring="Flamma Ring",
		back="Izdubar Mantle",
	}
    
	--------------------------------------
	-- Enfeebling Magic Accuracy
	--------------------------------------
	sets.midcast['Enfeebling Magic'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Malignance Earring",
		left_ring="Evanescence Ring",
		right_ring="Flamma Ring",
		back="Izdubar Mantle",
	}

	--------------------------------------
	-- Absorb Spells 
	--------------------------------------
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {back="Ankou's Mantle"})
	--sets.AbsorbWeapon = {main="Liberator", sub="Khonsu", range="Ullr", ammo=empty}
	
	--------------------------------------
	-- Cure Spells 
	--------------------------------------
	sets.midcast.Cure = {}

	--------------------------------------
	-- Drain/Aspir
	--------------------------------------
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		--back="Niht Mantle",
	})
	
	sets.midcast.Aspir = sets.midcast.Drain
	--sets.DrainWeapon = {main="Misanthropy",sub="Alber Strap"}
	
	--------------------------------------
	-- Dread Spikes
	--------------------------------------
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
		--ammo="Happy Egg",
		--head="Ratri Sallet +1",
		body="Heath. Cuirass +3",
		--hands="Rat. Gadlings +1",
		--legs="Ratri Cuisses +1",
		--feet="Rat. Sollerets +1",
		neck="Unmoving Collar +1", --Needs Augmented
		waist="Plat. Mog. Belt",
		--left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		--back="Moonlight Cape",
	})
	
	sets.DreadWeapon = {main="Crepuscular Scythe", sub="Utu Grip",}
	
	--------------------------------------
	-- Endark I/II
	--------------------------------------
	sets.midcast.Endark = {}
	
	--------------------------------------
	-- Impact
	--------------------------------------
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {head=empty,body="Crepuscular Cloak"})
	
	--------------------------------------
	-- Stun
	--------------------------------------
	sets.midcast.Stun = {ammo="Pemphredo Tathlum",
		head="Carmine Mask +1",neck="Erra Pendant",ear1="Digni. Earring",ear2="Malignance Earring",
		body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Toro Cape",waist="Eschan Stone",legs="Eschite Cuisses",feet="Flam. Gambieras +2"}
	
	--------------------------------------
	-- Miscellaneous Midcast Sets
	--------------------------------------
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
						                   
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
		neck="Abyssal Beads +2",
		waist="Sailfi Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Cornelia's Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {right_ear="Telos Earring"})

	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		--right_ear="Heath. Earring +1",
		left_ring="Sroda Ring",
	})


	--------------------------------------
	-- Club Weaponskills
	--------------------------------------
	-- Judgement
	sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {
		--feet="Heath. Sollerets +3",
	})
	
	sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Judgement'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	--------------------------------------
	-- Great Sword Weaponskills
	--------------------------------------	
	-- Resolution
	sets.precast.WS['Resolution'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Heath. Burgeon. +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Heath. Sollerets +3",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    
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
	sets.precast.WS['Shockwave'] = {
		ammo="Knobkierrie",
		head="Heath. Burgeon. +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Heath. Sollerets +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Malignance Earring",
		left_ring="Cornelia's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	-- Torcleaver
    sets.precast.WS['Torcleaver'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Heath. Sollerets +3",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-8%',}},
	}
    
	sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {})
	
    sets.precast.WS['Torcleaver'].Fodder = set_combine(sets.precast.WS['Torcleaver'], {
		head="Heath. Burgeon. +2",
		waist="Fotia Belt",
		right_ring="Sroda Ring",
	})
	
	
	--------------------------------------
	-- Scythe Weaponskills
	--------------------------------------
	-- Catastrophe
	
	
	-- Cross Reaper
	
	
	-- Entropy
	sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Heath. Burgeon. +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Heath. Sollerets +3",
		neck="Fotia Gorget",
		waist="Flume Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Heathen's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'], {})
	
	sets.precast.WS['Entropy'].Fodder = set_combine(sets.precast.WS['Entropy'], {
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})	
	
	-- Origin
	
	
	-- Quietus
	

	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	--Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = {
		ammo="Knobkierrie",
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Heath. Sollerets +3",
		neck="Erra Pendant",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Cornelia's Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	
	--Savage Blade
	sets.precast.WS["Savage Blade"] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Heath. Sollerets +3",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Heathen's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+10','Mag. Acc.+10',}},
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"], {})
	
	sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {
		right_ring="Sroda Ring",
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
	--sets.MaxTP = {ear1="Lugra Earring +1",ear2="Lugra Earring",}
	--sets.AccMaxTP = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.AccDayMaxTPWSEars = {left_ear="Mache Earring", right_ear="Telos Earring",}
	--sets.DayMaxTPWSEars = {ear1="Ishvara Earring",ear2="Brutal Earring",}
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
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		back="Solemnity Cape",
	}
	
	--------------------------------------
	-- Refresh Set
	--------------------------------------
	sets.idle.Refresh = set_combine(sets.idle, {head=empty, body="Lugra Cloak +1", neck="Sibyl Scarf"})
	
	--------------------------------------
	-- Regen Set
	--------------------------------------
    sets.idle.Regen = set_combine(sets.idle, {
		head="Volte Salade",
		body="Sacro Breastplate",
		hands="Volte Moufles",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		left_ring="Chirich Ring +1",
	})

	--------------------------------------
	-- Reraise Set
	--------------------------------------
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail",})
	
	--------------------------------------
	-- Weakened Set
	--------------------------------------
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail",})


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical Damage Reduction
	--------------------------------------
	sets.defense.PDT = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Loricate Torque +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back="Solemnity Cape",
	}
		
	--sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	--------------------------------------
	-- Magical Damage Reduction
	--------------------------------------
	sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back="Solemnity Cape",
	}
		
	--sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
	
	--------------------------------------
	-- Magic Evasion
	--------------------------------------
	sets.defense.MEVA = {
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back="Solemnity Cape",
	}
	
	--------------------------------------
	-- Misc Defensive Sets
	--------------------------------------
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.passive.Reraise = {head="Twilight Helm",body="Twilight Mail"}
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
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
	-- Engaged Accuracy Set
	--------------------------------------
	sets.engaged.Acc = set_combine(sets.engaged, {})
	
	--------------------------------------
	-- Engaged Fodder Set
	--------------------------------------
    sets.engaged.Fodder = set_combine(sets.engaged, {})
	
	--------------------------------------
	-- DT Hybrid Set
	--------------------------------------
	sets.engaged.DT = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	--------------------------------------
	-- DT Hybrid / Acc Set
	--------------------------------------
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, { 
		right_ear="Telos Earring",
	})
	
	
-------------------------------------------------------------------------------------------------------------------
-- Special Sets
-------------------------------------------------------------------------------------------------------------------
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	

-------------------------------------------------------------------------------------------------------------------
-- Weapon Sets
-------------------------------------------------------------------------------------------------------------------
	sets.weapons.Greatsword = {main="Agwu's Claymore", sub="Utu Grip"}
	sets.weapons.Scythe = {main="Crepuscular Scythe", sub="Utu Grip"}
	sets.weapons.Sword = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.Club = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 7)
    elseif player.sub_job == 'DNC' then
        set_macro_page(3, 7)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 7)
    else
        set_macro_page(1, 7)
    end
end