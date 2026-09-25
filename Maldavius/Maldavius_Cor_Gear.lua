-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.RangedMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.CastingMode = M{['description']='Quick Draw Mode', 'Normal', 'Fodder'}
    state.IdleMode:options('Normal', 'Regen', 'Refresh')
	state.HybridMode:options('Normal', 'DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax'}
	state.Weapons:options('Savage', 'Aeolian')
	state.CompensatorMode:options('Always', '300', '1000', 'Never')

    gear.RAbullet = "Eminent Bullet"
    gear.WSbullet = "Eminent Bullet"
    gear.MAbullet = "Eminent Bullet" --For MAB WS, do not put single-use bullets here.
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
-----------------------------------------------------------------------------------------------------------
-- START DEFINING THE SETS
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-- PRECAST SETS
-----------------------------------------------------------------------------------------------------------
-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"} --(Upgrade to +4)
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +4"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"} --(Upgrade to +4)
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"} --(Upgrade to +4)

-- ### Fast Cast gear ###
    sets.precast.FC = { --FC +25/80, DT -51
		head={ name="Herculean Helm", augments={'VIT+4','"Mag.Atk.Bns."+17','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}, --FC +7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Voltsurge Torque", --FC +4
		waist="Null Belt",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Murky Ring", --DT -10
		right_ring="Kishar Ring", --FC +4
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10, DT -5
	}

  -- Fast cast for specific spells
	--sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"}) --(Magoraga Beads) 

-- ### Phantom Roll precast ###
    sets.precast.CorsairRoll = { --P. Roll Effect Duration +185, Phantom Roll Effect +8, DT -50
		main={ name="Rostam", augments={'Path: C',}}, -- P. Roll Effect Duration +60, Phantom Roll +8
		range="Compensator", --P. Roll Effect Duration +20
		head="Lanun Tricorne +3", -- P. Roll Effect Duration +50
		body="Chasseur's Frac +3", --DT -13
		hands="Chasseur's Gants +3", -- P. Roll Effect Duration +55
		legs="Chas. Culottes +3", --DT -11
		feet="Nyame Sollerets", --DT -7
		neck="Warder's Charm +1", --(Regal Necklace)
		waist="Null Belt", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Murky Ring", --DT -10
		right_ring="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --P. Roll Effect Duration +30, DT -5
	}

  -- Larger AOE on Phantom Roll
	sets.precast.LuzafRing = {}
    
  -- Precast sets for Specific rolls
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +3"}) --(Upgrade to +3)
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +2"}) --(Upgrade to +3)
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +2"}) --(Upgrade to +3)
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})

-- ### Quick Draw Sets ###
  -- Quick Draw, Normal
	sets.precast.CorsairShot = { 
		ammo="Hauksbok Bullet",
		head="Laksa. Tricorne +4",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Fenrir Ring +1",
		right_ring="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+9','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}

  -- Quick Draw, Fodder
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {
		feet="Laksa. Bottes +4",
		waist="Null Belt",
		left_ring="Kishar Ring",
		back="Null Shawl",
	})
	
  -- Quick Draw, Resistant
	sets.precast.CorsairShot.Resistant = set_combine(sets.precast.CorsairShot, {})
		
  -- Specific Quickdraw shots
	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})
	sets.precast.CorsairShot['Light Shot'] = set_combine{sets.precast.CorsairShot.Resistant, {}}

-- ### Ranged preshot gear ###
    sets.precast.RA = { --RS +xx, SS +xx
		head="Chass. Tricorne +2", --RS +16 (Upgrade to +3)
		body="Laksa. Frac +3", --RS +20 (Oshosi Vest +1)
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, --RS +11, SS +8
		legs="Lanun Trews +3", --SS +10 (Upgrade to +4)
		feet="Meg. Jam. +2", --SS +10
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --SS +4
		waist="Ponente Sash", --RS +3 (Yemaya Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring", --DT -10
		right_ring="Crepuscular Ring", --SS +3
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+9','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Ambu cape Agi +30, Acc/RAcc +20, Snapshot +10, DT -5)
	}

