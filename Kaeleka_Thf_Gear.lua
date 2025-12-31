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
	state.Weapons:options('Rudras', 'Aeolian', 'Evisceration', 'Exenterator', 'Savage')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax'}
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
-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head="Nyame Helm",
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Skulk. Culottes +3",
		feet="Skulk. Poulaines +3",
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}},
	}
	
-- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {"Skulker's Bonnet +3"}
    sets.precast.JA['Accomplice'] = {"Skulker's Bonnet +3"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"} -- Upgrade to +4
    sets.precast.JA['Hide'] = {body="Pill. Vest +4"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +3"} 
    sets.precast.JA['Steal'] = {head="Plun. Bonnet +3", feet="Pillager's Poulaines +3"} 
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes +3", feet="Skulk. Poulaines +3"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"} -- Upgrade to +4
    sets.precast.JA['Feint'] = {legs="Plun. Culottes +4"} -- Upgrade to +4
	sets.precast.JA['Mug'] = {
		ammo="Aurgelmir Orb",
		head="Plun. Bonnet +3", -- Upgrade to +4
		body="Skulker's Vest +3",
		hands="Skulk. Armlets +3",
		legs="Plun. Culottes +4", -- Upgrade to +4
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

-- Waltz sets
    sets.precast.Waltz = {
		ammo="Aurgelmir Orb", -- Yamarang
		head="Pill. Bonnet +4",
		body="Gleti's Cuirass", -- Upgrade to R25+ 
		hands="Regal Gloves",
		legs="Dashing Subligar",
		feet="Rawhide Boots",
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Handler's Earring",
		right_ear="Alabaster Earring", -- Upgrade to R30
		left_ring="Metamor. Ring +1",
		right_ring="Regal Ring", -- Asklepian Ring (?)
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.Self_Waltz = {head="Mummu Bonnet +2"}
	sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
-- Ranged Snapshot Gear
    sets.precast.RA = {
		range="Antitail",
		head="Volte Tiara",
		body="Volte Harness",
		hands="Volte Mittens",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		left_ring="Crepuscular Ring",
		waist="Yemaya Belt",
	}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- Midcast fast recast
	sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head="Nyame Helm",
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Skulk. Culottes +3",
		feet="Skulk. Poulaines +3",
		neck="Voltsurge Torque",
		waist="Sailfi Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Murky Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}},
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
		range="Antitail",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Crepuscular Ring",
		right_ring="Chirich Ring +1",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

-- Ranged attack acc midcast
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		left_ear="Enervating Earring",
		back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- Physical Damage Taken
    sets.defense.PDT = {
		ammo="Eluder's Sachet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Warden's Ring",
		right_ring="Murky Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

-- Magic Damage Taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ring="Archon Ring",
	})
		
-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		left_ring="Vengeful Ring", 
		back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- Base idle set
	sets.idle = {
        ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Gleti's Cuirass",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Dawn Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}},
    }
	
-- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		right_ring="Chirich Ring +1",
	})
	
-- Refresh idle set
	sets.idle.Refresh = set_combine(sets.idle, {
		neck="Sibyl Scarf",
    })

-- Regain idle set
	sets.idle.Regain = set_combine(sets.idle, {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Null Loop",
	})

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
		ammo="Aurgelmir Orb", -- Cait Palug Stone
		head="Skulker's Bonnet +3",
		body="Pill. Vest +4",
		hands="Malignance Gloves",
		legs="Pill. Culottes +3", -- Upgrade to +4
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Accuracy Set
	sets.engaged.Acc = set_combine(sets.engaged, {})
	
	-- Max Accuracy Set
	sets.engaged.FullAcc = set_combine(sets.engaged, {})

	-- Hybrid DT
	sets.engaged.DT = set_combine(sets.engaged, {
		ammo="Aurgelmir Orb", -- Upgrade to +1
		legs="Skulk. Culottes +3",
		feet="Skulk. Poulaines +3",
		left_ring="Moonlight Ring",
		right_ring="Murky Ring", -- Upgrade to R30
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})

