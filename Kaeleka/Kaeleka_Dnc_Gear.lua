-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'DT', 'Hoxne')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc', 'PDL')
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas', 'AeneasGleti', 'Tauret', 'Mpu', 'Karambit', 'None')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None', 'DWMid', 'DWMax', 'SubtleBlow'}

	
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
-- ## Enmity set ##
	sets.Enmity = {
		ammo="Sapience Orb",
		head="Nyame Helm",
		body="Passion Jacket",
		hands="Horos Bangles +3",
		legs="Zoar Subligar +1",
		feet="Gleti's Boots",
		neck="Unmoving Collar +1",
		waist="Flume Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Friomisi Earring",
		left_ring="Murky Ring",
		right_ring="Vengeful Ring",
		back="Solemnity Cape",
	}
		
    sets.precast.JA.Provoke = sets.Enmity
	
-- ### Fast cast gear ###
	sets.precast.FC = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Nyame Flanchard",
		feet="Macu. Toe Sh. +3",
		neck="Voltsurge Torque",
		waist="Null Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Murky Ring",
		right_ring="Rahab Ring",
		back="Solemnity Cape",
	}
	
  -- Fast cast gear for specific spells
    -- Utsusemi
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket",	neck="Magoraga Beads"})

-- ### Precast sets to enhance JAs ###
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}
  
  
-- ### Waltz sets ###
    sets.precast.Waltz = { 
		ammo="Staunch Tathlum +1",
		head="Horos Tiara +3",
		body="Maxixi Casaque +2",
		hands="Regal Gloves",
		legs="Dashing Subligar",
		feet="Maxixi Toe Shoes +2",
		neck="Unmoving Collar +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Solemnity Cape", 
	}

	sets.precast.Waltz['Healing Waltz'] = set_combine(sets.precast.Waltz, {})
  	
	sets.Self_Waltz = {head="Mummu Bonnet +2"}
        
  
-- ### Samba duration set ###
    sets.precast.Samba = {
		head="Maxixi Tiara +2", 
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15'}}, 
	}

-- ### Jig duration set ###
    sets.precast.Jig = { 
		legs="Horos Tights +3", 
		feet="Maxixi Toe Shoes +2",
	}

-- ### Step sets ###
    sets.precast.Step = { 
		ammo="Yamarang",
		head="Maxixi Tiara +2",
		body="Macu. Casaque +3",
		hands="Maxixi Bangles +2",
		legs="Maculele Tights +3",
		feet="Horos T. Shoes +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back="Null Shawl",
	}

-- ### Flourish I sets ###
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
	sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {})
	sets.precast.Flourish1['Violent Flourish'] = {
		ammo="Yamarang",
		head="Maculele Tiara +3",
		body="Macu. Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		feet="Macu. Toe Sh. +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	}

-- ### Flourish II sets ###
    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Macu. Bangles +3",	back="Toetapper Mantle"}

-- ### Flourish III sets ###
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +3"}
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +3"}
 	
-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast recast sets ###
    sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Nyame Flanchard",
		feet="Macu. Toe Sh. +3",
		neck="Voltsurge Torque",
		waist="Null Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Murky Ring",
		right_ring="Rahab Ring",
		back="Solemnity Cape",
	}
        
  -- Fast Recast for Specific spells
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

-- ### Enhancing Magic ###
	-- Phalanx received
	sets.Phalanx_Received = { --Phalanx +13
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
	}
	
-- ### Healing Magic ###
  -- Cure potency received
	sets.Cure_Received = {waist="Gishdubar Sash"}
  

---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm", --(Null Masque)
		body="Nyame Mail", 
		hands="Nyame Gauntlets",
		legs="Turms Subligar",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Murky Ring",
		right_ring="Chirich Ring +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}, --(FC/Regen Cape)
	}
	
  -- Regain set
	sets.idle.Regain = set_combine(sets.idle, {
		head="Gleti's Mask", --(Null Masque)
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
	})
  
  -- Regen set
	sets.idle.Regen = set_combine(sets.idle, { 
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		feet="Meg. Jam. +2",
		left_ring="Chirich Ring +1",
	})
	
  -- Refresh
	sets.idle.Refresh = set_combine(sets.idle, {neck="Sibyl Scarf"})
	
