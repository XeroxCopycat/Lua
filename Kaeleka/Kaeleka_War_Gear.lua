function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'MaxAcc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	state.Passive = M{['description'] = 'Passive Mode', 'None', 'Twilight'}
	state.Weapons:options('Sword', 'Greataxe', 'Club', 'Polearm', 'Greatsword', 'Club', 'Axe', 'DualSword', 'DualDagger',
		'ProcDagger', 'ProcSword', 'ProcGreatSword', 'ProcKatana', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'ProcClub', 'ProcStaff')


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
-- START DEFINING THE SETS
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- PRECAST SETS
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Enmity Set
--------------------------------------
    sets.Enmity = {
		ammo="Sapience Orb",
		head="Pummeler's Mask +3",
		body="Shab. Cuirass +1",
		hands="Pumm. Mufflers +3",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Unmoving Collar +1",
		left_ring="Vengeful Ring",
	}
	
	sets.Knockback = {}
	sets.passive.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	
--------------------------------------
-- Fast cast sets
--------------------------------------
	sets.precast.FC = {
		ammo="Sapience Orb",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Murky Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
-- Fast cast sets / specific spells
  -- Utsusemi
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
	
--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
-- Berserk
	sets.precast.JA['Berserk'] = {
		body="Pummeler's Lorica +3",
		feet="Agoge Calligae +3",
		back="Cichol's Mantle",
	}
	
-- Warcry
	sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
	
-- Defender
	sets.precast.JA['Defender'] = {hands="Agoge Mufflers +3"}
	
-- Aggressor
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +3", body="Agoge Lorica +3"}
	
-- Mighty Strikes
	sets.precast.JA['Mighty Strikes'] = {head="Agoge Mufflers +3"}
	
-- Warrior's Charge
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +3"}
	
-- Tomahawk
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	
-- Retaliation
	sets.precast.JA['Retaliation'] = {hands="Pummeler's Mufflers +3", feet="Boii Calligae +3"}
	
-- Restraint
	sets.precast.JA['Restraint'] = {hands="Boii Mufflers +3"}
	
-- Blood Rage
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +3"}
	
-- Brazen Rush
	sets.precast.JA['Brazen Rush'] = {}
	
-- Provoke
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
    
--------------------------------------
-- Waltz sets for /DNC
--------------------------------------
-- Curing Waltz
	sets.precast.Waltz = {
		ammo="Staunch Tathlum +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Boii Mufflers +3",
		legs="Dashing Subligar",
		feet="Boii Calligae +3",
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Handler's Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    
	-- Flourish I
	sets.precast.Flourish1 = set_combine(sets.Enmity, {})
	
	-- Healing Waltz
	sets.precast.Waltz['Healing Waltz'] = {}
    
	-- Steps
	sets.precast.Step = {
		ammo="Seething Bomblet",
		head="Boii Mask +3",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Pumm. Cuisses +4",
		feet="Pumm. Calligae +4",
		neck="Null Loop",
		waist="Ioskeha Belt +1",
		left_ear="Digni. Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}


------------------------------------------------------------------------------------------------------------------- 
-- MIDCAST SETS
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast recast
--------------------------------------
	sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Murky Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

-- Fast reset for specific spells
  -- Cure
	sets.midcast.Cure = {left_ear="Mendi. Earring", right_ring="Lebeche Ring"}
	
  -- Cures potency received
	sets.Cure_Received = {waist="Gishdubar Sash"}
	
  -- Utsusemi
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {neck="Magoraga Beads"})

  -- Self Healing
	sets.Self_Healing = {waist="Gishdubar Sash"}
	
-------------------------------------------------------------------------------------------------------------------
-- DEFENSE & IDLE SETS
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
		neck="Null Loop",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Warden's Ring",
		right_ring="Murky Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	-- PDT reraise set
	--sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})


--------------------------------------
-- Magical Damage Reduction
--------------------------------------
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		body="Tartarus Platemail",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ring="Archon Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
		
-- MDT reraise set
	--sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
	
	
--------------------------------------
-- Magical Evasion
--------------------------------------
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		left_ring="Archon Ring",
		right_ring="Icecrack Ring",
		back="Null Shawl",
	})
	
--------------------------------------
-- Misc. Defensive Sets
--------------------------------------
-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}
	
-- Reraise set
	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
-- Vs. Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	
-- Vs. Sleep
	sets.buff.Sleep = {neck="Vim Torque +1"}
	