-- ### Steps and Waltz sets for /DNC ###
	sets.precast.Steps = { --Acc 1376
		head="Null Masque",
		body="Chasseur's Frac +2",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Odr Earring",
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Mummu Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
  -- Waltz
    sets.precast.Waltz = {
		head="Null Masque",
		body="Passion Jacket", --Waltz Potency +13%
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard", --(Dashing Subligar)
		feet="Nyame Sollerets", --(Rawhide Boots)
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna",
		left_ring="Murky Ring",
		right_ring="Mummu Ring", --(Valseur's Ring)
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}
		
    sets.precast.Waltz['Healing Waltz'] = {}
	sets.Self_Waltz = set_combine(sets.precast.waltz, {head="Mummu Bonnet +2"}) --Waltz effect received +9%
        
------------------------------------------------------------------------------------------------------------
-- Midcast Sets
------------------------------------------------------------------------------------------------------------
-- ### Fast Recast ###
    sets.midcast.FastRecast = { --FC +19
        head="Null Masque", --(Herculean Helm, aug w/ FC +6)
		body="Chasseur's Frac +3", --DT -13 (Dread Jupon)
		hands="Nyame Gauntlets", --DT -7 (Leyline Gloves, aug with FC +3)
		legs="Chas. Culottes +3", --DT -11
		feet="Nyame Sollerets", --DT -7 (Carmine Greaves +1)
		neck="Voltsurge Torque", --FC +4 (Baetyl Pendant)
		waist="Carrier's Sash", --
		left_ear="Alabaster Earring", --DT -5 (Locquacious Earring)
		right_ear="Arete del Luna", --(Enchanter's Earring +1)
		left_ring="Kishar Ring", --FC +4
		right_ring="Shneddick Ring", --(Rahab Ring)
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10
	}
        
  -- Fast recast for specific spells
    --Utsusemi
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {body="Passion Jacket"})

-- ### Ranged midshot gear ###
	sets.midcast.RA = { --RAcc 1310, RAtk 1291, Store TP +69
        head="Chass. Tricorne +2", --(Ikenga's Hat)
		body="Nyame Mail", --Path A: Store TP +8 (Ikenga's Vest)
		hands="Nyame Gauntlets", --Path A: Store TP +8 (Ikenga's Gloves)
		legs="Chas. Culottes +3", --Store TP +12
		feet="Nyame Sollerets", --Path A: Store TP +8 (Ikenga's Clogs)
		neck="Iskur Gorget", --Store TP +8
		waist="Null Belt", --(Yemaya Belt)
		left_ear="Alabaster Earring", --(Telos Earring)
		right_ear="Neritic Earring", --Store TP +4 (Crep. Earring)
		left_ring="Rajas Ring", --Store TP +5 (Ilabrat Ring)
		right_ring="Crepuscular Ring", --Store TP +6
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --Store TP +10 (Ambu Cape with AGI +30, RAtk/RAcc +20, Store TP +10, DT -5)
	}

  -- Ranged Attack, Accuracy 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, { --RAcc 1382, RAtk 1247, Store TP +66
		head="Laksa. Tricorne +4",
		back="Null Shawl", 
	})
	
  -- Ranged Attack, Full Accuracy
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA, { --RAcc 1480, RAtk 1330, Store TP 
		head="Laksa. Tricorne +4",
		body="Laksa. Frac +3",
		hands="Chasseur's Gants +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		left_ring="Regal Ring",
		back="Null Shawl",
	})
	
  -- Ranged Attack, Subtble Blow
	sets.midcast.RA.SubtleBlow = set_combine(sets.midcast.RA, {})
	
-- ### Triple Shot gear ###
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
		--head="Oshosi Mask +1",
		body="Chasseur's Frac +3", -- Triple Shot +14
		hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}}, -- Triple Shot occ. becomes Quad Shot (Upgrade to +4)
		--legs="Osh. Trousers +1",
		--feet="Osh. Leggings +1",
	})

