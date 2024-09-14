-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'MaxAcc', 'Fodder')
    state.RangedMode:options('Normal', 'Acc', 'MaxAcc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.CastingMode = M{['description']='Quick Draw Mode', 'Normal', 'Resistant', 'StoreTP', 'Fodder'}
    state.IdleMode:options('Normal', 'PDT', 'Regen', 'Refresh')
	state.HybridMode:options('Normal', 'DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default', 'Savage', 'LeadenMelee', 'LeadenRanged', 'Aeolian', 'DualSavage', 'DualLeadenMelee', 'DualLeadenRanged',
		'ProcSword', 'ProcDagger')
	state.CompensatorMode:options('Always','300','1000','Never')

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
	send_command('bind ^q gs c weapons DualAeolian;gs c update')
	send_command('bind !q gs c weapons DualLeadenRanged;gs c update')
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
	--------------------------------------
	-- Fast Cast gear
	--------------------------------------
    sets.precast.FC = {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
	}


	--------------------------------------
	-- Fast cast for specific spells
	--------------------------------------
	-- Cure
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})
	
	-- Utsusemi
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"}) -- body="Passion Jacket"
	

	--------------------------------------
	-- Phantom Roll precast
	--------------------------------------
    sets.precast.CorsairRoll = {
		main={ name="Rostam", augments={'Path: C',}},
		range="Compensator",
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Malignance Tabard",
		hands="Chasseur's Gants +3",
		legs="Malignance Tights", -- Desulutor's Tassets
		feet="Malignance Boots",
		neck="Regal Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=gear.snapshot_jse_back,
	}

	-- Larger AOE on Phantom Roll
	sets.precast.LuzafRing = {right_ring="Luzaf's Ring"}
    
	-- Specific rolls
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})
	
	--------------------------------------
	-- Precast sets to enhance JAs
	--------------------------------------
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}


	--------------------------------------
	-- Quick Draw Sests
	--------------------------------------
	-- Quick Draw, Normal
	sets.precast.CorsairShot = {
		ammo="Hauksbok Bullet",
		head={ name="Ikenga's Hat", augments={'Path: A',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Crepuscular Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	-- Quick Draw, Resistant
	sets.precast.CorsairShot.Resistant = set_combine(sets.precast.CorsairShot, {
		ammo="Animikii Bullet",
		head="Laksa. Tricorne +3",
		body="Ikenga's Vest",
		hands="Laksa. Gants +3",
		legs={ name="Ikenga's Trousers", augments={'Path: A',}},
		feet="Laksa. Bottes +2",
		left_ring="Regal Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	})

	-- Quick Draw, StoreTP
	sets.precast.CorsairShot.StoreTP = set_combine(sets.precast.CorsairShot, {
		ammo="Animikii Bullet",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		right_ear="Cessance Earring",
		left_ring="Crepuscular Ring",
		right_ring="Chirich Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	-- Quick Draw, Chass. Bottes +3 for +31% elemental bonus on quick draw
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {feet="Chass. Bottes +3"})
	
	
	-- Specific Quickdraw shots
	-- Dark Shot
	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})
		
	-- Light Shot
	sets.precast.CorsairShot['Light Shot'] = set_combine{sets.precast.CorsairShot.Resistant, {}}
	
	
	--------------------------------------
	-- Ranged preshot gear
	--------------------------------------
	-- No Flurry / Snapshot 60%
    sets.precast.RA = {
		head="Chass. Tricorne +3",
		body="Oshosi Vest +1",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Impulse Belt",
		left_ring="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}
	
	-- Flurry I / Snapshot 45%
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {body="Laksa. Frac +3", waist="Yemaya Belt"})
	
	-- Flurry II / Snapshop 30%
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
		body="Laksa. Frac +3", 
		waist="Yemaya Belt",
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
	})


	--------------------------------------
	-- Step Sets for /DNC
	--------------------------------------
	sets.precast.Steps = {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Sanctity Necklace",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	
    --------------------------------------
	-- Waltz sets for /DNC
	--------------------------------------
	-- Curing Waltz on others
    sets.precast.Waltz = {
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		neck="Loricate Torque +1",
		waist="Impulse Belt",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}
		
	-- Curing Waltz on aelf
	sets.Self_Waltz = set_combine(sets.precast.waltz, {
		head="Mummu Bonnet +2",
		--body="Passion Jacket",
		--left_ring="Asklepian Ring",
	})
        
	-- Healing Waltz
    sets.precast.Waltz['Healing Waltz'] = {}
	

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Fast Recast
	--------------------------------------
    sets.midcast.FastRecast = {
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Malignance Tights",
		feet="Mummu Gamash. +2",
		neck="Voltsurge Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
	}
        
    
	--------------------------------------
	-- Fast recast for specific spells
	--------------------------------------
	-- Cure received
	sets.Cure_Received = {waist="Gishdubar Sash"}
	
	-- Utsusemi
    sets.midcast.Utsusemi = sets.midcast.FastRecast


	--------------------------------------
	-- Midshot Gear
	--------------------------------------
    -- Ranged Attack, Normal
	sets.midcast.RA = {
        ammo="Chrono Bullet",
		head={ name="Ikenga's Hat", augments={'Path: A',}},
		body="Ikenga's Vest",
		hands="Ikenga's Gloves",
		legs="Chas. Culottes +3",
		feet="Ikenga's Clogs",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Crepuscular Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Ranged Attack, Accuracy 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		--right_ear="Beyla Earring",
		waist="K. Kachina Belt +1",
	})
	
	-- Ranged Attack, Max Accuracy
	sets.midcast.RA.MaxAcc = set_combine(sets.midcast.RA, {
		ammo="Chrono Bullet",
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="K. Kachina Belt +1",
		right_ring="Cacoethic Ring +1",
	})
	
	-- Ranged Attack, Fodder
	sets.midcast.RA.Fodder = set_combine(sets.midcast.RA, {
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ring="Chirich Ring +1",
	})
	
	
	--------------------------------------
	-- Triple Shot gear
	--------------------------------------	
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
		body="Chasseur's Frac +3",
		hands="Lanun Gants +3",
	})


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical damage taken
	--------------------------------------
    sets.defense.PDT = {
        head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Hearty Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}

	
	--------------------------------------
	-- Magical damage taken
	--------------------------------------
    sets.defense.MDT = set_combine(sets.defense.PDT, {})
	
	
	--------------------------------------
	-- Magic Evasion
	--------------------------------------
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Unmoving Collar +1",
		left_ear="Hearty Earring",
		left_ring="Archon Ring",
		right_ring="Warden's Ring",
		back="Solemnity Cape",
	})
		

