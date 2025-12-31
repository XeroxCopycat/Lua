-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'FullAcc', 'Fodder')
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Rudras', 'Evisceration', 'Exenterator', 'Aeolian', 'Ruthless')

	
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
-- Enmity set
	sets.Enmity = {
		ammo="Sapience Orb",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Horos Bangles +3", -- Upgrade to +4
		legs="Zoar Subligar +1",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Friomisi Earring",
		right_ear="Alabaster Earring",
		left_ring="Petrov Ring",
		right_ring="Vengeful Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}
		
    sets.precast.JA.Provoke = sets.Enmity
	
-- Fast cast gear
	sets.precast.FC = {
		ammo="Impatiens",
		head="Nyame Helm",
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
-- Fast cast gear for specific spells
  -- Utsusemi
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

-- Precast sets to enhance JAs
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}
    
-- Waltz sets
  -- Curing Waltz
    sets.precast.Waltz = {
		ammo="Staunch Tathlum +1",
		head="Horos Tiara +3",
 		body="Maxixi Casaque +2", -- Upgrade to +4
		hands="Regal Gloves",
		legs="Dashing Subligar",
		feet="Maxixi Toe Shoes +2", -- Upgrade to +4
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Handler's Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
  -- Curing Waltz Received
	sets.Self_Waltz = {head="Mummu Bonnet +2"} 
        
	
  -- Healing Waltz
    sets.precast.Waltz['Healing Waltz'] = {}
    
-- Samba sets
    sets.precast.Samba = {
		head="Maxixi Tiara +2", -- Upgrade to +4
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15'}},
	}

-- Jig sets
    sets.precast.Jig = {legs="Horos Tights +3", feet="Maxixi Toe Shoes +2"}  -- Upgrade to +4

-- Step sets
    sets.precast.Step = {
		ammo="Hasty Pinion +1",
		head="Maculele Tiara +3",
		body="Macu. Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet="Horos T. Shoes +3",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Digni. Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}

-- Flourish I sets
    sets.precast.Flourish1 = {}
  
  -- Violent Flourish
	sets.precast.Flourish1['Violent Flourish'] = {
		ammo="Hasty Pinion +1",
		head="Maculele Tiara +3",
		body="Horos Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet="Macu. Toe Sh. +3",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
  -- Animated Flourish
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
	
  -- Desperate Flouish
    sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {})

-- Flourish II sets
    sets.precast.Flourish2 = {}
	
  -- Reverse Flourish
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Macu. Bangles +3", back="Toetapper Mantle"}

-- Flourish III sets
    sets.precast.Flourish3 = {}
	
  -- Striking Flourish
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +3"}
 	
  -- Climatic Flourish
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +3"}

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- Fast recast sets
    sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head="Nyame Helm",
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Murky Ring",
		back="Null Shawl",
	}
        
-- Fast Recast for Specific spells
  -- Utsusemi
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

-- Sets to return to when not performing an action.
    sets.resting = {}
    sets.ExtraRegen = {}
	
---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
-- Base idle set
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm", -- Null Masque
		body="Gleti's Cuirass",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Dawn Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}}, -- Fast Cast/Regen
	}
	
	sets.idle.Regen = set_combine(sets.idle, {
		head="Meghanada Visor +2", -- Null Masque
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
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
		back="Null Shawl",
	}
	
-- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		left_ring="Archon Ring",
	})

-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		left_ring="Vengeful Ring",
		waist="Plat. Mog. Belt", -- Null Belt
	})

-- Misc. Defense Sets
  -- Kiting
    sets.Kiting = {right_ring="Shneddick Ring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
	sets.engaged = { -- 1425 Acc
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Malignance Tights", -- Gleti's Breeches augmented to R30
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back="Null Shawl",
	}
	
-- Accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, {})
	
-- Full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
-- Subtle blow set
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		body="Macu. Casaque +3",
		right_ear="Digni. Earring",
	})

-- Hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, {
		neck="Null Loop",
		right_ear="Alabaster Earring",
		left_ring="Moonlight Ring",
		right_ring="Murky Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}}, -- Change to DT
	})

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- Default weaponskill sets
    sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets", -- Maxixi Bangles +4
		legs="Horos Tights +3", -- Upgrade to +4
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


-- Dagger weaponskills
  -- Aeolian Edge
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		head="Nyame Helm",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		right_ring="Metamor. Ring +1",
		back={ name="Senuna's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+1','Weapon skill damage +10%',}}, --Int/WSD
	})
	
  -- Evisceration
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar", -- Charis Feather
		head="Blistering Sallet +1",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		left_ring="Gere Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
	-- Exenterator sets
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		body="Gleti's Cuirass",
		hands="Nyame Gauntlets", -- Maxixi Bangles +4
		legs="Maculele Tights +3",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		left_ring="Gere Ring",
    right_ring="Sroda Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}}, -- AGI/DA
	})
	
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {
		ammo="Crepuscular Pebble",
		hands="Gleti's Gauntlets",
	})
	
	-- Pyrrhic Kleos sets

	-- Rudra's Storm
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
    -- Shark Bite
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		ammo="Hasty Pinion +1",
		head="Maculele Tiara +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Ilabrat Ring",
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
	sets.weapons.Rudras = {main="Aeneas", sub="Centovente"}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Exenterator = {main="Aeneas", sub="Gleti's Knife"}
	sets.weapons.Aeolian = {main="Aeneas", sub="Centovente"}
	sets.weapons.Ruthless = {main="Mpu Gandring", sub="Centovente"}
	
---------------------------------------------------------------------------------------------------------------
-- Miscellaneous sets
---------------------------------------------------------------------------------------------------------------
-- Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {legs="Horos Tights +3"} -- Upgrade to +4
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +3", body="Meg. Cuirie +2"}
	
-- Vs. Debuff sets
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	
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
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 19)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 19)
    else
        set_macro_page(1, 19)
    end
end