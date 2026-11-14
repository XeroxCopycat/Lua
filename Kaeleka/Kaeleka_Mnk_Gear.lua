function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc', 'PDL')
    state.HybridMode:options('Normal', 'DT', 'Hoxne')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'SubtleBlow'}
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Godhands', 'Karambit', 'Malignance', 'Fist')
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
-- ### Fast cast sets for spells (FC +44/80, DT -40) ###
	sets.precast.FC = { 
		ammo="Sapience Orb", --FC +2
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}, --FC +7
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Bhikku Hose +3", --DT -14
		feet="Bhikku Gaiters +3", --DT -10
		neck="Voltsurge Torque", --FC +4
		waist="Moonbow Belt +1", --DT -6
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring", --DT -10
		right_ring="Rahab Ring", --FC +2
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}}, --FC +10
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket", neck="Magoraga Beads"})


-- ### Precast sets to enhance JAs on use ###
	sets.precast.JA['Hundred Fists'] = {legs="Hes. Hose +3"} --(Upgrade to +4)
	sets.precast.JA['Boost'] = {hands="Anchor. Gloves +3"} --(Upgrade to +4)
	sets.precast.JA['Boost'].OutOfCombat = {hands="Anchor. Gloves +3"} --(Upgrade to +4)
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3",} --(Upgrade to +4)
	sets.precast.JA['Focus'] = {head="Anch. Crown +3"} --(Upgrade to +4)
	sets.precast.JA['Counterstance'] = {feet="Hes. Gaiters +3"} --(Upgrade to +4)
	sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters +3"}
	sets.precast.JA['Formless Strikes'] = {body="Hes. Cyclas +3"} --(Upgrade to +4)
	sets.precast.JA['Mantra'] = {feet="Hes. Gaiters +3"} --(Upgrade to +4)
	sets.precast.JA['Chi Blast'] = {head="Hes. Crown +3"} --(Upgrade to +4)
	sets.precast.JA['Chakra'] = {body="Anch. Cyclas +3", hands="Hes. Gloves +3"} --(Upgrade to +4)


-- ### Waltz set for /DNC ###
	sets.precast.Waltz = {body="Passion Jacket", legs="Dashing Subligar", feet="Rawhide Boots"} --Waltz Pot. +31%
	sets.precast.Waltz['Healing Waltz'] = {}

-- ### Step set for /DNC (Base Acc: 1480) ###
	sets.precast.Step = {
		ammo="Staunch Tathlum +1", 
		head="Bhikku Crown +3",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Bhikku Hose +3", 
		feet="Bhikku Gaiters +3",
		neck="Null Loop", 
		waist="Null Belt", 
		left_ear="Mache Earring +1",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}},
		left_ring="Cacoethic Ring +1", 
		right_ring="Chirich Ring +1", 
		back="Null Shawl",
	}
	
	
------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- Midcast fast recast
	sets.midcast.FastRecast = sets.precast.FC
	
-- Midcast sets for specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {body="Passion Jacket", neck="Magoraga Beads"})

-------------------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base idle set (Regen +26, DT -50 ###
	sets.idle = { 
		ammo="Staunch Tathlum +1", --DT -3
		head="Nyame Helm", --DT -7 (Null Masque)
		body="Hiza. Haramaki +2", --Regen +12
		hands="Nyame Gauntlets", --DT -7
		legs="Bhikku Hose +3", --DT -14
		feet="Bhikku Gaiters +3", --DT -10
		neck="Bathy Choker +1", --Regen +3
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Chirich Ring +1", --Regen +2
		back={ name="Segomo's Mantle", augments={'AGI+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','"Regen"+5',}}, --Regen +5
	}
		
  -- Refresh set
	sets.idle.Refresh = set_combine(sets.idle, {neck="Sibyl Scarf"})
	
  -- Regain set
	sets.idle.Regain = set_combine(sets.idle, {}) --Null Masque
  
  -- Regen set (Regen +28, DT -41)
	sets.idle.Regen = set_combine(sets.idle, {left_ring="Chirich Ring +1"})

  -- Resting set
	sets.Resting = set_combine(sets.idle.Regen, {})
	

-------------------------------------------------------------------------------------------------------------------
-- Defensive Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Damage taken sets ###
  -- Physical damage taken (Def: 1486, DT -50, Enemy crit. -10%)
	sets.defense.PDT = {
		ammo="Eluder's Sachet", --Enemy crit. -5%
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Null Belt", --Eva +30
		left_ear="Alabaster Earring", --DT 5
		right_ear="Eabani Earring", --Eva +15 
		left_ring="Murky Ring", --DT -10
		right_ring="Warden's Ring", --Enemy crit. -5%
		back="Null Shawl", --Eva +50
	}
		
  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1", 
		neck="Warder's Charm +1",
		right_ring="Archon Ring", 
		back="Null Shawl",
	})
		
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Hearty Earring",
		right_ring="Vengeful Ring",
		back="Null Shawl",
	})
	
