-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Hoxne', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'DT', 'MEVA')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'Hoxne', 'Acc', 'FullAcc', 'PDL', 'Fodder')
	state.IdleMode:options('Normal', 'Regen', 'Refresh', 'Regain')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options( 'Rudras', 'Ruthless', 'Evisceration', 'Aeolian', 'Savage', 'None')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax', 'SubtleBlow'}
	state.AmbushMode = M(false, 'Ambush Mode')

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	send_command('bind ^q gs c weapons ProcWeapons;gs c set WeaponSkillMode proc;')
	send_command('bind !q gs c weapons SwordThrowing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind ^r gs c weapons Default;gs c set WeaponSkillMode match') --Requips weapons and gear.
	send_command('bind !r gs c weapons MagicWeapons')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

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
	sets.precast.Enmity ={ --DT -15 [PDT -25], Enmity +63
		ammo="Sapience Orb", --Enmity +2
		head="Malignance Chapeau", --DT -6
		body="Plunderer's Vest +4", --Enmity +30
		hands="Plun. Armlets +1", --Enmity +6
		legs="Zoar Subligar +1", --Enmity +6
		feet="Malignance Boots", --DT -4
		neck="Unmoving Collar +1", --Enmity +10
		waist="Carrier's Sash", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Friomisi Earring", --Enmity +2
		left_ring="Petrov Ring", --Enmity +4
		right_ring="Vengeful Ring", --Enmity +3
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --(Toutatis's Cape: AGI +30, Eva/MEva +20, Enmity +10, DT -5)
	}


-- ### Fast cast sets for spells ###
    sets.precast.FC = { --DT -10, FC +44/80
		ammo="Sapience Orb", --FC +2
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}, --FC +7 (Aug. w/ FC +6)
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Malignance Tights", --(Herc. Trousers, Aug. w/ FC +6)
		feet="Malignance Boots", --(Herc. Boots, Aug. w/ FC +6)
		neck="Voltsurge Torque", --FC +4
		waist="Carrier's Sash",
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring", --DT -10
		right_ring="Rahab Ring", --FC +2
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}}, --FC +10 (Aug. to AGI +30)
	}

  -- Fast cast for specific spells
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket", neck="Magoraga Beads"})


-- ### Precast sets to enhance JAs ###
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"} -- Upgrade to +4
    sets.precast.JA['Hide'] = {body="Pill. Vest +4"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +3"} 
    sets.precast.JA['Steal'] = {head="Plun. Bonnet +3", feet="Pillager's Poulaines +3"} --(Upgrade to +4)
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes +3", feet="Skulk. Poulaines +3"} 
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"} -- Upgrade to +4
    sets.precast.JA['Feint'] = {legs="Plun. Culottes +4"}
	sets.precast.JA['Mug'] = { 
		ammo="Aurgelmir Orb",
		head="Plun. Bonnet +3", --Mug +5 (Upgrade to +4)
		body="Skulker's Vest +3",
		hands="Skulk. Armlets +3",
		legs="Plun. Culottes +4",
		feet="Skulk. Poulaines +3",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Odr Earring",
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']
	
  -- Job abilities used to apply Treasure Hunter
	sets.precast.Step = sets.TreasureHunter	
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = set_combine(sets.precast.Enmity, sets.TreasureHunter)
	sets.precast.JA.Provoke = set_combine(sets.precast.Enmity, sets.TreasureHunter) 

	
-- ### Step and Waltz sets ###
	sets.precast.Step = { --Base Acc 1536
		ammo="Yamarang",
		head="Pill. Bonnet +4",
		body="Pill. Vest +4",
		hands="Gazu Bracelets +1", 
		legs="Skulk. Culottes +3", --(Pill. Culottes +4)
		feet="Skulk. Poulaines +3", --(Pill. Poulaines +4)
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back="Null Shawl",
	}
	
    sets.precast.Waltz = { --Waltz Potency +36
		ammo="Yamarang", --Waltz Pot. +5
		head="Plun. Bonnet +3", --(Upgrade to +4)
		body="Passion Jacket", --Waltz Pot. +13
		hands="Regal Gloves",
		legs="Dashing Subligar", --Waltz Pot. +10
		feet="Rawhide Boots", --Waltz Pot. +8
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Handler's Earring", --(Hoxne Earring, MR 6+)
		left_ring="Murky Ring", --DT -10
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --(Toutatis's Cape: CHA +30, Eva/MEva, Waltz Pot. +10, PDT -10)
	}
	
	sets.precast.Waltz['Healing Waltz'] = {}
	sets.Self_Waltz = {head="Mummu Bonnet +2"}


------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast Recast ###
	sets.midcast.FastRecast = sets.precast.FC

  -- Fast Recast sets for specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {body="Passion Jacket", neck="Magoraga Beads"})
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)


-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###
	sets.idle = { --DT -49, Regen +12
        ammo="Staunch Tathlum +1", --DT -3
		head="Malignance Chapeau", --DT -6 (Null Masque)
		body="Malignance Tabard", --DT -9
		hands="Malignance Gloves", --DT -5
		legs="Malignance Tights", --DT -7
		feet="Malignance Boots", --DT -4
		neck="Bathy Choker +1", --Regen +3
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}}, --Regen +5 (Toutatis's Cape: AGI +30, Eva/MEva +20, FC +10, Regen +5)
    }

  -- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {neck="Sibyl Scarf"})
	
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, { --DT -8 [PDT -28], Regen +30
		head="Meghanada Visor +2", --PDT -5, Set Bonus (x4): Regen +9 (Null Masque)
		body="Meg. Cuirie +2", --PDT -8
		hands="Meg. Gloves +2", --PDT -4
		legs="Turms Subligar", --Regen +7
		feet="Meg. Jam. +2", --PDT -3
		left_ring="Chirich Ring +1", --Regen +2 (Meghanda Ring)
	})
	
  -- Regain idle set
	sets.idle.Regain = set_combine(sets.idle, { --DT 18 [PDT -50/MDT -18], Regain +10, Regen +12
		head="Gleti's Mask", --PDT -6, Regain +2 (Null Masque)
		body="Gleti's Cuirass", --PDT -9, Regain +3
		hands="Gleti's Gauntlets", --PDT -7, Regain +2
		legs="Gleti's Breeches", --PDT -8, Regain +3
		feet="Gleti's Boots", --PDT -5, Regain +2
	})

  -- Weakened idle set
    sets.idle.Weak = set_combine(sets.idle, {})

	
