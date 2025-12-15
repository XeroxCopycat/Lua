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
--------------------------------------
-- Fast Cast gear
--------------------------------------
    sets.precast.FC = {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Chas. Culottes +3",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

-- Fast cast for specific spells
  -- Cure
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})
	
  -- Utsusemi
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"}) -- body="Passion Jacket"

--------------------------------------
-- Phantom Roll precast
--------------------------------------
    sets.precast.CorsairRoll = {
		main={ name="Rostam", augments={'Path: C',}},
		range={ name="Compensator", augments={'DMG:+15','AGI+15','Rng.Acc.+15',}},
		head="Lanun Tricorne +3",
		body="Chasseur's Frac +4",
		hands="Nyame Gauntlets",
		legs="Chas. Culottes +3",
		feet="Nyame Sollerets",
		neck="Regal Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Murky Ring",
		right_ring="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

-- Larger AOE on Phantom Roll
	sets.precast.LuzafRing = {right_ring="Luzaf's Ring"}
    
-- Precast sets for Specific rolls
  -- Caster's Roll
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
  
  -- Courser's Roll  
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +4"})
    
  -- Blitzer's Roll
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    
  -- Tactician's Roll	
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +4"})
    
  -- Allies' Roll
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})

--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
  -- Triple Shot
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +4"}
    
  -- Snake Eye
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
	
  -- Wild Card
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +4"}
    
  -- Random Deal
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +4"}
    
  -- Fold
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

--------------------------------------
-- Quick Draw Sests
--------------------------------------
  -- Quick Draw, Normal
	sets.precast.CorsairShot = {
		ammo="Hauksbok Bullet",
		head="Ikenga's Hat",
		body="Lanun Frac +4", -- Upgrade to +4
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4", -- Upgrade to +4
		neck="Baetyl Pendant",
		waist="Eschan Stone", -- Skrymir Belt +1
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1", -- Fenrir Ring +1
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}, 
	}

-- Quick Draw, Fodder (Chass. Bottes +4 for +31% elemental bonus on quick draw)
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {feet="Chass. Bottes +4"})
		
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
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {body="Laksa. Frac +4", waist="Yemaya Belt"})
	
	-- Flurry II / Snapshop 30%
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
		body="Laksa. Frac +4", 
		waist="Yemaya Belt",
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
	})

--------------------------------------
-- Step Sets for /DNC
--------------------------------------
	sets.precast.Steps = {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +4",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +4",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Odr Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
--------------------------------------
-- Waltz sets for /DNC
--------------------------------------
	-- Curing Waltz on others
    sets.precast.Waltz = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Dashing Subligar",
		feet="Rawhide Boots",
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Handler's Earring",
		right_ear="Alabaster Earring",
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
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
		legs="Chas. Culottes +3",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Sailfi Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
        
-- Fast recast for specific spells
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
		head="Ikenga's Hat",
		body="Ikenga's Vest",
		hands="Ikenga's Gloves",
		legs="Chas. Culottes +3",
		feet="Ikenga's Clogs",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring",
		right_ring="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}},
	}

-- Ranged Attack, Accuracy 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		left_ear="Enervating Earring",
	})
	
-- Ranged Attack, Full Accuracy
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +4",
		hands="Chasseur's Gants +3",
		feet="Chass. Bottes +4",
		waist="K. Kachina Belt +1",
		left_ear="Beyla Earring",
		left_ring="Cacoethic Ring +1",
	})
	
-- Ranged Attack, Subtble Blow
	sets.midcast.RA.SubtleBlow = set_combine(sets.midcast.RA, {
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet="Volte Spats",
		left_ear="Beyla Earring",
		left_ring="Chirich Ring +1",
	})
	
--------------------------------------
-- Triple Shot gear
--------------------------------------	
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
		head="Oshosi Mask +1",
		body="Chasseur's Frac +4",
		hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}},
		legs="Osh. Trousers +1",
		feet="Osh. Leggings +1",
	})

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical damage taken
--------------------------------------
    sets.defense.PDT = {
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

--------------------------------------
-- Magical damage taken
--------------------------------------
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
--------------------------------------
-- Magic Evasion
--------------------------------------
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Unmoving Collar +1",
		left_ear="Hearty Earring",
		back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
    --------------------------------------
	-- Base Idle Set
	--------------------------------------
    sets.idle = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Dawn Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
		
	--------------------------------------
	-- Regen idle set
	--------------------------------------
	sets.idle.Regen = set_combine(sets.idle, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Bathy Choker +1",
		left_ear="Dawn Earring",
		right_ring="Chirich Ring +1",
	}) 

	--------------------------------------
	-- Refresh idle set
	--------------------------------------
    sets.idle.Refresh = set_combine(sets.idle.Regen, {neck="Sybil Scarf"})
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Engaged Sets
--------------------------------------
-- Engaged set, Single Wield	
    sets.engaged = {
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Chas. Culottes +3",
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		neck="Iskur Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Dedition Earring",
		right_ear="Cessance Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	
	-- Engaged set, single wield accuracy 
    sets.engaged.Acc = set_combine(sets.engaged, {})
	
	-- Engaged set, single wield full acc
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
	-- Engaged set, single wield fodder
    sets.engaged.Fodder = set_combine(sets.engaged, {})
	
	-- Engaged set, single wield subtle blow
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		feet="Volte Spats",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	})
	
	-- Engaged set, single wield hybrid DT
    sets.engaged.DT = set_combine(sets.engaged, {
		body="Malignance Tabard",
		feet="Malignance Boots",
		right_ring="Murky Ring",
	})
	
