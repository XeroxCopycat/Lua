function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'StoreTP')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Regen', 'Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Axe', 'Club', 'Greataxe', 'Greatsword', 'Polearm', 'Sword', 'DualWeapons', 
		'ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcClub','ProcStaff')


	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Greatsword;gs c update')

	--Ikenga_axe_bonus = 300  -- It is 300 at R25. Uncomment if you need to manually adjust because you are using below R25 or above
	
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
		head="Pummeler's Mask +3",
		body="Shab. Cuirass +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		left_ring="Defending Ring",
		right_ring="Vengeful Ring",
	}
	
	sets.Knockback = {back="Impassive Mantle"}
	sets.passive.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	
	
	--------------------------------------
	-- Precast sets to enhance JAs
	--------------------------------------
	sets.precast.JA['Berserk'] = {body="Pummeler's Lorica +3", feet="Agoge Calligae +3", back="Cichol's Mantle"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
	sets.precast.JA['Defender'] = {hands="Agoge Mufflers +3"}
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +3", body="Agoge Lorica +3"}
	sets.precast.JA['Mighty Strikes'] = {head="Agoge Mufflers +3"}
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +3"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Retaliation'] = {hands="Pummeler's Mufflers +2", feet="Boii Calligae +3"}
	sets.precast.JA['Restraint'] = {hands="Boii Mufflers +3"}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +3"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
    
	
	--------------------------------------
	-- Waltz sets
	--------------------------------------
	sets.precast.Waltz = {}
                   
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
	
	
	--------------------------------------
	-- Fast cast sets for spells
	--------------------------------------
	sets.precast.FC = {
		ammo="Sapience Orb",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
	}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
	sets.midcast.FastRecast = {
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
	}
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
                   
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
						                   
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default set for any weaponskill that isn't any more specifically defined
	--------------------------------------
    sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})

    --------------------------------------
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
	--------------------------------------
	--------------------------------------
	-- Axe Weaponskills
	--------------------------------------
    sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Full Break"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Full Break"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	--------------------------------------
	-- Club Weaponskills
	--------------------------------------
	-- Black Halo
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ring="Cornelia's Ring",	
	})
    
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Black Halo'].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	-- Judgement
    sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},})

    sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Judgement'].PDL = set_combine(sets.precast.WS.PDL, {body={ name="Sakpata's Plate", augments={'Path: A',}}, right_ring="Sroda Ring"})
	
	
	--------------------------------------
	-- Great Axe Weaponskills
	--------------------------------------
	-- Fell Cleave
    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
	})

    sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Fell Cleave'].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	-- Full Break
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Boii Mask +3",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		right_ear="Gwati Earring",
		left_ring="Flamma Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

    sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Full Break"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	-- Ukko's Fury
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	})

    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Ukko's Fury"].PDL = set_combine(sets.precast.WS.PDL, {
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})
	
   
	-- Upheaval
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Upheaval'].PDL = set_combine(sets.precast.WS.PDL, {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		right_ring="Sroda Ring",
	}) 
	
	--------------------------------------
	-- Great Sword Weaponskills
	--------------------------------------
    -- Resolution
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Boii Mask +3",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Boii Cuisses +3",
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Resolution'].PDL = set_combine(sets.precast.WS.PDL, {neck="Fotia Gorget", waist="Fotia Belt",})
	
	--------------------------------------
	-- Polearm Weaponskills
	--------------------------------------
	-- Impulse Drive
    sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Boii Mufflers +3",
		feet="Boii Calligae +3",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
	})

    sets.precast.WS["Impulse Drive"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Impulse Drive"].PDL = set_combine(sets.precast.WS.PDL, {
		head="Blistering Sallet +1",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		legs="Boii Cuisses +3",
	})
	
	
	-- Sonic Thrust
	sets.precast.WS["Sonic Thrust"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Sonic Thrust"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Sonic Thrust"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	-- Stardiver
	sets.precast.WS["Stardiver"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
	})

    sets.precast.WS["Stardiver"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Stardiver"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	-- Vorpal Thrust
	sets.precast.WS["Vorpal Thrust"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
	})

    sets.precast.WS["Vorpal Thrust"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Vorpal Thrust"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	--------------------------------------
	-- Staff Weaponskills
	--------------------------------------
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Full Break"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	-- Circle Blade
	sets.precast.WS["Circle Blade"] = set_combine(sets.precast.WS, {
		head="Boii Mask +3",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Boii Cuisses +3",
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Circle Blade"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Circle Blade"].PDL = set_combine(sets.precast.WS.PDL, {right_ring="Sroda Ring"})
	
	
	-- Requiscat
	sets.precast.WS["Requiscat"] = set_combine(sets.precast.WS, {
		head="Boii Mask +3",
		legs="Boii Cuisses +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Requiscat"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Requiscat"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	-- Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		right_ring="Archon Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

    sets.precast.WS["Sanguine Blade"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Sanguine Blade"].PDL = set_combine(sets.precast.WS.PDL, {})
	
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		hands="Boii Mufflers +3",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	})

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS.PDL, {
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		legs="Boii Cuisses +3",
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
	})


	--------------------------------------
	-- Swaps when using WS at 3000 TP
	--------------------------------------
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}
	
	
	--------------------------------------
	-- Specialty weaponskill set overrides
	--------------------------------------
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}
           
     
           
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.idle.Regen = set_combine(sets.idle, { 
		head="Volte Salade",
		body="Sacro Breastplate",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
	})
		
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
	
	sets.resting = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical Damage Reduction
	--------------------------------------
	sets.defense.PDT = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Elite Royal Collar",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})


	--------------------------------------
	-- Magical Damage Reduction
	--------------------------------------
	sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Tartarus Platemail",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Archon Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.defense.MEVA = sets.defense.MDT
	
	
	--------------------------------------
	-- Misc. Defensive Sets
	--------------------------------------
	sets.Kiting = {left_ring="Shneddick Ring"}
	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
     
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Engaged Set
	--------------------------------------
	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	--------------------------------------
	-- Accuracy Set
	--------------------------------------
	sets.engaged.Acc = {}


	--------------------------------------
	-- Store TP Set
	--------------------------------------
	sets.engaged.StoreTP = set_combine(sets.engaged, {
		body={ name="Sakpata's Plate", augments={'Path: A',}}, 
		neck="Vim Torque +1",
		left_ear="Dedition Earring"
	})
	
	
	--------------------------------------
	-- Special Sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {hands="Pumm. Mufflers +2", feet="Boii Calligae +3"}
	sets.buff.Restraint = {hands="Boii Mufflers +3"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	
	--------------------------------------
	-- Weapon Sets
	--------------------------------------
	sets.weapons.Axe = {main="Ikenga's Axe", sub="Blurred Shield +1"}
	sets.weapons.Club = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	sets.weapons.Greataxe = {main="Chango",sub="Utu Grip"}
	sets.weapons.Greatsword = {main="Agwu's Claymore",sub="Utu Grip"}
	sets.weapons.Polearm = {main="Shining One", sub="Utu Grip"}
	--sets.weapons.Staff = {main="", sub=""}
	sets.weapons.Sword = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Blurred Knife +1"}
	sets.weapons.ProcDagger = {main="Chicken Knife II",sub=empty}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
	sets.weapons.ProcClub = {main="Dream Bell +1",sub=empty}
	sets.weapons.ProcStaff = {main="Terra's Staff",sub=empty}

end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'DNC' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 2)
    else
        set_macro_page(1, 2)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 181')
end