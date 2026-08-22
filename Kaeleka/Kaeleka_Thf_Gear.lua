-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'DT', 'MEVA')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'FullAcc', 'PDL', 'Fodder')
	state.IdleMode:options('Normal', 'Regen', 'Refresh', 'Regain')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options( 'Rudras', 'Ruthless', 'Evisceration', 'Aeolian', 'Savage', 'None')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'SubtleBlow', 'DWMid', 'DWMax'}
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
-- ### Precast sets to enhance JAs ###
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"} -- Upgrade to +4
    sets.precast.JA['Hide'] = {body="Pill. Vest +4"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +3"} 
    sets.precast.JA['Steal'] = {head="Plun. Bonnet +3", feet="Pillager's Poulaines +3"} --Upgrade to +4
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes +3", feet="Skulk. Poulaines +3"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"} -- Upgrade to +4
    sets.precast.JA['Feint'] = {legs="Plun. Culottes +4"}
	sets.precast.JA['Mug'] = {
		ammo="Aurgelmir Orb",
		head="Plun. Bonnet +3", -- Upgrade to +4
		body="Skulker's Vest +3",
		hands="Skulk. Armlets +3",
		legs="Plun. Culottes +4",
		feet="Skulk. Poulaines +3",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Svelt. Gouriz +1",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']
	
  -- Job abilities used to apply Treasure Hunter
	sets.precast.Step = sets.TreasureHunter	
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

-- ### Enmity set ###
	sets.precast.Enmity ={
		ammo="Sapience Orb",
		head="Nyame Helm",
		body="Plunderer's Vest +3",
		hands="Nyame Gauntlets",
		legs="Zoar Subligar +1",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Friomisi Earring",
		left_ring="Murky Ring",
		right_ring="Vengeful Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

-- ### Fast cast sets for spells ###
    sets.precast.FC = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Carrier's Sash",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Lebeche Ring",
		right_ring="Rahab Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}},
	}

  -- Fast cast for specific spells
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket", neck="Magoraga Beads"})
	
-- ### Step and Waltz sets ###
	sets.precast.Steps = {
		main="Naegling",
		sub="Centovente",
		ammo="Yamarang",
		head="Pill. Bonnet +4",
		body="Pill. Vest +4",
		hands="Skulk. Armlets +3",
		legs="Skulk. Culottes +3",
		feet="Skulk. Poulaines +3",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back="Null Shawl",
	}
	
    sets.precast.Waltz = {
		ammo="Yamarang",
		head="Pill. Bonnet +4",
		body="Passion Jacket",
		hands="Regal Gloves",
		legs="Dashing Subligar",
		feet="Rawhide Boots",
		neck="Unmoving Collar +1",
		waist="Kentarch Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Handler's Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.Waltz['Healing Waltz'] = {}
	sets.Self_Waltz = {head="Mummu Bonnet +2"}
	
-- ### Ranged Rapid Shot/Snapshot Gear ###
    sets.precast.RA = {
		range="Antitail",
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
		waist="Yemaya Belt",
		left_ring="Crepuscular Ring",
	}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast Recast ###
	sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Carrier's Sash",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Lebeche Ring",
		right_ring="Rahab Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}},
	}

  -- Fast Recast sets for specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

-- Ranged attack midcast
    sets.midcast.RA = {
		range="Antitail",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Alabaster Earring",
		right_ear="Telos Earring",
		left_ring="Crepuscular Ring",
		right_ring="Cacoethic Ring +1",
		back="Null Shawl",
	}

-- Ranged attack acc midcast
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		head="Pill. Bonnet +4",
		feet="Pill. Poulaines +3",
		left_ring="Regal Ring",
	})

-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base idle set ###
	sets.idle = {
        ammo="Staunch Tathlum +1",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Skulk. Armlets +3",
		legs="Turms Subligar",
		feet="Skulk. Poulaines +3",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Murky Ring",
		right_ring="Shneddick Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}},
    }

  -- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {
		neck="Sibyl Scarf",
    })
	
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {
		hands="Meg. Gloves +2",
		feet="Meg. Jam. +2",
		left_ring="Chirich Ring +1",
	})
	
  -- Regain idle set
	sets.idle.Regain = set_combine(sets.idle, {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		legs="Gleti's Breeches",
		feet="Skulk. Poulaines +3",
	})

  -- Weakened idle set
    sets.idle.Weak = set_combine(sets.idle, {})

  -- Special idle sets
	--sets.DayIdle = {}
	--sets.NightIdle = {}
	--sets.ExtraRegen = {hands="Turms Mittens +1"}
	
-- ### Resting Set ###
    sets.resting = {
		ammo="Staunch Tathlum +1",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Turms Subligar",
		feet="Meg. Jam. +2",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}},
	}
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Physical Damage Taken ###
    sets.defense.PDT = {
		ammo="Eluder's Sachet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Eabani Earring",
		left_ring="Murky Ring",
		right_ring="Warden's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

-- Magic Damage Taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Yamarang",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Arete del Luna",
		left_ring="Murky Ring",
		right_ring="Archon Ring",
		back="Null Shawl",
	})
		
