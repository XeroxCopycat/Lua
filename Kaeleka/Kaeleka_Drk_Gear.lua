function character_user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.HybridMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
	state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
	state.Weapons:options('Montante','Anguta')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}
	state.DrainSwapWeaponMode = M{'Always','Never','300','1000'}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
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
-- ### Enmity sets ###
	sets.precast.Enmity = { --DT -25 [PDT -35], Enmity +47
		ammo="Sapience Orb", --Enmity +2
		head="Loess Barbuta +1", --DT -10, Enmity +9~14 (Aug. to R15)
		body="Shab. Cuirass +1", --Enmity +6
		hands="Macabre Gaunt. +1", --Enmity +7 (Aug. to R15)
		legs="Zoar Subligar +1", --Enmity +6 
		feet="Nyame Sollerets", --DT -7 (Eschite Greaves, Path C: Aug. to R15)
		neck="Unmoving Collar +1", --Enmity +10
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", -- (Cryptic Earring)
		left_ring="Petrov Ring", --Enmity +4
		right_ring="Vengeful Ring", --Enmity +3
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Ankou's Mantle: VIT +30, Eva/MEva +20, Enmity +10, PDT -10)
	}

-- ### Fast cast sets for spells ###
	sets.precast.FC = { --DT -12/50 [PDT -22], FC +68/80
		ammo="Sapience Orb", --FC +2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Sakpata's Cuisses", --DT -9
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Voltsurge Torque", --FC +4 
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Malignance Earring", --FC +4
		right_ear="Loquac. Earring", --FC +2
		left_ring="Kishar Ring", --FC +4
		right_ring="Rahab Ring", --FC +2
		back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --FC +10
	}
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})

-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Diabolic Eye'] = {hands="Fall. Fin. Gaunt. +3"} --(Upgrade to +4)
	sets.precast.JA['Arcane Circle'] = {feet="Ig. Sollerets +2"} --(Upgrade to +3)
	sets.precast.JA['Souleater'] = {head="Ig. Burgeonet +2"} --(Upgrade to +3) 
	sets.precast.JA['Weapon Bash'] = {hands="Ig. Gauntlets +2"} --(Upgrade to +3)
	sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +3"} --(Upgrade to +4)
	sets.precast.JA['Blood Weapon'] = {body="Fall. Cuirass +3"} --(Upgrade to +4)
	sets.precast.JA['Dark Seal'] = {head="Fall. Burgeonet +3"} --(Upgrade to +4)
	sets.precast.JA['Last Resort'] = {feet="Fall. Sollerets +3"} --(Upgrade to +4)  
	
-- ### /DNC Step and Waltz sets ###
  -- Flourish sets
	sets.precast.Flourish1 = sets.Enmity, sets.TreasureHunter
  
  -- Step set (acc)
	sets.precast.Step = { --Base Acc 1415
		ammo="Seeth. Bomblet +1",
		head="Heath. Bur. +3",
		body="Heath. Cuirass +3",
		hands="Heath. Gauntlets +3",
		legs="Heath. Flanchard +3",
		feet="Heath. Sollerets +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
		left_ring="Moonlight Ring",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
  -- Waltz set (CHA and VIT)
	sets.precast.Waltz = {
		ammo="Iron Gobbet",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Sakpata's Gauntlets",
		legs="Dashing Subligar",
		feet="Heath. Sollerets +3",
		neck="Unmoving Collar +1",
		waist="Flume Belt +1",
		left_ear="Handler's Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.precast.Waltz['Healing Waltz'] = {}

	
------------------------------------------------------------------------------------------------------------------- 
-- MIDCAST SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Fast Recast ###
	sets.midcast.FastRecast = sets.precast.FC
	
-- ### Dark Magic ###	
	sets.midcast['Dark Magic'] = {
		ammo="Sapience Orb",
		head="Pixie Hairpin +1",
		body={ name="Carm. Sc. Mail +1", augments={'MP+80','INT+12','MND+12',}},
		hands="Fall. Fin. Gaunt. +3",
		legs="Fall. Flanchard +3",
		feet="Nyame Sollerets",
		neck="Erra Pendant",
		waist="Null Belt",
		left_ear="Malignance Earring", --(Mani Earring)
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Niht Mantle", augments={'Attack+5','Dark magic skill +8','"Drain" and "Aspir" potency +25',}},
	}

	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
		ammo="Pemphredo Tathlum",
		head="Ig. Burgeonet +2", --(Upgrade to +4)
		hands="Fall. Fin. Gaunt. +3", --(Pavor Gauntlets)
		legs="Heath. Flanchard +3", 
		feet="Nyame Sollerets", --(Rat. Sollerets +1)
		left_ring="Kishar Ring", 
		right_ring="Metamor. Ring +1", --(Stikini Ring +1)
		back="Chuparrosa Mantle",
	})
	
	sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
		head="Fall. Burgeonet +3", --(Upgrade to +4)
		legs="Heath. Flanchard +3",
		feet="Heath. Sollerets +3",
		waist="Orpheus's Sash",
	})
	
	sets.midcast.Drain = sets.midcast.Aspir
	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, {
		legs="Heath. Flanchard +3",
		waist="Null Belt",
	}
	
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
		head="Hjarrandi Helm", --(Ratri Sallet +1)
		body="Heath. Cuirass +3", 
		hands="Sakpata's Gauntlets", --(Ratri Gadlings +1)
		legs="Sakpata's Cuisses", --(Ratri Cuisses +1)
		feet="Nyame Sollerets", --(Ratri Sollerets +1)
		neck="Unmoving Collar +1", 
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring", --(Tuisto Earring)
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Gelatinous Ring +1", --(Aug. to R15)
		back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --(Moonlight Cape)
	})	
	
	--sets.AbsorbWeapon = {main="Liberator",sub="Khonsu",range="Ullr",ammo=empty}
	sets.DrainWeapon = {}
	--sets.DreadWeapon = {main="Crepuscular Scythe",sub="Utu Grip",} 
	
	