-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
    --------------------------------------
	-- Base Idle Set
	--------------------------------------
    sets.idle = {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		left_ring="Chirich Ring +1",
		right_ring="Shneddick Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}
		
	
	--------------------------------------
	-- Max regen idle set
	--------------------------------------
	sets.idle.Regen = set_combine(sets.idle, {}) --right_ring="Chirich Ring +1"
	

	--------------------------------------
	-- Refresh idle set
	--------------------------------------
    sets.idle.Refresh = set_combine(sets.idle, {neck="Sybil Scarf"})
	
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- Engaged Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Engaged set, Single Wield
	--------------------------------------	
    sets.engaged = { -- Acc 1212
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	
	
	-- Engaged set, single wield accuracy (1254 Acc)
    sets.engaged.Acc = set_combine(sets.engaged, {
		neck="Combatant's Torque",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
	})
	
	
	-- Engaged set, single wield max accuracy (1398 Acc)
	sets.engaged.MaxAcc = set_combine(sets.engaged, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
	})
	

	-- Engaged set, single wield fodder
    sets.engaged.Fodder = set_combine(sets.engaged, {})
	
	
	-- Engaged set, single wield hybrid DT (1340 Acc)
    sets.engaged.DT = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		neck="Combatant's Torque",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
	})
	

	--------------------------------------
	-- Engaged set, Dual Wield
	--------------------------------------	
    sets.engaged.DW = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    
	
	-- Engaged set, dual wield accuracy
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		neck="Combatant's Torque",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
	})
	
	
	-- Engaged set, dual wield max Accuracy
	sets.engaged.DW.MaxAcc = set_combine(sets.engaged.DW, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Combatant's Torque",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
	})
	
	
	-- Engaged set, dual wield fodder
    sets.engaged.DW.Fodder = set_combine(sets.engaged.DW, {})

	
	-- DW Hybrid DT Set 
    sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		neck="Combatant's Torque",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
	})
	
	