-- ### Resting set ###
	sets.resting = {
		ammo="Staunch Tathlum +1",
		head="Meghanada Visor +2", --(Null Masque)
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Turms Subligar",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}, --(FC/Regen Cape)
	}
	
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
		waist="Flume Belt +1",
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
	})

  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, { --Resist all +71, [Charm] +95, [Death] +81
		ammo="Yamarang",
		neck="Warder's Charm +1", --(Moonlight Necklace)
		waist="Null Belt",
		right_ear="Eabani Earring",
		right_ring="Vengeful Ring",
		back="Null Shawl",
	})

-- ## Misc. Defense Sets ##
    sets.Kiting = {right_ring="Shneddick Ring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
	sets.engaged = { -- Acc 1395, DA +22, TA +6, Store TP +86, DT -31
		ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Dedition Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back="Null Shawl",
	}
	
  -- Accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, {
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
	})
	
  -- Full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
		ammo="Yamarang",
		head="Maculele Tiara +3",
		body="Macu. Casaque +3",
		hands="Macu. Bangles +3",
		legs="Maculele Tights +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})

-- ## Hybrid DT set ##
	sets.engaged.DT = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Moonlight Ring",
		right_ring="Gere Ring",
		back="Null Shawl",
	}
	
	sets.engaged.DT.Acc = set_combine(sets.engaged.DT, {waist="Kentarch Belt +1", left_ear="Telos Earring"})
	sets.engaged.DT.FullAcc = set_combine(sets.engaged.DT.Acc, {
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		right_ring="Cacoethic Ring +1",
		back="Null Shawl",
	})
	
-- ## Hoxne Ampulla set ##
	sets.engaged.Hoxne = {
		ammo="Hoxne Ampulla",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Sweordfaetels +1",
		left_ear="Dedition Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},
	}
	
	sets.engaged.Hoxne.Acc = set_combine(sets.engaged.Hoxne, {waist="Null Belt", left_ear="Telos Earring"})
	sets.engaged.Hoxne.FullAcc = set_combine(sets.engaged.Hoxne.Acc, {
		right_ring="Cacoethic Ring +1",
		back="Null Shawl",
	})
	
-- ### Misc. engaged sets, applied on top of engaged sets ###
	sets.DWMid = {waist="Reiki Yotai", right_ear="Eabani Earring"}
	sets.DWMax = {
		head="Maxixi Tiara +2",
		body="Macu. Casaque +3",
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
	}
	
	sets.SubtleBlow = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Macu. Casaque +3",
		neck="Bathy Choker +1",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	}


-------------------------------------------------------------------------------------------------------------------
-- Weapon & Weaponskill Sets
---------------------------------------------------------------------------------------------------------------
-- ### Base weapon sets ###
	sets.weapons.Aeneas = {main="Aeneas", sub="Centovente"} --(Twashtar)
	sets.weapons.AeneasGleti = {main="Aeneas", sub="Gleti's Knife"}
	sets.weapons.Tauret = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Mpu = {main="Mpu Gandring", sub="Centovente"}
	sets.weapons.Karambit = {main="Karambit", sub=empty}
	sets.weapons.None = {main=empty, sub=empty}