-- ### Elemental Magic ###
	sets.midcast['Elemental Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		body="Fall. Cuirass +3",
		hands="Fall. Fin. Gaunt. +3",
		legs="Nyame Flanchard",
		feet="Heath. Sollerets +3",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Kishar Ring", --(Stikini Ring +1)
		right_ring="Metamor. Ring +1",
		back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast['Impact'] = set_combine(sets.midcast['Elemental Magic'], {
		--range="Ullr",
		head=empty
		body="Crepuscular Cloak",
		hands="Heath. Gauntlets +3",
		legs="Heath. Flanchard +3",
		neck="Erra Pendant",
		waist="Null Belt",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
	})
	
-- ### Enfeebling Magic ###
	sets.midcast['Enfeebling Magic'] = {}
	
-- ### Enhancing Magic ###
	sets.midcast['Enhancing MAgic'] = {}
	
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
	sets.Phalanx_Received = {legs="Sakpata's Cuisses"} -- Phalanx +5

-- ### Healing Magic ###
	sets.midcast['Healing Magic'] = {}
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	
-------------------------------------------------------------------------------------------------------------------
-- IDLE & RESTING SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Idle sets ###
	sets.idle = { --DT -50/50, Regen +17
		ammo="Staunch Tathlum +1", --DT -3
		head="Sakpata's Helm", --DT -7 (Null Masque)
		body="Sacro Breastplate", --Regen +13
		hands="Nyame Gauntlets", --DT -7 (Aug. to R30)
		legs="Sakpata's Cuisses", --DT -9 (Aug. to R30)
		feet="Nyame Sollerets", --DT -7 (Aug. to R30)
		neck="Loricate Torque +1", --DT -6
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Ankou's Mantle: VIT +30, Eva/MEva +20, FC +10, Regen +5) 
	}
	
	sets.idle.Regain = set_combine(sets.idle, {})
	
	sets.idle.Refresh = set_combine(sets.idle, { --Regen +3, Refresh +4~6
		head=empty,
		body="Lugra Cloak +1", --Regen +3, Refresh +3
		--legs="Carmine Cuisses +1", --Mv. Speed +18%
		neck="Vim Torque +1", --Refresh +1~3
		waist="Flume Belt +1", --PDT -4, Convert 2% of damage to MP
		--right_ring="Stikini Ring +1"
	})
	
	sets.idle.Regen = set_combine(sets.idle, { --DT -12 [PDT -32/MDT -25], Regen +28, Mv. Speed +18%
		ammo="Staunch Tathlum +1", --DT -3
		head="Volte Salade", --PDT -3/MDT -7, Regen +2 (Null Masque)
		body="Sacro Breastplate", --Regen +13
		hands="Volte Moufles", --PDT -6/MDT -4, Regen +2
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}, --Mv. Speed +18%
		neck="Bathy Choker +1", --Regen +3
		left_ring="Chirich Ring +1", --Regen +2
		right_ring="Chirich Ring +1", --Regen +2
	})
	
	sets.idle.Weak = set_combine(sets.idle, {})
		
	sets.idle.Reraise = set_combine(sets.idle, {})
	
-- Resting sets
	 sets.resting = sets.idle.regen	
	
