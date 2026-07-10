-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow', 'Fodder')
    state.HybridMode:options('Normal', 'DT', 'MEva')
    state.WeaponskillMode:options('Normal', 'Acc', 'FullAcc', 'Fodder')
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Rudras', 'Evisceration', 'Exenterator', 'Aeolian', 'Ruthless')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None', 'DWMid', 'DWMax'}

	
    -- Additional local binds
    send_command('bind @` gs c step')
	send_command('bind ^!@` gs c toggle usealtstep')
	send_command('bind ^@` gs c cycle mainstep')
	send_command('bind !@` gs c cycle altstep')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
	send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
	send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
	send_command('bind !backspace input /ja "Reverse Flourish" <me>')
	send_command('bind ^backspace input /ja "No Foot Rise" <me>')
	send_command('bind %~` gs c cycle SkillchainMode')

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
	sets.Enmity = {
		ammo="Sapience Orb",
		head="Nyame Helm",
		body="Passion Jacket",
		hands="Horos Bangles +3",
		legs="Zoar Subligar +1",
		feet="Macu. Toe Sh. +3",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Friomisi Earring",
		left_ring="Petrov Ring",
		right_ring="Vengeful Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}
		
    sets.precast.JA.Provoke = sets.Enmity
	
-- ### Fast cast gear ###
	sets.precast.FC = { --FC +32/80, QC +4
		ammo="Impatiens", --QC +2
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}, --FC +7
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Nyame Flanchard", --(Limbo Trousers)
		feet="Macu. Toe Sh. +3",
		neck="Voltsurge Torque", --FC +5
		waist="Plat. Mog. Belt", 
		left_ear="Loquac. Earring", --FC +2
		right_ear="Etiolation Earring", --FC +1
		left_ring="Lebeche Ring", --QC +2
		right_ring="Rahab Ring", --FC +2
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --(Fast Cast cape)
	}
	
  -- Fast cast gear for specific spells
    -- Utsusemi
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		body="Passion Jacket",
		neck="Magoraga Beads",
	})

-- ### Precast sets to enhance JAs ###
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}
    
-- ###Waltz sets ###
  -- Curing Waltz
    sets.precast.Waltz = { --Waltz Potency +54/+50, Waltz Potency Received +7, Waltz Delay -1
		ammo="Staunch Tathlum +1",
		head="Horos Tiara +3", --Waltz Pot. +15 (Upgrade to +4)
		body="Maxixi Casaque +2", --Waltz Pot. +17, Waltz Recived +7, Waltz Delay -1 (Upgrade to +4)
		hands="Regal Gloves", 
		legs="Dashing Subligar", --Waltz Pot. +10
		feet="Maxixi Toe Shoes +2", --Waltz Pot. +12 (Upgrade to +4)
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Alabaster Earring",
		right_ear="Handler's Earring", --(Hoxne Earring)
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --(CHA cape)
	}
		
  -- Curing Waltz Received
	sets.Self_Waltz = {head="Mummu Bonnet +2"} --Waltz Potency Received +9
        
	
  -- Healing Waltz
    sets.precast.Waltz['Healing Waltz'] = set_combine(sets.precast.Waltz, {})
    
-- ### Samba duration set ###
    sets.precast.Samba = { --Samba duration +60
		head="Maxixi Tiara +2", -- Samba duration +45 (Upgrade to +4)
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15'}}, --Samba duration +15
	}

-- ### Jig duration set ###
    sets.precast.Jig = { --Jig Duration +95%
		legs="Horos Tights +3", --Jig Duration +50% (Upgrade to +4)
		feet="Maxixi Toe Shoes +2" --Jig Duration +45% (Upgrade to +4)
	}

-- ### Step sets ###
    sets.precast.Step = { --1506 acc, Step Accuracy +79
		ammo="Yamarang",
		head="Maxixi Tiara +2", --Step accuracy +25 (Upgrade to +4)
		body="Macu. Casaque +3",
		hands="Maxixi Bangles +2", --Step accuracy +30 (Upgrade to +4)
		legs="Maculele Tights +3",
		feet="Horos T. Shoes +3", --Step accuracy +24, Step TP -20 (Upgrade to +4)
		neck="Null Loop", 
		waist="Kentarch Belt +1", 
		left_ear="Alabaster Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back="Null Shawl",
	}