-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Yamarang",
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Arete del Luna",
		left_ring="Vengeful Ring",
		right_ring="Icecrack Ring",
		back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged set ###
    sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Pill. Vest +4",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Plun. Poulaines +3",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
  -- Accuracy set
	sets.engaged.Acc = set_combine(sets.engaged, {
		hands="Pill. Armlets +3",
		legs="Pill. Culottes +3",
		right_ring="Regal Ring",
	})
	
  -- Full accuracy set
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		ammo="Yamarang",
		head="Pill. Bonnet +4",
		hands="Pill. Armlets +3",
		legs="Pill. Culottes +3",
		feet="Pill. Poulaines +3",
		right_ring="Regal Ring",
		back="Null Shawl",
	})
	
  -- Fodder Set
	sets.engaged.Fodder = set_combine(sets.engaged, {})

-- ### Hybrid DT engaged set ###
	sets.engaged.DT = {
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Murky Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
  -- Hybrid Evasion/MEVA
	sets.engaged.DT.Evasion = set_combine(sets.engaged, {
		ammo="Yamarang",
		back="Null Shawl",
	})
	
-- ### Extra melee sets, to add on top of engaged sets ### 
	sets.Ambush = {body="Plunderer's Vest +3"} -- Upgrade to +4	
	sets.DWMid = {
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Pill. Armlets +3", 
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
	} 
	
	sets.DWMax = {} -- (Ambu cape w/ dual wield +10)
	sets.Kiting = {right_ring="Shneddick Ring"}
	sets.SubtleBlow = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Volte Harness",
		feet={ name="Herculean Boots", augments={'Attack+29','"Triple Atk."+4','AGI+7','Accuracy+13',}},
		left_ear="Sherida Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	}
	
-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
-- ### Weapons sets ###
	sets.weapons.Rudras = {main="Aeneas", sub="Gleti's Knife"}
	sets.weapons.Ruthless = {main="Mpu Gandring", sub="Gleti's Knife"}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Aeolian = {main="Aeneas", sub="Malevolance"}
	sets.weapons.Savage = {main="Naegling", sub="Centovente"}
	sets.weapons.None = {main=empty, sub=empty}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill set ###
    sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Plun. Culottes +4",
		feet="Nyame Sollerets",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Cornelia's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		left_ring="Sroda Ring",
	})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Skulk. Armlets +3",
		legs="Skulk. Culottes +3",
		feet="Skulk. Poulaines +3",
		left_ear="Alabaster Earring",
		left_ring="Murky Ring",
		right_ring="Moonlight Ring",
	})

-- ### Dagger weaponskills ###
  -- Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		legs="Nyame Flanchard",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		back={ name="Toutatis's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
  -- Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Blistering Sallet +1",
		body="Plunderer's Vest +3",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Friomisi Earring",
		left_ring="Mummu Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'], {
		head="Gleti's Mask",
		left_ring="Sroda Ring",
	})
	
  -- Exenterator 
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Plun. Poulaines +3",
		waist="Kentarch Belt +1",
		right_ring="Ilabrat Ring",
	})
	
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].PDL = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {})
	
  -- Rudra's Storm
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
  -- Ruthless Stroke
    sets.precast.WS['Ruthless Stroke'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Ruthless Stroke'].Acc = set_combine(sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].FullAcc = set_combine(sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].PDL = set_combine(sets.precast.WS['Ruthless Stroke'], {})
	sets.precast.WS['Ruthless Stroke'].Fodder = set_combine(sets.precast.WS['Ruthless Stroke'], {})
	
-- ### Sword weaponskills ###
  -- Sanguine Blade
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Archon Ring",
		back={ name="Toutatis's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
  -- Savage Blade
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		body="Skulker's Vest +3",
		hands="Nyame Gauntlets",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
    
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Savage Blade"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Savage Blade"].PDL = set_combine(sets.precast.WS.PDL, {})
	sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {})

-- ### Miscellaenous WS swaps ###
	sets.MaxTP = {left_ear="Ishvara Earring", right_ear="Sherida Earring"}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Sherida Earring"}

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Gear that needs to be worn to actively enhance a current player buff. ###
	sets.buff['Sneak Attack'] = {hands="Skulk. Armlets +3"}
    sets.buff['Trick Attack'] = {hands="Pill. Armlets +3"} -- Upgrade to +4

-- ### Gear that is equiped to counteract specific debuffs ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {head="Frenzy Sallet"}

-- ### Phalanx Received ###
	sets.Phalanx_Received = {
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
	}
	
-- ### Treasure Hunter ###
	sets.TreasureHunter = {feet="Skulk. Poulaines +3"} -- (Hoxne Ring)
  

-- Extra Melee sets.  Apply these on top of melee sets.
  -- Vs. Knockback
	sets.Knockback = {}
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