-------------------------------------------------------------------------------------------------------------------
-- DEFENSE SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Defense sets ###
	sets.defense.PDT = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Brutal Earring",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ring="Moonlight Ring",
		right_ring="Archon Ring",
	})
	
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Vengeful Ring",
		back="Null Shawl",
	})
	 
-- ### Misc. defensive sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}
	sets.passive.Reraise = {}
	

-------------------------------------------------------------------------------------------------------------------
-- ENGAGED SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged sets ###
	sets.engaged = { --DT -35 [PDT -45], DA +43, TA +2, QA +3, Store TP +58
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Hjarrandi Helm", --DT -10, DA +6, Store TP +7
		body="Hjarrandi Breast.", --DT -12, Store TP +10 
		hands="Sakpata's Gauntlets", --DT -8, DA +6, Store TP +4
		legs="Ig. Flanchard +2", --DA +5 (Upgrade to +4)
		feet="Flam. Gambieras +2", --DA +6, Store TP +6
		neck="Vim Torque +1", --Latent: Regain +20, Store TP +10
		waist="Sailfi Belt +1", --DA +5, TA +2
		left_ear="Telos Earring", --DA +1, Store TP +5
		right_ear="Dedition Earring", --Store TP +8
		left_ring="Moonlight Ring", --DT -5, Store TP +5
		right_ring="Niqmaddu Ring", --QA +3
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --DA +10
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		waist="Ioskeha Belt +1",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
	sets.engaged.FullAcc = set_combine(sets.engaged, { --Base Acc 1438
		ammo="Seeth. Bomblet +1",
		head="Heath. Bur. +3",
		body="Heath. Cuirass +3",
		hands="Gazu Braclets +1",
		legs="Heath. Flanchard +3",
		feet="Heath. Sollerets +3",
		neck="Null Loop",
		waist="Ioskeha Belt +1",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Weapon skill damage +3%',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
	sets.engaged.Fodder = {
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		left_ring="Chirich Ring +1",
	}
	
	sets.engaged.Hoxne = { --DT -23, TA +5, QA +3, Store TP +76
		ammo="Hoxne Ampulla",
		head="Flam. Zucchetto +2", --TA +5, Store TP +6
		body="Hjarrandi Breast.", --DT -10, Store TP +10
		hands="Sakpata's Gauntlets", --DT -8, Store TP +4
		legs="Flamma Dirs +2", --Store TP +9
		feet="Flam. Gambieras +2", --Store TP +6
		neck="Vim Torque +1", --Latent: Regain +20, Store TP +10
		waist="Sweordfaetels +1", --Store TP +6
		left_ear="Dedition Earring", --Store TP +8
		right_ear="Telos Earring", --Store TP +5
		left_ring="Moonlight Ring", --DA -5, Store TP +5
		right_ring="Niqmaddu Ring", --QA +3
		back="Null Shawl", --Store TP +7, (Ankou's Mantle: DEX +30, Acc/Atk +20, Store TP +10, PDT -10)
	}

-------------------------------------------------------------------------------------------------------------------
-- WEAPON SETS
-------------------------------------------------------------------------------------------------------------------
-- Weapons sets
	sets.weapons.Savage = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.Torcleaver = {main="Caladbolg", sub="Utu Grip"}
	sets.weapons.Resolution = {main="Agwu's Greatsword", sub="Utu Grip"}
	sets.weapons.Entropy = {main="Crepuscular Scythe", sub="Utu Grip"}
	sets.weapons.Judgement = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	
-------------------------------------------------------------------------------------------------------------------
-- WEAPONSKILL SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill sets ###
	sets.precast.WS = {}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Hoxne = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {})

-- ### Specific weaponskill sets ### 
  -- Club
	-- Judgement
	sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS['Judgement'], sets.precast.WS.Acc, {})
	sets.precast.WS['Judgement'].FullAcc = set_combine(sets.precast.WS['Judgement'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Judgement'].Hoxne = set_combine(sets.precast.WS['Judgement'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Judgement'].PDL = set_combine(sets.precast.WS['Judgement'], sets.precast.WS.PDL {})

  -- Greataxe
    -- Armor Break
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Armor Break'].Acc = set_combine(sets.precast.WS['Armor Break'], sets.precast.WS.Acc, {})
	sets.precast.WS['Armor Break'].FullAcc = set_combine(sets.precast.WS['Armor Break'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Armor Break'].Hoxne = set_combine(sets.precast.WS['Armor Break'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Armor Break'].PDL = set_combine(sets.precast.WS['Armor Break'], sets.precast.WS.PDL {})
	
	-- Fell Cleave
	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS['Fell Cleave'], sets.precast.WS.Acc, {})
	sets.precast.WS['Fell Cleave'].FullAcc = set_combine(sets.precast.WS['Fell Cleave'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Fell Cleave'].Hoxne = set_combine(sets.precast.WS['Fell Cleave'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Fell Cleave'].PDL = set_combine(sets.precast.WS['Fell Cleave'], sets.precast.WS.PDL {})
	
	-- Full Break
	sets.precast.WS['Full Break'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Full Break'].Acc = set_combine(sets.precast.WS['Full Break'], sets.precast.WS.Acc, {})
	sets.precast.WS['Full Break'].FullAcc = set_combine(sets.precast.WS['Full Break'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Full Break'].Hoxne = set_combine(sets.precast.WS['Full Break'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Full Break'].PDL = set_combine(sets.precast.WS['Full Break'], sets.precast.WS.PDL {})
	
	-- Steel Cyclone
	sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Steel Cyclone'].Acc = set_combine(sets.precast.WS['Steel Cyclone'], sets.precast.WS.Acc, {})
	sets.precast.WS['Steel Cyclone'].FullAcc = set_combine(sets.precast.WS['Steel Cyclone'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Steel Cyclone'].Hoxne = set_combine(sets.precast.WS['Steel Cyclone'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Steel Cyclone'].PDL = set_combine(sets.precast.WS['Steel Cyclone'], sets.precast.WS.PDL {})
	
	-- Upheaval
	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS['Upheaval'], sets.precast.WS.Acc, {})
	sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS['Upheaval'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Upheaval'].Hoxne = set_combine(sets.precast.WS['Upheaval'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Upheaval'].PDL = set_combine(sets.precast.WS['Upheaval'], sets.precast.WS.PDL {})
  
  -- Greatsword
	-- Resolution
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], sets.precast.WS.Acc, {})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Resolution'].Hoxne = set_combine(sets.precast.WS['Resolution'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Resolution'].PDL = set_combine(sets.precast.WS['Resolution'], sets.precast.WS.PDL {})
	
	-- Torcleaver
	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], sets.precast.WS.Acc, {})
	sets.precast.WS['Torcleaver'].FullAcc = set_combine(sets.precast.WS['Torcleaver'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Torcleaver'].Hoxne = set_combine(sets.precast.WS['Torcleaver'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Torcleaver'].PDL = set_combine(sets.precast.WS['Torcleaver'], sets.precast.WS.PDL {})

  -- Scythe
    -- Catastrophe
	sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS['Catastrophe'], sets.precast.WS.Acc, {})
	sets.precast.WS['Catastrophe'].FullAcc = set_combine(sets.precast.WS['Catastrophe'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Catastrophe'].Hoxne = set_combine(sets.precast.WS['Catastrophe'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Catastrophe'].PDL = set_combine(sets.precast.WS['Catastrophe'], sets.precast.WS.PDL {})
	
	-- Entropy
	sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'], sets.precast.WS.Acc, {})
	sets.precast.WS['Entropy'].FullAcc = set_combine(sets.precast.WS['Entropy'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Entropy'].Hoxne = set_combine(sets.precast.WS['Entropy'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Entropy'].PDL = set_combine(sets.precast.WS['Entropy'], sets.precast.WS.PDL {})
	
  -- Sword
	-- Sanguine Blade
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {}
	sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc, {})
	sets.precast.WS['Sanguine Blade'].FullAcc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Sanguine Blade'].Hoxne = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Sanguine Blade'].PDL = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.PDL {})
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Heath. Sollerets +3",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring", --(Hoxne Earring, MR 7+)
		left_ring="Regal Ring",
		right_ring="Cornelia's Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].Hoxne = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.Hoxne, {ammo="Hoxne Ampulla"})
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.PDL {
		ammo="Crepuscular Pebble",
		head="Heath. Bur. +3",
		left_ring="Sroda Ring",
	})
	

-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}

-------------------------------------------------------------------------------------------------------------------
-- MISCELANEOUS SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Gear to equip when a specific buff is applied ###
	sets.buff['Dark Seal'] = {head="Fallen's Burgeonet +3"} --(Upgrade to +4)
	sets.buff.Souleater = {head="Ig. Burgeonet +2"} --(Upgrade to +4)
	
-- ### Gear to equip when specific debuffs are applied ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
-- ### Treasure Hunter gear ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		body="Volte Jupon",
		hands="Volte Bracers",
		waist="Chaac Belt",
	})
	
	end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'SAM' then
		set_macro_page(1, 8)
	elseif player.sub_job == 'WAR' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'DNC' then
		set_macro_page(3, 8)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 8)
	else
		set_macro_page(4, 8)
	end
end