-- ### Default weaponskill set (DEX/WSD) ###
    sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Horos Tights +3",
		feet="Nyame Sollerets",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Moonshade Earring",
		right_ear={ name="Macu. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {waist="Null Belt", left_ear="Telos Earring"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		legs="Maculele Tights +3",
	})
	
	sets.precast.WS.Hoxne = set_combine(sets.precast.WS, {ammo="Hoxne Earring"})
	sets.precast.WS.Hoxne.Acc = set_combine(sets.precast.WS.Hoxne, {waist="Null Belt", left_ear="Telos Earring"})
	sets.precast.WS.Hoxne.FullAcc = set_combine(sets.precast.WS.Hoxne, {})
	sets.precast.WS.Hoxne.PDL = set_combine(sets.precast.WS.Hoxne, {body="Gleti's Cuirass",	legs="Maculele Tights +3"})
	sets.precast.WS.DT = set_combine(sets.precast.WS, {head="Nyame Helm", left_ring="Murky Ring"})
	sets.precast.WS.DT.Acc = set_combine(sets.precast.WS.DT, {waist="Null Belt", left_ear="Telos Earring"})
	sets.precast.WS.DT.FullAcc = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS.DT.PDL = set_combine(sets.precast.WS.DT, {
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
		back={ name="Senuna's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+1','Weapon skill damage +10%',}}, --(Senuna's Mantle: INT +30, MAcc/MDmg +20, WSD +10, DT -5)
	})
	
  -- Evisceration (DEX/Crit)
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Charis Feather",
		head="Blistering Sallet +1",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].Hoxne = set_combine(sets.precast.WS.Hoxne, sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].Hoxne.Acc = set_combine(sets.precast.WS.Hoxne.Acc, sets.precast.WS['Evisceration'].Hoxne, {})
	sets.precast.WS['Evisceration'].Hoxne.FullAcc = set_combine(sets.precast.WS.Hoxne.FullAcc, sets.precast.WS['Evisceration'].Hoxne, {})
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS.Hoxne.PDL, sets.precast.WS['Evisceration'].Hoxne, {})
	sets.precast.WS['Evisceration'].DT = set_combine(sets.precast.WS.DT, sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].DT.Acc = set_combine(sets.precast.WS.DT.Acc, sets.precast.WS['Evisceration'].DT,  {})
	sets.precast.WS['Evisceration'].DT.FullAcc = set_combine(sets.precast.WS.DT.FullAcc, sets.precast.WS['Evisceration'].DT, {})
	sets.precast.WS['Evisceration'].DT.PDL = set_combine(sets.precast.WS.DT.PDL, sets.precast.WS['Evisceration'].DT, {})
	
  -- Exenterator (AGI/DA)
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		body="Gleti's Cuirass",
		hands="Maxixi Bangles +2",
		legs="Maculele Tights +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		left_ring="Gere Ring",
		back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Senuna's Mantle: AGI +30, Acc/Atk +20, Crit rate +10%, DT -5)
	})
	
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].Hoxne = set_combine(sets.precast.WS.Hoxne, sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].Hoxne.Acc = set_combine(sets.precast.WS.Hoxne.Acc, sets.precast.WS['Exenterator'].Hoxne, {})
	sets.precast.WS['Exenterator'].Hoxne.FullAcc = set_combine(sets.precast.WS.Hoxne.FullAcc, sets.precast.WS['Exenterator'].Hoxne, {})
	sets.precast.WS['Exenterator'].PDL = set_combine(sets.precast.WS.Hoxne.PDL, sets.precast.WS['Exenterator'].Hoxne, {})
	sets.precast.WS['Exenterator'].DT = set_combine(sets.precast.WS.DT, {})
    sets.precast.WS['Exenterator'].DT.Acc = set_combine(sets.precast.WS.DT.Acc, sets.precast.WS['Exenterator'].DT,  {})
	sets.precast.WS['Exenterator'].DT.FullAcc = set_combine(sets.precast.WS.DT.FullAcc, sets.precast.WS['Exenterator'].DT, {})
	sets.precast.WS['Exenterator'].DT.PDL = set_combine(sets.precast.WS.DT.PDL, sets.precast.WS['Exenterator'].DT, {})
	
  -- Pyrrhic Kleos sets

  -- Rudra's Storm (DEX/WSD, uses the default WS set as base)
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].Hoxne = set_combine(sets.precast.WS.Hoxne, sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].Hoxne.Acc = set_combine(sets.precast.WS.Hoxne.Acc, sets.precast.WS["Rudra's Storm"].Hoxne, {})
	sets.precast.WS["Rudra's Storm"].Hoxne.FullAcc = set_combine(sets.precast.WS.Hoxne.FullAcc, sets.precast.WS["Rudra's Storm"].Hoxne, {})
	sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS.Hoxne.PDL, sets.precast.WS["Rudra's Storm"].Hoxne, {})
	sets.precast.WS["Rudra's Storm"].DT = set_combine(sets.precast.WS.DT, sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].DT.Acc = set_combine(sets.precast.WS.DT.Acc, sets.precast.WS["Rudra's Storm"].DT,  {})
	sets.precast.WS["Rudra's Storm"].DT.FullAcc = set_combine(sets.precast.WS.DT.FullAcc, sets.precast.WS["Rudra's Storm"].DT, {})
	sets.precast.WS["Rudra's Storm"].DT.PDL = set_combine(sets.precast.WS.DT.PDL, sets.precast.WS["Rudra's Storm"].DT, {})

  -- Ruthless Stroke (DEX/AGI/WSD)
	sets.precast.WS['Ruthless Stroke'] = set_combine(sets.precast.WS, {
		legs="Nyame Flanchard",
		waist="Sailfi Belt +1",
		back="Alabaster Mantle", --(Aug to R30)
	})
	
    sets.precast.WS['Ruthless Stroke'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].Hoxne = set_combine(sets.precast.WS.Hoxne, sets.precast.WS['Ruthless Stroke'], {})
    sets.precast.WS['Ruthless Stroke'].Hoxne.Acc = set_combine(sets.precast.WS.Hoxne.Acc, sets.precast.WS['Ruthless Stroke'].Hoxne, {})
	sets.precast.WS['Ruthless Stroke'].Hoxne.FullAcc = set_combine(sets.precast.WS.Hoxne.FullAcc, sets.precast.WS['Ruthless Stroke'].Hoxne, {})
	sets.precast.WS['Ruthless Stroke'].PDL = set_combine(sets.precast.WS.Hoxne.PDL, sets.precast.WS['Ruthless Stroke'].Hoxne, {})
	sets.precast.WS['Ruthless Stroke'].DT = set_combine(sets.precast.WS.DT, sets.precast.WS['Ruthless Stroke'], {})
    sets.precast.WS['Ruthless Stroke'].DT.Acc = set_combine(sets.precast.WS.DT.Acc, sets.precast.WS['Ruthless Stroke'].DT,  {})
	sets.precast.WS['Ruthless Stroke'].DT.FullAcc = set_combine(sets.precast.WS.DT.FullAcc, sets.precast.WS['Ruthless Stroke'].DT, {})
	sets.precast.WS['Ruthless Stroke'].DT.PDL = set_combine(sets.precast.WS.DT.PDL, sets.precast.WS['Ruthless Stroke'].DT, {})
  
  -- Shark Bite (DEX/AGI/WSD)
    sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS, {
		--ammo="Cait Palug Stone",
		legs="Nyame Flanchard",
		waist="Sailfi Belt +1",
		back="Alabaster Mantle", --(Aug to R30)
	})
	
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Shark Bite'], {})
	sets.precast.WS['Shark Bite'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Shark Bite'], {})
	sets.precast.WS['Shark Bite'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Shark Bite'], {})
	sets.precast.WS['Shark Bite'].Hoxne = set_combine(sets.precast.WS.Hoxne, sets.precast.WS['Shark Bite'],  {})
    sets.precast.WS['Shark Bite'].Hoxne.Acc = set_combine(sets.precast.WS.Hoxne.Acc, sets.precast.WS['Shark Bite'].Hoxne, {})
	sets.precast.WS['Shark Bite'].Hoxne.FullAcc = set_combine(sets.precast.WS.Hoxne.FullAcc, sets.precast.WS['Shark Bite'].Hoxne, {})
	sets.precast.WS['Shark Bite'].PDL = set_combine(sets.precast.WS.Hoxne.PDL, sets.precast.WS['Shark Bite'].Hoxne, {})
	sets.precast.WS['Shark Bite'].DT = set_combine(sets.precast.WS.DT, sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].DT.Acc = set_combine(sets.precast.WS.DT.Acc, sets.precast.WS['Shark Bite'].DT,  {})
	sets.precast.WS['Shark Bite'].DT.FullAcc = set_combine(sets.precast.WS.DT.FullAcc, sets.precast.WS['Shark Bite'].DT, {})
	sets.precast.WS['Shark Bite'].DT.PDL = set_combine(sets.precast.WS.DT.PDL, sets.precast.WS['Shark Bite'].DT, {})
	
-- ### Miscellaneous WS swaps ###
  -- Swaps when WS at 3000 tp
	sets.MaxTP = {left_ear="Sherida Earring", right_ear="Ishvara Earring"}
	sets.AccMaxTP = {left_ear="Sherida Earring", right_ear="Mache Earring +1",}
	
  -- Skillchain bonus swaps
    sets.Skillchain = {hands="Macu. Bangles +3"}


---------------------------------------------------------------------------------------------------------------
-- Miscellaneous sets
---------------------------------------------------------------------------------------------------------------
-- Gear that needs to be worn when a buff is active.
    sets.buff['Saber Dance'] = {legs="Horos Tights +3"} --(Upgrade to +4)
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +3", body="Meg. Cuirie +2"}
	
-- Treasure Hunter gear
	sets.TreasureHunter = {
		body="Volte Jupon",
		right_ring="Hoxne Ring",
	}

-- Vs. Debuff sets
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		--right_ring="Purity Ring",
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