-------------------------------------------------------------------------------------------------------------------
-- IDLE SETS
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Base Idle Set
--------------------------------------
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Volte Salade",
		body="Sacro Breastplate",
		hands="Volte Moufles",
		legs="Sakpata's Cuisses",
		feet="Boii Calligae +3",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Dawn Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --Regen cape?
	}
	
-- Regen set
	sets.idle.Regen = set_combine(sets.idle, {
		right_ring="Chirich Ring +1",
	})
	
-- Regain set
	sets.idle.Regain = set_combine(sets.idle, {body="Makora Meikogai"})
	
-- Weakened idle set
	-- sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail"})
	
-- Reraise idle set
	-- sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail"})
	
-- Resting set
	sets.resting = {}

-------------------------------------------------------------------------------------------------------------------
-- ENGAGED SETS
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Engaged Set, Single Wield
--------------------------------------
	sets.engaged = { 
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Boii Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +4",
		feet="Pumm. Calligae +4",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back="Null Shawl",
	}
	
-- Accuracy Set
	sets.engaged.Acc = set_combine(sets.engaged, {})
	
-- Max Accuracy Set
	sets.engaged.MaxAcc = set_combine(sets.engaged, {})

-- Fodder set
	sets.engaged.Fodder = set_combine(sets.engaged, {
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		legs="Pumm. Cuisses +4",
		feet="Pumm. Calligae +4",
		neck={ name="War. Beads +2", augments={'Path: A',}},
	})
	
-- Subtle Blow set
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		neck="Bathy Choker +1",
	})
	
-- Hybrid DT Set
	sets.engaged.DT = set_combine(sets.engaged, {
		head="Hjarrandi Helm",
		waist="Sailfi Belt +1",
		left_ring="Moonlight Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	
--------------------------------------
-- Engaged Set, Dual Wield
--------------------------------------
	sets.engaged.DW = { 
		aammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +4",
		feet="Pumm. Calligae +4",
		neck="Vim Torque +1",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back="Null Shawl",
	}
	
	-- Accuracy set
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	
	-- Max Accuracy set
	sets.engaged.DW.MaxAcc = set_combine(sets.engaged.DW, {})
	
	-- Fodder set
	sets.engaged.DW.Fodder = set_combine(sets.engaged.DW, {})
	
	-- Hybrid DT set
	sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
		head="Hjarrandi Helm",
		body="Boii Lorica +3",
	})

-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Single handed weapons
--------------------------------------
	sets.weapons.Axe = {main="Ikenga's Axe", sub="Blurred Shield +1"}
	sets.weapons.Club = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	sets.weapons.Greataxe = {main="Chango", sub="Utu Grip"}
	sets.weapons.Greatsword = {main="Agwu's Claymore", sub="Utu Grip"}
	sets.weapons.Polearm = {main="Shining One", sub="Utu Grip"}
	sets.weapons.Sword = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.Dagger = {main="Crepuscular Knife", sub="Blurred Shield +1"}
	
--------------------------------------
-- Dual weapons
--------------------------------------
	sets.weapons.DualSword = {main="Naegling", sub="Blurred Knife +1"}
	sets.weapons.DualDagger = {main="Crepuscular Knife", sub="Blurred Knife +1"}
		
--------------------------------------
-- Proc weapons (Enabled in Abyssea only)
--------------------------------------
	sets.weapons.ProcDagger = {main="Qutrub Knife", sub=empty}
	sets.weapons.ProcSword = {main="Ibushi Shinai", sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament", sub=empty}
	sets.weapons.ProcKatana = {main="Debahocho", sub=empty}
	sets.weapons.ProcScythe = {main="Lost Sickle", sub=empty}
	sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade", sub=empty}
	sets.weapons.ProcGreatKatana = {main="Zanmato", sub=empty}
	sets.weapons.ProcClub = {main="Soulflayer's Wand", sub=empty}
	sets.weapons.ProcStaff = {main="Ranine Staff", sub=empty}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill sets
--------------------------------------
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Agoge Mask +4",
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		body="Sakpata's Plate",
		legs="Boii Cuisses +3",
		left_ring="Sroda Ring",
		right_ring="Cornelia's Ring",
	})

