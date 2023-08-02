-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--Startup--
    send_command('gs enable all')   
    send_command('input /macro book 1;wait 1;input /macro set 1;wait 3;input /lockstyleset 181')

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    --state.Buff.Souleater = buffactive.souleater or false
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
    
    -- Override certain gear from swapping when equipped
	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
        "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",}

    get_combat_form()
    --get_combat_weapon()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'StoreTP', 'Crit')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    state.drain = M(false)
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    
    select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
end
 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	-- Treasure Hunter Set
    sets.TreasureHunter = {
		ammo="Per. Lucky Egg",
        head="White rarab cap +1", 
        waist="Chaac Belt",
    }
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Blood Rage'] = { body="Boii Lorica +3" }
    
	sets.precast.JA['Provoke'] = set_combine(sets.TreasureHunter, { hands="Pummeler's Mufflers +2"})
    
	sets.precast.JA['Berserk'] = { 
		body="Pummeler's Lorica +3",
		feet="Agoge Calligae +3",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    
	sets.precast.JA['Warcry'] = { head="Agoge Mask +3"}
    
	sets.precast.JA['Mighty Strikes'] = { head="Agoge Mufflers +3"}
    
	sets.precast.JA['Retaliation'] = { 
		hands="Pummeler's Mufflers +2",
		feet="Boii Calligae +3",
	}
    
	sets.precast.JA['Aggressor'] = { 
		head="Pummeler's Mask +3", 
		body="Agoge Lorica +3",
	}
    
	sets.precast.JA['Restraint'] = { hands="Boii Mufflers +3"}
    
	sets.precast.JA['Warrior\'s Charge'] = { legs="Agoge Cuisses +3"}

    sets.CapacityMantle  = { back="Apptitude Mantle +1" }
 
    sets.reive = {neck="Ygnas's Resolve +1"}
            
    -- Fast cast sets for spells
     sets.precast.FC = {
        head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Leyline Gloves",
        left_ear="Loquacious Earring",    
    }
	 
     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

	--------------------------------------
    -- Weaponskill sets
	--------------------------------------
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }

    sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
    })
	 
    sets.precast.WS.HighAcc = set_combine(sets.precast.WS.MidAcc, {
    })
    
	--------------------------------------
    -- Axe Weaponskills
	--------------------------------------
	--To Be Added
	
	--------------------------------------
    -- Club Weaponskills
	--------------------------------------
	-- Black Halo
	sets.precast.WS['Black Halo'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	
	-- Hexa Strike
	sets.precast.WS["Hexa Strike"] = {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	--------------------------------------
    -- Great Axe Weaponskills
	--------------------------------------
	--Fell Cleave
	sets.precast.WS["Fell Cleave"] = set_combine {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Fell Cleave'].MidAcc = set_combine(sets.precast.WS['Fell Cleave'], {
    })
	
	sets.precast.WS['Fell Cleave'].HighAcc = set_combine(sets.precast.WS['Fell Cleave'], {
    })
	
	--Full Break
	sets.precast.WS["Full Break"] = set_combine {
		ammo="Pemphredo Tathlum",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		feet="Sakpata's Leggings",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Gwati Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Full Break'].MidAcc = set_combine(sets.precast.WS['Full Break'], {
    })
	
	sets.precast.WS['Full Break'].HighAcc = set_combine(sets.precast.WS['Full Break'], {
    })
	
	--Ukko's Fury
	sets.precast.WS["Ukko's Fury"] = set_combine {
        ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Ukko\'s Fury'].MidAcc = set_combine(sets.precast.WS['Ukko\'s Fury'], {
    })
	
	sets.precast.WS['Ukko\'s Fury'].HighAcc = set_combine(sets.precast.WS['Ukko\'s Fury'], {
    })
	
	--Upheaval
    sets.precast.WS['Upheaval'] = {
        ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	
    sets.precast.WS['Upheaval'].MidAcc = set_combine(sets.precast.WS['Upheaval'], {
    })
	
	sets.precast.WS['Upheaval'].HighAcc = set_combine(sets.precast.WS['Upheaval'], {
    })
 
	--------------------------------------
    -- Great Sword Weaponskills
	--------------------------------------
	-- Resolution
	sets.precast.WS['Resolution'] = {
		ammo="Aurgelmir Orb",
		head="Boii Mask +3",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands="Sakpata's Gauntlets",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
    --------------------------------------
    -- Polearm Weaponskills
	--------------------------------------
	--Impulse Drive
	sets.precast.WS['Impulse Drive'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs={ name="Valorous Hose", augments={'Attack+29','Weapon skill damage +3%','Accuracy+7',}},
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	--Sonic Thrust
	sets.precast.WS['Sonic Thrust'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	--Stardiver
    sets.precast.WS.Stardiver = {
        ammo="Knobkierrie",
		head="Boii Mask +3",
		body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Pumm. Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	
	--Vorpal Thrust
	sets.precast.WS['Vorpal Thrust'] = {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
    
	--------------------------------------
    -- Sword Weaponskills
	--------------------------------------
	-- Circle Blade
	sets.precast.WS['Circle Blade'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	-- Requiescat
	sets.precast.WS['Requiescat'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
        waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	
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
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},   
    }
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	--------------------------------------
	-- Midcast Sets
	--------------------------------------
	-- Not currently in use on Warrior.
	
	--------------------------------------
	-- Miscelanious Sets
	--------------------------------------
	-- Sets to return to when not performing an action.
    -- Idle sets
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

     sets.idle.Regen = {
        ammo="Staunch Tathlum +1",
		head="Boii Mask +3",
		body="Sacro Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Boii Calligae +3",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Dawn Earring",
		right_ear="Hearty Earring",
		left_ring="Shneddick Ring",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
		
	sets.idle.Town = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Shneddick Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
	-- Defensive Sets
	--------------------------------------
     -- Defense sets, activated with F10 (PDT) and
	 -- F11 (MDT) keys.
    sets.defense.PDT = {
        head="Sakpata's Helm",
        body="Tartarus Platemail",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        right_ring="Defending Ring",
    }

    sets.defense.MDT = set_combine(sets.defense.PDT, {
        ammo="Staunch Tathlum +1",
		head="Volte Cap",
		feet="Volte Boots",
		neck="Loricate Torque",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Hearty Earring",
    })
 
     sets.Kiting = {left_ring="Shneddick Ring"}
 
    -------------------------------------
    -- Engaged sets
	-------------------------------------
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	-- Normal, MidAcc, HighAcc, StoreTP, Crit
	-- Default set for two-handed weapons such as Great Axe, Great Sword, and Polearm.
    
	sets.engaged = { --Acc 1256, DA +94, TA +5
        ammo="Coiste Bodhar",
		head="Boii Mask +3",
		body="Boii Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    
	sets.engaged.MidAcc = set_combine(sets.engaged, { --Acc 1281
		waist="Ioskeha Belt +1", --9/0
		left_ear="Telos Earring", --1/0, STP +5
		left_ring="Chirich Ring +1", --0,0, STP +5
    })
    
	sets.engaged.HighAcc = set_combine(sets.engaged.Mid, { --Acc 1384
		hands="Boii Mufflets +3",
		legs="Boii Cuisses +3",
		Feet="Boii Calligae +3",
	})
	 
	sets.engaged.StoreTP = set_combine(sets.engaged, {
		neck="Vim Torque +1", --0/0, STP +10, Regain +20
		left_ear="Dedition Earring", --0/0, STP +8
		right_ear="Telos Earring", 
	})

	-------------------------------------
    -- Dual Wield sets
	-------------------------------------
	-- Requires the GearInfo plugin to function
	-- properly. Otherwise will fallback to engaged sets.
	-- DW calculations assume /NIN
    -- * /NIN DW Trait: 25% DW
    -- * /DNC DW Trait: 15% DW
	
	-- No Magic Haste (74% DW to cap)
	sets.engaged.DW = { --DW +16
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
		feet="Pumm. Calligae +3",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Reiki Yotai", --DW +7
		left_ear="Suppanomimi", --DW +5
		right_ear="Eabani Earring", --DW +4
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
	})
	
    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
	})
	
    sets.engaged.DW.StoreTP = set_combine(sets.engaged.DW, {
	})
	
	-- 15% Magic Haste (67% DW to cap)
	sets.engaged.DW.LowHaste = { --DW +41
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
		feet="Pumm. Calligae +3",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Reiki Yotai", --DW +7
		left_ear="Suppanomimi", --DW +5
		right_ear="Eabani Earring", --DW +4
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
	})
	
    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
	})
	
    sets.engaged.DW.StoreTP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
	})
	
	-- 30% Magic Haste (56% DW to cap)
	sets.engaged.DW.MidHaste = { --DW +41
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
		feet="Pumm. Calligae +3",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Reiki Yotai", --DW +7
		left_ear="Suppanomimi", --DW +5
		right_ear="Eabani Earring", --DW +4
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
	})
	
    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
	})
	
    sets.engaged.DW.StoreTP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
	})
	
	-- 35% Magic Haste (51% DW to cap)
	sets.engaged.DW.HighHaste = { --DW +41
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
		feet="Pumm. Calligae +3",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Reiki Yotai", --DW +7
		left_ear="Suppanomimi", --DW +5
		right_ear="Eabani Earring", --DW +4
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
	})
	
    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
	})
	
    sets.engaged.DW.StoreTP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
	})
	
	-- 45% Magic Haste (+36 DW needed)
	sets.engaged.DW.MaxHaste = { --DW +36
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
		feet="Pumm. Calligae +3",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Reiki Yotai", --DW +7
		left_ear="Suppanomimi", --DW +5
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
	})
	
    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
	})
	
    sets.engaged.DW.StoreTP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
	})
	
	-------------------------------------
    -- Sword & Shield Set
	-------------------------------------
	-- Used for Sword, Club, and Axe sets when using a shield in the off-hand.
	sets.engaged.OH = { --Acc 1326, DA +101
        ammo="Coiste Bodhar",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.OH.MidAcc = set_combine(sets.engaged.OH, { --Acc 1346
		waist="Ioskeha Belt +1", --9/0
		left_ear="Telos Earring", --1/0, STP +5
		left_ring="Chirich Ring +1", --0,0, STP +5
    })
    
	sets.engaged.OH.HighAcc = set_combine(sets.engaged.OH.MidAcc, { --Acc 1384
		body="Boii Lorica +3",
		hands="Boii Mufflets +3",
		legs="Boii Cuisses +3",
		Feet="Boii Calligae +3",
	})
	 
	sets.engaged.OH.StoreTP = set_combine(sets.engaged.OH, {
		body="Boii Lorica +3",
		neck="Vim Torque +1", --0/0, STP +10, Regain +20
		left_ear="Telos Earring",
		right_ear="Dedition Earring", --0/0, STP +8
	})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    --elseif spell.target.distance > 8 and player.status == 'Engaged' then
    --    eventArgs.cancel = true
    --    add_to_chat(122,"Outside WS Range! /Canceling")
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end
 
function job_post_precast(spell, action, spellMap, eventArgs)

    -- Make sure abilities using head gear don't swap 
	if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
        --if is_sc_element_today(spell) then
            --if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            --else
                --equip(sets.WSDayBonus)
            --end
        --end
		
		-- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
		if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        
        -- Equip Ygnas's Resolve +1 for reives in place of WS neck
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
        equip(sets.buff.Berserk)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Berserk)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if buffactive.Berserk and not state.Buff.Retaliation then
            equip(sets.buff.Berserk)
        end
        --get_combat_weapon()
    elseif newStatus == 'Idle' then
        --determine_idle_group()
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
	
    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Vocation', 'Capacity'}:contains(player.equipment.left_ring) then
        if not buffactive['Dedication'] then
            disable('left_ring')
        end
    else
        enable('left_ring')
    end
    
    if buff == "Berserk" then
        if gain and not buffactive['Retaliation'] then
            equip(sets.buff.Berserk)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    war_sj = player.sub_job == 'WAR' or false
    get_combat_form()
    --get_combat_weapon()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Defines if we are dual-wielding, and if so determines
