-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.RangedMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.CastingMode = M{['description']='Quick Draw Mode', 'Normal', 'Fodder'}
    state.IdleMode:options('Normal', 'Regen', 'Refresh')
	state.HybridMode:options('Normal', 'DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax'}
	state.Weapons:options('Savage', 'LeadenSalute', 'Aeolian')
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
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +4"}
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +4"}


-- ### Fast Cast gear ###
    sets.precast.FC = {
		sub="Demers. Degen +1",
		head={ name="Herculean Helm", augments={'VIT+4','"Mag.Atk.Bns."+17','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}, --(Aug. w/ FC +6)
		body="Taeon Tabard", --(Aug. w/ FC +5)
		hands="Nyame Gauntlets", --(Leyline Gloves, Aug. w/ FC +3)
		legs="Chas. Culottes +3", --(Herc. Trousers, Aug. w/ FC +6)
		feet="Nyame Sollerets", --(Carmine Greaves +1, Path D)
		neck="Voltsurge Torque",
		waist="Null Belt", 
		left_ear="Alabaster Earring", --(Loq. Earring)
		right_ear="Arete del Luna", --(Ench. Earring +1)
		left_ring="Murky Ring", --(Rahab Ring)
		right_ring="Kishar Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}

  -- Fast cast for specific spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"}) --(Magoraga Beads) 


-- ### Phantom Roll precast ###
    sets.precast.CorsairRoll = { --PR Duration +160, PR Effect +50, Phantom Roll +8, DT -50
		main={ name="Rostam", augments={'Path: C',}}, --PR Duration +60, Phan. Roll +8
		range="Compensator", --PR Duration +20
		head="Lanun Tricorne +3", --PR Effect +50
		body="Chasseur's Frac +3", --DT -13
		hands="Chasseur's Gants +3", --PR Duration +60
		legs="Chas. Culottes +3", --DT -12
		feet="Nyame Sollerets", --DT -7
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Eabani Earring",
		left_ring="Murky Ring", --DT -10
		right_ring="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --PR Duration +20
	}

  -- Larger AOE on Phantom Roll
	sets.precast.LuzafRing = {}
    
  -- Precast sets for Specific rolls
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +3"}) 
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +3"}) 
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +3"}) 
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})


-- ### Quick Draw Sets ###
  -- Quick Draw, Normal
	sets.precast.CorsairShot = { 
		range={ name="Doomsday", augments={'"Mag.Atk.Bns."+19','Weapon skill damage +5%','Magic Damage +13',}},
		ammo="Hauksbok Bullet",
		head="Laksa. Tricorne +4",
		body="Lanun Frac +4",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Nyame Flanchard", --(Aug. to R30, Path B)
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Skrymir Cord", --(Skrymir Cord +1)
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1", 
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+9','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}

  -- Quick Draw, Accuracy
	sets.precast.CorsairShot.Resistant = set_combine(sets.precast.CorsairShot, {
		ammo="Hauksbok Bullet", --(Amikiri Bullet)
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}}, --(Chas. Earring +2)
		left_ring="Fenrir Ring +1", --(Metamorph Ring +1, Aug. to R15)
		right_ring="Crepuscular Ring", 
		back="Null Shawl",
	})
	
  -- Quick Draw, Fodder
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {feet="Lanun Bottes +4"})
	
  -- Specific Quickdraw shots
	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot.Resistant, {})
	sets.precast.CorsairShot['Light Shot'] = set_combine{sets.precast.CorsairShot.Resistant, {}}


-- ### Ranged preshot gear ###
    sets.precast.RA = { --RS +11, SS +60
		head="Ikenga's Hat", --SS +6
		body="Ikenga's Vest", --SS +9
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, --RS +11, SS +8
		legs="Laksa. Trews +3", --SS +15
		feet="Ikenga's Clogs", --SS +5
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --SS +4
		waist="Ponente Sash", --RS +3
		left_ear="Alabaster Earring",
		right_ear="Neritic Earring",
		left_ring="Murky Ring",
		right_ring="Crepuscular Ring", --SS +3
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Snapshot"+10','Damage taken-5%',}}, --SS +10
	}