-- ###Flourish I sets ###
    sets.precast.Flourish1 = {}
  
  -- Animated Flourish
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
	
  -- Desperate Flouish
	sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {})
  
  -- Violent Flourish
	sets.precast.Flourish1['Violent Flourish'] = {
		ammo="Yamarang",
		head="Maculele Tiara +3",
		body="Macu. Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet="Macu. Toe Sh. +3",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	}

-- ### Flourish II sets ###
    sets.precast.Flourish2 = {}
	
  -- Reverse Flourish
    sets.precast.Flourish2['Reverse Flourish'] = { --Reverse Flourish +42
		hands="Macu. Bangles +3", --Reverse Flourish +14
		back="Toetapper Mantle", --Reverse Flourish +28
	}

-- ### Flourish III sets ###
    sets.precast.Flourish3 = {}
	
  -- Climatic Flourish
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +3"}
	
  -- Striking Flourish
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +3"}
 	
-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast recast sets ###
    sets.midcast.FastRecast = { ----FC +34/80
		ammo="Sapience Orb", --FC +2
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}, --FC +7
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Nyame Flanchard",
		feet="Macu. Toe Sh. +3",
		neck="Voltsurge Torque", --FC +5
		waist="Plat. Mog. Belt",
		left_ear="Loquac. Earring", --FC +2
		right_ear="Etiolation Earring", --FC +1
		left_ring="Murky Ring",
		right_ring="Rahab Ring", --FC +2
		back="Null Shawl", --(Fast cast cape)
	}
        
  -- Fast Recast for Specific spells
    -- Utsusemi
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	
-- ### Dark magic (/DRK for Aminon) ###
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		ammo="Yamarang",
		head="Maculele Tiara +3",
		body="Macu. Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet="Macu. Toe Sh. +3",
		neck="Null Loop", 
		waist="Eschan Stone", --(Null Belt)
		left_ear="Alabaster Earring", --(Mani Earring)
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		right_ring="Metamor. Ring +1", --(Stikini Ring +1)
	})

-- ### Sets to return to when not performing an action. ###
    sets.resting = {}
    sets.ExtraRegen = {}
	
