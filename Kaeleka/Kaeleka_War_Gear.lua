function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Hoxne', 'Acc', 'FullAcc', 'PDL')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'PDL')
    state.HybridMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Refresh', 'Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'DWMax', 'SubtleBlow'}
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
-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +3", body="Agoge Lorica +3"} --(Upgrade to +4)
	sets.precast.JA['Berserk'] = {body="Pummeler's Lorica +3", feet="Agoge Calligae +3", back="Cichol's Mantle"} --(Upgrade to +4)
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +3"} 
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Mighty Strikes'] = {head="Agoge Mufflers +3"} --(Upgrade to +4)
	sets.precast.JA['Defender'] = {hands="Agoge Mufflers +3"} --(Upgrade to +4)
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Restraint'] = {hands="Boii Mufflers +3"}
	sets.precast.JA['Retaliation'] = {hands="Pummeler's Mufflers +3", feet="Boii Calligae +3"} --(Upgrade to +4)
	sets.precast.JA['Warcry'] = {head="Agoge Mask +3"} --(Upgrade to +4)
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +3"} --(Upgrade to +4)
	sets.precast.JA['Tomahawk'] = {feet="Agoge Calligae +3", ammo="Thr. Tomahawk"} --(Upgrade to +4)

-- ### Enmity Set ###
    sets.Enmity = { --DT -22 [PDT -37], Enmity +66
		ammo="Sapience Orb", --Enmity +2
		head="Pummeler's Mask +3", --Enmity +12 (Upgrade to +4)
		body="Nyame Mail", --DT -9 (Souv. Cuisses +1, Path C: Aug. to R15)
		hands="Pumm. Mufflers +3", --Enmity +15 (Upgrade to +4)
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --DT -4 Enmity +9
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --PDT -5 Enmity +9
		neck="Unmoving Collar +1", --Enmity +10
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Friomisi Earring", --Enmity +2
		left_ring="Petrov Ring", --Enmity +4
		right_ring="Vengeful Ring", --Enmity +3 (Supershear Ring)
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Cichol's Mantle: Enmity +10, DT -5)
	}
	
	sets.passive.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	
	
-- ### Fast cast sets ###
	sets.precast.FC = { --FC +37/+80, DT -36
		ammo="Sapience Orb", --FC +2, 
		head="Sakpata's Helm", --DT -7, FC +8
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Sakpata's Cuisses", --DT -9
		feet="Nyame Sollerets", --DT -7 (Odyssean Greaves)
		neck="Voltsurge Torque", --FC +4
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Loquac. Earring", --FC +2
		right_ear="Eabani Earring", --FC +1 (Enchant. Earring +1)
		left_ring="Murky Ring", --DT -10
		right_ring="Rahab Ring", --FC +2
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Cichol's Mantle: VIT +30, Eva/MEva +20, +10, FC +10, Regen +5)
	}
	
  -- Fast cast sets / specific spells
    -- Utsusemi
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	

-- ### Flourish sets for /DNC ###
	sets.precast.Flourish1 = set_combine(sets.Enmity, {})
	sets.precast.Flourish2 = set_combine(sets.Enmity, {})


-- ### Waltz sets for /DNC ###
  -- Curing Waltz
	sets.precast.Waltz = {
		ammo="Aurgelmir Orb", --(Aurgelmir Orb +1)
		head="Boii Mask +3",
		body="Nyame Mail", --(Path B: Aug. to R30)
		hands="Boii Mufflers +3",
		legs="Dashing Subligar", 
		feet="Nyame Sollerets", --(Path B: Aug. to R30)
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}}, --(Hoxne Earring, MR 6+)
		left_ring="Murky Ring", --(Aug. to R30)
		right_ring="Metamor. Ring +1",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --(Cichol's Mantle: VIT +30, Eva/MEva +20, Waltz Pot. +10, DT -5)
	}
	
	sets.precast.Waltz['Healing Waltz'] = {}

    
-- ### Step sets for /DNC ###
	sets.precast.Step = {
		ammo="Seeth. Bomblet +1", 
		head="Boii Mask +3",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}


------------------------------------------------------------------------------------------------------------------- 
-- MIDCAST SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Fast recast ###
	sets.midcast.FastRecast = {
		ammo="Sapience Orb", --FC +2, 
		head="Sakpata's Helm", --DT -7, FC +8
		body="Sacro Breastplate", --FC +10
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Sakpata's Cuisses", --DT -9
		feet="Nyame Sollerets", --DT -7 (Odyssean Greaves)
		neck="Voltsurge Torque", --FC +4
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Loquac. Earring", --FC +2
		right_ear="Eabani Earring", --FC +1 (Enchant. Earring +1)
		left_ring="Murky Ring", --DT -10
		right_ring="Rahab Ring", --FC +2
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Cichol's Mantle: VIT +30, Eva/MEva +20, +10, FC +10, Regen +5)
	}

  -- Fast reset for specific spells
	sets.midcast.Cure = {left_ear="Mendi. Earring", right_ring="Lebeche Ring"}
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {neck="Magoraga Beads"})
	
	
	sets.Self_Healing = {waist="Gishdubar Sash"}
	
