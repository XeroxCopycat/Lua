-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'Fodder', 'SubtleBlow')
    state.HybridMode:options('Normal', 'DT', 'DTSubtleBlow')
    state.WeaponskillMode:options('Normal', 'Acc', 'FullAcc', 'Fodder', 'SubtleBlow')
	state.IdleMode:options('Normal', 'Regen', 'Regain')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas', 'LowBuff')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None', 'Suppa', 'DWMax'}

	
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
    --------------------------------------
	-- Enmity set
	--------------------------------------
	sets.Enmity = {
		ammo="Sapience Orb",
		hands={ name="Horos Bangles +3", augments={'Enhances "Fan Dance" effect',}},
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		left_ear="Friomisi Earring",
		left_ring="Petrov Ring",
		right_ring="Vengeful Ring",
	}
		
    sets.precast.JA.Provoke = sets.Enmity
	
	--------------------------------------
	-- Fast cast gear
	--------------------------------------
	sets.precast.FC = {
		ammo="Sapience Orb",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}
	
	-- Utsusemi
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
	--------------------------------------
    -- Precast Sets
    --------------------------------------
    -- Precast sets to enhance JAs
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}
    
    -- Waltz sets (chr and vit)
    sets.precast.Waltz = {
		ammo="Staunch Tathlum +1",
		head={ name="Horos Tiara +3", augments={'Enhances "Trance" effect',}},
		body="Maxixi Casaque +2",
		hands="Regal Gloves",
		legs="Dashing Subligar",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Chaac Belt",
		left_ear="Eabani Earring",
		right_ear="Handler's Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}
		
	sets.Self_Waltz = {head="Mummu Bonnet +2"} --right_ring="Asklepian Ring"
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
	-- Samba sets
    sets.precast.Samba = {
		head="Maxixi Tiara +2",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15'}},
	}

	-- Jig sets
    sets.precast.Jig = {legs="Horos Tights +3", feet="Maxixi Toe Shoes +2"} 

	-- Step sets
    sets.precast.Step = {
		ammo="Hasty Pinion +1",
		head="Maculele Tiara +3",
		body="Macu. Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	--------------------------------------
	-- Flourish I sets
	--------------------------------------
    sets.precast.Flourish1 = {}
    
	-- Violent Flourish
	sets.precast.Flourish1['Violent Flourish'] = {
		ammo="Pemphredo Tathlum",
		head="Maculele Tiara +3",
		body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet="Macu. Toe Sh. +3",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Crepuscular Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Senuna's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
	
	-- Animated Flourish
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
	
	-- Desperate Flouish
    sets.precast.Flourish1['Desperate Flourish'] = {
		ammo="Hasty Pinion +1",
		head="Maculele Tiara +3",
		body="Macu. Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Cacoethic Ring +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	--------------------------------------
	-- Flourish II sets
	--------------------------------------
    sets.precast.Flourish2 = {}
	
	-- Reverse Flourish
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Macu. Bangles +3", back="Toetapper Mantle"}

	--------------------------------------
	-- Flourish III sets
	--------------------------------------
    sets.precast.Flourish3 = {}
	
	-- Striking Flourish
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +3"}
	
	-- Climatic Flourish
    sets.precast.Flourish3['Climactic Flourish'] = {}

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
    -- Midcast Sets
    --------------------------------------
    sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
        
    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

    
    -- Sets to return to when not performing an action.
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}
	
---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Base idle set
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
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Moonlight Ring",
		back="Null Shawl",
	}
	
	sets.idle.Regen = set_combine(sets.idle, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Bathy Choker +1",
		right_ear="Dawn Earring",
		right_ring="Chirich Ring +1",
	})
	
	sets.idle.Regain = set_combine(sets.idle, {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
	})
	
	sets.idle.Refresh = set_combine(sets.idle, {
		neck="Sibyl Scarf",
	})

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	-- Physical damage taken
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Null Loop",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Warden's Ring",
		right_ring="Defending Ring",
		back="Null Shawl",
	}
	
	-- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ring="Icecrack Ring",
	})
		
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		right_ear="Hearty Earring",
		left_ring="Vengeful Ring",
	}

	--------------------------------------
	-- Misc. Defense Sets
	--------------------------------------
	-- Kiting
    sets.Kiting = {right_ring="Shneddick Ring",}
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Single wield sets
	--------------------------------------
	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back="Null Shawl",
	}
	
	-- Single wield accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, {})
	
	-- Single wield full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
	-- Single wield subtle blow set
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	
	-- Single wield hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	})

	--------------------------------------
	-- Dual wield sets
	--------------------------------------
	-- Dual wield engaged set
	sets.engaged.DW = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back="Null Shawl",
	}

	-- Single wield accuracy set
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	
	-- Single wield full accuracy set
	sets.engaged.DW.FullAcc = set_combine(sets.engaged.DW, {})
	
	-- Single wield subtle blow set
	sets.engaged.DW.SubtleBlow = set_combine(sets.engaged.DW, {})
	
	-- Single wield hybrid DT set
	sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	})

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
    --------------------------------------
    -- Weaponskill sets
    --------------------------------------
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = {}
	sets.precast.WS.SubtleBlow = {}

    --------------------------------------
    -- Dagger weaponskills
    --------------------------------------
	-- Aeolian Edge sets
    sets.precast.WS['Aeolian Edge'] = {
		main={ name="Aeneas", augments={'Path: A',}},
		sub="Gleti's Knife",
		ammo="Ghastly Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
	
	-- Evisceration sets
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Gleti's Cuirass",
		hands="Mummu Wrists +2",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
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
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Evisceration'].SubtleBlow = set_combine(sets.precast.WS['Evisceration'], {
		body="Macu. Casaque +3",
		left_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
	})
	
	-- Exenterator sets
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		main={ name="Aeneas", augments={'Path: A',}},
		sub="Gleti's Knife",
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
		hands="Macu. Bangles +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	})
	
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Maculele Tights +3",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
	})
	
	-- Pyrrhic Kleos sets
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
		hands="Macu. Bangles +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
    
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	
	sets.precast.WS['Pyrrhic Kleos'].Fodder = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
	})
	
	sets.precast.WS['Pyrrhic Kleos'].SubtleBlow = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
		body="Macu. Casaque +3",
		left_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
	})
	
	-- Rudra's Storm
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {left_ear="Moonshade Earring", right_ear="Mache Earring +1"})
	
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Cornelia's Ring",
	})
	
	sets.precast.WS["Rudra's Storm"].SubtleBlow = set_combine(sets.precast.WS["Rudra's Storm"], {
		body="Macu. Casaque +3",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
	})
	
    -- Shark Bite
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Maculele Tiara +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    
	sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		legs="Maculele Tights +3",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Cornelia's Ring",
	})
	
	sets.precast.WS["Shark Bite"].SubtleBlow = set_combine(sets.precast.WS["Shark Bite"], {
		body="Macu. Casaque +3",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
	})



	--------------------------------------
	-- Swap to these on Moonshade using WS if at 3000 TP
	--------------------------------------
	sets.MaxTP = {left_ear="Sherida Earring", right_ear="Ishvara Earring"}
	sets.AccMaxTP = {left_ear="Sherida Earring", right_ear="Mache Earring +1",}
	
    sets.Skillchain = {hands="Macu. Bangles +3"}

---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Single handed weapons
	--------------------------------------
	sets.weapons.DualAeneas = {main="Aeneas", sub="Gleti's Knife"}
	sets.weapons.DualTauret = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.DualMpu = {main="Mpu Gandring", sub="Gleti's Knife"}
	
	
---------------------------------------------------------------------------------------------------------------
-- Miscellaneous sets
---------------------------------------------------------------------------------------------------------------
	-- Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {legs="Horos Tights +3"} 
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +3", body="Meg. Cuirie +2"}
	
	-- Doom set
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	
	-- Sleep set
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 19)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 19)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 19)
    else
        set_macro_page(1, 19)
    end
end

	--------------------------------------
	-- Weapons sets
	--------------------------------------
	sets.weapons.Aeneas = {main="Aeneas", sub="Gleti's Knife"}
	sets.weapons.Tauret = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Mpu = {main="Mpu Gandring", sub="Gleti's Knife"}
	--sets.weapons.Twashtar = {main="Twashtar", sub"Gleti's Knife"}
	sets.weapons.LowBuff = {main="Aeneas",sub="Blurred Knife +1"}