---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###
	sets.idle = { --DT -31 [PDT -66/50], Regain +12, Regen +1, Mv. Speed +18%
		ammo="Staunch Tathlum +1", --DT -3
		head="Gleti's Mask", --PDT -6, Regain +2 (Null Masque)
		body="Gleti's Cuirass", --PDT -9, Regain +3
		hands="Gleti's Gauntlets", --PDT -7, Regain +2
		legs="Gleti's Breeches", --PDT -8, Regain +3
		feet="Gleti's Boots", --PDT -5, Regain +2
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3 (Null Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back="Solemnity Cape", --DT -4 (Fast Cast/DT or Regen cape)
	}
	
  -- Regen set
	sets.idle.Regen = set_combine(sets.idle, { --DT -25 [PDT -51/50], Regen +16, Mv. Speed +18%
		head="Meghanada Visor +2", --PDT -5, Set Bonus: Regen +12 (Null Masque)
		body="Meg. Cuirie +2", --PDT -8 
		hands="Meg. Gloves +2", --PDT -4
		legs="Meg. Chausses +2", --PDT -6
		feet="Meg. Jam. +2", --PDT -3
		neck="Bathy Choker +1", --Regen +3
	})
	
  -- Refresh
	sets.idle.Refresh = set_combine(sets.idle, { --DT -25 [PDT -61/50], Refresh +1
		neck="Sibyl Scarf",
	})
	
  -- Weakened
	sets.idle.Weakened = set_combine(sets.idle, {})

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
	sets.defense.PDT = {
		ammo="Eluder's Sachet", --DT +2, Enemy Crit -5%
		head="Nyame Helm", 
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back="Solemnity Cape",
	}
	
  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
		back="Null Shawl",
	})

  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, { --Resist all +71, [Charm] +95, [Death] +81
		ammo="Staunch Tathlum +1", --Resist all +11
		head="Volte Cap", --Resist all +10
		body="Volte Jupon", --Resist all +20
		hands="Volte Bracers", --Resist all +10
		legs="Volte Hose", --Resist all +10
		feet="Volte Boots", --Resist all +10
		neck="Unmoving Collar +1", --Resist charm +9
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Hearty Earring", --Resist all +xx
		left_ring="Murky Ring",
		right_ring="Warden's Ring", --Resist Death +10
		back="Solemnity Cape", --Resist charm +15
	})

  -- Misc. Defense Sets
    -- Kiting
    sets.Kiting = {right_ring="Shneddick Ring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
	sets.engaged = { -- Acc 1395, DA +22, TA +6, Store TP +86, DT -31
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Malignance Tabard", --DT -9
		hands="Malignance Gloves", --DT -5
		legs="Malignance Tights", --DT -7
		feet="Macu. Toe Sh. +3", --DT -10
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Dedition Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}}, --(DT -5 Cape)
	}
	
  -- Accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, { --Acc 1463, DA +17, Store TP +89, DT -31
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	})
	
  -- Full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, { --Acc 1563, DA +11, Store TP +63, DT -40
		ammo="Yamarang",
		body="Macu. Casaque +3", --DT -14
		hands="Macu. Bangles +3", --DT -11
		legs="Maculele Tights +3", --DT -10
		neck="Null Loop", --DT -5
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl", 
	})
	
-- Subtle blow set
	sets.engaged.SubtleBlow = set_combine(sets.engaged, { --Acc 1439, DA +18, STP +74, DT -30, SB +53/50, SBII +5
		head="Malignance Chapeau", --DT -6
		body="Macu. Casaque +3", --DT -14, SB +14
		hands="Volte Mittens", --SB +6
		legs="Volte Tights", --SB +8
		waist="Kentarch Belt +1",
		left_ear="Digni. Earring", --SB +5
		right_ear="Sherida Earring", --SBII +5
		left_ring="Chirich Ring +1", --SB +10
		right_ring="Chirich Ring +1", --SB +10
		back="Null Shawl",
	})
	
-- Fodder set
	sets.engaged.Fodder = set_combine(sets.engaged, { --Acc 1341, DA +22, TA +20, QA +2, STP +64, DT -10
		ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Dedition Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back="Null Shawl",	
	})

-- Hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, { --Acc 1403, DA +14, TA +2, Store TP +84, DT -53/50
		head="Malignance Chapeau",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		right_ear="Telos Earring",
		left_ring="Murky Ring",
		right_ring="Moonlight Ring",
	})
	
  -- Hybrid MEva set
	sets.engaged.MEva = set_combine(sets.engaged, { --Acc 1359, DA +7, Store TP +67
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Hearty Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back="Null Shawl",
	})

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill sets (DEX/WSD) ###
    sets.precast.WS = { 
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Horos Tights +3", --(Upgrade to +4)
		feet="Nyame Sollerets",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Moonshade Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		legs="Maculele Tights +3",
	})