-- ### Steps and Waltz sets for /DNC ###
	sets.precast.Steps = {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Odr Earring", --(Chass. Earring +2)
		left_ring="Mummu Ring", --(Chirich Ring +1)
		right_ring="Regal Ring", --(Chirich Ring +1)
		back="Null Shawl",
	}
	
  -- Waltz
    sets.precast.Waltz = {
		head="Null Masque", 
		body="Passion Jacket",
		hands="Lanun Gants +4",
		legs="Nyame Flanchard", --(Dashing Subligar)
		feet="Nyame Sollerets", --(Rawhide Boots)
		neck="Loricate Torque +1", --(Unmoving Collar +1)
		waist="Null Belt", --(Chaac Belt)
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Arete del Luna", --(Hoxne Earring, MR 6+)
		left_ring="Murky Ring", --(Aug. to R30)
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Waltz" potency +10%','Damage taken-5%',}},
	}
		
    sets.precast.Waltz['Healing Waltz'] = {}
	sets.Self_Waltz = set_combine(sets.precast.waltz, {head="Mummu Bonnet +2"}) --Waltz effect received +9%
        
		
------------------------------------------------------------------------------------------------------------
-- Midcast Sets
------------------------------------------------------------------------------------------------------------
-- ### Fast Recast ###
    sets.midcast.FastRecast = { --FC +19
        head={ name="Herculean Helm", augments={'VIT+4','"Mag.Atk.Bns."+17','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}, --(Aug. w/ FC +6)
		body="Taeon Tabard", --(Aug. w/ FC +5)
		hands="Nyame Gauntlets", --(Leyline Gloves, Aug. w/ FC +3)
		legs="Chas. Culottes +3", --(Herc. Trousers, Aug. w/ FC +6)
		feet="Nyame Sollerets", --(Carmine Greaves +1, Path D)
		neck="Voltsurge Torque",
		waist="Null Belt", 
		left_ear="Alabaster Earring", --(Loq. Earring)
		right_ear="Arete del Luna", --(Ench. Earring +1)
		left_ring="Murky Ring", --(Rahab Ring)
		right_ring="Kishar Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}
        
  -- Fast recast for specific spells
    --Utsusemi
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {body="Passion Jacket"})


-- ### Ranged midshot gear ###
	sets.midcast.RA = {
        head="Ikenga's Hat", --(Aug. to R30)
		body="Ikenga's Vest", --(Aug. to R30)
		hands="Ikenga's Gloves", --(Aug. to R30)
		legs="Chas. Culottes +3",
		feet="Ikenga's Clogs", --(Aug. to R30)
		neck="Iskur Gorget",
		waist="Ponente Sash", --(Yemaya Belt)
		left_ear="Alabaster Earring", --(Telos Earring)
		right_ear="Neritic Earring", --(Crepuscular Earring)
		left_ring="Ilabrat Ring", 
		right_ring="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},
	}

  -- Ranged Attack, Accuracy 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		waist="Null Belt",
		back="Null Shawl",
	})
	
  -- Ranged Attack, Full Accuracy
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA, { 
		head="Laksa. Tricorne +4",
		body="Laksa. Frac +3",
		hands="Chasseur's Gants +3",
		feet="Laksa. Bottes +4",
		neck="Null Loop",
		waist="Null Belt",
		left_ring="Regal Ring",
		back="Null Shawl",
	})
	
  -- Ranged Attack, Subtble Blow
	sets.midcast.RA.SubtleBlow = set_combine(sets.midcast.RA, {})
	
	
-- ### Triple Shot gear ###
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
		--head="Oshosi Mask +1",
		body="Chasseur's Frac +3",
		hands="Lanun Gants +4",
		--legs="Osh. Trousers +1",
		--feet="Osh. Leggings +1",
	})


