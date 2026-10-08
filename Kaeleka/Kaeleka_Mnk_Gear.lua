function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc', 'PDL')
    state.HybridMode:options('Normal', 'DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'SubtleBlow'}
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('VictorySmite', 'Cataclysm', 'None')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'SubtleBlow'}

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()
-------------------------------------------------------------------------------------------------------------------
-- Start defining the sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Enmity set ###
	sets.precast.Enmity = {
		ammo="Iron Gobbet", 
		body="Passion Jacket", 
		neck="Unmoving Collar +1",
	}

-- ### Fast cast sets for spells ###
	sets.precast.FC = {
		ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Bhikku Hose +3",
		feet="Bhikku Gaiters +3",
		neck="Voltsurge Torque",
		waist="Moonbow Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket", neck="Magoraga Beads"})

-- ### Precast sets to enhance JAs on use ###
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"} --(Upgrade to +4)
	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +3"} --(Upgrade to +4)
	sets.precast.JA['Boost'].OutOfCombat = {hands="Anchorite's Gloves +3"} --(Upgrade to +4)
	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"} --(Upgrade to +4)
	sets.precast.JA['Focus'] = {head="Anchorite's Crown +3"} --(Upgrade to +4)
	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +3"} --(Upgrade to +4)
	sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters +3"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +3"} --(Upgrade to +4)
	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +3"} --(Upgrade to +4)
	sets.precast.JA['Chi Blast'] = {
		ammo="Staunch Tathlum +1",
		head="Hes. Crown +3", --(Upgrade to +4)
		body="Bhikku Cyclas +3",
		hands="Nyame Gauntlets",
		legs="Bhikku Hose +3",
		feet="Bhikku Gaiters +3",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.JA['Chakra'] = {
		ammo="Aurgelmir Orb", --(Upgrade to +1)
		head="Hes. Crown +3", --(Null Masque)
		body="Anch. Cyclas +3", --(Upgrade to +4)
		hands="Hes. Gloves +3", --(Upgrade to +4)
		legs="Tatena. Haidate +1",
		feet="Bhikku Gaiters +3",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt", --(Latria Belt)
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --(Hoxne Earring, MR 6+)
		left_ring="Niqmaddu Ring", 
		right_ring="Regal Ring", --(Gelatenous Ring +1, Aug. to R15)
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}}, --(Segmono's Mantle: VIT +30)
	}

-- ### Waltz sets (chr and vit) ###
	sets.precast.Waltz = {
		ammo="Aurgelmir Orb",
		head="Hes. Crown +3",
		body="Passion Jacket",
		hands="Hes. Gloves +3",
		legs="Dashing Subligar",
		feet="Rawhide Boots",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},	
	}
		
	sets.precast.Waltz['Healing Waltz'] = {}

-- ### Step set ###
	sets.precast.Step = {
		ammo="Amar Cluster",
		head="Bhikku Crown +3",
		body="Bhikku Cyclas +3",
		hands="Gazu Bracelets +1",
		legs="Bhikku Hose +3",
		feet="Bhikku Gaiters +3",
		neck="Null Loop",
		waist="Moonbow Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}},
		left_ring="Murky Ring", --(Aug. to R30)
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
		
-- Flourish set (used for Enmity)		
	sets.precast.Flourish1 = sets.precast.Enmity

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- Midcast fast recast
	sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Bhikku Hose +3",
		feet="Bhikku Gaiters +3",
		neck="Voltsurge Torque",
		waist="Moonbow Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},
	}
	
-- Midcast sets for specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {body="Passion Jacket", neck="Magoraga Beads"})

-------------------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###
	sets.idle = { --DT -53/50, Regen +24
		ammo="Staunch Tathlum +1", --DT -3
		head="Nyame Helm", --DT -7 (Null Masque)
		body="Hiza. Haramaki +2", --Regen +12
		hands="Nyame Gauntlets", --DT -7
		legs="Bhikku Hose +3", --DT -14
		feet="Nyame Sollerets", --DT -7
		neck="Bathy Choker +1", --Regen +3
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}}, --Regen +5
	}
		
  -- Refresh set
	sets.idle.Refresh = set_combine(sets.idle, {neck="Sibyl Scarf"})
	
  -- Regain set
	sets.idle.Regain = set_combine(sets.idle, {
		head="Nyame Helm", --(Null Masque)
	})
  
  -- Regen set
	sets.idle.Regen = set_combine(sets.idle, {
		left_ring="Chirich Ring +1",
	})