-- ### Dagger weaponskills ###
  -- Aeolian Edge (INT/MSB/WSD)
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		head="Nyame Helm",
		legs="Nyame Flanchard",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		right_ring="Shiva Ring +1",
		back={ name="Senuna's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+1','Weapon skill damage +10%',}},
	})
	
  -- Evisceration (DEX/Crit)
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Charis Feather",
		head="Blistering Sallet +1",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
  -- Exenterator (AGI/DA)
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		body="Gleti's Cuirass",
		hands="Maxixi Bangles +2", --(Upgrade to +4)
		legs="Maculele Tights +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring", --(Hoxne Earring)
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Gere Ring",
		back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(AGI/DA Cape))
	})
	
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {
		ammo="Crepuscular Pebble",
		hands="Gleti's Gauntlets",
	})
	
  -- Pyrrhic Kleos sets

  -- Rudra's Storm (DEX/WSD, uses the default WS set as base)
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})

  -- Ruthless Stroke (DEX?/WSD)
	sets.precast.WS['Ruthless Stroke'] = set_combine(sets.precast.WS, {
		legs="Nyame Flanchard",
		waist="Sailfi Belt +1",
	})
	
    sets.precast.WS['Ruthless Stroke'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Ruthless Stroke'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Ruthless Stroke'].Fodder = set_combine(sets.precast.WS['Ruthless Stroke'], {})
  
  -- Shark Bite
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		ammo="Yamarang", --(Cait Palug Stone)
		hands="Nyame Gauntlets", --(Maxixi Bangles +4)
		legs="Nyame Flanchard",
		waist="Sailfi Belt +1",
	})
	
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		legs="Maculele Tights +3",
		waist="Kentarch Belt +1",
		left_ring="Cornelia's Ring",
	})
	
-- ### Miscellaneous WS swaps ###
  -- Swaps when WS at 3000 tp
	sets.MaxTP = {left_ear="Sherida Earring", right_ear="Ishvara Earring"}
	sets.AccMaxTP = {left_ear="Sherida Earring", right_ear="Mache Earring +1",}
	
  -- Skillchain bonus swaps
    sets.Skillchain = {hands="Macu. Bangles +3"}

---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
-- ### Base weapon sets ###
	sets.weapons.Rudras = {main="Aeneas", sub="Centovente"} --(Twashtar)
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Exenterator = {main="Aeneas", sub="Gleti's Knife"}
	sets.weapons.Aeolian = {main="Aeneas", sub="Centovente"}
	sets.weapons.Ruthless = {main="Mpu Gandring", sub="Centovente"}
	
-- ### Abyssea proc sets ###
	sets.weapons.ProcDagger = {main="Qutrub Knife", sub=empty}
	sets.weapons.ProcSword = {main="Ibushi Shinai", sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament", sub=empty}
	sets.weapons.ProcGreatAxe = {main="Helgoland", sub=empty}
	sets.weapons.ProcScythe = {main="Lost Sickle", sub=empty}
	sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade", sub=empty}
	sets.weapons.ProcKatana = {main="Debahocho", sub=empty}
	sets.weapons.ProcGreatKatana = {main="Zanmato", sub=empty}
	sets.weapons.ProcClub = {main="Soulflayer's Wand", sub=empty}
	sets.weapons.ProcStaff = {main="Ranine Staff", sub=empty}
	
---------------------------------------------------------------------------------------------------------------
-- Miscellaneous sets
---------------------------------------------------------------------------------------------------------------
-- Dual Wield Sets
	sets.DWMid = {body="Macu. Casaque +3", left_ear="Eabani Earring",} --Dual Wield +15
	sets.DWMax = { --Dual Wield +35
		head="Maxixi Tiara +2",
		body="Macu. Casaque +3",
		feet="Taeon Boots",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
	}

-- Gear that needs to be worn when a buff is active.
    sets.buff['Saber Dance'] = {legs="Horos Tights +3"} --(Upgrade to +4)
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +3", body="Meg. Cuirie +2"}
	
-- Gear that needs to be worn when a buff is received.
  -- Cure potency received
	sets.Cure_Received = {waist="Gishdubar Sash"}
  
  -- Phalanx received
	sets.Phalanx_Received = { --Phalanx +13
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
	}
	
-- Vs. Debuff sets
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		--right_ring="Purity Ring"
	})
	
  -- Sleep
	--sets.buff.Sleep = {head="Frenzy Sallet"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 19)
    elseif player.sub_job == 'DRG' then
        set_macro_page(3, 19)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 19)
	elseif player.sub_job == 'DRK' then
        set_macro_page(5, 19)
	elseif player.sub_job == 'RDM' then
        set_macro_page(6, 19)
    else
        set_macro_page(1, 19)
    end
end