------------------------------------------------------------------------------------------------------------
-- Idle Sets
------------------------------------------------------------------------------------------------------------
-- ### Base Idle Set ###
    sets.idle = {
		head="Null Masque", 
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Chas. Culottes +3",
		feet="Meg. Jam. +2",
		neck="Loricate Torque +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Shneddick Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
		
  -- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {})
	
  -- Regain idle set
	sets.idle.Regain = set_combine(sets.idle, {})
  
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {}) 


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
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	
------------------------------------------------------------------------------------------------------------
-- Defense Sets
------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
    sets.defense.PDT = { --DT -50
        head="Nyame Helm", --DT -7 (Aug. to R30)
		body="Nyame Mail", --DT -9 (Aug. to R30)
		hands="Nyame Gauntlets", --DT -7 (Aug. to R30)
		legs="Nyame Flanchard", --DT -8 (Aug. to R30)
		feet="Nyame Sollerets", --DT -7 (Aug. to R30)
		neck="Loricate Torque +1", --DT -6 (Aug. to R15)
		waist="Null Belt",
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30)
		right_ear="Eabani Earring",
		left_ring="Murky Ring", --DT -10 (Aug. to R30)
		right_ring="Archon Ring", --(Warden's Ring)
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

  -- Magical damage taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
  -- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		waist="Null Belt", 
		back="Null Shawl",
	})
	
-- ### Misc. Defensive Sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}
	