-- ### Resting set ###
	sets.Resting = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm", --(Null Masque)
		body="Hiza. Haramaki +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},
	}

-------------------------------------------------------------------------------------------------------------------
-- Defensive Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
	sets.defense.PDT = {
		ammo="Eluder's Sachet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},
	}
		
  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		head="Bhikku Crown +3",
		body="Bhikku Cyclas +3",
		legs="Bhikku Hose +3",
		feet="Bhikku Gaiters +3",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Arete del Luna",
		right_ring="Archon Ring",
		back="Null Shawl",
	})
		
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Carrier's Sash", --(Null Belt)
		right_ring="Vengeful Ring",
		back="Null Shawl",
	})

-- ### Misc. defensive sets ###
  -- Kiting
	sets.Kiting = {right_ring="Shneddick Ring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- Normal melee sets (Impetus down)
	sets.engaged = {
		ammo="Coiste Bodhar", --(Aug. to R30)
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --(Duty Crown, Aug. to R30) 
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --(Duty Cyclas, Aug. to R30)
		hands="Tatena. Gote +1",
		legs="Bhikku Hose +3",
		feet="Malignance Boots", --(Duty Sollerets, Aug. to R30)
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}}, --(Upgrade to +2, Aug. to R25)
		waist="Moonbow Belt +1",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Schere Earring", --(Aug. to R30)
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		hands="Gazu Braclets +1", 
		neck="Null Loop",
		back="Null Shawl",
	})
	
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		ammo="Hasty Pinion +1",
		head="Bhikku Crown +3",
		body="Bhikku Cyclas +3",
		hands="Gazu Bracelets +1",
		feet="Bhikku Gaiters +3",
		neck="Null Loop",
		left_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
-- Defensive melee hybrid sets
	sets.engaged.DT = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Tatena. Gote +1",
		legs="Bhikku Hose +3",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Schere Earring",
		left_ring="Murky Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

-- ## Extra melee sets (equipped over engaged sets) ##
	sets.SubtleBlow = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Mpaca's Hose",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ring="Niqmaddu Ring",
	}
		
-- Misc. engaged sets (equipped when a buff is active on top of melee sets)
	sets.buff.Counterstance = {
		ammo="Crepuscular Pebble",
		head="Bhikku Crown +3",
		body="Mpaca's Doublet", --(Aug. to R30)
		hands="Tatena. Gote +1", --(Rao Kote +1, Path A: Aug. to R15)
		legs="Anch. Hose +3", --(Upgrade to +4)
		feet="Bhikku Gaiters +3",
		neck="Bathy Choker +1", --(Aug. to R15)
		waist="Moonbow Belt +1",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --(Bhikku Earring +2)
		left_ring="Murky Ring", --(Aug. to R30)
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Segomo's Mantle: DEX +30, Acc/Atk +20, DA +10, Counter +10)
	}
	
	sets.buff.Impetus = {body="Bhikku Cyclas +3"}
	sets.buff.Footwork = {feet="Bhikku Gaiters +3"}
	sets.buff.Boost = {waist="Ask Sash"}

	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	--sets.Skillchain = {legs="Ryuo Hakama"}
	

-------------------------------------------------------------------------------------------------------------------
-- Weapon & Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Weapon sets ###
	sets.weapons.VictorySmite = {main="Karambit"}
	sets.weapons.Cataclysm = {main="Malignance Pole", sub="Bloodrain Strap"}
	sets.weapons.None = {main=empty}

-- ### Default weaponskill set ###
	sets.precast.WS = {
		ammo="Coiste Bodhar", 
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --(Path B: Aug. to R15)
		body="Bhikku Cyclas +3", --(Duty Cyclas)
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --(Path B: Aug. to R15)
		legs="Mpaca's Hose", --(Aug. to R30)
		feet="Bhikku Gaiters +3", --(Duty Sollerets)
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring", --(Hoxne Earring)
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +3", --(Upgrade to +3)
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}}, --(Upgrade to +2, Aug. to R25)
	})