--------------------------------------
-- Engaged set, Dual Wield
--------------------------------------	
    sets.engaged.DW = {
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Chas. Culottes +3",
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		neck="Iskur Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Dedition Earring",
		right_ear="Cessance Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    
	-- Engaged set, dual wield accuracy
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	
	-- Engaged set, dual wield max Accuracy
	sets.engaged.DW.FullAcc = set_combine(sets.engaged.DW, {})
	
	-- Engaged set, dual wield fodder
    sets.engaged.DW.Fodder = set_combine(sets.engaged.DW, {})

	-- Engaged set, dual wield subtle blow
	sets.engaged.DW.SubtleBlow = set_combine(sets.engaged.DW, {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		feet="Volte Spats",
		left_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
	})
	
	-- DW Hybrid DT Set 
    sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
		body="Malignance Tabard",
		feet="Malignance Boots",
		right_ring="Murky Ring",
	})
	
	
---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
	sets.weapons.Savage = {main="Naegling", sub="Gleti's Knife", range="Ataktos"}
	sets.weapons.LeadenSalute = {main="Naegling", sub="Tauret", range="Death Penalty"}
	sets.weapons.HotShot = {main="Naegling", sub="Tauret", range="Fomalhaut"}
	sets.weapons.LastStand = {main="Crepuscular Knife", sub="Gleti's Knife", range="Fomalhaut"}
	sets.weapons.Wildfire = {main="Naegling", sub="Tauret", range="Death Penalty"}
	sets.weapons.Aeolian = {main="Tauret", sub="Naegling", range="Ataktos"}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife", range="Earp"}
	
---------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gear
--------------------------------------
-- Default Weaponskill Gear
    sets.precast.WS = {
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
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
		body="Ikenga's Vest",
		right_ring="Sroda Ring",
	})

--------------------------------------
-- Dagger Weaponskills
--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		body="Lanun Frac +4",
		hands="Nyame Gauntlets",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}}, --Int/WS dmg
	})
	
    --Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ikenga's Vest",
		legs="Zoar Subligar +1",
		feet={ name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Dawn Earring", -- Domin. Earring +1
		right_ear="Odr Earring",
		left_ring="Epona's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --Dex/Crit Rate
	})
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {left_ear="Mache Earring +1"})

--------------------------------------
-- Gun Weaponskills
--------------------------------------
-- Hot Shot
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {
		ammo="Living Bullet",
		hands="Nyame Gauntlets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear="Friomisi Earring",
		right_ring="Dingir Ring",
	})
	
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS['Hot Shot'].Fodder = set_combine(sets.precast.WS, {
		right_ring="Sroda Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},	
	})

-- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
		ammo="Chrono Bullet",
		head="Lanun Tricorne +3",
		body="Ikenga's Vest",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Dingir Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	
	sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {
		legs={ name="Ikenga's Trousers", augments={'Path: A',}},
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
	})
	
-- Leaden Salute
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, {
		ammo="Living Bullet",
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +4", augments={'Enhances "Loaded Deck" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Dingir Ring",
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
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {
		body="Lanun Frac +4",
		hands="Nyame Gauntlets",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		right_ear="Friomisi Earring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Wildfire'].Fodder = set_combine(sets.precast.WS.Fodder, {})

--------------------------------------
-- Sword Weaponskills
--------------------------------------
--Requiescat
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
--------------------------------------
-- Swaps when using WS at 3000 TP
--------------------------------------
	sets.MaxTP = {left_ear="Lugra Earring +1"} -- right_ear="Lugra Earring"
	sets.AccMaxTP = {}
 
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Kiting
    sets.Kiting = {right_ring="Shneddick Ring"}
	
-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		legs="Volte Hose",	
	})

--------------------------------------
-- Dual Wield Sets
--------------------------------------
	sets.DWMid = {left_ear="Eabani Earring", right_ear="Suppanomimi"}
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
		['LeadenSalute']='Leaden Salute',
		['HotShot']='Hot Shot',
		['LastStand']='Last Stand',
		['Wildfire']='Wildfire',
		['Aeolian']='Aeolian Edge',
		['Evisceration']='Evisceration',
	}