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
    sets.precast.FC = { --FC +19~21/80
		sub="Derersal Degen +1", --FC +1~3
		head="Null Masque", --(Herculean Helm, aug w/ FC +6)
		body="Chasseur's Frac +3", --DT -13 (Dread Jupon)
		hands="Nyame Gauntlets", --DT -7 (Leyline Gloves, aug with FC +3)
		legs="Chas. Culottes +2", --DT -11
		feet="Nyame Sollerets", --DT -7 (Carmine Greaves +1)
		neck="Voltsurge Torque", --FC +4 (Baetyl Pendant)
		waist="Carrier's Sash", --
		left_ear="Alabaster Earring", --DT -5 (Locquacious Earring)
		right_ear="Arete del Luna", --(Enchanter's Earring +1)
		left_ring="Kishar Ring", --FC +4
		right_ring="Shneddick Ring", --(Rahab Ring)
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10
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
		legs="Chas. Culottes +2", --DT -11
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
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +2"}) --(Upgrade to +3)
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +2"}) --(Upgrade to +3)
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +2"}) --(Upgrade to +3)
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})

-- ### Quick Draw Sets ###
  -- Quick Draw, Normal
	sets.precast.CorsairShot = { --Quick Draw Damage +20 
		ammo="Hauksbok Bullet",
		head="Laksa. Tricorne +2", --Quick Draw Damage +10
		body="Chasseur's Frac +2", --Set: Augments "Quick Draw" effect
		hands="Chasseur's Gants +3", --Set: Augments "Quick Draw" effect
		legs="Chas. Culottes +2", --Set: Augments "Quick Draw" effect
		feet="Laksa. Bottes +2", --Quick Draw Damage +10
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Murky Ring", --DT -10
		right_ring="Archon Ring", 
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+9','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5
	}

  -- Quick Draw, Fodder
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {}) --(Upgrade to +3)
		
  -- Specific Quickdraw shots
	--sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})
	--sets.precast.CorsairShot['Light Shot'] = set_combine{sets.precast.CorsairShot.Resistant, {}}

-- ### Ranged preshot gear ###
    sets.precast.RA = { --Rapid Shot +50, Snapshot +40/70
		head="Chass. Tricorne +2", --Rapid Shot +16
		body="Laksa. Frac +3", --Rapid Shot +20
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, --Rapid Shot +11, Snapshot +8
		legs="Laksa. Trews +3", --Snapshot +15
		feet="Meg. Jam. +2", --Snapshot +10
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --Snapshot +4
		waist="Ponente Sash", --Rapid Shot +3
		left_ear="Alabaster Earring", 
		right_ear="Arete del Luna",
		left_ring="Murky Ring",
		right_ring="Crepuscular Ring", --Snapshot +3
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+9','"Mag.Atk.Bns."+10','Damage taken-5%',}}, 
	}

--------------------------------------
-- Step Sets for /DNC
--------------------------------------
	sets.precast.Steps = { --Acc 1376
		head="Null Masque",
		body="Chasseur's Frac +2",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +2",
		feet="Chass. Bottes +2",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Odr Earring",
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Mummu Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
--------------------------------------
-- Waltz sets for /DNC
--------------------------------------
-- Curing Waltz on others
    sets.precast.Waltz = {
		head="Null Masque",
		body="Passion Jacket",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna",
		left_ring="Murky Ring",
		right_ring="Mummu Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}
		
  -- Curing Waltz on aelf
	sets.Self_Waltz = set_combine(sets.precast.waltz, {head="Mummu Bonnet +2"})
        
  -- Healing Waltz
    sets.precast.Waltz['Healing Waltz'] = {}
	
------------------------------------------------------------------------------------------------------------
-- Midcast Sets
------------------------------------------------------------------------------------------------------------
-- ### Fast Recast ###
    sets.midcast.FastRecast = { --FC +19
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque", --FC +5
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna",
		left_ring="Murky Ring",
		right_ring="Kishar Ring", --FC +4
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10
	}
        
  -- Fast recast for specific spells
    --Utsusemi
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {body="Passion Jacket"})

-- ### Ranged midshot gear ###
	sets.midcast.RA = { --Ranged Acc 1212, Ranged Atk 1307, Store TP +42
        head="Lanun Tricorne +3",
		body="Nyame Mail",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Chas. Culottes +2",
		feet="Nyame Sollerets",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Neritic Earring",
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Crepuscular Ring",
		right_ring="Rajas Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

  -- Ranged Attack, Accuracy 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, { --Ranged Acc 1270, Ranged Atk 1241, Store TP +36
		head="Chass. Tricorne +2",
		hands="Nyame Gauntlets",
	})
	
  -- Ranged Attack, Full Accuracy
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA, { --Ranged Acc. 1302, Ranged Atk 1319, Store TP +31
		head="Chass. Tricorne +2",
		body="Chasseur's Frac +2",
		hands="Chasseur's Gants +3",
		feet="Chass. Bottes +2",
		right_ring="Mummu Ring",
	})
	
  -- Ranged Attack, Subtble Blow
	sets.midcast.RA.SubtleBlow = set_combine(sets.midcast.RA, {})
	
