-- Kaeleka's THF GearSwaps
-- Original: Motenten, Arislan. Modified: Kaeleka
-- Haste/DW Detection Requires Gearinfo Addon

--------------------------------------------------
--  Keybinds
--------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Cycle Treasure Hunter Mode
--              [ WIN+C ]           Toggle Capacity Points Mode

--------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
--------------------------------------------------

--  gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
--
--  TH Modes:  	None                Will never equip TH gear
--             	Tag                 Will equip TH gear sufficient for initial contact with a mob (either melee,
--				SATA 				Will equip TH gear sufficient for initial contact with a mob, and when using SATA
--             	Fulltime 			Will keep TH gear equipped fulltime


--------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
--------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
	elemental_ws = S{"Aeolian Edge"}
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    state.Ambush = M(false, 'Ambush')
    -- state.CP = M(false, "Capacity Points Mode")

    lockstyleset = 1
end

--------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
--------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'StoreTP')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Crit')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    -- Additional local binds
    send_command('bind ^` gs c cycle treasuremode')
    send_command('bind %numpad0 gs c toggle Ambush')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^,')
    send_command('unbind numpad0')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------------------
    --Precast Sets 
    --------------------------------------------------

    sets.TreasureHunter = {feet="Skulk. Poulaines +3",}

    sets.buff['Sneak Attack'] = {hands="Skulk. Armlets +2"}
    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    -- Precast sets to enhance JAs
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Aura Steal'] = {head="Plun. Bonnet"}
    sets.precast.JA['Collaborator'] = set_combine(sets.TreasureHunter, {head="Skulker's Bonnet +3"})
    sets.precast.JA['Flee'] = {feet="Pill. Poulaines +3"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = set_combine(sets.TreasureHunter, {body="Skulker's Vest +2"})

    sets.precast.JA['Steal'] = {
        -- ammo="Barathrum", 
        head="Plun. Bonnet",
        feet="Pill. Poulaines +2",
    }

    sets.precast.JA['Despoil'] = {
		--ammo="Barathrum",
		legs="Skulk. Culottes +2",
		feet="Skulk. Poulaines +2",
	}
	
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +1"}
	sets.precast.JA['Feint'] = {legs="Plun. Culottes +1"}
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    sets.precast.Waltz = {
        --ammo="Yamarang",
        --body="Passion Jacket",
        --legs="Dashing Subligar",
        --ring1="Asklepian Ring",
        waist="Gishdubar Sash",
    }

    --sets.precast.Waltz['Healing Waltz'] = {Body="Gleti's Cuirass",}

    sets.precast.FC = {
        ammo="Sapience Orb",
        head={ name="Herculean Helm", augments={'Accuracy+17','Weapon skill damage +3%','STR+5',}},
        --body=gear.Taeon_FC_body,
        hands="Leyline Gloves", --8
        --legs="Rawhide Trousers", --5
        --feet=gear.Herc_MAB_feet, --2
        neck="Baetyl Pendant", --4
        left_ear="Loquacious Earring", --2
        -- ear2="Enchntr. Earring +1", --2
        -- ring2="Weather. Ring +1", --6(4)
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        --body="Passion Jacket",
        Neck="Magoraga Beats", --10
    })

    --------------------------------------------------
    --Weaponskill Sets
    --------------------------------------------------
	-- Default set for any weaponskill that isn't any more specifically defined
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

    sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
        --ammo="Voluspa Tathlum",
        left_ear="Telos Earring",
    })
	
	--sets.precast.WS.HighAcc = set_combine(sets.precast.WS.MidAcc, {

    sets.precast.WS.Critical = {
        --ammo="Yetshila +1",
        head="Pill. Bonnet +3",
        body="Meg. Cuirie +2",
    }

	--------------------------------------------------
	--Dagger Weaponskills
	--------------------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		ammo="Seething Bomblet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		--waist="Orpheus's Sash",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	-- Evisceration
    sets.precast.WS['Evisceration'] = {
        ammo="Yetshila +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		--body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		body={ name="Plunderer's Vest +2", augments={'Enhances "Ambush" effect',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Pill. Culottes +3",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
    })
	
	-- Exenterator
    sets.precast.WS['Exenterator'] = {
        ammo="Yetshila +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Pill. Culottes +3",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','Crit.hit rate+10','Phys. dmg. taken-10%',}},
    }

    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
    })
	
	-- Rudra's Storm
    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
		ammo="Seething Bomblet",
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body="Skulker's Vest +3",
		hands="Meg. Gloves +2",
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Kentarch Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        right_ear="Telos Earring",
    })
	
	sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS['Rudra\'s Storm'], {
		ammo="Yetshila +1",
		hands="Skulk. Armlets +3",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','MND+8',}},
		--feet="Lustra. Leggings +1",
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		waist="Kentarch Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    })
	
	sets.precast.WS['Rudra\'s Storm'].TA = set_combine(sets.precast.WS['Rudra\'s Storm'].SA, {
		hands="Meg. Gloves +2",
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
	})
	
	--------------------------------------------------
	--Sword Weaponskills
	--------------------------------------------------
	-- Sanguine Blade
	sets.precast.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Archon Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = {
        ammo="Coiste Bodhar",
		head="Pill. Bonnet +3",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Meg. Gloves +2",
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Asn. Gorget +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Skulker's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS, {
		right_ear="Telos Earring",
	})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        --body=gear.Taeon_Phalanx_body, --10
        --hands="Rawhide Gloves", --15
        --legs=gear.Taeon_Phalanx_legs, --10
        --feet=gear.Taeon_Phalanx_feet, --10
        --neck="Loricate Torque +1", --5
        --ear1="Halasz Earring", --5
        --ear2="Magnetic Earring", --8
        --ring2="Evanescence Ring", --5
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Dawn Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		neck="Loricate Torque",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

    --sets.idle.Refresh = set_combine(sets.idle, {
        --ring1={name="Stikini Ring +1", bag="wardrobe3"},
        --ring2={name="Stikini Ring +1", bag="wardrobe4"},
    --})


    sets.idle.Town = set_combine(sets.idle, {
        ammo="Aurgelmir Orb",
        neck="Asn. Gorget +1",
		waist="Windbuffet Belt +1",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {left_ring="Shneddick Ring"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Pillager's Vest +3",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Asn. Gorget +1",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        left_ear="Telos Earring",
		left_ring="Chirich Ring +1",
    })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
        left_ear="Telos Earring",
		right_ring="Regal Ring",	
    })
	
	sets.engaged.StoreTP = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		left_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
	})	
	
	--------------------------------------------------
	-- Engaged/Dual Wield Sets
	--------------------------------------------------
	-- Notes: These sets require the Gearinfo plugin
	-- to work properly.
    -- * THF Native DW Trait: +30 DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = { --DW +75
        ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands="Floral Gauntlets", --DW +5
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet="Taeon Boots", --DW +8
		neck="Asn. Gorget +1",
		waist="Reiki Yotai", --DW +7
		left_ear="Eabani Earring", --DW +4
		right_ear="Suppanomimi", --DW +5
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --DW +10
    }

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
    })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
		head="Malignance Chapeau",
		legs="Malignance Tights",
    })
	
	sets.engaged.DW.StoreTP = set_combine(sets.engaged.DW, {
		head="Malignance Chapeau",
		legs="Malignance Tights",
		neck="Anu Torque",
		left_ring="Chirich Ring +1",
	})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = { --DW +67
        ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, -- +6
		hands="Floral Gauntlets", -- +5
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Asn. Gorget +1",
		waist="Reiki Yotai", -- +7
		left_ear="Eabani Earring", -- +4
		right_ear="Suppanomimi", -- +5
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, -- +10
	}
	
    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
    })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
		head="Malignance Chapeau",
		legs="Malignance Tights",
		feet="Malignance Boots",
     })
	 
    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = { -- DW +57
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Asn. Gorget +1",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		left_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
    })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
    })
	
	sets.engaged.DW.StoreTP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		left_ring="Chirich Ring +1",
	})
	
    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = { --DW +52, 1402 Acc
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Asn. Gorget +1",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		left_ear="Telos Earring",
		right_ring="Regal Ring",
    })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
    })
	
	sets.engaged.DW.StoreTP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		left_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
	})
		
    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = { --DW +37
		ammo="Aurgelmir Orb",
		head="Skulker's Bonnet +3",
		body="Pillager's Vest +3",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Asn. Gorget +1",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		left_ear="Telos Earring",
		right_ring="Regal Ring",
    })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
		ammo="Yamarang",
		head="Malignance Chapeau",
		hands="Pill. Armlets +3",
		legs="Malignance Tights",
    })
	
	sets.engaged.DW.StoreTP.MaxHasste = set_combine(sets.engaged.DW.MaxHaste, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		left_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
	})
	
	--------------------------------------------------
	-- Special Purpose Sets
	--------------------------------------------------
	
    sets.buff['Ambush'] = {body="Plunderer's Vest +3"}

    sets.buff.Doom = {
        --neck="Nicander's Necklace", --20
        --ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        --ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
    }

    --sets.Reive = {neck="Ygnas's Resolve +1"}
    sets.CP = {back="Aptitude Mantle +1"}
	sets.Obi = {waist="Hachirin-no-Obi"}