------------------------------------------------------------------------------------------------------------
-- Idle Sets
------------------------------------------------------------------------------------------------------------
-- ### Base Idle Set ###
    sets.idle = { --Regain +2, Regen +17, Refresh +1, DT -43/50 (PDT -50)
		head="Null Masque", --Refresh +1, Regain +2, Regen +3, DT -10
		body="Meg. Cuirie +2", --Set: Regen +6
		hands="Meg. Gloves +2",
		legs="Chas. Culottes +3", --DT -12
		feet="Meg. Jam. +2",
		neck="Loricate Torque +1", --DT -6
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Camulus's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','"Regen"+5',}}, --Regen +5
	}
		
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {}) 

  -- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {})
	
-- ### Resting set ###
    sets.resting = { --Regain +2, Regen +20, Refresh +1
		head="Null Masque", --Regain +2, Regen +3, Refresh +1
		body="Meg. Cuirie +2", --Set: Regen +9
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Loricate Torque +1", --(Bathy Gorget +1)
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", 
		right_ear="Arete del Luna", --(Infused Earring)
		left_ring="Murky Ring", --(Chirich Ring +1)
		right_ring="Shneddick Ring", --(Chirich Ring +1)
		back={ name="Camulus's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','"Regen"+5',}}, --Regen +5
	}
	
------------------------------------------------------------------------------------------------------------ 
-- Defense Sets
------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
    sets.defense.PDT = { --DT -50
        head="Nyame Helm", --DT -7 (Augment to R30)
		body="Nyame Mail", --DT -9 (Augment to R30)
		hands="Nyame Gauntlets", --DT -7 (Augment to R30)
		legs="Nyame Flanchard", --DT -8 (Augment to R30)
		feet="Nyame Sollerets", --DT -7 (Augment to R30)
		neck="Loricate Torque +1", --DT -6 (Augment to R15)
		waist="Null Belt",
		left_ear="Alabaster Earring", --DT -5 (Augment to R30
		right_ear="Eabani Earring",
		left_ring="Murky Ring", --DT -10 (Augment to R30)
		right_ring="Archon Ring",
		back="Null Shawl",
	}

  -- Magical damage taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Arete del Luna",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	})
	
  -- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		waist="Null Belt", 
		right_ear="Eabani Earring",
		back="Null Shawl",
	})
	
-----------------------------------------------------------------------------------------------------------
-- Offensive Sets
-----------------------------------------------------------------------------------------------------------
-- ### Engaged Sets ###
	sets.engaged = {  --DT -16, DA +10, TA +11, Store TP +56
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --TA +4 (Clemency Somon) 
		body="Nyame Mail", --DT -9, Store TP +8 (Clemency Haramaki)
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --TA +4, Store TP +7 (Clemency Kote)
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}, --DA +3, TA +3, Store TP +7
		feet="Nyame Sollerets", --DT -7, Store TP +8 (Clemency Sune-Ate)
		neck="Iskur Gorget", --Store TP +8
		waist="Null Belt", --(Reiki Yotai)
		left_ear="Suppanomimi", --Dual Wield +5
		right_ear="Eabani Earring", --Dual Wield +4
		left_ring="Rajas Ring", --Store TP +5 (Epona's Ring)
		right_ring="Crepuscular Ring", --Store TP +6 (Petrov Ring)
		back="Null Shawl", --DA +7, Store TP +7
	}
	
  -- Engaged set, accuracy 
    sets.engaged.Acc = set_combine(sets.engaged, { --Acc 1370, DT -49/50, Store TP +54
		head="Chass. Tricorne +2", --DT -9 (Upgrade to +3)
		legs="Chas. Culottes +3", --DT -12, Store TP +12
		neck="Null Loop", --DT -5
	})
	
  -- Engaged set, full acc
	sets.engaged.FullAcc = set_combine(sets.engaged, { --Acc 1416, DT -53/50, DA +7, Store TP +40, Dual Wield +5
		head="Chass. Tricorne +2", --DT -9
		body="Chasseur's Frac +3", --DT -13
		hands="Nyame Gauntlets", --DT -7, Store TP +8
		legs="Chas. Culottes +3", --DT -12, Store TP +12
		neck="Null Loop", --DT -5
		waist="Null Belt", --(Reiki Yotai)
		right_ear="Odr Earring",
		right_ring="Mummu Ring",
	})

