-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.RangedMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.CastingMode = M{['description']='Quick Draw Mode', 'Normal', 'Fodder'}
    state.IdleMode:options('Normal', 'Regen', 'Refresh')
	state.HybridMode:options('Normal', 'DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax'}
	state.Weapons:options('Savage', 'LeadenSalute', 'HotShot', 'LastStand', 'Wildfire', 'Aeolian', 'Evisceration')
	state.CompensatorMode:options('Always', '300', '1000', 'Never')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Hauksbok Bullet"
    options.ammo_warning_limit = 15
    --Ikenga_vest_bonus = 190  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20

    -- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')
	--send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
	send_command('bind ^q gs c weapons Savage;gs c update')
	send_command('bind !q gs c weapons LeadenSalute;gs c update')
	send_command('bind @pause roller roll')

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
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"} --(Upgrade to +4)
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +4"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +4"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"} --(Upgrade to +4)


-- ### Fast Cast gear ###
	sets.precast.FC = { --DT -15, FC +51/80
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Chas. Culottes +3", --DT -12
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Baetyl Pendant", --FC +4
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Rahab Ring", --FC +2
		right_ring="Kishar Ring", --FC +4
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Ambu Cape: FC +10)
	}

  -- Fast cast for specific spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket", neck="Magoraga Beads"}) 


-- ### Phantom Roll precast ###
    sets.precast.CorsairRoll = { --DT -50, Phantom Roll +8, Phan. Roll Duration +170, Phan. Roll Effect +50
		main={ name="Rostam", augments={'Path: C',}}, --Phan. Roll +8, Phan. Roll Dur. +20
		sub={ name="Rostam", augments={'Path: A',}},
		range={ name="Compensator", augments={'DMG:+15','AGI+15','Rng.Acc.+15',}}, --Phan. Roll Dur. +20
		head="Lanun Tricorne +3", --Phan. Roll Effect +50
		body="Chasseur's Frac +3", --DT -13
		hands="Chasseur's Gants +3", --Phan. Roll Dur. +60, 
		legs="Chas. Culottes +3", --DT -12
		feet="Nyame Sollerets", --DT -7
		neck="Regal Necklace", --Phan. Roll +7, Phan. Roll Dur. +20
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Eabani Earring", 
		left_ring="Murky Ring", --DT -10
		right_ring="Luzaf's Ring", --Enlarges Phan. Roll radius
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --Phan. Roll Dur. +30
	}

  -- Larger AOE on Phantom Roll
	sets.precast.LuzafRing = {right_ring="Luzaf's Ring"}
    
  -- Precast sets for Specific rolls
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})


-- ### Quick Draw Sets ###
	sets.precast.CorsairShot = {
		ammo="Hauksbok Bullet",
		head="Ikenga's Hat",
		body="Lanun Frac +4",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck="Baetyl Pendant",
		waist="Eschan Stone", --(Skyrmir Belt +1)
		left_ear="Moonshade Earring", --(Crematio Earring)
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1", --(Fenrir Ring +1)
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}, --(AGI, MAcc/MDmg, MAB, DT)
	}

	sets.precast.CorsairShot.Resistant = set_combine(sets.precast.CorsairShot, {
		ammo="Animikii Bullet",
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		left_ear="Alabaster Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Metamor. Ring +1",
		right_ring="Crepuscular Ring",
		back="Null Shawl",
	})
	
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {feet="Chass. Bottes +4"})
		
  -- Specific Quickdraw shots
	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot.Resistant, {})
	sets.precast.CorsairShot['Light Shot'] = set_combine{sets.precast.CorsairShot.Resistant, {}}