-------------------------------------------------------------------------------------------------------------------
-- Weapon sets
-------------------------------------------------------------------------------------------------------------------
	-- Weapons sets
	sets.weapons.Rudras = {main="Aeneas", sub="Centovente"}
	sets.weapons.Aeolian = {main="Aeneas", sub="Centovente"}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Exenterator = {main="Aeneas", sub="Centovente"}
	sets.weapons.Savage = {main="Naegling", sub="Centovente"}
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- Default weaponskill set
    sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Pill. Bonnet +4",
		body="Skulker's Vest +3",
		hands="Nyame Gauntlets",
		legs="Plun. Culottes +4",
		feet="Nyame Sollerets",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt +1", -- Augment
		left_ear="Moonshade Earring",
		right_ear="Domin. Earring +1",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		right_ear="Odr Earring",
	})

-- Dagger weaponskills
  --Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		ammo="Seething Bomblet +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Gleti's Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Toutatis's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
  --Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
		head="Blistering Sallet +1",
		body="Plunderer's Vest +3",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {
		head="Skulker's Bonnet +3",
		body="Gleti's Cuirass",
		left_ring="Gere Ring",
	})
	
  --Exenterator
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
		head="Skulker's Bonnet +3",
		body="Skulker's Vest +3",
		hands="Skulk. Armlets +3",
		legs="Nyame Flanchard",
		feet="Plun. Poulaines +3", -- Upgrade to +4
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','AGI+4','"Fast Cast"+10','"Regen"+5',}}, -- AGI/DA Cape
	})
		
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
	
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], { 
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		left_ring="Sroda Ring",
	})
	
  --Mandalic Stab

  --Mercy Stroke
	
  --Rudra's Storm
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
  -- Shark Bite
	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		waist="Sailfi Belt +1",
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
	})
    
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		waist="Kentarch Belt +1",
	})
    
-- Sword weaponskills	
  --Savage Blade
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
		ammo="Seething Bomblet +1",
		head="Pill. Bonnet +4",
		body="Skulker's Vest +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Sherida Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {
		ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		neck="Null Loop",
		right_ear="Ishvara Earring",
		right_ring="Sroda Ring",
	})

	-- Swaps when using WS at 3000 TP
	sets.MaxTP = {left_ear="Ishvara Earring", right_ear="Sherida Earring"}
	sets.AccMaxTP = {left_ear="Mache Earring +1", right_ear="Sherida Earring"}

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Treasure Hunter
	sets.TreasureHunter = {feet="Skulk. Poulaines +3"}
    
-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}

-- Debuff Countermeasures
  -- Vs. Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	
  -- Vs. Sleep
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
-- Sneak Attack/Trick Attack
    sets.buff['Sneak Attack'] = {hands="Skulk. Armlets +3"}
    sets.buff['Trick Attack'] = {hands="Pill. Armlets +3"} -- Upgrade to +4

-- Extra Melee sets.  Apply these on top of melee sets.
  -- Vs. Knockback
	sets.Knockback = {}

  -- Mid-Level Dual Wield 
	sets.DWMid = {left_ear="Eabani Earring",right_ear="Suppanomimi"}

  -- Max Level Dual Wield (used when weakened)
	sets.DWMax = {
		left_ear="Eabani Earring", 
		right_ear="Suppanomimi",
		body="Adhemar Jacket +1",
		hands="Floral Gauntlets",
		waist="Reiki Yotai",
	}
	
  -- Ambush
	sets.Ambush = {body="Plunderer's Vest +3"} -- Upgrade to +4
	
-- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter	
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter
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
		['Aeneas']="Rudra's Storm",
		['Aeolian']='Aeolian Edge',
		['Savage']='Savage Blade',
		['Throwing']="Rudra's Storm",
		['SwordThrowing']='Savage Blade',
		['Evisceration']='Evisceration',
		['ProcWeapons']='Wasp Sting',
	}