-- ### Misc. defensive sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged, single wield ###
  -- Normal melee set (Base Acc: 1296, DT -25 [PDT -35], DA +17/TA +28/Store TP +56~60/Kick Atks. +65)
	sets.engaged = {
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --Store TP +12
		body="Tatena. Harama. +1", --TA +5, Store TP +5~9
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --TA +4, Store TP +7
		legs="Bhikku Hose +3", --DT -14, Store TP +10, Kick atks. +30
		feet="Tatena. Sune. +1", --TA +3, Store TP +4~8
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}}, --Kick atks. +25
		waist="Moonbow Belt +1", --DT -6, TA +8
		left_ear="Schere Earring", --DA +6
		right_ear="Sherida Earring", --DA +5, Store TP +5
		left_ring="Gere Ring", --TA +5
		right_ring="Epona's Ring", --DA +3, TA +3
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --DT -5, Store TP +10, Kick atks. +10
	}
	
  -- Normal melee set, accuracy (Base Acc: 1324, DT -20 [PDT -30], DA +19, TA +27, Store TP +48~52, Kick Atks. +55
	sets.engaged.Acc = set_combine(sets.engaged, {
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --Store TP +5
		back="Null Shawl", --DA +7, Store TP +7
	})
	
  -- Normal melee set, full accuracy (Base Acc: 1421, DT -25, DA +16, TA +8, Store TP +36
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Bhikku Crown +3", --DT -11
		hands="Bhikku Gloves +3", --Acc +62, Hand-to-Hand skill +21
		legs="Bhikku Hose +3", --DT -14, Store TP +10, Kick atks. +30
		feet="Tatena. Sune. +1", --TA +3, Store TP +4~8
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}}, --Kick atks. +25
		waist="Null Belt", --Acc +30
		left_ear="Schere Earring", --DA +6
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --Store TP +5
		left_ring="Chirich Ring +1", --Store TP +6
		right_ring="Chirich Ring +1", --Store TP +6
		back="Null Shawl", --DA +7, Store TP +7
	})
	
	
