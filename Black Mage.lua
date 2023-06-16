-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+D ]           Toggle Death Casting Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+P ]           Shock Spikes
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    -- state.CP = M(false, "Capacity Points Mode")

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'}
        }

    lockstyleset = 100

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.CastingMode:options('Normal', 'Resistant', 'Spaekona')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}

    -- Additional local binds

    send_command('bind ^` input /ma Stun <t>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind !p input /ma "Shock Spikes" <me>')
    send_command('bind @d gs c toggle DeathMode')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind ^numpad0 input /Myrkr')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @d')
    -- send_command('unbind @c')
    send_command('unbind @w')
    send_command('unbind ^numpad0')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -------------------------------------
    -- Precast sets
	-------------------------------------
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        --feet="Wicce Sabots +1",
        back={ name="Taranus's Cape", augments={'Mag. Acc+20 /Mag. Dmg.+20',}},
    }

    sets.precast.JA.Manafont = {body="Arch. Coat +1"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        head={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +4','MND+4','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+29','"Fast Cast"+5','MND+7','Mag. Acc.+14',}},
		hands="Jhakri Cuffs +2",
		legs="Mallquis Trews +2",
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		left_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Jhakri Ring",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        --waist="Siegel Sash",
        --back="Perimede Cape",
        })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak", waist="Shinjutsu-no-Obi +1"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})
    sets.precast.Storm = set_combine(sets.precast.FC, {right_ring={name="Stikini Ring +1", bag="wardrobe4"},})

    sets.precast.FC.DeathMode = {
        ammo="Ghastly Tathlum +1",
        --head="Amalric Coif +1", --11
        --body="Amalric Doublet +1",
        --hands="Merlinic Dastanas", --6
        --legs="Volte Brais", --8
        --feet="Volte Gaiters", --6
        --neck="Orunmila's Torque", --5
        --left_ear="Etiolation Earring", --1
        right_ear="Loquacious Earring", --2
        --left_ring="Mephitas's Ring +1",
        --right_ring="Weather. Ring +1", --5
        --back="Bane Cape", --4
        --waist="Embla Sash",
    }

    sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {
		head=empty,
		body="Crepuscular Cloak",
		--waist="Shinjutsu-no-Obi +1",
	})

	
    -------------------------------------
    -- weaponskill sets
	-------------------------------------
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back={ name="Taranus's Cape", augments={'Mag. Acc+20 /Mag. Dmg.+20',}},
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands=gear.Telchine_ENH_hands,
        legs="Amalric Slops +1",
        feet="Medium's Sabots",
        neck="Orunmila's Torque",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        left_ring="Mephitas's Ring +1",
        right_ring="Mephitas's Ring",
        back="Bane Cape",
        waist="Shinjutsu-no-Obi +1",
    } -- Max MP

    sets.precast.WS['Vidohunir'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        legs="Merlinic Shalwar",
        feet="Merlinic Crackows",
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Moonshade Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Archon Ring",
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
        } -- INT

    

	-------------------------------------
    -- Midcast sets
	-------------------------------------
    sets.midcast.FastRecast = sets.precast.FC

	-- Cures
    sets.midcast.Cure = {
        --ammo="Esper Stone +1", --0/(-5)
        --body="Vanya Robe",
        --hands=gear.Telchine_ENH_hands, --10
        --feet="Medium's Sabots", --12
        --neck="Nodens Gorget", --5
        --ear1="Mendi. Earring", --5
        --ear2="Roundel Earring", --5
        --left_ring="Lebeche Ring", --3/(-5)
        --right_ring="Haoma's Ring",
        --back="Oretan. Cape +1", --6
        --waist="Bishop's Sash",
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        --neck="Nuna Gorget +1",
        --left_ring={name="Stikini Ring +1", bag="wardrobe3"},
        --right_ring="Metamor. Ring +1",
        --waist="Luminary Sash",
    })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        --main=gear.Gada_ENH,
        --sub="Genmei Shield",
        --head="Vanya Hood",
        --body="Vanya Robe",
        --hands="Hieros Mittens",
        --feet="Vanya Clogs",
        --neck="Debilis Medallion",
        --ear1="Beatific Earring",
        --ear2="Meili Earring",
        --left_ring="Menelaus's Ring",
        --right_ring="Haoma's Ring",
    })

	-- Enhancing Magic
    sets.midcast['Enhancing Magic'] = {
        --main=gear.Gada_ENH,
        --sub="Ammurapi Shield",
        --head=gear.Telchine_ENH_head,
        --body=gear.Telchine_ENH_body,
        --hands=gear.Telchine_ENH_hands,
        --legs=gear.Telchine_ENH_legs,
        --feet=gear.Telchine_ENH_feet,
        --neck="Incanter's Torque",
        --ear1="Mimir Earring",
        --ear2="Andoaa Earring",
        --left_ring={name="Stikini Ring +1", bag="wardrobe3"},
        --right_ring={name="Stikini Ring +1", bag="wardrobe4"},
        --back="Fi Follet Cape +1",
        --waist="Olympus Sash",
    }

    sets.midcast.EnhancingDuration = {
        --main=gear.Gada_ENH,
        --sub="Ammurapi Shield",
        --head=gear.Telchine_ENH_head,
        --body=gear.Telchine_ENH_body,
        --hands=gear.Telchine_ENH_hands,
        --legs=gear.Telchine_ENH_legs,
        --feet=gear.Telchine_ENH_feet,
        --waist="Embla Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        --main="Bolelabunga",
        --sub="Ammurapi Shield",
        --head=gear.Telchine_ENH_head,
        --body=gear.Telchine_ENH_body,
        --hands=gear.Telchine_ENH_hands,
        --legs=gear.Telchine_ENH_legs,
        --feet=gear.Telchine_ENH_feet,
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        --head="Amalric Coif +1",
        --feet="Inspirited Boots",
        --waist="Gishdubar Sash",
        --back="Grapevine Cape",
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        --neck="Nodens Gorget",
        --waist="Siegel Sash",
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        --main="Vadose Rod",
        --sub="Ammurapi Shield",
        ammo="Staunch Tathlum +1",
        --head="Amalric Coif +1",
        --hands="Regal Cuffs",
        --ear1="Halasz Earring",
        --left_ring="Freke Ring",
        --right_ring="Evanescence Ring",
        --waist="Emphatikos Rope",
    })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {left_ring="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

	-- Enfeebling magic
    sets.midcast.MndEnfeebles = {
        main="Daybreak",
        --sub="Ammurapi Shield",
        --ammo="Pemphredo Tathlum",
        --head=empty;
        --body="Cohort Cloak +1",
        --hands="Regal Cuffs",
        --legs="Ea Slops +1",
        --feet="Skaoi Boots",
        neck="Erra Pendant",
        --ear1="Malignance Earring",
        --ear2="Vor Earring",
        --left_ring={name="Stikini Ring +1", bag="wardrobe3"},
        --right_ring={name="Stikini Ring +1", bag="wardrobe4"},
        --back="Aurist's Cape +1",
        --waist="Luminary Sash",
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        --main="Maxentius",
        --sub="Ammurapi Shield",
        --waist="Acuity Belt +1",
    })

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
		main="Daybreak",
		sub="Ammurapi Shield",
		--waist="Shinjutsu-no-Obi +1",
	})

	-- Dark Magic
    sets.midcast['Dark Magic'] = {
        head="Pixie Hairpin +1",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Barkaro. Earring",
		right_ear="Telos Earring",
		left_ring="Kishar Ring",
		right_ring="Jhakri Ring",
		back={ name="Taranus's Cape", augments={'Mag. Acc+20 /Mag. Dmg.+20',}},
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +4','MND+4','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		body={ name="Agwu's Robe", augments={'Path: A',}},
		hands={ name="Agwu's Gages", augments={'Path: A',}},
		legs="Spae. Tonban +1",
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		neck="Sorcerer's Stole",
		waist="Fucho-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Regal Earring",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        feet="Volte Gaiters",
    })

    sets.midcast.Death = {
        --main=gear.Grioavolr_MB, --5
        --sub="Enki Strap",
        --ammo="Ghastly Tathlum +1",
        --head="Pixie Hairpin +1",
        --body=gear.Merl_MB_body, --10
        --hands="Amalric Gages", --(5)
        --legs="Amalric Slops +1",
        --feet="Merlinic Crackows", --11
        --neck="Mizu. Kubikazari", --10
        --ear1="Malignance Earring",
        --ear2="Regal Earring",
        --left_ring="Mephitas's Ring +1",
        --right_ring="Metamor. Ring +1",
        --back=gear.BLM_Death_Cape, --5
        --waist="Sacro Cord",
        }

    sets.midcast.Death.Resistant = set_combine(sets.midcast.Death, {
        --main=gear.Grioavolr_MB,
        --sub="Enki Strap",
        --head="Amalric Coif +1",
        --waist="Acuity Belt +1",
    })

    -- Elemental Magic sets
    sets.midcast['Elemental Magic'] = {
		ammo="Sroda Tathlum",
		head="Wicce Petasos +2",
		body="Wicce Coat +3",
		hands="Wicce Gloves +3",
		legs="Wicce Chausses +3",
		feet="Wicce Sabots +2",
		neck="Sorcerer's Stole",
		waist="Eschan Stone",
		left_ear="Regal Earring",
		right_ear={ name="Wicce Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+12','Enmity-2',}},
		left_ring="Metamor. Ring +1",
		right_ring="Defending Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
    }

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
        --main=gear.Grioavolr_MB,
        --sub="Enki Strap",
        --ammo="Ghastly Tathlum +1",
        --legs="Amalric Slops +1",
        --feet="Merlinic Crackows",
        --back=gear.BLM_Death_Cape,
        })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        --sub="Khonsu",
        ammo="Pemphredo Tathlum",
        --legs="Merlinic Shalwar",
        neck="Sanctity Necklace",
        --waist="Sacro Cord",
        })

    sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
        --sub="Khonsu",
        ammo="Pemphredo Tathlum",
        body="Spaekona's Coat +2",
        --legs="Merlinic Shalwar",
        --feet="Merlinic Crackows",
        neck="Erra Pendant",
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak",
        right_ring="Archon Ring",
        })

    sets.midcast.Impact.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        --sub="Khonsu",
        --head=empty,
        --body="Twilight Cloak",
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    sets.resting = {
        --main="Chatoyant Staff",
        --waist="Shinjutsu-no-Obi +1",
        }

	-------------------------------------
    -- Idle sets
	-------------------------------------
    sets.idle = {
        ammo="Staunch Tathlum +1",
		head="Volte Beret",
		body="Wicce Coat +3",
		hands="Nyame Gauntlets",
		legs="Assid. Pants +1",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Wicce Coat +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
    })

    sets.idle.ManaWall = {
        --feet="Wicce Sabots +1",
        --back=gear.BLM_Death_Cape,
    }

    sets.idle.DeathMode = {
        --ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        --body="Amalric Doublet +1",
        --hands="Amalric Gages",
        --legs="Amalric Slops +1",
        --feet="Merlinic Crackows",
        neck="Sanctity Necklace",
        --left_ear="Malignance Earring",
        right_ear="Regal Earring",
        --left_ring="Mephitas's Ring +1",
        --right_ring="Mephitas's Ring",
        --back=gear.BLM_Death_Cape,
        --waist="Shinjutsu-no-Obi +1",
    }

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Sroda Tathlum",
		head={ name="Arch. Petasos +3", augments={'Increases Ancient Magic damage and magic burst damage',}},
		body={ name="Arch. Coat +1", augments={'Enhances "Manafont" effect',}},
		hands={ name="Arch. Gloves +1", augments={'Increases Elemental Magic accuracy',}},
		legs={ name="Arch. Tonban +3", augments={'Increases Elemental Magic debuff time and potency',}},
		feet={ name="Arch. Sabots +1", augments={'Increases Aspir absorption amount',}},
		neck="Sorcerer's Stole",
		waist="Eschan Stone",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
    })

   
	-------------------------------------
    -- Defense sets
	-------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Shneddick Ring"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.latent_dt = {ear2="Sorcerer's Earring"}

	-------------------------------------
    -- Magic Burst sets
	-------------------------------------

    sets.magic_burst = {
        head="Ea Hat +1",
		body="Wicce Coat +3",
		hands={ name="Agwu's Gages", augments={'Path: A',}},
		legs={ name="Agwu's Slops", augments={'Path: A',}},
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		neck="Sorcerer's Stole",
		waist="Eschan Stone",
		left_ear="Barkaro. Earring",
		right_ear="Regal Earring",
		left_ring="Kishar Ring",
		right_ring="Jhakri Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
    }

    sets.magic_burst.Resistant = {
        neck="Sanctity Necklace",
    }
	
	-------------------------------------
    -- Engaged Sets
	-------------------------------------
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = {
        ammo="Amar Cluster",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Mache Earring",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
    }

	-------------------------------------
    -- Misc. Sets
	-------------------------------------
    sets.buff.Doom = {
        --neck="Nicander's Necklace", --20
        --left_ring={name="Eshmun's Ring", bag="wardrobe3"}, --20
        --right_ring={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
    }

    sets.DarkAffinity = {
		head="Pixie Hairpin +1",
		left_ring="Archon Ring",
	}
    
	-- sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end

    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            --if state.CastingMode.value == "Resistant" then
                --equip(sets.magic_burst.Resistant)
            --else
                equip(sets.magic_burst)
            --end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('left_ring','right_ring','waist')
        else
            enable('left_ring','right_ring','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- latent DT set auto equip on HP% change
    windower.register_event('hpp change', function(new, old)
        if new<=25 then
            equip(sets.latent_dt)
        end
    end)


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end

    return defenseSet
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.DeathMode.value then
        msg = msg .. ' Death: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir','Aspir II','Aspir III'}

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if aspirs:contains(spell.name) then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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
    set_macro_page(1, 5)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end