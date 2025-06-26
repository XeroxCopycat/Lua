-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal','DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
	state.IdleMode:options('Normal', 'Regen', 'Refresh', 'Regain', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas', 'Aeolian', 'Evisceration', 'Savage', 'TrialWeapon')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'Suppa', 'DWMax', 'Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.wsd_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

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
	-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Skulk. Poulaines +3",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {"Skulker's Bonnet +3"}
    sets.precast.JA['Accomplice'] = {"Skulker's Bonnet +3"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"} 
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +3"} 
    sets.precast.JA['Steal'] = {head="Plun. Bonnet +3", feet="Pillager's Poulaines +3"} 
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes +3", feet="Skulk. Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"} -- Upgrade to +3
    sets.precast.JA['Feint'] = {legs="Plun. Culottes +3"}
	
	sets.precast.JA['Mug'] = {
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Skulker's Vest +3",
		hands="Skulk. Armlets +3",
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet="Skulk. Poulaines +3",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Svelt. Gouriz +1",
		left_ear="Mache Earring +1",
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz sets
    sets.precast.Waltz = {}
	sets.Self_Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}

    --sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
	-- Ranged Snapshot Gear
    sets.precast.RA = {
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		waist="Yemaya Belt",
	}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
	-- Midcast fast recast
	sets.midcast.FastRecast = {
		ammo="Impatiens",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Skulk. Poulaines +3",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	-- Midcast sets for specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

	-- Ranged attack midcast
    sets.midcast.RA = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	-- Ranged attack acc midcast
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		right_ear="Enervating Earring",
		back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	-- Physical Damage Taken
    sets.defense.PDT = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
	}

	-- Magic Damage Taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})
		
	-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
	-- Base idle set
	sets.idle = {
        head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Dawn Earring",
		left_ring="Shneddick Ring",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
    }
	
	-- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		left_ring="Chirich Ring +1",
	})
	
	-- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {
		neck="Sybil Scarf",
        --right_ring="Stikini Ring +1",
    })

	-- Regain idle set
	sets.idle.Regain = set_combine(sets.idle, {})

	-- Weakened idle set
    sets.idle.Weak = set_combine(sets.idle, {})

	-- Special idle sets
	sets.DayIdle = {right_ear="Dawn Earring"}
	sets.NightIdle = {}
	--sets.ExtraRegen = {hands="Turms Mittens +1"}
	
	-- Resting Set
    --sets.resting = {}

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
	-- Engaged Set
    sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Moonlight Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Accuracy Set
	sets.engaged.Acc = set_combine(sets.engaged, {})
	
	-- Max Accuracy Set
	sets.engaged.FullAcc = set_combine(sets.engaged, {})

	-- Hybrid DT
	sets.engaged.DT = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Skulker's Bonnet +3",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas", sub="Crepuscular Knife"}
	sets.weapons.Aeolian = {main="Aeneas", sub="Malevolence"}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Savage = {main="Naegling", sub="Gleti's Knife"}
	sets.weapons.TrialWeapon = {main="Fusetto", sub=none}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
	-- Default weaponskill set
    sets.precast.WS = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Skulker's Vest +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		left_ring="Cornelia's Ring",
	})

	--------------------------------------
	-- Dagger weaponskills
	--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		ammo="Seething Bomblet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	--Evisceration
	sets.precast.WS['Evisceration'] = {
        ammo="Yetshila +1",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Cornelia's Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {
		head="Skulker's Bonnet +3",
		body="Gleti's Cuirass",
		left_ring="Regal Ring",
	})
	
	--Exenterator
	sets.precast.WS['Exenterator'] = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Skulker's Bonnet +3",
		body="Skulker's Vest +3",
		hands="Skulk. Armlets +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Regal Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
	
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], { 
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Volte Spats",
	})
	
	--Mandalic Stab

	--Mercy Stroke
	
	--Rudra's Storm
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		legs="Pill. Culottes +3",
	})
	
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		hands="Pill. Armlets +3",
		legs="Pill. Culottes +3",
	})
    
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		hands="Pill. Armlets +3",
		legs="Pill. Culottes +3",
	})
	
	-- Shark Bite
	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		right_ear="Sherida Earring",
	})
    
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
	})
	
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		legs="Pill. Culottes +3",
	})
	
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		hands="Pill. Armlets +3",
		legs="Pill. Culottes +3",
	})
    
	sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		hands="Pill. Armlets +3",
		legs="Pill. Culottes +3",
	})
	
    
	--------------------------------------
	-- Sword weaponskills
	--------------------------------------
	--Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS["Sanguine Blade"].Acc = set_combine(sets.precast.WS["Sanguine Blade"], {})
	sets.precast.WS["Sanguine Blade"].Fodder = set_combine(sets.precast.WS["Sanguine Blade"], {})
	
	--Savage Blade
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
		ammo="Seething Bomblet",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})
	
    sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		right_ring="Sroda Ring",
	})
	
    sets.precast.WS["Savage Blade"].SA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		legs="Pill. Culottes +3",
	})
	
    sets.precast.WS["Savage Blade"].TA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		legs="Pill. Culottes +3",
	})
    
	sets.precast.WS["Savage Blade"].SATA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {
		ammo="Yetshila +1",
		body="Meg. Cuirie +2",
		legs="Pill. Culottes +3",
	})

	-- Swaps when using WS at 3000 TP
	sets.MaxTP = {left_ear="Ishvara Earring", right_ear="Sherida Earring"}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Sherida Earring"}


	
	
-------------------------------------------------------------------------------------------------------------------
-- Special Sets
-------------------------------------------------------------------------------------------------------------------
	sets.TreasureHunter = {feet="Skulk. Poulaines +3"}
    sets.Kiting = {left_ring="Shneddick Ring"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {hands="Skulk. Armlets +3"}
    sets.buff['Trick Attack'] = {hands="Pill. Armlets +3"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {left_ear="Sherida Earring", right_ear="Suppanomimi"}
	sets.DWEarrings = {left_ear="Eabani Earring",right_ear="Suppanomimi"}
	sets.DWMax = {left_ear="Eabani Earring", right_ear="Suppanomimi", body="Adhemar Jacket +1", hands="Floral Gauntlets", waist="Reiki Yotai"}
	sets.Parry = {hands="Turms Mittens +1", right_ring="Defending Ring"}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	

	
    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter	
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(1, 6)
end

autows_list = {['Aeneas']="Rudra's Storm",['Aeolian']='Aeolian Edge',['Savage']='Savage Blade',['Throwing']="Rudra's Storm",['SwordThrowing']='Savage Blade',['Evisceration']='Evisceration',['ProcWeapons']='Wasp Sting',['Bow']='Empyreal Arrow'}