-- ## Hybrid DT sets ##
  -- Engaged, Hybrid DT normal set (Base Acc: 1329, DT -50, DA +8, TA +8, QA +3, Store TP +71) 
	sets.engaged.DT = {
		head="Malignance Chapeau", --DT -6, Store TP +8
		body="Malignance Tabard", --DT -9, Store TP +11
		hands="Malignance Gloves", --DT -5, Store TP +12
		legs="Bhikku Hose +3", --DT -14, Acc +63, Store TP +10, Kick atks. +30
		feet="Malignance Boots", --DT -4, Store TP +9
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30)
		right_ear="Dedition Earring", --Store TP +8
		left_ring="Murky Ring", --DT -10
	}
	
  -- Engaged, Hybrid DT accuracy set (Base acc: 1363, DT -50, DA +8, TA +8, QA +3, Store TP +68
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --Acc +14, Store TP +5
	})
	
  -- Engaged, Hybrid DT full accuracy set (Base acc: 1430, DT -50, DA +10, TA +8, Store TP +45 
	sets.engaged.DT.FullAcc = set_combine(sets.engaged.DT, {
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Bhikku Crown +3", --DT -11, Acc +61
		body="Malignance Tabard", --DT -9, Store TP +11
		hands="Bhikku Gloves +3", --Acc +62, Hand-to-Hand skill +21
		legs="Bhikku Hose +3", --DT -14, Acc +63, Store TP +10, Kick atks. +30
		feet="Bhikku Gaiters +3", --DT -10, Acc +60
		neck="Null Loop", --DT -5, Acc +50
		waist="Moonbow Belt +1", --DT -6, TA +8
		left_ear="Alabaster Earring", --DT -5, Acc +10
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --Acc +14, Store TP +5
		left_ring="Chirich Ring +1", --Acc +10, Store TP +6
		right_ring="Chirich Ring +1", --Acc +10, Store TP +6
		back="Null Shawl", --Acc +50, DA +7, Store TP +7
	})


-- ### Engaged, Hoxne Ampulla enabled ###
  -- Hoxne normal set (Base Acc: 1327, DT -33, TA +20, Store TP +64~72, Kick Atks. +65, Ench: DA +100
	sets.engaged.Hoxne = {
		ammo="Hoxne Ampulla", --Enchantment: 1,000 gil > DA +100
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --Store TP +12
		body="Malignance Tabard", --DT -9, Store TP +11
		hands="Tatena. Gote +1", --TA +4, Store TP +4~8
		legs="Bhikku Hose +3", --DT -14, Store TP +10, Kick Atks. +30
		feet="Tatena. Sune. +1", --TA +3, Store TP +4~8
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}}, --Kick Atks. +25
		waist="Moonbow Belt +1", --DT -6, TA +8
		left_ear="Dedition Earring", --Store TP +8
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --Store TP +5
		left_ring="Niqmaddu Ring", --QA +3
		right_ring="Gere Ring", --TA +5
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --DT -5, Store TP +10, Kick Atks. +10
	}
	
  -- Hoxne accuracy set (Base Acc: 1347, DT -33, TA +20, QA +3, Store TP +61~69, Kick Atks. +65, Ench.: DA +100
	sets.engaged.Hoxne.Acc = set_combine(sets.engaged.Hoxne, {
		left_ear="Telos Earring" --Acc +10, Store TP +5
	})
	
  -- Hoxne full accuracy set (Base Acc: 1418, DT -25, TA +16, Store TP +51~59, Kick Atks. +65, Ench.: DA +100
	sets.engaged.Hoxne.FullAcc = set_combine(sets.engaged.Hoxne, {
		head="Bhikku Crown +3", --Acc +61, DT -11
		body="Tatena. Harama. +1", --Acc +65, TA +5, Store TP +5~9
		hands="Bhikku Gloves +3", --Acc +62, Hand-to-Hand skill +21
		legs="Bhikku Hose +3", --DT -14, Store TP +10, Kick Atks. +30
		feet="Tatena. Sune. +1", --TA +3, Store TP +4~8
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}}, --Kick Atks. +25
		waist="Moonbow Belt +1", --DT -6, TA +8
		left_ear="Telos Earring", --Acc +10, Store TP +5
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}}, --Store TP +5
		left_ring="Chirich Ring +1", --Acc +10, Store TP +6
		right_ring="Chirich Ring +1", --Acc +10, Store TP +6
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --DT -5, Store TP +10, Kick Atks. +10
	})


-- ## Extra melee sets (equipped over engaged sets) ##
  -- Subtle Blow set (Subtle Blow +17, Subtle Blow II +25. Note that Monk only needs Subtle Blow +15 to cap.) 
	sets.SubtleBlow = {
		head="Bhikku Crown +3", --Subtle Blow +14
		waist="Moonbow Belt +1", --Subtle Blow II +15
		left_ear="Schere Earring", --Subtle Blow +3
		right_ear="Sherida Earring", --Subtle Blow II +5
		left_ring="Niqmaddu Ring", --Subtle Blow II +5
	}

		
-- ### Offensive buff sets (equipped when a buff is active on top of melee sets) ###
	sets.buff.Impetus = {body="Bhikku Cyclas +3"}
	sets.buff.Footwork = {feet="Bhikku Gaiters +3"}
	sets.buff.Boost = {waist="Ask Sash"}


-- ### Misc. engaged sets ### 
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	--sets.Skillchain = {legs="Ryuo Hakama"}
	

-------------------------------------------------------------------------------------------------------------------
-- Weapon & Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Weapon sets ###
	sets.weapons.Godhands = {main="Godhands"} --(Godhands, Aug. to R15)
	sets.weapons.Karambit = {main="Karambit"}
	--sets.weapons.Prime = {main="Varga Purnikawa"}
	sets.weapons.Malignance = {main="Malignance Pole", sub="Bloodrain Strap"}
	sets.weapons.Fist = {main=empty}