-------------------------------------------------------------------------------------------------------------------
-- DEFENSE & IDLE SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
	sets.defense.PDT = {
		ammo="Eluder's Sachet",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	--sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})


-- ### Magical damage taken ###
	sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Archon Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	--sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})

	
-- ### Magical Evasion ###
	sets.defense.MEVA = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Hearty Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back="Null Shawl",
	}
	

-- ### Misc. Defensive Sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}
	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	
-------------------------------------------------------------------------------------------------------------------
-- IDLE SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Base Idle Set ###
	sets.idle = { --DT -37 [PDT -50/MDT -48], Regen +24
		ammo="Staunch Tathlum +1", --DT -3
		head="Volte Salade", --PDT -3/MDT -7, Regen +2 (Null Masque)
		body="Sacro Breastplate", --Regen +13
		hands="Volte Moufles", --PDT -6/MDT -4, Regen +2
		legs="Sakpata's Cuisses", --DT -9
		feet="Boii Calligae +3", --DT -10
		neck="Bathy Choker +1", --Regen +3
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Cichol's Mantle: VIT +30, Eva/MEva +20, +10, FC +10, Regen +5)
	}
	
  -- Refresh set
	sets.idle.Refresh = set_combine(sets.idle, {neck="Sibyl Scarf"})
	
  -- Regain set
	sets.idle.Regain = set_combine(sets.idle, {body="Makora Meikogai"})
	
  -- Regen set
	sets.idle.Regen = set_combine(sets.idle, {left_ring="Chirich Ring +1"})
	
  -- Weakened idle set	
	sets.idle.Weak = set_combine(sets.idle, { --DT -50, Regen +17
		ammo="Staunch Tathlum +1", --DT -3
		head="Sakpata's Helm", --DT -7 (Aug. to R30)
		body="Sacro Breastplate", --Regen +13
		hands="Sakpata's Gauntlets", --DT -8 (Aug. to R30)
		legs="Sakpata's Cuisses", --DT -9 (Aug. to R30)
		feet="Sakpata's Leggings", --DT -6 (Aug. to R30)
		neck="Loricate Torque +1", --DT -6
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", 
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Cichol's Mantle: VIT +30, Eva/MEva +20, +10, FC +10, Regen +5)
	})
	
  -- sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail"})
	
	
-- ### Resting set ###
	sets.resting = {
		ammo="Staunch Tathlum +1",
		head="Volte Salade",
		body="Sacro Breastplate",
		hands="Volte Moufles",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Bathy Choker +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}