---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Single handed weapons
	--------------------------------------
	sets.weapons.Default = {main="Naegling", sub="Nusku Shield", range="Death Penalty"}
	sets.weapons.Savage = {main="Naegling", sub="Nusku Shield", range="Ataktos"}
	sets.weapons.LeadenRanged = {main={ name="Rostam", augments={'Path: A',}}, sub="Nusku Shield", range="Death Penalty"}
	sets.weapons.LeadenMelee = {main="Naegling", sub="Nusku Shield", range="Death Penalty"}
	sets.weapons.Aeolian = {main={ name="Rostam", augments={'Path: A',}}, sub="Nusku Shield", range="Ataktos"} 
	
	
	--------------------------------------
	-- Single handed weapons
	--------------------------------------
	sets.weapons.DualSavage = {main="Naegling", sub="Crepuscular Knife", range="Ataktos"}
	sets.weapons.DualLeadenRanged = {main={ name="Rostam", augments={'Path: A',}}, sub="Tauret", range="Death Penalty"}
	sets.weapons.DualLeadenMelee = {main="Naegling", sub="Tauret", range="Death Penalty"}
	sets.weapons.DualAeolian = {main={ name="Rostam", augments={'Path: A',}}, sub="Tauret", range="Ataktos"}
	
	
	--------------------------------------
	-- Proc weapons (Enabled in Abyssea only)
	--------------------------------------
	sets.weapons.ProcDagger = {main="Wind Knife", sub=empty, range=empty}
	sets.weapons.ProcSword = {main="Ibushi Shinai", sub=empty, range=empty}

	
---------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
---------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default weaponskill gear
	--------------------------------------
    sets.precast.WS = {
        head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Chasseur's Gants +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
    }


	-- Default weaponskill accuracy gear
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		legs="Chas. Culottes +3",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
	})
	
	
	-- Default weaponskill fodder gear
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {body="Ikenga's Vest", right_ring="Sroda Ring"})


    --------------------------------------
	-- Dagger Weaponskills
	--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		ammo="Hauksbok Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	
    --Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		-- ammo="Bayoux Bullet",
		head="Blistering Sallet +1",
		body="Meg. Cuirie +2",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Zoar Subligar +1",
		feet={ name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}},
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {
		body="Ikenga's Vest",
		feet="Ikenga's Clogs",
	})

	
    --------------------------------------
	-- Gun Weaponskills
	--------------------------------------
	-- Hot Shot
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {
		ammo="Living Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Chasseur's Gants +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	
	-- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
		ammo="Chrono Bullet",
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Ikenga's Vest",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], { })
	
    sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {
		head={ name="Ikenga's Hat", augments={'Path: A',}},
		hands="Ikenga's Gloves",
		legs={ name="Ikenga's Trousers", augments={'Path: A',}},
		feet="Ikenga's Clogs",
		left_ring="Sroda Ring",
	})
	
	
	-- Leaden Salute
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, {
		ammo="Living Bullet",
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], {
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
	})
	
	sets.precast.WS['Leaden Salute'].Fodder = set_combine(sets.precast.WS['Leaden Salute'], {})

	
	-- Terminus
	sets.precast.WS['Terminus'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Terminus'].Acc = sets.precast.WS['Last Stand'].Acc
	sets.precast.WS['Terminus'].Fodder = sets.precast.WS['Last Stand'].Fodder
	
	
	 -- Wildfire
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'], {
		head={ name="Nyame Helm", augments={'Path: B',}}, 
		left_ring="Cornelia's Ring",
	})
	
	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Leaden Salute'].Acc, {})
	sets.precast.WS['Wildfire'].Fodder = set_combine(sets.precast.WS['Leaden Salute'].Fodder, {})


	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	--Requiescat
    sets.precast.WS['Requiescat'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		right_ear="Digni. Earring",
		right_ring="Chirich Ring +1",
	})
	
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {
		body="Ikenga's Vest",
		right_ring="Sroda Ring",
	})
	
	
	--------------------------------------
	-- Swaps when using WS at 3000 TP
	--------------------------------------
	sets.MaxTP = {left_ear="Lugra Earring +1"} -- right_ear="Lugra Earring"
	sets.AccMaxTP = {}
        
 
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Kiting
	--------------------------------------
    sets.Kiting = {right_ring="Shneddick Ring"}
	
	
	--------------------------------------
	-- Treasure Hunter
	--------------------------------------
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	
	--------------------------------------
	-- Dual Wield Max
	--------------------------------------
	sets.DWMax = {
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','STR+5 DEX+5',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
    
	
    -- Resting sets
    sets.resting = {}
	
	
	-- Bullet Pouch
	sets.BulletPouch = {waist="Chr. Bul. Pouch"}
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
		['LeadenRanged']='Leaden Salute',
		['LeadenMelee']='Leaden Salute',
		['DualSavage']='Savage Blade',
		['DualLeadenRanged']='Leaden Salute',
		['DualLeadenMelee']='Leaden Salute',
		['DualAeolian']='Aeolian Edge',
	}