-- ### Resting Set ###
    sets.resting = set_combine(sets.idle.Regen, {right_ring="Chirich Ring +1"})
	
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical Damage Taken ###
    sets.defense.PDT = { --DT -50, Enemy Crit. Rate -10
		ammo="Eluder's Sachet", --DT +2, Enemy Crit. Rate -5
		head="Malignance Chapeau", --DT -6
		body="Malignance Tabard", --DT -9
		hands="Malignance Gloves", --DT -5
		legs="Malignance Tights", --DT -7
		feet="Malignance Boots", --DT -4
		neck="Loricate Torque +1", --DT -6
		waist="Null Belt",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring",
		left_ring="Murky Ring", --DT -10
		right_ring="Warden's Ring", --Enemy Crit. Rate -5
		back="Null Shawl",
	}

  -- Magic Damage Taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1", --DT -3 (Vanir Battery)
		head="Nyame Helm", --DT -7, MDB +5 (Null Masque)
		body="Nyame Mail", --DT -9, MDB +8 (Adamantite Armor)
		hands="Nyame Gauntlets", --DT -7, MDB +4 (Gleti's Gauntlets, Aug. to R30)
		legs="Nyame Flanchard", --DT -8, MDB +7 (Gleti's Breeches, Aug. to R30)
		feet="Nyame Sollerets", --DT -7, MDB +5 (Gleti's Boots, Aug. to R30)
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Eabani Earring", --MEva +8 (Mujin Stud)
		right_ring="Archon Ring", --Annuls severe magic dmg. taken
	})
		
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, sets.defense.MDT, {
		ammo="Yamarang", --MEva +15
		neck="Warder's Charm +1", --(Moonlight Necklace)
		waist="Null Belt", --MEva +30
		right_ear="Eabani Earring", --MEva +8
		right_ring="Vengeful Ring", --MEva +9
		back="Null Shawl", --MEva +50
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged set ###
    sets.engaged = { --Base Acc 1375, DT -5 [PDT -23], Store TP +39, TA +35
		ammo="Aurgelmir Orb", --Store TP +4 (Aurgelmir Orb +1)
		head="Skulker's Bonnet +3", --TA +6
		body="Pill. Vest +4", --TA +7
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Store TP +7, TA +4
		legs="Gleti's Breaches", --PDT -8 (Aug. to R30)
		feet="Malignance Boots", --DT -4, Store TP +9
		neck={ name="Asn. Gorget +2", augments={'Path: A',}}, --TA +4
		waist="Reiki Yotai", --Dual Wield +7
		left_ear="Sherida Earring", --DA +5
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}}, --Store TP +4, TA +4
		left_ring="Moonlight Ring", --DT -5 Store TP +5
		right_ring="Gere Ring", --TA +5
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}, --PDT -10, Store TP +10
	}
	
  -- Hoxne Ampulla set
	sets.engaged.Hoxne = set_combine(sets.engaged, {ammo="Hoxne Ampulla"})
  
  -- Accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, {
		hands="Gazu Bracelets +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	})
	
  -- Full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, { --Base Acc 1560
		ammo="Yamarang",
		head="Pill. Bonnet +4",
		body="Pill. Vest +4",
		hands="Gazu Bracelets +1",
		legs="Pill. Culottes +3",
		feet="Pill. Poulaines +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back="Null Shawl",
	})