-- ### Ranged preshot gear ###
	sets.precast.RA = { --Rapid Shot +18, Snapshot +70
		head="Ikenga's Hat", --Snapshot +6 (Augment to R30)
		body="Oshosi Vest +1", --Snapshot +14
		hands="Lanun Gants +3", --Snapshot +13 (Upgrade to +4)
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, --Rapid Shot +13, Snapshot +10
		feet="Meg. Jam. +2", --Snapshot +10
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --Snapshot +4
		waist="Yemaya Belt", --Rapid Shot +5
		left_ear="Alabaster Earring", --DT -5
		right_ear="Eabani Earring",
		left_ring="Murky Ring", --DT -10
		right_ring="Crepuscular Ring", --Snapshot +3
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Snapshot"+10','Damage taken-5%',}}, --Snapshot +10
	}
	
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, { --Rapid Shot +67, Snapshot +45
		head="Chass. Tricorne +3", --Rapid Shot +18
		body="Laksa. Frac +3", --Rapid Shot +20
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, --Rapid Shot +11, Snapshot +8
	})
	
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, { --Rapid Shot +67, Snapshot +35
		head="Chass. Tricorne +3", --Rapid Shot +18
		body="Laksa. Frac +3", --Rapid Shot +20
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, --Rapid Shot +11, Snapshot +8
		
	})


-- ### Step & Waltz sets for /DNC ###
  -- Steps
	sets.precast.Steps = {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
  -- Curing & Healing Waltz
	sets.precast.Waltz = {
		head="Nyame Helm",
		body="Passion Jacket",
		hands="Nyame Gauntlets",
		legs="Dashing Subligar",
		feet="Rawhide Boots",
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Alabaster Earring",
		right_ear="Handler's Earring", --(Hoxne Earring)
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1", 
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Snapshot"+10','Damage taken-5%',}},
	}
		
	sets.Self_Waltz = set_combine(sets.precast.waltz, {head="Mummu Bonnet +2"})
    sets.precast.Waltz['Healing Waltz'] = {}
	
	
------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast recast set ###
	sets.midcast.FastRecast = {
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --FC +8
		legs="Chas. Culottes +3", --DT -12
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Baetyl Pendant", --FC +4
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Rahab Ring", --FC +2
		right_ring="Kishar Ring", --FC +4
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --(Ambu Cape: FC +10)
	}
   
  -- Fast recast for specific spells
	sets.Cure_Received = {waist="Gishdubar Sash"}
    sets.midcast.Utsusemi = sets.midcast.FastRecast

-- ### Dark Magic spells (used for /DRK Aminon only) ###
	sets.midcast['Dark Magic'] = {
		main={ name="Rostam", augments={'Path: C',}},
		sub={ name="Rostam", augments={'Path: A',}},
		range="Fomalhaut",
		ammo="Animikii Bullet",
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		waist="K. Kachina Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Evanescence Ring", --(Stikini Ring +1)
		right_ring="Archon Ring", --(Stikini Ring +1)
		back="Null Shawl",
	}


-- ### Midshot Gear ###
  -- Ranged Attack, Normal
	sets.midcast.RA = { --Store TP +93
        ammo="Chrono Bullet",
		head="Ikenga's Hat", --Store TP +8 (Augment to R30)
		body="Ikenga's Vest", --Store TP +11 (Augment to R30)
		hands="Ikenga's Gloves", --Store TP +9 (Augment to R30)
		legs="Chas. Culottes +3", --Store TP +12 
		feet="Ikenga's Clogs", --Store TP +7 (Augment to R30)
		neck="Iskur Gorget", --Store TP +8
		waist="Yemaya Belt", --Store TP +4
		left_ear="Dedition Earring", --Store TP +8 (Crepuscular Earring)
		right_ear="Telos Earring", --Store TP +5
		left_ring="Ilabrat Ring", --Store TP +5
		right_ring="Crepuscular Ring", --Store TP +6
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}}, --Store TP +10
	}

  -- Ranged Attack, Accuracy 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {left_ear="Enervating Earring", left_ring="Cacoethic Ring +1"})
	
  -- Ranged Attack, Full Accuracy
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		feet="Chass. Bottes +3",
		left_ear="Beyla Earring",
		left_ring="Cacoethic Ring +1",
	})
	
  -- Ranged Attack, Subtble Blow
	sets.midcast.RA.SubtleBlow = set_combine(sets.midcast.RA, { --Subtle Blow +51/50
		body="Volte Harness", --Subtle Blow +10
		hands="Laksa. Gants +3", --Subtle Blow +10
		neck="Bathy Choker +1", --Subtle Blow +11
		left_ring="Chirich Ring +1", --Subtle Blow +10
		right_ring="Chirich Ring +1", --Subtle Blow
	})
	

