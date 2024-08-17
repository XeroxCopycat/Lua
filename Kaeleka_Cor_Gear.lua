-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.RangedMode:options('Normal', 'Acc', 'Fodder')
    state.WeaponskillMode:options('Normal','Acc', 'Fodder')
    state.CastingMode:options('Normal', 'Resistant', 'Proc', 'StoreTP')
    state.IdleMode:options('Normal', 'PDT', 'Regen', 'Refresh')
	state.HybridMode:options('Normal','DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default', 'Savage', 'LeadenMelee', 'LeadenRanged', 'LastStand', 'Terminus', 'Wildfire', 'Evisceration', 'Aeolian',
		'DualSavage', 'DualLeadenMelee', 'DualLeadenRanged', 'DualLastStand', 'DualTerminus', 'DualWildfire', 'DualEvisceration', 'DualAeolian')
	state.CompensatorMode:options('Always','300','1000','Never')

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
	send_command('bind ^q gs c weapons DualAeolian;gs c update')
	send_command('bind !q gs c weapons DualLeadenRanged;gs c update')
	send_command('bind @pause roller roll')

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
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}


	--------------------------------------
	-- Phantom Roll precast
	--------------------------------------
    sets.precast.CorsairRoll = {
		main={ name="Rostam", augments={'Path: C',}},
		range="Compensator",
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Malignance Tabard",
		hands="Chasseur's Gants +3",
		legs="Malignance Tights", -- Desulutor's Tassets
		feet="Malignance Boots",
		neck="Regal Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=gear.snapshot_jse_back,
	}


	--------------------------------------
	-- Precast for larger AOE on Phantom Roll
	--------------------------------------
    sets.precast.LuzafRing = {right_ring="Luzaf's Ring"}
    
    
	--------------------------------------
	-- Precast gear for specific rolls
	--------------------------------------
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})
	
	
	--------------------------------------
	-- Quick Draw Sests
	--------------------------------------
	-- Quick Draw Precsat / Normal
	sets.precast.CorsairShot = {
		ammo="Hauksbok Bullet",
		head={ name="Ikenga's Hat", augments={'Path: A',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Dingir Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	-- Quick Draw Precsat / Resistant
	sets.precast.CorsairShot.Resistant = set_combine(sets.precast.CorsairShot, {
		ammo="Animikii Bullet",
		head="Laksa. Tricorne +3",
		body="Ikenga's Vest",
		hands="Laksa. Gants +3",
		legs={ name="Ikenga's Trousers", augments={'Path: A',}},
		feet="Laksa. Bottes +2",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		left_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})

	-- Quick Draw Precsat / Proc
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {feet="Chass. Bottes +3"})
	
	-- Quick Draw Precsat / StoreTP
	sets.precast.CorsairShot.StoreTP = set_combine(sets.precast.CorsairShot, {
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Ilabrat Ring",
	})
	
	-- Quick Draw Precsat / Light Shot
    sets.precast.CorsairShot['Light Shot'] = set_combine{sets.precast.CorsairShot.Resistant, {right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},	}}
	
	-- Quick Draw Precsat / Dark Shot
    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], { })


    --------------------------------------
	-- Waltz sets
	--------------------------------------
	-- Curing Waltz / Others
    --sets.precast.Waltz = {
        --head="Carmine Mask +1",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
        --body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        --back="Moonlight Cape",waist="Flume Belt +1",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
		
	-- Curing Waltz / Self
	sets.Self_Waltz = {
		head="Mummu Bonnet +2",
		--body="Passion Jacket",
		--left_ring="Asklepian Ring",
	}
        
	-- Healing Waltz.
    --sets.precast.Waltz['Healing Waltz'] = {}
	
	
	--------------------------------------
	-- Fast Cast gear
	--------------------------------------
	-- To-Do: Add fast cast cape, herc. legs w/ fast cast, carmine feet
    sets.precast.FC = {
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
	}

	-- Fast Cast / Utsusemi
    --sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads", body="Passion Jacket"})
	
	-- Fast Cast / Cure
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})


	--------------------------------------
	-- Preshot Gear
	--------------------------------------
	-- No Flurry / Snapshot 60%
    sets.precast.RA = {
		ammo=gear.RAbullet,
        head="Chass. Tricorne +3",
		body="Oshosi Vest +1",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Impulse Belt",
		--ring="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}
	
	-- Flurry I / Snapshot 45%
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
		body="Laksa. Frac +3",
		waist="Yemaya Belt",
	})
	
	-- Flurry II / Snapshop 30%
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
		body="Laksa. Frac +3",
		waist="Yemaya Belt",
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
	})

       
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default weaponskill gear
	--------------------------------------
    sets.precast.WS = {
        head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Chasseur's Gants +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, { })
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {body="Ikenga's Vest",left_ring="Sroda Ring"})
		
    --------------------------------------
	-- Dagger Weaponskills
	--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
    --Evisceration
	sets.precast.WS['Evisceration'] = {
		head="Blistering Sallet +1",
		body="Meg. Cuirie +2",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Zoar Subligar +1",
		feet={ name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {
		body="Ikenga's Vest",
		hands="Malignance Gloves",
		feet="Ikenga's Clogs",
		left_ear="Mache Earring",
	})

	
    --------------------------------------
	-- Gun Weaponskills
	--------------------------------------
	-- Hot Shot
    sets.precast.WS['Hot Shot'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Chasseur's Gants +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	
	-- Last Stand
    sets.precast.WS['Last Stand'] = {
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Ikenga's Vest",
		hands="Chasseur's Gants +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], { })
	
    sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {
		head={ name="Nyame Helm", augments={'Path: B',}},
		legs={ name="Ikenga's Trousers", augments={'Path: A',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
	})
	
	
	-- Leaden Salute
	sets.precast.WS['Leaden Salute'] = {
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	
	-- Terminus
	sets.precast.WS['Terminus'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Terminus'].Acc = sets.precast.WS['Last Stand'].Acc
	sets.precast.WS['Terminus'].Fodder = sets.precast.WS['Last Stand'].Fodder
	
	
	 -- Wildfire
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'], {
		head={ name="Nyame Helm", augments={'Path: B',}}, 
		left_ring="Cornelia's Ring",
	})


	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	--Requiescat
    sets.precast.WS['Requiescat'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Chasseur's Gants +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], { })
	
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {
		body="Ikenga's Vest",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})
	
	
	--------------------------------------
	-- Swaps when using WS at 3000 TP
	--------------------------------------
	sets.MaxTP = {}
	sets.AccMaxTP = {}
        
    
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
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
	}
        
    
	--------------------------------------
	-- Midcast Gear for Specific Spells
	--------------------------------------
	sets.midcast.Cure = {
        head="Carmine Mask +1",neck="Phalaina Locket",left_ear="Enchntr. Earring +1",right_ear="Mendi. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Janniston Ring",ring2="Lebeche Ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast


	--------------------------------------
	-- Midshot Gear
	--------------------------------------
    -- Ranged Attack / Normal
	sets.midcast.RA = {
		ammo=gear.RAbullet,
        head={ name="Ikenga's Hat", augments={'Path: A',}},
		body="Ikenga's Vest",
		hands="Ikenga's Gloves",
		legs="Chas. Culottes +3",
		feet="Ikenga's Clogs",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Ranged Attack / Acc
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
	})
	
	-- Ranged Attack / Fodder
	sets.midcast.RA.Fodder = set_combine(sets.midcast.RA, {
		legs={ name="Ikenga's Trousers", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})
	
	-- Ranged Attack / StoreTP
	sets.midcast.RA.StoreTP = set_combine(sets.midcast.RA, {
		right_ear="Dedition Earring",
		right_ring="Chirich Ring +1",
	})
	
	
	--------------------------------------
	-- Triple Shot gear
	--------------------------------------	
	sets.buff['Triple Shot'] = {
		body="Chasseur's Frac +3",
		hands="Lanun Gants +3",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Mag. Evasion+15',}},
	}


-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
    --------------------------------------
	-- Base Idle Set
	--------------------------------------
    sets.idle = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}
		
	
	--------------------------------------
	-- Idle Regen set
	--------------------------------------
	sets.idle.Regen = set_combine(sets.idle, { 
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		left_ring="Chirich Ring +1",
	})
	

	--------------------------------------
	-- Idle Refresh set
	--------------------------------------
    sets.idle.Refresh = set_combine(sets.idle.Regen, {neck="Sybil Scarf"})
	
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Damage Reduction / DT Sets
	--------------------------------------
	-- Physical Damage Taken
    sets.defense.PDT = {
        head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}

	
	-- Magic Damage Taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		right_ring="Archon Ring",
	})
	
	
	
	-- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
        head="Volte Cap",
		feet="Volte Boots",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Hearty Earring",
		right_ring="Warden's Ring",
		back="Solemnity Cape",
	})
		
	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Kiting
	--------------------------------------
    sets.Kiting = {right_ring="Shneddick Ring"}
	
	
	--------------------------------------
	-- Treasure Hunter
	--------------------------------------
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	
	--------------------------------------
	-- Dual Wield Max
	--------------------------------------
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
	
	
	--------------------------------------
	-- Doom
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
    
	
    -- Resting sets
    sets.resting = {}
	
	
	-- Bullet Pouch
	sets.BulletPouch = {waist="Chr. Bul. Pouch"}
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Single Wield Sets
	--------------------------------------
	-- Engaged Set
    sets.engaged = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Herculean Vest", augments={'"Triple Atk."+3','INT+10','Accuracy+9','Attack+6',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Iskur Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	
	
	-- Accuracy Set
    sets.engaged.Acc = set_combine(sets.engaged, {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Mache Earring", --Upgrade to +1
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}}, --Change to Crep. Earring
		left_ring="Chirich Ring +1",
	})
	

	-- Fodder Set
    sets.engaged.Fodder = set_combine(sets.engaged, {})
	
	
	-- Hybrid DT Set
    sets.engaged.DT = set_combine(sets.engaged, {
        head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		feet="Malignance Boots",
		left_ring="Defending Ring",
	})
	

	--------------------------------------
	-- Dual Wield Sets
	--------------------------------------
	-- DW Engaged Set
    sets.engaged.DW = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Iskur Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
    
	
	-- DW Accuracy Set
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ring="Chirich Ring +1",
	})
	
	
	-- DW Fodder Set
    sets.engaged.DW.Fodder = set_combine(sets.engaged.DW, {})

	
	-- DW Hybrid DT Set
    sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
        head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		feet="Malignance Boots",
		left_ring="Defending Ring",
	})
		
	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Weapon Sets
	--------------------------------------
		sets.weapons.Default = {main="Naegling", sub="Nusku Shield", range="Death Penalty"}
		sets.weapons.Savage = {main="Naegling", sub="Nusku Shield", range="Ataktos"}
		sets.weapons.LeadenRanged = {main={ name="Rostam", augments={'Path: A',}}, sub="Nusku Shield", range="Death Penalty"}
		sets.weapons.LeadenMelee = {main="Naegling", sub="Nusku Shield", range="Death Penalty"}
		sets.weapons.LastStand = {main={ name="Rostam", augments={'Path: A',}}, sub="Nusku Shield", range="Fomalhaut"}
		sets.weapons.Wildfire = {main="Naegling", sub="Nusku Shield", range="Death Penalty"}
		sets.weapons.Evisceration = {main="Tauret", sub="Nusku Shield", range="Ataktos"}
		sets.weapons.Aeolian = {main={ name="Rostam", augments={'Path: A',}}, sub="Nusku Shield", range="Ataktos"} 
		sets.weapons.Terminus = {main="Gleti's Knife", sub="Nusku Shield", range="Earp"}
		sets.weapons.DualSavage = {main="Naegling", sub="Crepuscular Knife", range="Ataktos"}
		sets.weapons.DualLeadenRanged = {main={ name="Rostam", augments={'Path: A',}}, sub="Tauret", range="Death Penalty"}
		sets.weapons.DualLeadenMelee = {main="Naegling", sub="Tauret", range="Death Penalty"}
		sets.weapons.DualLastStand = {main={ name="Rostam", augments={'Path: A',}}, sub="Crepuscular Knife", range="Fomalhaut"}
		sets.weapons.DualWildfire = {main="Naegling", sub="Tauret", range="Death Penalty"}
		sets.weapons.DualEvisceration = {main="Tauret", sub="Gleti's Knife", range="Ataktos"}
		sets.weapons.DualAeolian = {main="Tauret", sub="Naegling", range="Ataktos"}
		sets.weapons.DualTerminus = {main="Gleti's Knife", sub="Crepuscular Knife", range="Earp"}
	end

	--------------------------------------
	-- Selects default macro book on initial load or subjob change.
	--------------------------------------
	function select_default_macro_book()
		set_macro_page(1, 1)
	end

	--------------------------------------
	--AutoWS when a specific weapon set is selected
	--------------------------------------
	autows_list = {
		['Default']='Savage Blade',
		['Savage']='Savage Blade',
		['LeadenRanged']='Leaden Salute',
		['LeadenMelee']='Leaden Salute',
		['LastStand']='Last Stand',
		['Wildfire']='Wildfire',
		['Evisceration']='Evisceration',
		['Terminus']='Terminus',
		['DualSavage']='Savage Blade',
		['DualLeadenRanged']='Leaden Salute',
		['DualLeadenMelee']='Leaden Salute',
		['DualLastStand']='Last Stand',
		['DualWildfire']='Wildfire',
		['DualEvisceration']='Evisceration',
		['DualAeolian']='Aeolian Edge',
		['DualTerminus']='Terminus'
	}