-- ### Hybrid DT engaged set ###
	sets.engaged.DT = {
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Alabaster Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Murky Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	
-- ### Extra melee sets, to add on top of engaged sets ### 
	sets.Ambush = {body="Plunderer's Vest +3"} -- Upgrade to +4	
	sets.DWMid = { -- Dual Wield +36
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands="Pill. Armlets +3", --DW +5
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}}, --DW +9
		waist="Reiki Yotai", --DW +7
		left_ear="Suppanomimi", --DW +5
		right_ear="Eabani Earring", --DW +4
	} 
	
	sets.DWMax = {} -- (Toutatis's Cape: DEX +30, Acc/Atk +20, Dual Wield +10, DT -5)
	sets.SubtleBlow = { --Store TP +28, Subtle Blow +50, Subtle Blow II +5, TA +4
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Subtle Blow +8, TA +4
		body="Volte Harness", --Store TP +10, Subtle Blow +10
		feet="Volte Spats", --Store TP +6, Subtle Blow +6
		left_ear="Sherida Earring", --Subtle Blow II +5
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}}, --Subtle Blow +6
		left_ring="Chirich Ring +1", --Store TP +6, Subtle Blow +10
		right_ring="Chirich Ring +1", --Store TP +6, Subtle Blow +10
	}
	
	sets.Kiting = {right_ring="Shneddick Ring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
-- ### Weapons sets ###
	sets.weapons.Aeolian = {main="Aeneas", sub="Centovente"}
	sets.weapons.Evisceration = {main="Tauret", sub="Centovente"}
	sets.weapons.Rudras = {main="Aeneas", sub="Centovente"} --(Twashtar, Aug. to R15)
	sets.weapons.Ruthless = {main="Mpu Gandring", sub="Centovente"} --(Mpu Gandring, Aug. to Stage 5)
	sets.weapons.Savage = {main="Naegling", sub="Centovente"}
	sets.weapons.None = {main=empty, sub=empty}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill set ###
	sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Pill. Bonnet +4",
		body="Skulker's Vest +3",
		hands="Nyame Gauntlets", --(Aug. to R30)
		legs="Plun. Culottes +4",
		feet="Nyame Sollerets", --(Aug. to R30)
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Odr Earring", --(Hoxne Earring, MR 6+)
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS.Hoxne = set_combine(sets.precast.WS, {ammo="Hoxne Ampulla"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets", --(Aug. to R30)
	})
	
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {})

