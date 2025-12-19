function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
	state.IdleMode:options('Normal', 'Regen')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Godhands', 'Staff', 'ProcStaff', 'ProcClub', 'Barehanded', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana')

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
-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Impatiens",
		head="Malignance Chapeau",
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

-- Precast sets to enhance JAs on use
	--sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +3"}
	sets.precast.JA['Boost'].OutOfCombat = {hands="Anchorite's Gloves +3"}
	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Anchorite's Crown +3"}
	--sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
	--sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	--sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	--sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}
	
	sets.precast.JA['Chi Blast'] = {
		head="Anch. Crown +3",
		body="Nyame Mail",
		hands="Anchorite's Gloves +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	}
	
	sets.precast.JA['Chakra'] = {
		ammo="Iron Gobbet",
		head="Anch. Crown +3",
		body="Anch. Cyclas +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		ammo="Iron Gobbet",
		head="Anch. Crown +3",
		body="Anch. Cyclas +3",
		hands="Nyame Gauntlets",
		legs="Dashing Subligar",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
		
-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

-- Step set
	sets.precast.Step = {
		ammo="Hasty Pinion +1",
		head="Blistering Sallet +1",
		body="Anch. Cyclas +3",
		hands="Gazu Bracelets +1",
		legs="Tatena. Haidate +1",
		feet="Tatena. Sune. +1",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Odr Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",}
		
-- Flourish set (used for Enmity)		
	sets.precast.Flourish1 = {
		ammo="Iron Gobbet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Murky Ring",
		right_ring="Vengeful Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- Midcast fast recast
	sets.midcast.FastRecast = {
		ammo="Impatiens",
		head="Malignance Chapeau",
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},
	}
	
-- Midcast sets for specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
       
-------------------------------------------------------------------------------------------------------------------
-- Defensive Sets
-------------------------------------------------------------------------------------------------------------------
-- Physical damage taken
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
		
-- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
		
-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Unmoving Collar +1",
		right_ear="Hearty Earring",
		left_ring="Icecrack Ring",
		right_ring="Warden's Ring",
		back="Null Shawl",
	})

-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- Base idle set
	sets.idle = {
		ammo="Eluder's Sachet",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Warden's Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
-- Regen set
	sets.idle.Regen = set_combine(sets.idle, {
		body="Hiza. Haramaki +2",
		neck="Bathy Choker +1",
		right_ear="Dawn Earring",
		right_ring="Chirich Ring +1",
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}},
	})

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- Normal melee sets
	sets.engaged = {
		ammo="Coiste Bodhar",
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Mpaca's Doublet",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Bhikku Hose +3",
		feet="Tatena. Sune. +1",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		right_ring="Niqmaddu Ring",
	})

-- Defensive melee hybrid sets
	sets.engaged.DT = {
		ammo="Coiste Bodhar",
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Mpaca's Doublet",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Bhikku Hose +3",
		feet="Tatena. Sune. +1",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		waist="Moonbow Belt",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Murky Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.FullAcc.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.SubtleBlow.DT = set_combine(sets.engaged.DT, {
		neck="Bathy Choker +1",
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
	})

-- Misc. Defensive Sets
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	--sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Impetus = {body="Bhikku Cyclas +3"}
	sets.buff.Footwork = {feet="Bhikku Gaiters +3"}
	--sets.buff.Boost = {} waist="Ask Sash"

	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	--sets.Skillchain = {legs="Ryuo Hakama"}
	

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- Default weaponskill set
	sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt",
		left_ear="Schere Earring",
		right_ear="Odr Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands="Mpaca's Gloves",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
	})

-- Specific weaponskill sets.
 -- Hand-to-Hand Weaponskills
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		waist="Fotia Belt",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Sroda Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	})
	
	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear="Moonshade Earring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	})
	
	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		left_ear="Schere Earring",
		right_ear="Moonshade Earring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	})
	
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		left_ear="Schere Earring",
		right_ear="Moonshade Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	})
	
	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		body="Bhikku Cyclas +3",
		feet="Mummu Gamash. +2",
		left_ear="Sherida Earring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	})
	
	sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt",
		left_ear="Odr Earring",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	})

 -- Staff Weaponskills
	sets.precast.WS['Cataclysm'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Metamor. Ring +1",
		back="Null Shawl",
	}
	
-- Gearswaps using WS with either Footwork and/or Impetus
	sets.buff.FootworkWS = {feet="Bhikku Gaiters +3"}
	sets.buff.ImpetusWS = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +2",
		--feet="Ken. Sune-Ate +1",
	}

-- Gear swaps using WS if at 3000 TP
	sets.MaxTP = {left_ear="Brutal Earring", right_ear="Sherida Earring",}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Telos Earring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Weapon Sets
-------------------------------------------------------------------------------------------------------------------
	sets.weapons.Godhands = {main="Godhands"}
	sets.weapons.Barehanded = {main=empty}
	sets.weapons.Staff = {main="Malignance Pole",sub="Bloodrain Strap"}
	sets.weapons.ProcStaff = {main="Terra's Staff"}
	sets.weapons.ProcClub = {main="Mafic Cudgel"}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Treasure Hunter	
	sets.TreasureHunter = {
		head="Volte Cap",
		body="Volte Jupon",
		legs="Volte Hose",	
	}
    
-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}

-- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	
-- Sleep	
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
-- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.SubtleBlow = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		waist="Moonbow Belt",
		left_ear="Sherida Earring",
		right_ring="Niqmaddu Ring",
	}
	
-- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter	
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'RUN' then
		set_macro_page(5, 2)
	else
		set_macro_page(1, 2)
	end
end