--------------------------------------
-- Axe Weaponskills
--------------------------------------
-- Decimation
	sets.precast.WS["Decimation"] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		body="Agoge Lorica +3",
		hands="Boii Mufflers +3",
		left_ear="Schere Earring",
		right_ear="Lugra Earring +1",
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS["Decimation"].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS["Decimation"].Fodder = set_combine(sets.precast.WS.Fodder, {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		hands="Sakpata's Gauntlets",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	 
	 
-- Mistral Axe
	sets.precast.WS["Mistral Axe"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Mistral Axe"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Mistral Axe"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
-- Ruination
	sets.precast.WS["Ruination"] = set_combine(sets.precast.WS["Decimation"], {})
	sets.precast.WS["Ruination"].Acc = set_combine(sets.precast.WS["Decimation"].Acc, {})
	sets.precast.WS["Ruination"].Fodder = set_combine(sets.precast.WS["Decimation"].Fodder, {})
	
--------------------------------------
-- Club Weaponskills
--------------------------------------
-- Black Halo
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +4", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",	
	})
    
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {})

    sets.precast.WS['Black Halo'].Fodder = set_combine(sets.precast.WS['Black Halo'], {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})
	
	
-- Judgement
    sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		right_ring="Cornelia's Ring",
	})

    sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Judgement'].Fodder = set_combine(sets.precast.WS.Fodder, {body="Pumm. Lorica +3"})
	
	
--------------------------------------
-- Great Axe Weaponskills
--------------------------------------
-- Fell Cleave
    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})

    sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS['Fell Cleave'], {})
    sets.precast.WS['Fell Cleave'].Fodder = set_combine(sets.precast.WS['Fell Cleave'], {})
	
	
-- Full Break
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Boii Mask +3",
		body="Boii Lorica +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Alabaster Earring",
		right_ring="Crepuscular Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	})

    sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Full Break"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
-- Ukko's Fury
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Sakpata's Plate",
		feet="Boii Calligae +3",
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS["Ukko's Fury"], {})
    sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {hands="Sakpata's Gauntlets"})
	
   
-- Upheaval
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		right_ring="Sroda Ring",
	}) 
	
--------------------------------------
-- Great Sword Weaponskills
--------------------------------------
-- Resolution
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		body="Agoge Lorica +3",
		hands="Agoge Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sakpata's Leggings",
		waist="Fotia Belt",
		right_ear="Schere Earring",
		left_ring="Sroda Ring",
	})

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    
	sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {
		head="Sakpata's Helm",
		hands="Sakpata's Gauntlets",
		neck="Fotia Gorget",
	})
	
--------------------------------------
-- Polearm Weaponskills
--------------------------------------
-- Impulse Drive
    sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		body="Hjarrandi Breast.",
		hands="Boii Mufflers +3",
		feet="Boii Calligae +3",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Sroda Ring",
	})

    sets.precast.WS["Impulse Drive"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Impulse Drive"].Fodder = set_combine(sets.precast.WS.Fodder, {})

-- Stardiver
	sets.precast.WS["Stardiver"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Sroda Ring",
		})

    sets.precast.WS["Stardiver"].Acc = set_combine(sets.precast.WS["Stardiver"], {})

    sets.precast.WS["Stardiver"].Fodder = set_combine(sets.precast.WS["Stardiver"], {
		ammo="Yetshila +1",
		head="Blistering Sallet +1",
		hands="Sakpata's Gauntlets",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
	})
	
--------------------------------------
-- Sword Weaponskills
--------------------------------------
-- Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Archon Ring",
	})

    sets.precast.WS["Sanguine Blade"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Sanguine Blade"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})


--------------------------------------
-- Swaps when using WS at 3000 TP
--------------------------------------
	sets.MaxTP = {left_ear="Lugra Earring +1"}
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
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
        body="Volte Jupon",
		waist="Chaac Belt",
	})

-- Retaliation
	sets.buff.Retaliation = {hands="Pumm. Mufflers +3", feet="Boii Calligae +3"}

-- Restraint
	sets.buff.Restraint = {hands="Boii Mufflers +3"}
	
-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}
	
-- Vs. Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
-- Vs. Sleep
	sets.buff.Sleep = {neck="Vim Torque +1"}	
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    function select_default_macro_book()
		if player.sub_job == 'DRG' then
			set_macro_page(1, 1)
		elseif player.sub_job == 'SAM' then
			set_macro_page(2, 1)
		elseif player.sub_job == 'DNC' then
			set_macro_page(3, 1)
		elseif player.sub_job == 'NIN' then
			set_macro_page(4, 1)
		else
			set_macro_page(1, 1)
		end
	end
end