-- ### Specific weaponskill sets ###
  -- Hand-to-Hand Weaponskills
	-- Asuran Fists
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Hes. Crown +3",
		hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",
		feet="Hes. Gaiters +3",
		waist="Fotia Belt",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Sroda Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS['Asuran Fists'], {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS['Asuran Fists'], {})
	sets.precast.WS['Asuran Fists'].PDL = set_combine(sets.precast.WS['Asuran Fists'], {
		body="Malignance Tabard",
		feet="Nyame Sollerets", --(Aug. to R30)
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}}, --(Upgrade to +2)
	})
	
	-- Dragon Kick
	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap", --(Aug. to R30)
		body="Nyame Mail", --(Duty Cyclas, Aug. to R30)
		hands="Nyame Gauntlets", --(Aug. to R30)
		legs="Nyame Flanchard", --(Duty Flanchard, Aug. to R30)
		feet="Nyame Sollerets", --(Duty Sollerets, Aug. to R30)
		neck="Fotia Gorget", 
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring", 
		right_ear="Schere Earring",
		left_ring="Gere Ring", 
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --(Segomo's Mantle: STR +30, Acc/Atk +20, DA +10, DT -5)
	})
	
	sets.precast.WS['Dragon Kick'].Acc = set_combine(sets.precast.WS['Dragon Kick'], {})
	sets.precast.WS['Dragon Kick'].FullAcc = set_combine(sets.precast.WS['Dragon Kick'], {})
	sets.precast.WS['Dragon Kick'].PDL = set_combine(sets.precast.WS['Dragon Kick'], {
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +3", --(Upgrade to +3)
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}}, --(Upgrade to +2, Aug. to R25)
	})
	
	-- Howling Fist
	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Cornelia's Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS['Howling Fist'], {})
	sets.precast.WS['Howling Fist'].FullAcc = set_combine(sets.precast.WS['Howling Fist'], {})
	sets.precast.WS['Howling Fist'].PDL = set_combine(sets.precast.WS['Howling Fist'], {
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +3", --(Upgrade to +3)
	})
	
	-- Raging Fists
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS['Raging Fists'], {})
	sets.precast.WS['Raging Fists'].FullAcc = set_combine(sets.precast.WS['Raging Fists'], {})
	sets.precast.WS['Raging Fists'].PDL = set_combine(sets.precast.WS['Raging Fists'], {
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +3", --(Upgrade to +3)
		legs="Mpaca's Hose", --(Aug. to R30)
	})
	
	-- Shijin Spiral
	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		left_ear="Moonshade Earring",
		right_ear="Odr Earring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS['Shijin Spiral'], {})
	sets.precast.WS['Shijin Spiral'].FullAcc = set_combine(sets.precast.WS['Shijin Spiral'], {})
	sets.precast.WS['Shijin Spiral'].PDL = set_combine(sets.precast.WS['Shijin Spiral'], {
		ammo="Crepuscular Pebble",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Malignance Tabard",
		hands="Bhikku Gloves +2",
		legs="Mpaca's Hose",
		right_ear="Sherida Earring",
		right_ring="Regal Ring",
	})
	
	-- Tornado Kick
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS['Tornado Kick'], {})
	sets.precast.WS['Tornado Kick'].FullAcc = set_combine(sets.precast.WS['Tornado Kick'], {})
	sets.precast.WS['Tornado Kick'].PDL = set_combine(sets.precast.WS['Tornado Kick'], {
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +2", --(Upgrade to +3)
		legs="Mpaca's Hose",
	})
	
	-- Victory Smite
	sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS['Victory Smite'], {})
	sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS['Victory Smite'], {})
	sets.precast.WS["Victory Smite"].Fodder = set_combine(sets.precast.WS['Victory Smite'], {})

  -- Staff Weaponskills
    -- Cataclysm 
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast,WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
-- ### Weaponskills when either Footwork and/or Impetus is active ###
	sets.buff.FootworkWS = {feet="Bhikku Gaiters +3"}
	sets.buff.ImpetusWS = {
		head="Blistering Sallet +1",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +2",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --(Segomo's Mantle: Str +30, Acc/Atk +20, DA +10, DT -5)
	}

-- ### Gear swaps when using WS at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Weapon Sets
-------------------------------------------------------------------------------------------------------------------

	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Treasure Hunter	
	sets.TreasureHunter = {
		body="Volte Jupon",
		feet="Volte Boots",
		waist="Chaac Belt",
	}
    
-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}

-- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	
-- Sleep	
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
-- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	
-- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter	
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'DNC' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(5, 2)
	else
		set_macro_page(1, 2)
	end
end