-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill set ###
  -- Default weaponskill set assumes STR/WSD base - Base Acc: 1219, STR +224, DT -37, DA +14, WSD +39%, PDL +13%)
	sets.precast.WS = {
		ammo="Coiste Bodhar", --DA +3
		head="Hes. Crown +3", --STR +30, WSD +10%
		body="Nyame Mail", --DT -9, STR +35, DA +3, WSD +10%
		hands="Bhikku Gloves +3", --STR +26, PDL +10%
		legs="Nyame Flanchard", --DT -8, STR +43, DA +3, WSD +9%
		feet="Bhikku Gaiters +3", --DT -10, STR +30
		neck="Fotia Gorget", --fTP bonus, Latent: WS Acc +10, WSD +10%
		waist="Fotia Belt", --fTP bonus, Latent: WS Acc +10, WSD +10%
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30)
		right_ear="Schere Earring", --STR +5, DA +5
		left_ring="Regal Ring", --STR +10
		right_ring="Sroda Ring", --STR +15, PDL +3%
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --DT -5, STR +30, WSD +10%
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble", --STR +3. PDL +3%
		feet="Nyame Sollerets", --DT -7, STR +23, DA +2, WSD +8%
	})
	
	sets.precast.WS.Hoxne = set_combine(sets.precast.WS, {ammo="Hoxne Earring"})
	sets.precast.WS.Hoxne.Acc = set_combine(sets.precast.WS.Hoxne, {})
	sets.precast.WS.Hoxne.FullAll = set_combine(sets.precast.WS.Hoxne, {})
	sets.precast.WS.Hoxne.PDL = set_combine(sets.precast.WS.Hoxne, {})
	
	sets.precast.WS.DT = set_combine(sets.precast.WS, {
		head="Nyame Helm", --DT -7, STR +26, DA +2, WSD +8%
		left_ring="Murky Ring", --DT -10 (Aug. to R30)
	})
	sets.precast.WS.DT.Acc = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS.DT.FullAcc = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS.DT.PDL = set_combine(sets.precast.WS.DT, {})