-- how much dual-wield we need for a given haste value. 
-- This requires the Gearinfo addon to work properly.
function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true
			then if DW_needed <= 11 then
				classes.CustomMeleeGroups:append('MaxHaste')
			elseif DW_needed > 11 and DW_needed <= 26 then
				classes.CustomMeleeGroups:append('HighHaste')
			elseif DW_needed > 26 and DW_needed <= 31 then
				classes.CustomMeleeGroups:append('MidHaste')
			elseif DW_needed > 31 and DW_needed <= 42 then
				classes.CustomMeleeGroups:append('LowHaste')
			elseif DW_needed > 42 then
				classes.CustomMeleeGroups:append('')
		end
    end
end

-- Checks with the GearInfo plugin and determines what amount of DW we have,
-- and what level of haste we need in return.
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

-- Checks if we are using either a two-handed weapon (default), dual-wielding, or using a one-handed weapon
-- with a shield, then switches over to the appropriate set.
function get_combat_form()
    --if war_sj then
        --state.CombatForm:set("War")
    --else
        --state.CombatForm:reset()
    --end
    --if S{'NIN', 'DNC'}:contains(player.sub_job) and war_sub_weapons:contains(player.equipment.sub) then
        --state.CombatForm:set("DW")
    --elseif S{'SAM', 'DRG'}:contains(player.sub_job) and player.equipment.sub == 'Blurred Shield +1' then
        --state.CombatForm:set("OH")
    --else
        --state.CombatForm:reset()
    --end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    --if stateField == 'Look Cool' then
    --    if newValue == 'On' then
    --        send_command('gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
    --        --send_command('wait 1.2;gs c update user')
    --    else
    --        send_command('@input /lockstyle off')
    --    end
    --end
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DRG' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 4)
	else
		set_macro_page(1, 1)
	end
end