-- ### Triple Shot gear ###
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
		head="Oshosi Mask +1", --Triple Shot +5, Triple Shot Dmg +13
		body="Chasseur's Frac +3", --Triple Shot +14
		hands="Lanun Gants +3", --Triple Shot: Occ. becomes Quad Shot
		legs="Osh. Trousers +1", --Triple Shot +6
		feet="Osh. Leggings +1", --Triple Shot +3
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}}, --Triple Shot +5
	})


-------------------------------------------------------------------------------------------------------------------
-- Idle & Resting sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###   
	sets.idle = { --DT -50, Regen +7
		head="Chass. Tricorne +3", --(Null Masque)
		body="Chasseur's Frac +3", --DT -13
		hands="Meg. Gloves +2", --Set: Regen +3
		legs="Chas. Culottes +3", --DT -12
		feet="Meg. Jam. +2",
		neck="Bathy Choker +1", --Regen +3
		waist="Plat. Mog. Belt", --DT -3 (Null Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}}, --(Ambu Cape: FC +10, Regen +5)
	}

  -- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {neck="Sybil Scarf"})
  
  -- Regain idle set
	sets.idle.Regain = set_combine(sets.idle, {})
  
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {
		head="Meghanada Visor +2", --Set: Regen +12 (Null Masque)
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	}) 


-- ### Resting set ###
	sets.Resting = { --Regen +20
		head="Meghanada Visor +2", --Set: Regen +12 (Null Masque)
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Bathy Choker +1", --Regen +3
		waist="Plat. Mog. Belt", --(Null Belt)
		left_ear="Dawn Earring", --Daytime: Regen +1
		right_ear="Infused Earring", --Regen +1
		left_ring="Chirich Ring +1", --Regen +2
		right_ring="Chirich Ring +1", --Regen +2
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}}, --(Ambu Cape: FC +10, Regen +5)
	}


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
    sets.defense.PDT = { --DT -50, DEF 1463
        head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Eabani Earring", 
		left_ring="Murky Ring", --DT -10
		right_ring="Warden's Ring", --Enemy Crit Rate -5
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}}, --(Ambu Cape: FC +10, Regen +5)
	}

  -- Magical damage taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Arete del Luna",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}}, --(Ambu Cape: FC +10, Regen +5)
	})
	
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		left_ring="Murky Ring",
		right_ring="Vengeful Ring",
		back="Null Shawl",
	})
	
