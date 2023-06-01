-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

--[[
    gs c toggle luzaf -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    Acc on offense mode (which is intended for melee) will currently use .Acc weaponskill
    mode for both melee and ranged weaponskills.  Need to fix that in core.
--]]


--Startup--
    send_command('gs enable all')   
    send_command('input /macro book 4;wait 1;input /macro set 1;wait 3;input /lockstyleset 80')
    
-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    mote_include_version = 2
    include('Mote-Include.lua')
    include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    state.warned = M(false)
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false
	
	-- Override certain gear from swapping, very important for QD bullets
	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
              "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch"}
	no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}

    --define_roll_values()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'StoreTP', 'Crit')
    state.HybridMode:options('Normal', 'PDT' )
    state.RangedMode:options('Normal', 'MidAcc', 'HighAcc', 'StoreTP', 'Crit')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Acc', 'StoreTP')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')

    options.ammo_warning_limit = 15

    state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }

    cor_sub_weapons = S{"Demers. Degen +1", }
    auto_gun_ws = "Wildfire"

    get_combat_form()
    -- Additional local binds
    -- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
	-- Cor doesn't use casting mode; use that for Quick Draw mode adjustments.
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command('bind != gs c toggle CapacityMode')
    
    send_command('bind ^- gs c cycle AutoRA')
    select_default_macro_book()
	
	state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind !`')
    send_command('unbind ^-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	-- Precast sets to enhance JAs
    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.JA['Fold'] = {hands="Lanun Gants +3"} 
    sets.CapacityMantle = {back="Aptitude Mantle +1"}
    
    sets.precast.CorsairRoll = {
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Malignance Tabard",
		hands="Chasseur's Gants +3",
		--legs="Desultor Tassets", --Ability Delay -5
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Regal Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Luzaf's Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
}
    TaeonHands = {}
    TaeonHands.Snap = {name="Taeon Gloves", augments={'Attack+22','"Snapshot"+8'}}
	
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})
    
    sets.precast.LuzafRing = {right_ring="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}
    
    sets.precast.CorsairShot = {}
    

    -- Waltz set (chr and vit)
    --sets.precast.Waltz = {
        --head="Whirlpool Mask",
        --hands="Iuitl Wristbands +1",
        --legs="Adhemar Kecks",
    --}

    --sets.Organizer = {
        --ain="Arendsi Fleuret",
        --sub="Odium",
        --range="Doomsday",
        --hands="Compensator",
        --ammo="Legion Scutum"
    --}
        
    -- Don't need any special gear for Healing Waltz.
    --sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		--head="Carmine Mask +1", --Path D
		head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Enmity-1','MND+4','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		--legs="Herculean Trousers" --Fast Cast
		legs="Malignance Tights",
		--Feet="Carmine Greaves +1", --Path D
		feet="Malignance Boots",
		--neck="Orunmila's torque",
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		--left_ring="Rahab Ring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		--back="Camulus's Mantle", --Fast Cast
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		--body="Passion Jacket",
		neck="Magoraga Beads",
	})
    
    sets.precast.RA = { -- +51 Rapid Shot, +62 Snapshot
		head="Chass. Tricorne +3", --18 RS/0 SS
		--body="Oshosi Vest +1", --0 RS/14 SS
		body="Laksa. Frac +3", --20 RS/0 SS
		hands="Lanun Gants +3", --0 RS/13 SS
		legs="Adhemar Kecks +1", augments={'Path: D',}, --13 RS/10 SS 
		feet="Meg. Jam. +2", --0 RS/10 SS
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --0 RS/4 SS
		waist="Yemaya Belt", --0 RS/5 SS
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+8','"Store TP"+10','Mag. Evasion+15',}}, --0 RS/10 SS
	}
	
	sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body="Laksa. Frac +3",
    }) --47/52

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        hands="Carmine Fin. Ga. +1", --8/11
        feet="Pursuer's Gaiters", --0/10
        }) --32/73

	--------------------------------------
    -- Weaponskill sets
	--------------------------------------
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head={ name="Nyame Helm", augments={'Path: B',}},
    body="Laksa. Frac +3",
    hands="Chasseur's Gants +3",
    legs="Nyame Flanchard",
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	--------------------------------------
	-- Dagger Weaponskills
	--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Enmity-1','MND+4','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		--waist="Orpheus's Sash",
		waist="Eschan Stone",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
    --Evisceration
	sets.precast.WS['Evisceration'] = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		--body="Abnoba Kaftan",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		--legs="Herculean Trousers", --Dex/Atk/Acc/CritDmg
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet="Mummu Gamash. +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Mummu Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Laksa. Frac +3",
		hands="Chasseur's Gants +3",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','MND+8',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	--Requiescat
    sets.precast.WS['Requiescat'] = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Chasseur's Gants +3",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
	-- Gun Weaponskills
	--------------------------------------
	--Wildfire
	sets.precast.WS['Wildfire'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands="Chasseur's Gants +3",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','MND+8',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	--Last Stand
    sets.precast.WS['Last Stand'] = {
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Laksa. Frac +3",
		hands="Chasseur's Gants +3",
		legs="Meg. Chausses +2",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
	})
	
	--Leaden Salute
	sets.precast.WS['Leaden Salute'] = {
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Dingir Ring",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	--------------------------------------
	-- Midcast Sets
	--------------------------------------
    sets.midcast.FastRecast = {
}
 
	-- Specific spells
    --sets.midcast.Utsusemi = sets.midcast.FastRecast

	--Quick Draw
    sets.midcast.CorsairShot = {
		head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Enmity-1','MND+4','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		feet="Chass. Bottes +3",
		neck="Baetyl Pendant",
		--waist="Skrymir Cord +1",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		--right_ring="Fenrir Ring +1",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

    sets.midcast.CorsairShot.Acc = {
		head="Laksa. Tricorne +3",
		body="Malignance Tabard",
		hands="Chasseur's Gants +3",
		legs="Malignance Tights",
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		--waist="K. Kachina Belt +1",
		waist="Eschan Stone",
		--left_ear="Digni. Earring",
		left_ear="Telos Earring",
		right_ear="Gwati Earring",
		--left_ring="Stikini Ring +1",
		left_ring="Mummu Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.midcast.CorsairShot.StoreTP = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Melignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		left_ring="Mummu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Acc
	
    sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot.Acc, {
        head="Pixie Hairpin +1",
        left_ring="Archon Ring",
	})

    -- Midshot Set
    sets.midcast.RA = {
		head="Ikenga's Hat",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+8','"Store TP"+10','Mag. Evasion+15',}},
	}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		body="Laska. Frac +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		--waist="K. Kachina Belt +1",
		--left_ear="Belya Earring",
		--left_ring="Hajduk Ring +1",
		right_ring="Regal Ring",
	})

	sets.midcast.RA.StoreTP = set_combine(sets.midcast.RA, {
		feet="Malignance Boots",
		--waist="Gerdr Belt +1",
		left_ear="Dedition Earring",
		--left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	})
	
	sets.midcast.RA.TripleShot = set_combine(sets.midcast.RA, {
		--head="Oshosi Mask +1",
		body="Chasseur's Frac +3",
		hands="Lanun Gants +3",
		--legs="Osh. Trousers +1",
		--feet="Osh. Leggings +1",
	})
    
	--------------------------------------
	-- Miscelanious Sets
	--------------------------------------
    -- Sets to return to when not performing an action.
    -- Resting sets
    sets.resting = {ring2="Paguroidea Ring"}

    -- Idle sets
    sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Hearty Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}

    sets.idle.Regen = set_combine(sets.idle, {
        head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		feet="Meg. Jam. +2",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		left_ring="Shneddick Ring",
        right_ring="Chirich Ring +1",		
	})

    sets.idle.Town = {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {
        head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Hearty Earring",
		left_ring="Vengeful Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	})

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {left_ring="Shneddick Ring"}

	-------------------------------------
    -- Engaged sets
	-------------------------------------
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	-- Normal, MidAcc, HighAcc, StoreTP, Crit
    
    sets.engaged = { --1265 Acc
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Iskur Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.MidAcc= set_combine(sets.engaged, { --1367 Acc
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Torque",
	})
	
	sets.engaged.HighAcc= set_combine(sets.engaged.MidAcc, {
		head="Chass. Tricorne +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		left_ear="Telos Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Epona's Ring",
		right_ring="Regal Ring",
	})

	sets.engaged.StoreTP = set_combine(sets.engaged, {
		right_ring="Chirich Ring +1",
	})		
			
    sets.engaged.Crit = set_combine(sets.engaged, {
        head="Mummu Bonnet +2",
		hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		left_ring="Mummu Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
})

	-------------------------------------
    -- Dual Wield sets
	-------------------------------------
	-- Requires the GearInfo plugin to function
	-- properly. Otherwise will fallback to engaged sets.
    -- * /NIN DW Trait: 25% DW
    -- * /DNC DW Trait: 15% DW
	
		-------------------------------------
    -- Dual Wield sets
	-------------------------------------
	-- Requires the GearInfo plugin to function
	-- properly. Otherwise will fallback to engaged sets.
    -- * /NIN DW Trait: 25% DW
    -- * /DNC DW Trait: 15% DW
	
	-- No Magic Haste (74% DW to cap)
    sets.engaged.DW = { --+70 Dual Wield
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}},
		legs="Malignance Tights",
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+4','STR+5 DEX+5',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Gelatinous Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
    }
	
    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
		neck="Sanctity Necklace",
	})
	
    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})
	
    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		legs="Chas. Culottes +3",
	})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = { --+66 Dual Wield
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}},
		legs="Malignance Tights",
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+4','STR+5 DEX+5',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear="Suppanomimi",
		left_ring="Gelatinous Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		neck="Sanctity Necklace",
		left_ear="Telos Earring",
	})
    
	sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})
    
	sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = { --+58 DW
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}, --DW +5
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai", --DW +7
		left_ear="Dedition Earring",
		right_ear="Suppanomimi", --DW +5
		left_ring="Gelatinous Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --DW +10
	}
	
    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		neck="Sanctity Necklace",
		left_ear="Telos Earring",
	})
	
    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})
    
	sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = { --+52 DW 
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}, --DW +5
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai", --DW +7
		left_ear="Eabani Earring", --DW +4
		right_ear="Suppanomimi", --DW +5
		left_ring="Gelatinous Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		neck="Sanctity Necklace",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})
	
    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		left_ear="Telos Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --DW +10
	})
	
    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		legs="Chas. Culottes +3",
		left_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})

    -- 45% Magic Haste (+36 DW needed)
    sets.engaged.DW.MaxHaste = { --+38 DW
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai", --DW +7
		left_ear="Dedition Earring", 
		right_ear="Telos Earring",
		left_ring="Gelatinous Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		neck="Sanctity Necklace",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})
	
    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		feet="Chass. Bottes +3",
	})
	
    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		legs="Chas. Culottes +3",
		left_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
	})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 1000+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end

-- Checks if Flurry is cast upon us, and uses the appropriate RA precast set.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
	elseif spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
	
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' or spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
	function job_aftercast(spell, action, spellMap, eventArgs)
		if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, default_wsmode)
    --if buffactive['Transcendancy'] then
    --  return 'Brew'
    --end
end
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end

function status_change(new,old)
    if new == 'Engaged' then
        equipSet = sets.engaged.Melee
    end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    --check_gear()
    update_combat_form()
    determine_haste_group()
    --check_moving()
end

function job_update(cmdParams, eventArgs)
    get_combat_form()
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Job-specific toggles.
function job_toggle_state(field)
    if field:lower() == 'luzaf' then
        state.LuzafRing:toggle()
        return "Use of Luzaf Ring", state.LuzafRing.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CorsairShotMode.current

    if state.AutoRA.value ~= 'Normal' then
        msg = '[Auto RA: ON]['..state.AutoRA.value..']'
    else
        msg = msg .. '[Auto RA: OFF]'
    end
    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end
	)

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

function get_combat_form()
	if state.Buff['Triple Shot'] then
		state.CombatForm:set('TripleShot')
    end
    if cor_sub_weapons:contains(player.equipment.main) then
      if player.equipment.main == gear.Stave then
        if S{'NIN', 'DNC'}:contains(player.sub_job) and cor_sub_weapons:contains(player.equipment.sub) then
            state.CombatForm:set("DW")
        else
            state.CombatForm:reset()
        end
    else
        state.CombatForm:set('Stave')
    end
end

function use_weaponskill()
    send_command('input /ws "'..auto_gun_ws..'" <t>')
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function use_ra(spell)
    local delay = '2.2'
    -- GUN 
    if spell.type:lower() == 'weaponskill' then
        delay = '2.25' 
    else
        if buffactive["Courser's Roll"] then
            delay = '0.7' -- MAKE ADJUSTMENT HERE
        elseif buffactive['Flurry II'] then
            delay = '0.5'
        else
            delay = '1.05' -- MAKE ADJUSTMENT HERE
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
            bullet_name = gear.RAccbullet
        else
            bullet_name = gear.RAbullet
        end
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe7[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

function special_ammo_check()
    -- Stop if Animikii/Hauksbok equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
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


function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(3, 4)
    elseif player.sub_job == 'WAR' then
        set_macro_page(5, 4)
    else
        set_macro_page(1, 4)
    end
end

--Unload--
function file_unload()
    send_command('lua unload autocor')
	end
end