-- ### Specific weaponskill sets ###
  -- Hand-to-Hand Weaponskills
	-- Asuran Fists (Uses default WS base set. Hoxne not applied as this is a capped 8-hit WS)
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Asuran Fists'], {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Asuran Fists'], {})
	sets.precast.WS['Asuran Fists'].PDL = set_combine(sets.precast.WS.PDL, sets.precast.WS['Asuran Fists'], {})
	sets.precast.WS['Asuran Fists'].DT = set_combine(sets.precast.WS['Asuran Fists'], sets.precast.WS.DT, {})
	sets.precast.WS['Asuran Fists'].DT.Acc = set_combine(sets.precast.WS['Asuran Fists'].Acc, sets.precast.WS.DT, {})
	sets.precast.WS['Asuran Fists'].DT.FullAcc = set_combine(sets.precast.WS['Asuran Fists'].FullAcc, sets.precast.WS.DT, {})
	sets.precast.WS['Asuran Fists'].DT.PDL = set_combine(sets.precast.WS['Asuran Fists'].PDL, sets.precast.WS.DT, {})
	
	-- Dragon Kick
	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --(STR +30, Acc/Atk +20, DA +10, DT -5)
	})
	
	sets.precast.WS['Dragon Kick'].Hoxne = set_combine(sets.precast.WS['Dragon Kick'], sets.precast.WS.Hoxne)
	sets.precast.WS['Dragon Kick'].Acc = set_combine(sets.precast.WS['Dragon Kick'], sets.precast.WS.Acc)
	sets.precast.WS['Dragon Kick'].FullAcc = set_combine(sets.precast.WS['Dragon Kick'], sets.precast.WS.FullAcc)
	sets.precast.WS['Dragon Kick'].PDL = set_combine(sets.precast.WS['Dragon Kick'], sets.precast.WS.PDL, {
		ammo="Crepuscular Pebble",
		legs="Mpaca's Hose", --(Aug. to R30)
		left_ring="Sroda Ring",
	})
	
	-- Howling Fist (STR/DA: DT -34 [PDT -50]. STR +235, DA +13, TA +20, WSD +46%, TP Bonus +450)
	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap", --PDT -7, STR +33, TA +3, TP Bonus +200
		body="Nyame Mail", --DT -9, STR +35, DA +3, WSD +10%
		hands="Nyame Gauntlets", --DT -7, STR +17, DA +2, WSD +8%
		legs="Mpaca's Hose", --PDT -9, STR +49, TA +4
		feet="Nyame Sollerets", --DT -7, STR +23, DA +2, WSD +8%
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}}, --PDL +10%
		waist="Moonbow Belt +1", --DT -6, STR +20, TA +8
		left_ear="Moonshade Earring", --TP Bonus +250
		right_ear="Schere Earring", --STR +5, DA +6
		left_ring="Regal Ring", --STR +10
		right_ring="Gere Ring", --STR +10, TA +5
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --STR +30, WSD +10% (Segomo's Mantle: STR +30, Acc/Atk +20, DA +10%, DT -5%)
	})
	
	sets.precast.WS['Howling Fist'].Hoxne = set_combine(sets.precast.WS['Howling Fist'], sets.precast.WS.Hoxne)
	sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS['Howling Fist'], sets.precast.WS.Acc)
	sets.precast.WS['Howling Fist'].FullAcc = set_combine(sets.precast.WS['Howling Fist'], sets.precast.WS.FullAcc)
	sets.precast.WS['Howling Fist'].PDL = set_combine(sets.precast.WS['Howling Fist'], sets.precast.WS.PDL, {
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose", --(Aug. to R30)
	})
	
	-- Raging Fists
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(STR +30, Acc/Atk +20, DA +10, DT -5)
	})
	
	sets.precast.WS['Raging Fists'].Hoxne = set_combine(sets.precast.WS['Raging Fists'], sets.precast.WS.Hoxne)
	sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS['Raging Fists'], sets.precast.WS.Acc)
	sets.precast.WS['Raging Fists'].FullAcc = set_combine(sets.precast.WS['Raging Fists'], sets.precast.WS.FullAcc)
	sets.precast.WS['Raging Fists'].PDL = set_combine(sets.precast.WS['Raging Fists'], sets.precast.WS.PDL, {
		ammo="Crepuscular Pebble",
		legs="Mpaca's Hose", --(Aug. to R30)
	})
	
	-- Shijin Spiral
	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		neck="Fotia Gorget",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Shijin Spiral'].Hoxne = set_combine(sets.precast.WS['Shijin Spiral'], sets.precast.WS.Hoxne)
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS['Shijin Spiral'], sets.precast.WS.Acc)
	sets.precast.WS['Shijin Spiral'].FullAcc = set_combine(sets.precast.WS['Shijin Spiral'], sets.precast.WS.FullAcc)
	sets.precast.WS['Shijin Spiral'].PDL = set_combine(sets.precast.WS['Shijin Spiral'], sets.precast.WS.PDL)
	
	-- Tornado Kick
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(STR +30, Acc/Atk +20, DA +10, DT -5)
	})
	
	sets.precast.WS['Tornado Kick'].Hoxne = set_combine(sets.precast.WS['Tornado Kick'], sets.precast.WS.Hoxne)
	sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS['Tornado Kick'], sets.precast.WS.Acc)
	sets.precast.WS['Tornado Kick'].FullAcc = set_combine(sets.precast.WS['Tornado Kick'], sets.precast.WS.FullAcc)
	sets.precast.WS['Tornado Kick'].PDL = set_combine(sets.precast.WS['Tornado Kick'], sets.precast.WS.PDL, {
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose", --(Aug. to R30)
	})
	
	-- Victory Smite
	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Mpaca's Doublet", --(Aug. to R30)
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Mpaca's Hose", --(Aug. to R30)
		feet="Mummu Gamash. +2", --(Ken. Sune-Ate +1, Aug. to R15)
		neck="Fotia Gorget",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Odr Earring",
		left_ring="Sroda Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	})
	
	sets.precast.WS['Victory Smite'].Hoxne = set_combine(sets.precast.WS['Victory Smite'], sets.precast.WS.Hoxne)
	sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS['Victory Smite'], sets.precast.WS.Acc)
	sets.precast.WS['Victory Smite'].FullAcc = set_combine(sets.precast.WS['Victory Smite'], sets.precast.WS.FullAcc)
	sets.precast.WS['Victory Smite'].PDL = set_combine(sets.precast.WS['Victory Smite'], sets.precast.WS.PDL, {
		body="Ken. Samue +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, ----(STR +30, Acc/Atk +20, DA +10, DT -5)
	})

  -- Staff Weaponskills
    -- Cataclysm 
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS)
	sets.precast.WS['Cataclysm'].Hoxne = set_combine(sets.precast.WS['Cataclysm'], sets.precast.WS.Hoxne)
	sets.precast.WS['Cataclysm'].Acc = set_combine(sets.precast.WS['Cataclysm'], sets.precast.WS.Acc)
	sets.precast.WS['Cataclysm'].FullAcc = set_combine(sets.precast.WS['Cataclysm'], sets.precast.WS.FullAcc)
	sets.precast.WS['Cataclysm'].PDL = set_combine(sets.precast.WS['Cataclysm'], sets.precast.WS.PDL)

	
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
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Treasure Hunter	
	sets.TreasureHunter = {
		body="Volte Jupon",
		feet="Volte Boots",
		waist="Chaac Belt",
	}

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