-- ### Dagger weaponskills ###
  -- Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {})
	
  -- Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Blistering Sallet +1",
		body="Plunderer's Vest +4",
		hands="Gleti's Gauntlets", --(Aug. to R30)
		legs="Gleti's Breeches", --(Aug. to R30)
		feet="Gleti's Boots", --(Aug. to R30)
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring", --(Hoxne Earring)
		left_ring="Ilabrat Ring", --(Begrudging Ring)
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Evisceration'].Hoxne = set_combine(sets.precast.WS['Evisceration'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'], sets.precast.PDL, {
		head="Skulker's Bonnet +3",
		body="Gleti's Cuirass", --(Aug. to R30)
		left_ring="Murky Ring", --(Aug. to R30)
		right_ring="Gere Ring",
	})
	
	sets.precast.WS['Evisceration'].Proc = set_combine(sets.precast.WS['Evisceration'], sets.precast.Proc, {})
	
  -- Exenterator 
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		head="Skulker's Bonnet +3",
		hands="Skulk. Armlets +3",
		legs="Nyame Flanchard", --(Aug. to R30)
		feet="Plun. Poulaines +4",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Domin. Earring +1", --(Hoxne Earring, MR 6+)
		left_ring="Murky Ring", --(Aug. to R30)
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}}, --(Toutatis's Cape, AGI +30, Acc/Atk +20, DA +10, DT -5)
	})
	
	sets.precast.WS['Exenterator'].Hoxne = set_combine(sets.precast.WS['Exenterator'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], sets.precast.WS.Acc, {})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS['Exenterator'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Exenterator'].PDL = set_combine(sets.precast.WS['Exenterator'], sets.precast.PDL, {
		body="Gleti's Cuirass",
		legs="Gleti's Breeches",
		left_ring="Sroda Ring",
    })
	sets.precast.WS['Exenterator'].Proc = set_combine(sets.precast.WS['Exenterator'], sets.precast.Proc, {})
	
  -- Rudra's Storm (uses the default set)
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Rudra's Storm"].Hoxne = set_combine(sets.precast.WS["Rudra's Storm"], sets.precast.WS.Hoxne, {})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"], sets.precast.WS.FullAcc, {})
	sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS["Rudra's Storm"], sets.precast.PDL, {})
	sets.precast.WS["Rudra's Storm"].Proc = set_combine(sets.precast.WS["Rudra's Storm"], sets.precast.Proc, {})
	
  -- Ruthless Stroke
    sets.precast.WS['Ruthless Stroke'] = set_combine(sets.precast.WS, {waist="Sailfi Belt +1", back="Alabaster Mantle"}) --(Alabaster Mantle, Aug. to R30)
	sets.precast.WS['Ruthless Stroke'].Hoxne = set_combine(sets.precast.WS['Ruthless Stroke'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Ruthless Stroke'].Acc = set_combine(sets.precast.WS['Ruthless Stroke'], sets.precast.WS.Acc, {})
	sets.precast.WS['Ruthless Stroke'].FullAcc = set_combine(sets.precast.WS['Ruthless Stroke'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Ruthless Stroke'].PDL = set_combine(sets.precast.WS['Ruthless Stroke'], sets.precast.PDL, {waist="Kentarch Belt +1"})
	sets.precast.WS['Ruthless Stroke'].Proc = set_combine(sets.precast.WS['Ruthless Stroke'], sets.precast.Proc, {})
	
  -- Shark Bite
	sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS, {waist="Sailfi Belt +1", left_ring="Ilabrat Ring"})
	sets.precast.WS['Shark Bite'].Hoxne = set_combine(sets.precast.WS['Shark Bite'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], sets.precast.WS.Acc, {})
	sets.precast.WS['Shark Bite'].FullAcc = set_combine(sets.precast.WS['Shark Bite'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Shark Bite'].PDL = set_combine(sets.precast.WS['Shark Bite'], sets.precast.PDL, {waist="Kentarch Belt +1"})
	sets.precast.WS['Shark Bite'].Proc = set_combine(sets.precast.WS['Shark Bite'], sets.precast.Proc, {})
	
-- ### Sword weaponskills ###
  -- Sanguine Blade
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1", --(Aug. to R15)
		head="Pixie Hairpin +1",
		body="Nyame Mail", --(Aug. to R30)
		legs="Nyame Flanchard", --(Aug. to R30)
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring",
		back={ name="Toutatis's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
  -- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +4",
		body="Skulker's Vest +3",
		legs="Nyame Flanchard", --(Aug. to R30)
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Sherida Earring", --(Hoxne Earring, MR 6+)
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Savage Blade'].Hoxne = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.Hoxne, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], sets.precast.PDL, {
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		right_ring="Sroda Ring",
		back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Savage Blade'].Proc = set_combine(sets.precast.WS['Savage Blade'], sets.precast.Proc, {})

-- ### Miscellaenous WS swaps ###
	sets.MaxTP = {left_ear="Ishvara Earring", right_ear="Sherida Earring"}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Sherida Earring"}

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Gear that needs to be worn to actively enhance a current player buff. ###
	sets.buff['Sneak Attack'] = {hands="Skulk. Armlets +3"}
    sets.buff['Trick Attack'] = {body="Plunderer's Vest +4", hands="Pill. Armlets +3"} -- (Upgrade to +4)

-- ### Gear that is equiped to counteract specific debuffs ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	--sets.buff.Sleep = {head="Frenzy Sallet"}

-- ### Phalanx Received ###
	sets.Phalanx_Received = { --Phalanx +13
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
	}
	
-- ### Treasure Hunter ###
	sets.TreasureHunter = {feet="Skulk. Poulaines +3"} -- (Hoxne Ring)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(2, 6)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 6)
	elseif player.sub_job == 'RDM' then
		set_macro_page(4, 6)
	else
		set_macro_page(1, 6)
	end
end

-- Auto Weaponskill List
	autows_list = {
		['Savage']='Savage Blade',
		['Rudras']="Rudra's Storm",
		['Aeolian']='Aeolian Edge',
		['Ruthless']='Ruthless Stroke',
		['Evisceration']='Evisceration',
		['SavageGleti']='Savage Blade',
		['RudrasGleti']="Rudra's Storm",
		['RuthlessGleti']='Ruthless Stroke'
	}