-- ### Misc. defensive sets ###
  -- Kiting
    sets.Kiting = {right_ring="Shneddick Ring"}
	
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged set, single wield ###
    sets.engaged = {
		head="Malignance Chapeau", --DT -6, Store TP +8, PDL +3%
		body="Malignance Tabard", --DT -9, Store TP +11
		hands="Malignance Gloves", --DT -5, Store TP +12
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}, --Store TP +7, DA +3, TA +3
		feet="Malignance Boots", --DT -4, Store TP +9
		neck="Iskur Gorget", --Store TP +8
		waist="Sailfi Belt +1", --DA +5, TA +2
		left_ear="Dedition Earring", --Store TP +8
		right_ear="Telos Earring", --Store TP +5, DA +1
		left_ring="Petrov Ring", --Store TP +5, DA +1
		right_ring="Epona's Ring", --DA +3, TA +3
		back="Null Shawl", --Store TP +7, DA +7
    }
	
    sets.engaged.Acc = set_combine(sets.engaged, {
		neck="Null Loop",
		left_ear="Telos Earring",
	})
	
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	})
	
    sets.engaged.Fodder = set_combine(sets.engaged, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
	})
	
    sets.engaged.DT = set_combine(sets.engaged, {
		legs="Chas. Culottes +3",
		left_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	

-- ### Engaged set, Dual Wield ###
    sets.engaged.DW = { --DT -24, Dual Wield +11, Store TP +84, DA +15, TA +6
		head="Malignance Chapeau", --DT -6, Store TP +8, PDL +3%
		body="Malignance Tabard", --DT -9, Store TP +11
		hands="Malignance Gloves", --DT -5, Store TP +12
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}, --Store TP +7, DA +3, TA +3
		feet="Malignance Boots", --DT -4, Store TP +9
		neck="Iskur Gorget", --Store TP +8
		waist="Reiki Yotai", --Dual Wield +7, Store TP +4
		left_ear="Dedition Earring", --Store TP +8
		right_ear="Eabani Earring", --Dual Wield +4
		left_ring="Petrov Ring", --Store TP +5, DA +1
		right_ring="Epona's Ring", --DA +3, TA +3
		back="Null Shawl", --Store TP +7, DA +7
	}
    
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		neck="Null Loop",
		left_ear="Telos Earring",
	})
	
	sets.engaged.DW.FullAcc = set_combine(sets.engaged.DW, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		left_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	})
	
	sets.engaged.DW.Fodder = set_combine(sets.engaged.DW, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
	})
    
	sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
		legs="Chas. Culottes +3",,
		left_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	sets.engaged.DW.SubtleBlow = set_combine(sets.engaged.DW, {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		feet="Volte Spats",
		left_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
	})
	
-- ### Extra melee modes applied on top of melee sets ###
	sets.engaged.DWMid = { --Dual Wield +22
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Dual Wield +6
		waist="Reiki Yotai", --Dual Wield +7
		left_ear="Suppanomimi", --Dual Wield +5
		right_ear="Eabani Earring", --Dual Wield +4
	}
	
	sets.engaged.DWMax = { --Dual Wield +46
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Dual Wield +6
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}, --Dual Wield +5
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}}, --Dual Wield +9
		waist="Reiki Yotai", --Dual Wield +7
		left_ear="Suppanomimi", --Dual Wield +5
		right_ear="Eabani Earring", --Dual Wield +4
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --Dual Wield +10
	}
	sets.engaged.SubtleBlow = {
		body="Volte Harness",
		hands="Laksa. Gants +3",
		neck="Bathy Choker +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	}
	
---------------------------------------------------------------------------------------------------------------
-- Weapon & weaponskill sets
---------------------------------------------------------------------------------------------------------------
-- ### Weapon sets ###
	sets.weapons.Savage = {main="Naegling", sub="Gleti's Knife", range="Ataktos"}
	sets.weapons.LeadenSalute = {main="Naegling", sub="Tauret", range="Death Penalty"}
	sets.weapons.HotShot = {main="Naegling", sub="Tauret", range="Fomalhaut"}
	sets.weapons.LastStand = {main="Crepuscular Knife", sub="Gleti's Knife", range="Fomalhaut"}
	sets.weapons.Wildfire = {main="Naegling", sub="Tauret", range="Death Penalty"}
	sets.weapons.Aeolian = {main="Tauret", sub="Naegling", range="Ataktos"}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife", range="Earp"}
	
-- ### Default weaponskill gear ###
    sets.precast.WS = {
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
    }

-- Default weaponskill accuracy gear
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
-- Default weaponskill fodder gear
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		head="Nyame Helm", --(Clemency Somen)
		body="Ikenga's Vest",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})