-- ### Triple Shot gear ###
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
		--head="Oshosi Mask +1",
		body="Chasseur's Frac +2", -- Triple Shot +13
		hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}}, -- Triple Shot occ. becomes Quad Shot (Upgrade to +4)
		--legs="Osh. Trousers +1",
		--feet="Osh. Leggings +1",
	})

------------------------------------------------------------------------------------------------------------
-- Idle Sets
------------------------------------------------------------------------------------------------------------
-- ### Base Idle Set ###
    sets.idle = { --DT -53/50, Regain +2, Regen +9, Refresh +1
		head="Null Masque",
		body="Chasseur's Frac +2",
		hands="Meg. Gloves +2",
		legs="Chas. Culottes +2",
		feet="Meg. Jam. +2",
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna",
		left_ring="Murky Ring",
		right_ring="Shneddick Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}
		
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		--neck="Bathy Choker +1",
		--right_ear="Infused Earring",
	}) 

  -- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {})
	
-- ### Resting set ###
    sets.resting = { --Regain +2, Regen +18, Refresh +1
		head="Null Masque", --Regain +2, Regen +3, Refresh +1
		body="Meg. Cuirie +2", --Set: Regen +12
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Null Loop", --(Bathy Choker +1)
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring",  
		right_ear="Arete del Luna", --(Infused Earring)
		left_ring="Murky Ring", --(Chirich Ring +1)
		right_ring="Mummu Ring", --(Chirich Ring +1)
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --(Cape with Regen +5)
	}
	
-------------------------------------------------------------------------------------------------------------- Defense Sets
-------------------------------------------------------------------------------------------------------------- ### Physical damage taken ###
    sets.defense.PDT = { --DT 53/50
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna",
		left_ring="Murky Ring",
		right_ring="Archon Ring",
		back="Null Shawl",
	}

  -- Magical damage taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {waist="Carrier's Sash"})
	
  -- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		waist="Null Belt", --MEVA +30
		back="Null Shawl", --MEVA +50
	})
	
-----------------------------------------------------------------------------------------------------------
-- Offensive Sets
-----------------------------------------------------------------------------------------------------------
-- ### Engaged Sets ###
	sets.engaged = { --Acc 1318, DT -22, Double Atk. +16, Triple Atk. +3, Store TP +35, Subtle Blow +5
		head="Null Masque", --DT -10
		body="Mummu Jacket +2", --Store TP +6
		hands="Mummu Wrists +2", --Double Attack +6
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}, --Double Attack +3, Triple Attack +3, Store TP +7
		feet="Nyame Sollerets", --DT -7, Path A: Store TP +4
		neck="Null Loop", --DT -5
		waist="Null Belt", 
		left_ear="Neritic Earring", --Store TP +4
		right_ear="Suppanomimi", --Dual Wield +5
		left_ring="Crepuscular Ring", --Store TP +6
		right_ring="Rajas Ring", --Store TP +5, Subtle Blow +5
		back="Null Shawl", --Double Attack +7, Store TP +7
	}
	
  -- Engaged set, accuracy 
    sets.engaged.Acc = set_combine(sets.engaged, {})
	
  -- Engaged set, full acc
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
  -- Engaged set, subtle blow
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	
  -- Engaged set, hybrid DT
    sets.engaged.DT = set_combine(sets.engaged, { --Acc 1316, DT -50, Store TP +36,
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Chas. Culottes +2",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	})
	
-- ### Dual Wield Sets ###
	sets.DWMid = {}
	sets.DWMax = {}
		
-----------------------------------------------------------------------------------------------------------
-- Weapon Sets
-----------------------------------------------------------------------------------------------------------
	sets.weapons.Savage = {main="Naegling", sub="Demersal Degen +1", range="Compensator"}
	sets.weapons.LeadenSalute = {main="Naegling", sub="Demersal Degen +1", range="Doomsday"}
	--sets.weapons.LastStand = {main="Naegling", sub="Gleti's Knife", range="Fomalhaut"}
	sets.weapons.Aeolian = {main={ name="Rostam", augments={'Path: C',}}, sub="Blurred Knife +1", range="Compensator"}
	
-----------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-----------------------------------------------------------------------------------------------------------
-- ### Default weaponskill gear ###
	sets.precast.WS = { --PDT -31/MDT -25, WSD -35, 
		head="Nyame Helm",
		body="Laksa. Frac +2",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear="Odr Earring",
		left_ring="Sroda Ring",
		right_ring="Rajas Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

  -- Default weaponskill accuracy gear
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
  -- Default weaponskill fodder gear
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

-- ### Dagger Weaponskills ###
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {})
	
    --Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {left_ear="Mache Earring +1"})

-- ### Gun Weaponskills ###
  -- Hot Shot
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS['Hot Shot'].Fodder = set_combine(sets.precast.WS, {})

  -- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {})
	
  -- Leaden Salute
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Lanun Frac +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Sortiarius Earring",
		right_ear="Friomisi Earring",
		left_ring="Crepuscular Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+9','"Mag.Atk.Bns."+10','Damage taken-5%',}},
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
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {
		neck="Ygnas's Resolve +1",
	})
	
-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		feet="Volte Boots",
	})
	
-- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
-- Bullet Pouch
	sets.BulletPouch = {}
end

-----------------------------------------------------------------------------------------------------------
-- Miscelaneous
-----------------------------------------------------------------------------------------------------------
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