-------------------------------------------------------------------------------------------------------------------
-- ENGAGED SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged set, single wield ###
	sets.engaged = { --DT -33 [PDT -48/MDT -33], DA +77, QA +3, Store TP +29
		ammo="Coiste Bodhar", --DA +3, Store TP +3 
		head="Hjarrandi Helm", --DT -10, DA +6, Store TP +7
		body="Sakpata's Plate", --DT -10, DA +8
		hands="Sakpata's Gauntlets", --DT -8, DA +6 
		legs="Pumm. Cuisses +4", --PDT -5, DA +11 
		feet="Pumm. Calligae +4", --DA +9, Store TP +4
		neck="Vim Torque +1", --Latent: Regain +20, Store TP +10
		waist="Ioskeha Belt +1", --DA +9
		left_ear="Schere Earring", --DA +6
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}}, --DA +9
		left_ring="Moonlight Ring", --DT -5, Store TP +5
		right_ring="Niqmaddu Ring", --QA +3
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --PDT -10, DA +10
	}
  
  -- Accuracy Set
	sets.engaged.Acc = set_combine(sets.engaged, { --1366 Acc
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
  -- Full Accuracy Set
	sets.engaged.FullAcc = set_combine(sets.engaged, { --1509 Acc
		ammo="Seeth. Bomblet +1",
		head="Boii Mask +3",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		neck="Null Loop",
		waist="Null Belt",
		right_ring="Regal Ring",
		back="Null Shawl",
	})
	
  -- Hybrid DT Set
	sets.engaged.DT = set_combine(sets.engaged, {
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Hjarrandi Helm", --DT -10, DA +6, Store TP +7
		body="Sakpata's Plate", --DT -10, DA +8
		hands="Sakpata's Gauntlets", --DT -8, DA +6
		legs="Sakpata's Cuisses", --DT -9, DA +7
		feet="Sakpata's Leggings", --DT -6, DA +4
		left_ring="Moonlight Ring", --DT -5, Store TP +5
	})
	
	sets.engaged.DT.Acc = set_combine(sets.engaged.DT, {
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
	sets.engaged.DT.FullAcc = set_combine(sets.engaged.DT, { --Acc 1460, DT -45 [PDT -50/MDT -45, DA +46, Store TP +29
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Boii Mask +3", --DT -11, DA +7
		body="Boii Lorica +3", --DT -14, Store TP +11
		hands="Tatena. Gote +1", --TA +4, Store TP +4~8
		legs="Pumm. Cuisses +4", --PDT -5, DA +11
		feet="Pumm. Calligae +4", --DA +9, Store TP +4
		neck="Null Loop", --DT -5
		waist="Null Belt", 
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}}, --DA +9
		left_ring="Murky Ring", --DT -10
		right_ring="Regal Ring",
		back="Null Shawl", --DA +7, Store TP +7
	})
	
-- ### Engaged set w/ Hoxne Ampulla, single wield ###
	sets.engaged.Hoxne = { --DT -29, Store TP +72
		ammo="Hoxne Ampulla", --Enchantment: 1,000 gil > DA +100
		head="Hjarrandi Helm", --DT -10, Store TP +7
		body="Boii Lorica +3", --DT -14, Store TP +11
		hands="Tatena. Gote +1", --Store TP +4~8
		legs="Tatena. Haidate +1", --Store TP +4~8
		feet="Tatena. Sune. +1", --Store TP +4~8
		neck="Vim Torque +1", --Latent: Regain +20, Store TP +10
		waist="Kentarch Belt +1", --Store TP +1~5
		left_ear="Dedition Earring", --Store TP +8
		right_ear="Telos Earring", --Store TP +5
		left_ring="Moonlight Ring", --DT -5, Store TP +5
		right_ring="Chirich Ring +1", --Store TP +6
		back="Null Shawl", --Store TP +7 (Cichol's Mantle: DEX +30, Acc/Atk +20, Store TP +10, DT -5)
	}
	
-- ### Engaged sets, dual-wield ###
	sets.engaged.DW = {}
	sets.engaged.DW.Acc = {}
	sets.engaged.DW.FullAcc = {}
	sets.engaged.DW.DT = {}
	sets.engaged.DW.DTAcc = {}
	sets.engaged.DW.DTFullAcc = {}
	
	
-- ### Extra melee sets (equipped on top of engaged sets) ###
	sets.DWMid = {}
	
	sets.DWMax = { --Dual wield +16
		waist="Reiki Yotai", --DW +7
		left_ear="Suppanomimi", --DW +5
		right_ear="Eabani Earring", --DW +4
	}
	
	sets.SubtleBlow = set_combine(sets.engaged, { --SB +47, SBII +5
		body="Sacro Breastplate", --SB +15
		neck="Bathy Choker +1", --SB +11
		left_ear="Schere Earring", --SB +3
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}}, --SB +7
		left_ring="Chirich Ring +1", --SB +11
		right_ring="Niqmaddu Ring", --SB2 +5
	})


-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
-- Single handed weapons
	sets.weapons.Axe = {main="Ikenga's Axe", sub="Blurred Shield +1"}
	sets.weapons.Club = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	sets.weapons.Greataxe = {main="Chango", sub="Utu Grip"}
	sets.weapons.Greatsword = {main="Agwu's Claymore", sub="Utu Grip"}
	sets.weapons.Polearm = {main="Shining One", sub="Utu Grip"}
	sets.weapons.Sword = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.Dagger = {main="Crepuscular Knife", sub="Blurred Shield +1"}
	
-- Dual weapons
	sets.weapons.DualSword = {main="Naegling", sub="Blurred Knife +1"}
	sets.weapons.DualDagger = {main="Crepuscular Knife", sub="Blurred Knife +1"}
		
-- Proc weapons (Enabled in Abyssea only)
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
-- ### Default weaponskill set ###
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Agoge Mask +4",
		body="Nyame Mail", --(Path B: Aug. to R30)
		hands="Boii Mufflers +3",
		legs="Nyame Flanchard", --(Path B: Aug. to R30) 
		feet="Nyame Sollerets", --(Path B: Aug. to R30)
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}}, --(Hoxne Earring, MR 7+)
		left_ring="Cornelia's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.precast.WS.Hoxne = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		body="Sakpata's Plate", --(Aug. to R30)
		legs="Boii Cuisses +3",
		right_ring="Sroda Ring",
	})


  -- Axe Weaponskills
	-- Decimation
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Decimation'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
	sets.precast.WS['Decimation'].Acc = set_combine(sets.precast.WS['Decimation'], {})
	sets.precast.WS['Decimation'].PDL = set_combine(sets.precast.WS['Decimation'], {})
	 
    -- Mistral Axe
	sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {right_ear="Thrud Earring", right_ring="Sroda Ring"})
	sets.precast.WS['Mistral Axe'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS['Mistral Axe'].Acc = set_combine(sets.precast.WS['Mistral Axe'], {})
	sets.precast.WS['Mistral Axe'].PDL = set_combine(sets.precast.WS['Mistral Axe'], {})
	
    -- Ruination
	sets.precast.WS['Ruination'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Ruination'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
	sets.precast.WS['Ruination'].Acc = set_combine(sets.precast.WS['Ruination'], {})
	sets.precast.WS['Ruination'].PDL = set_combine(sets.precast.WS['Ruination'], {})
	
	
  -- Club Weaponskills
	-- Black Halo
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {right_ring="Regal Ring"})
    sets.precast.WS['Black Halo'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {})
    sets.precast.WS['Black Halo'].Fodder = set_combine(sets.precast.WS['Black Halo'], {})
	
	-- Judgement
    sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Judgement'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS['Judgement'], {})
    sets.precast.WS['Judgement'].PDL = set_combine(sets.precast.WS['Judgement'], {})
	
	
  -- Great Axe Weaponskills
	-- Fell Cleave
    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {right_ear="Thrud Earring", right_ring="Sroda Ring"})
	sets.precast.WS['Fell Cleave'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS['Fell Cleave'], {})
    sets.precast.WS['Fell Cleave'].PDL = set_combine(sets.precast.WS['Fell Cleave'], {})
	
    -- Full Break (STR/VIT, MAcc)
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Boii Mask +3",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Metamor. Ring +1",
		right_ring="Crepuscular Ring",
		back="Null Shawl",
	})
	
    --sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})
    --sets.precast.WS["Full Break"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
  -- Ukko's Fury
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Ukko's Fury"].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS["Ukko's Fury"], {})
    sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS["Ukko's Fury"], {})
	
  -- Upheaval
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Upheaval'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS['Upheaval'], {})
    sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS['Upheaval'], {}) 
	
  -- Great Sword Weaponskills
	-- Resolution
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Resolution'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	

  -- Polearm Weaponskills
	-- Impulse Drive
    sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Impulse Drive"].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS["Impulse Drive"].Acc = set_combine(sets.precast.WS["Impulse Drive"], {})
    sets.precast.WS["Impulse Drive"].PDL = set_combine(sets.precast.WS["Impulse Drive"], {})

  -- Stardiver
	sets.precast.WS["Stardiver"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Stardiver"].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
    sets.precast.WS["Stardiver"].Acc = set_combine(sets.precast.WS["Stardiver"], {})
    sets.precast.WS["Stardiver"].PDL = set_combine(sets.precast.WS["Stardiver"], {})
	

  -- Sword Weaponskills
	-- Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Nyame Mail", --(Path B: Aug. to R30)
		hands="Nyame Gauntlets", --(Path B: Aug. to R30)
		legs="Nyame Flanchard", --(Path B: Aug. to R30)
		feet="Nyame Sollerets", --(Path B: Aug. to R30)
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --(Cichol's Mantle: INT +30, MAtk/Macc +20, WSD +10, DT -5)
	})
	
    -- Savage Blade (uses default WS set)
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].Hoxne = set_combine(sets.precast.WS.Hoxne, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], {})


-- ### Misc. weaponskill swaps, used when using WS at 3000 TP ###
	sets.MaxTP = {left_ear="Lugra Earring +1"}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}
		

-- Specialty weaponskill set overrides
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}


-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Gear equipped to counteract specific debuffs ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"}) --(Purity Ring, Shabti Cuisses +1)
	sets.buff.Sleep = {neck="Vim Torque +1"}

-- ### Gear for specific buffs that have to be kept equipped ###
	sets.buff.Retaliation = {hands="Pumm. Mufflers +3", feet="Boii Calligae +3"} --(Upgrade to +4)
	sets.buff.Restraint = {hands="Boii Mufflers +3"}
	
-- ### Gear equiped when specific spells are cast on us ###
  -- Cure effect received
	sets.Cure_Received = { --Cure effect received +38/30
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --Cure effect +23
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --Cure effect +15
	}
	
  -- Phalanx received
	sets.Phalanx_Received = { --Phalanx +14
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}}, --Phalanx +4
		legs="Sakpata's Cuisses", --Phalanx +5
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --Phalanx +5
	}

-- ### Treasure Hunter ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
        body="Volte Jupon",
		waist="Chaac Belt",
	})	
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