-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal','DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'Regen', 'Refresh', 'Regain', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas', 'Aeolian', 'Savage', 'Evisceration', 'TrialWeapon')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
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
	--------------------------------------
	-- Precast sets to enhance JAs
	--------------------------------------
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
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body="Skulker's Vest +3",
		hands="Skulk. Armlets +3",
		legs="Skulk. Culottes +3",
		feet="Skulk. Poulaines +3",
		neck="Magoraga Beads",
		waist="Svelt. Gouriz +1",
		left_ear="Odr Earring",
		right_ear="Loquac. Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    --------------------------------------
	-- Waltz sets
	--------------------------------------
    sets.precast.Waltz = {}
	sets.Self_Waltz = {}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    --------------------------------------
	-- Fast cast sets for spells
	--------------------------------------
    sets.precast.FC = {
		ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Accuracy+28','"Triple Atk."+4','DEX+10',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Voltsurge Torque",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Lebeche Ring",
		right_ring="Defending Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    --------------------------------------
	-- Ranged Snapshot Gear
	--------------------------------------
    sets.precast.RA = {legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, feet="Meg. Jam. +2",}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
    --------------------------------------
	-- Fast recast
	--------------------------------------
	sets.midcast.FastRecast = {
		ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Accuracy+28','"Triple Atk."+4','DEX+10',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Voltsurge Torque",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Lebeche Ring",
		right_ring="Defending Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}


    --------------------------------------
	-- Midcast sets for specific spells
	--------------------------------------
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)


    --------------------------------------
	-- Ranged attack midcast
	--------------------------------------
    sets.midcast.RA = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

    sets.midcast.RA.Acc = {
        head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	}
	
	
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default weaponskill set
	--------------------------------------
    sets.precast.WS = {
		ammo="Aurgelmir Orb",
		head="Pill. Bonnet +3",
		body="Skulker's Vest +3",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','MND+8',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		left_ear="Mache Earring",
		right_ear="Odr Earring",
		body="Meg. Cuirie +2",
		waist="Kentarch Belt",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
	})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		body="Malignance Tabard",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
		
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {})


    --------------------------------------
	-- Specific weaponskill sets.
	--------------------------------------
	--------------------------------------
	-- Dagger weaponskills
	--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		ammo="Ghastly Tathlum +1",
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
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
	
	
	--Evisceration
	sets.precast.WS['Evisceration'] = {
        ammo="Yetshila +1", 
		head="Blistering Sallet +1", -- Needs augments
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Skulk. Culottes +3",
		feet={ name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','Crit.hit rate+10','Phys. dmg. taken-10%',}}, -- Needs augments
	}
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets", -- Needs augmented
		legs="Gleti's Breeches", -- Needs augmented
		feet="Gleti's Boots", -- Needs augmented
		left_ear="Mache Earring", -- Needs +1
		right_ear="Odr Earring",
		left_ring="Gere Ring",
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
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --AGI +30/Double Atk +10
	}
		
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
	
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], { 
		--ammo="Crepscular Pebble",
		body="Gleti's Cuirass", -- Needs augmented
		hands="Gleti's Gauntlets", -- Needs augmented
		legs="Gleti's Breeches", -- Needs augmented
		feet="Skulk. Poulaines +3",
		right_ring="Sroda Ring",
	})
	
	--Mandalic Stab

	
	--Mercy Stroke
	
	
	--Rudra's Storm
	sets.precast.WS["Rudra's Storm"] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Skulker's Vest +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		right_ear="Odr Earring",
		left_ring="Cornelia's Ring",
	})
    
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
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Skulker's Vest +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
    
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Cornelia's Ring",
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
	sets.precast.WS["Savage Blade"] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Skulker's Vest +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {body="Meg. Cuirie +2"})
	
	sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {
		--ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		hands="Gleti's Gauntlets",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Kentarch Belt",
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


	--------------------------------------
	-- Swaps when using WS at 3000 TP
	--------------------------------------
	sets.MaxTP = {left_ear="Ishvara Earring",right_ear="Sherida Earring"}
	sets.AccMaxTP = {left_ear="Mache Earring +1",right_ear="Sherida Earring"}

-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
    --------------------------------------
	-- Base idle set
	--------------------------------------
	sets.idle = {
         ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
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
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		right_ring="Chirich Ring +1",
    })
	
	
	--------------------------------------
	-- Refresh idle set
	--------------------------------------
	sets.idle.Refresh = set_combine(sets.idle, {
		neck="Sybil Scarf",
        --right_ring="Stikini Ring +1",
    })


	--------------------------------------
	-- Regain idle set
	--------------------------------------
	sets.idle.Regain = set_combine(sets.idle, {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
	})


	--------------------------------------
	-- Weakened idle set
	--------------------------------------
    sets.idle.Weak = set_combine(sets.idle, {})

	
	--------------------------------------
	-- Special idle sets
	--------------------------------------
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ExtraRegen = {hands="Turms Mittens +1"}
	
	
	--------------------------------------
	-- Resting Set
	--------------------------------------
    sets.resting = {}


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical Damage Reduction
	--------------------------------------
    sets.defense.PDT = {
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
	-- Magic Damage Reduction
	--------------------------------------
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		legs="Malignance Tights",
		neck="Loricate Torque +1",
		waist="Reiki Yotai",
		left_ear="Odnowa Earring +1",
	})
		
	--------------------------------------
	-- Magic Evasion
	--------------------------------------
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		head="Volte Cap",
		legs="Malignance Tights",
		feet="Volte Boots",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		right_ring="Vengeful Ring",
	})

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Engaged Set
	--------------------------------------
    sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Pillager's Vest +3",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	--------------------------------------
	-- Accuracy Set
	--------------------------------------
	sets.engaged.Acc = {}

	--------------------------------------
	-- Fodder Set
	--------------------------------------
    sets.engaged.Fodder = set_combine(sets.engaged, {
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ring="Epona's Ring",
	})
 
	--------------------------------------
	-- Engaged / Damage Taken Set
	--------------------------------------
	sets.engaged.DT = {
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
	-- Accuracy / Damage Taken Set
	--------------------------------------	
    sets.engaged.Acc.DT = set_combine{sets.engaged.DT, }
	
	--------------------------------------
	-- Fodder / Damage Taken Set
	--------------------------------------
    sets.engaged.Fodder.DT = set_combine{sets.engaged.DT, }
	
	
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
	
	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Gleti's Knife"}
	sets.weapons.Aeolian = {main="Malevolence", sub="Naegling"}
	sets.weapons.Savage = {main="Naegling", sub="Gleti's Knife"}
	sets.weapons.Evisceration = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.TrialWeapon = {main="Fusetto", sub="Blurred Knife +1"}
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter	
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
	elseif player.sub_job == 'RDM' then
		set_macro_page(4, 4)
    else
        set_macro_page(1, 4)
    end
end

autows_list = {['Aeneas']="Rudra's Storm",['Aeolian']='Aeolian Edge',['Savage']='Savage Blade',['Throwing']="Rudra's Storm",['SwordThrowing']='Savage Blade',['Evisceration']='Evisceration',['ProcWeapons']='Wasp Sting',['Bow']='Empyreal Arrow'}