-----------------------------------------------------------------------------------------------------------
-- Offensive Sets
-----------------------------------------------------------------------------------------------------------
-- ### Engaged Sets ###
	sets.engaged = { 
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --(Clemency Somon, Aug. to R30)
		body="Nyame Mail", --(Clemency Harimaki, Aug. to R30)
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --(Clemency Kote, Aug. to R30)
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Nyame Sollerets", --(Clemency Sune-Ate, Aug. to R30) 
		neck="Iskur Gorget",
		waist="Null Belt", --(Reiki Yotai)
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Eabani Earring", --(Dedition Earring)
		left_ring="Ilabrat Ring", --(Epona's Ring)
		right_ring="Rajas Ring", --(Petrov Ring)
		back="Null Shawl",
	}
	
  -- Engaged set, accuracy 
    sets.engaged.Acc = set_combine(sets.engaged, {
		neck="Null Loop",
		back="Null Shawl", 
	})
	
  -- Engaged set, full acc
	sets.engaged.FullAcc = set_combine(sets.engaged, { 
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Null Loop",
		waist="Null Belt", --(Reiki Yotai)
		left_ear="Alabaster Earring", --(Aug. to R30)
		right_ear="Eabani Earring",
		left_ring="Ilabrat Ring", --(Chirich Ring +1)
		right_ring="Regal Ring", --(Chirich Ring +1)
		back="Null Shawl", 
	})


-- ### Engaged set, hybrid DT ###
    sets.engaged.DT = { --DT -50, Store TP +65, Dual Wield +4
		head="Chass. Tricorne +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Chas. Culottes +3",
		feet="Nyame Sollerets",
		neck="Iskur Gorget",
		waist="Null Belt",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	
-- ### Extra melee sets ###
	sets.DWMid = {}
	sets.DWMax = {}
	sets.SubtleBlow = {}
	
	
-----------------------------------------------------------------------------------------------------------
-- Weapons & weaponskill sets
-----------------------------------------------------------------------------------------------------------
-- ### Weapon sets ###	
	sets.weapons.Savage = {
		main="Naegling", 
		sub="Demersal Degen +1", --(Gleti's Knife, Aug. to R30)
		range="Ataktos",
	}
	
	sets.weapons.SavageLeaden = {
		main="Naegling", 
		sub="Telopanos Saber", --(Aug. to R30)
		range={ name="Doomsday", augments={'"Mag.Atk.Bns."+19','Weapon skill damage +5%','Magic Damage +13',}}, --(Death Penalty, Aug. to R15)
	}
	
	sets.weapons.LeadenSalute = {
		main={ name="Rostam", augments={'Path: C',}}, --(Rostam, Path A, Aug. to R25)
		sub="Telopanos Saber", --(Aug. to R30)
		range={ name="Doomsday", augments={'"Mag.Atk.Bns."+19','Weapon skill damage +5%','Magic Damage +13',}}, --(Death Penalty, Aug. to R15)
	}
	
	--sets.weapons.LastStand = {main="Naegling", sub="Gleti's Knife", range="Fomalhaut"}
	
	sets.weapons.Aeolian = {
		main={ name="Rostam", augments={'Path: C',}}, --(Rostam, Path A, Aug. to R25)
		sub="Telopanos Saber", --(Aug. to R30)
		range="Ataktos",
	}
	
	
-- ### Default weaponskill gear ###
	sets.precast.WS = { 
		head="Nyame Helm", --(Path B: Aug. to R30)
		body="Nyame Mail", --(Path B: Aug. to R30)
		hands="Chasseur's Gants +3", 
		legs="Nyame Flanchard", --(Path B: Aug. to R30)
		feet="Nyame Sollerets", --(Path B: Aug. to R30)
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --(Rep. Plat. Medal)
		waist="Null Belt", --(Sailfi Belt +1: Aug. to R15)
		left_ear="Alabaster Earring", --(Moonshade Earring)
		right_ear="Odr Earring", --(Hoxne Earring: MR 6+)
		left_ring="Sroda Ring", --(Epaminondas's Ring)
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {})


  -- Dagger Weaponskills
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo="Hauksbok Bullet",
		body="Lanun Frac +4",
		hands="Nyame Gauntlets", --(Path B: Aug. to R30)
		feet="Lanun Bottes +4", 
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --(Baetyl Pendant)
		waist="Eschan Stone", --(Orpheus's Sash)
		left_ear="Sortiarius Earring", --(Moonshade Earring)
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Fenrir Ring +1", --(Epaminondas's Ring)
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}, --(Ambu Cape: INT +30, MAcc/MDmg +20, WSD +10, DT -5)
	})
	
    --Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {left_ear="Mache Earring +1"})


  -- Gun Weaponskills
	-- Hot Shot
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {
		hands="Nyame Gauntlets", --(Path B: Aug. to R30)
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --(Fotia Gorget)
		waist="Eschan Stone", --(Fotia Belt)
		left_ear="Sortiarius Earring", --(Moonshade Earring)
		right_ear="Friomisi Earring", --(Hoxne Earring)
		left_ring="Dingir Ring", 
		right_ring="Fenrir Ring +1", --(Epaminondas's Ring)
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS['Hot Shot'].Fodder = set_combine(sets.precast.WS, {})

	-- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
		head="Lanun Tricorne +3", --(Upgrade to +4)
		body="Ikenga's Vest", --(Aug. to R30)
		feet="Lanun Bottes +4", 
		waist="Null Belt", --(Fotia Belt)
		right_ear="Neritic Earring", --(Hoxne Earring, MR 6+)
		left_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {})
	
	-- Leaden Salute
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, {
		head="Pixie Hairpin +1",
		body="Lanun Frac +4",
		hands="Nyame Gauntlets",
		feet="Lanun Bottes +4",
		waist="Skrymir Cord",
		left_ear="Sortiarius Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
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


  -- Sword Weaponskills
    -- Requiescat
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Nyame Helm", --(Path B: Aug. to R30)
		body="Nyame Mail", --(Path B: Aug. to R30)
		legs="Nyame Flanchard", --(Path B: Aug. to R30)
		feet="Nyame Sollerets", --(Path B: Aug. to R30)
		left_ear="Alabaster Earring", --(Moonshade Earring)
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}}, --(Hoxne Earring, MR 6+)
		left_ring="Murky Ring", --(Aug. to R30)
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, 
	})
	
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    -- Savage Blade (Uses the default WS set)
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
-- ### Misc. Weaponskill Swaps ###
	sets.MaxTP = {} -- right_ear="Lugra Earring"
	sets.AccMaxTP = {}
 
 
-----------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-----------------------------------------------------------------------------------------------------------
-- ### Sets to equip when a buff is applied ###
  -- Phalanx
	sets.Phalanx = {
		head="Taeon Chapeau", --(Aug. w/ Phalanx +3)
		body="Taeon Tabard", --(Aug. w/ Phalanx +3)
		hands="Taeon Gloves", --(Aug. w/ Phalanx +3)
		legs="Taeon Tights", --(Aug. w/ Phalanx +3)
		feet="Taeon Boots", --(Aug. w/ Phalanx +3)
	}
	
  -- Reive Mark
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {neck="Ygnas's Resolve +1"})

-- ### Sets to equip when a debuff is applied ###
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
-- ### Misc. sets ###
  -- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		feet="Volte Boots",
	})
		
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