-- ### Engaged set, hybrid DT ###
    sets.engaged.DT = set_combine(sets.engaged, { --DT -50, Store TP +65, Dual Wield +4
		head="Chass. Tricorne +2", --DT -9 (Upgrade to +3)
		body="Nyame Mail", --DT -9, Store TP +8 (Augment to R30)
		hands="Nyame Gauntlets", --DT -7, Store TP +8 (Augment to R30)
		legs="Chas. Culottes +3", --DT -12, Store TP +12
		feet="Nyame Sollerets", --DT -7, Store TP +8 (Augment to R30)
		neck="Iskur Gorget", --Store TP +8
		waist="Null Belt", --(Reiki Yotai)
		left_ear="Alabaster Earring", --DT -5 (Augment to R30)
		right_ear="Eabani Earring", --Dual Wield +4
		left_ring="Rajas Ring", --Store TP +5
		right_ring="Crepuscular Ring", --Store TP +6
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --DT -5, Store TP +10
	})
	
-- ### Extra melee sets ###
	sets.DWMid = {}
	sets.DWMax = {}
	sets.SubtleBlow = {}
		
-----------------------------------------------------------------------------------------------------------
-- Weapons & weaponskill sets
-----------------------------------------------------------------------------------------------------------
-- ### Weapon sets ###	
	sets.weapons.Savage = {main="Naegling", sub="Demersal Degen +1", range="Ataktos"}
	sets.weapons.LeadenSalute = {main="Naegling", sub="Demersal Degen +1", range="Doomsday"}
	sets.weapons.HotShot = {main="Naegling", sub="Demersal Degen +1", range="Doomsday"}
	--sets.weapons.LastStand = {main="Naegling", sub="Gleti's Knife", range="Fomalhaut"}
	sets.weapons.Aeolian = {main={ name="Rostam", augments={'Path: C',}}, sub="Blurred Knife +1", range="Ataktos"}
	
-- ### Default weaponskill gear ###
	sets.precast.WS = { 
		head="Nyame Helm", --WSD +4 (Augment to R30)
		body="Laksa. Frac +3", --WSD +10 (Upgrade to +4)
		hands="Chasseur's Gants +3", --WSD +12
		legs="Nyame Flanchard", --WSD +4 (Path B: Augment to R30)
		feet="Lanun Bottes +4", --WSD +12
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Sroda Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --WSD +10
	}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {})

  -- Dagger Weaponskills
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		body="Lanun Frac +4",
		hands="Nyame Gauntlets",
		left_ear="Sortiarius Earring",  
		right_ear="Friomisi Earring",
		left_ring="Murky Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --(Ambu Cape, INT, MAtk/Macc, MAB, WSD)
	})
	
    --Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {left_ear="Mache Earring +1"})

  -- Gun Weaponskills
	-- Hot Shot
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear="Friomisi Earring",
		left_ring="Regal Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS['Hot Shot'].Fodder = set_combine(sets.precast.WS, {})

	-- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {})
	
	-- Leaden Salute
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], {})
	sets.precast.WS['Leaden Salute'].Fodder = set_combine(sets.precast.WS['Leaden Salute'], {})

	-- Terminus
	sets.precast.WS['Terminus'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Terminus'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Terminus'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    -- Wildfire
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Wildfire'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  -- ### Sword Weaponskills ###
    -- Requiescat
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    -- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
-- ### Swaps when using WS at 3000 TP ###
	sets.MaxTP = {} -- right_ear="Lugra Earring"
	sets.AccMaxTP = {}
 
-----------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-----------------------------------------------------------------------------------------------------------
-- Kiting
    sets.Kiting = {right_ring="Shneddick Ring"}

-- Reive mark, worn within colonization/lair reives
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {neck="Ygnas's Resolve +1"})
	
-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		feet="Volte Boots",
	})
	
-- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
-- Bullet Pouch
	sets.BulletPouch = {}
end

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