end


--------------------------------------------------
-- Job specific hooks for standard casting events
--------------------------------------------------
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
    if spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

--------------------------------------------------
-- Job-specific hooks for non-casting events.
--------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.

function job_buff_change(buff,gain)
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Do Do Do-Doomed Doomed-da-do doomed DOOMED. <call12>')
            disable('left_ring','right_ring','waist')
        else
            enable('left_ring','right_ring','waist')
            handle_equipping_gear(player.status)
        end
    end

    if not midaction() then
        handle_equipping_gear(player.status)
    end

	if elemental_ws:contains(spell.name) then
        -- Matching double weather (w/o day conflict).
        if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
            equip({waist="Hachirin-no-Obi"})
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Matching day and weather.
        elseif spell.element == world.day_element and spell.element == world.weather_element then
			equip({waist="Hachirin-no-Obi"})
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Match day or weather.
        elseif spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-no-Obi"})
        end
    end
end


--------------------------------------------------
-- User code that supplements standard library decisions.
--------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end

function job_update(cmdParams, eventArgs)
    --handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
	
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.Ambush.value == true then
        meleeSet = set_combine(meleeSet, sets.buff['Ambush'])
    end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.TreasureMode.value ~= 'None' then
        msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


--------------------------------------------------
-- Utility functions specific to this job.
--------------------------------------------------
-- Defines if we are dual-wielding, and if so determines
-- how much dual-wield we need for a given haste value. 
-- This requires the Gearinfo addon to work properly.
function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 6 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 6 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 26 and DW_needed <= 37 then
            classes.CustomMeleeGroups:append('MidHaste')
		elseif DW_needed > 37 and DW_needed <= 40 then
			classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 40 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
--function job_pretarget(spell, action, spellMap, eventArgs)
    --if spell.type == 'Step' then
        --local allRecasts = windower.ffxi.get_ability_recasts()
        --local prestoCooldown = allRecasts[236]
        --local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

        --if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            --cast_delay(1.1)
            --send_command('input /ja "Presto" <me>')
        --end
    --end
--end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("left_ring")
    else
        enable("left_ring")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("right_ring")
    else
        enable("right_ring")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("left_ring")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("right_ring")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 2)
    else
        set_macro_page(2, 2)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 80 ' .. lockstyleset)
end