-- ### Dagger Weaponskills ###
  -- Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo="Hauksbok Bullet",
		head="Nyame Helm",
		body="Lanun Frac +4",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}, --(Ambu cape: INT, MAcc/MDmg, WSD, DT)
	})
	
    --Evisceration
	sets.precast.WS['Evisceration'] = {
		--ammo="Bayeux Bullet",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Mummu Jacket +2", --(Clemency Haramaki, Augment to R30)
		hands="Mummu Wrists +2", --(Clemency Kote, Augment to R30)
		legs="Mummu Kecks +2", --(Clemency Haidate, Augment to R30)
		feet="Mummu Gamash. +2", --(Clemency Sune-Ate, Augment to R30)
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}}, --(Hoxne Earring)
		left_ring="Murky Ring", --(Begrudging Ring)
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}, --(Ambu Cape: DEX, Atk/Acc, Crit Hit Rate, DT)
	}
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {left_ear="Mache Earring +1"})

-- ### Gun Weaponskills ###
  -- Hot Shot
    sets.precast.WS['Hot Shot'] = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring", --(Hoxne Earring)
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Hot Shot'], {})
	sets.precast.WS['Hot Shot'].Fodder = set_combine(sets.precast.WS['Hot Shot'], {right_ring="Sroda Ring"})

  -- Last Stand
    sets.precast.WS['Last Stand'] = {
		ammo="Chrono Bullet",
		head="Lanun Tricorne +3",
		body="Ikenga's Vest",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Dingir Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	
	sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {
		--head="Lanun Tricorne +3", --(Clemency Somon, Augment to R30) 
		--hands="Chasseur's Gants +3", --(Clemency Kote, Augment to R30)
		legs="Ikenga's Trousers", --(Clemency Haidate, Augment to R30)
		--feet="Lanun Bottes +4", --(Clemency Sune-Ate, Augment to R30)
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
	})
	
  -- Leaden Salute
	sets.precast.WS['Leaden Salute'] = {
		ammo="Living Bullet",
		head="Pixie Hairpin +1",
		body="Lanun Frac +4",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Orpheus's Sash", --(Skyrmir Cord +1)
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring", --(Hoxne Earring)
		left_ring="Dingir Ring",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], {})
	sets.precast.WS['Leaden Salute'].Fodder = set_combine(sets.precast.WS['Leaden Salute'], {})

  -- Terminus
	sets.precast.WS['Terminus'] = set_combine(sets.precast.WS, {
		body="Ikenga's Vest",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Ponente Sash",
	})
	
	sets.precast.WS['Terminus'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Terminus'].Fodder = set_combine(sets.precast.WS.Fodder, {
		waist="Fotia Belt",
		right_ring="Sroda Ring",
	})
	
  -- Wildfire
	sets.precast.WS['Wildfire'] = {
		ammo="Living Bullet",
		head="Nyame Helm",
		body="Lanun Frac +4",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Wildfire'].Fodder = set_combine(sets.precast.WS.Fodder, {})


-- ### Sword Weaponskills ###
  -- Requiescat
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
  -- Savage Blade
	sets.precast.WS['Savage Blade'] = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {
		head="Nyame Helm", --(Clemency Somen)
		body="Ikenga's Vest",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})
	
	
-- ### Swaps when using WS at 3000 TP ###
	sets.MaxTP = {left_ear="Lugra Earring +1"} -- right_ear="Lugra Earring"
	sets.AccMaxTP = {}
 
 
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Auto-equip and use bullet pouch when primary ammo is low ###
	sets.BulletPouch = {waist="Chr. Bul. Pouch"}

-- ### Gear equiped when critical debuffs are applied ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
    	
-- ### Treasure Hunter gear ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		legs="Volte Hose",
		--right_ring="Hoxne Ring",
	})
end

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous
-------------------------------------------------------------------------------------------------------------------
	-- Selects default macro book on initial load or subjob change.
	function select_default_macro_book()
		set_macro_page(1, 17)
	end

--------------------------------------
--AutoWS when a specific weapon set is selected
--------------------------------------
	autows_list = {
		['Default']='Savage Blade',
		['Savage']='Savage Blade',
		['LeadenSalute']='Leaden Salute',
		['HotShot']='Hot Shot',
		['LastStand']='Last Stand',
		['Wildfire']='Wildfire',
		['Aeolian']='Aeolian Edge',
		['Evisceration']='Evisceration',
	}