--Kaeleka's SAM Lua, Version 1.0, Revision 1, Updated: 2/27/23
--Revision Log (2/27/23): Various formatting cleanups, added STP and Subtle Blow sets.

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
-- Initialization function for this job file.

function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
    --include('Motes-TreasureHunter')
	include('Motes-Hasso')
    --state.TreasureMode:set('None')
    get_combat_form()
    --get_combat_weapon()
    update_melee_groups()
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.YoichiAM = M(false, 'Cancel Yoichi AM Mode')
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Tachi: Shoha'}

    gear.RAarrow = {name="Eminent Arrow"}
    LugraWSList = S{'Tachi: Fudo', 'Tachi: Shoha', 'Namas Arrow', 'Impulse Drive', 'Stardiver'}

    state.Buff.Sekkanoki = buffactive.sekkanoki or false
    state.Buff.Sengikori = buffactive.sengikori or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'Hybrid', 'SubtleBlow' )
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal', 'Sphere')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
    
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^[')
    send_command('unbind !=')
    send_command('unbind ![')
end

--[[
-- SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark
Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo
Shoha > Fudo > Kasha > Shoha > Fudo
--]]
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	sets.TreasureHunter = {
		ammo="Per. Lucky Egg",
        head="Volte Cap", 
        waist="Chaac Belt",
    }
    
	sets.precast.JA['Provoke'] = { 
        ammo="Per. Lucky Egg",
        head="Volte Cap", 
        waist="Chaac Belt",
    }
    
	--------------------------------------
    -- Precast Sets
    -- Precast sets to enhance JAs
	--------------------------------------
	
    sets.precast.JA.Meditate = {
        head="Wakido Kabuto +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }
	
    sets.precast.JA.Sekkanoki = {hands="Kasuga Kote +3" }
    sets.precast.JA.Seigan = {head="Kasuga Kabuto +3"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    --sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate"}
    --sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}
   
    sets.precast.FC = {
		body="Sacro Breastplate",
		hands="Leyline Gloves",
        left_ear="Etiolation Earring",
        right_ear="Loquacious Earring",
    }
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.Organizer = {
        grip="Pearlsack",
        waist="Linkpearl",
        head="Masamune",
        hands="Shining One",
        legs="Dojikiri Yasutsuna",
        feet="Fusenaikyo"
    }
    
	--sets.precast.RA = {
        --head="Volte Tiara",
        --hands="Buremte Gloves",
        --ring2="Crepuscular Ring",
        --feet="Ejekamal Boots",
        --legs="Volte Tights",
        --waist="Yemaya Belt",
    --}
    
	--sets.midcast.RA = {
        --head="Nyame Helm",
        --body="Kendatsuba Samue +1",
        --legs="Kendatsuba Hakama +1",
        --neck="Sanctity Necklace",
        --hands="Kendatsuba Tekko +1",
        --waist="Chaac Belt",
        --ear1="Telos Earring",
        --ear2="Crepuscular Earring",
        --ring1="Cacoethic Ring +1",
        --ring2="Crepuscular Ring",
        --feet="Kendatsuba Sune-ate +1",
    --}
	
    -- Don't need any special gear for Healing Waltz.
    --sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.CapacityMantle  = { back="Aptitude Mantle +1" }
    --sets.Berserker       = { neck="Berserker's Torque" }
    --sets.WSDayBonus      = { head="Gavialis Helm" }
    --sets.LugraMoonshade  = { ear1="Moonshade Earring", ear2="Lugra Earring +1" }
    --sets.BrutalMoonshade = { ear1="Moonshade Earring", ear2="Brutal Earring" }
    --sets.LugraFlame      = { ear1="Lugra Earring +1", ear2="Flame Pearl" }
    --sets.FlameFlame      = { ear1="Flame Pearl", ear2="Flame Pearl" }
      
	--------------------------------------
    -- Weaponskill sets
	--------------------------------------
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands="Kasuga Kote +3",
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','DEX+2','Accuracy+13','Attack+4',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }
	
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        --hands="Nyame Gauntlets"
        --head="Rao Kabuto",
    })
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        head="Flamma Zucchetto +2",
		feet="Flamma Gambieras +2",
		right_ring="Regal Ring",
    })
    
	--Bow Weaponskills (Why do you use these?)
    --sets.precast.WS['Namas Arrow'] = {
        --ammo=gear.RAarrow,
        --head="Mpaca's Cap",
        --neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
        --ear1="Thrud Earring",
        --ear2="Ishvara Earring",
        --body="Nyame Mail",
        --legs="Nyame Flanchard",
        --hands="Nyame Gauntlets",
        --back=Smertrios.WS,
        --ring1="Ilabrat Ring",
        --ring2="Regal Ring",
        --waist="Eschan Stone",
        -- legs="Hizamaru Hizayoroi +2",
        --feet=Valorous.Feet.WS
    --}
	
    --sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS['Namas Arrow'], {
        --body="Nyame Mail",
    --})
    
	--sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'].Mid, {
        --ring2="Crepuscular Ring"
    --})
    
    --sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS['Namas Arrow'], {
        --neck="Breeze Gorget",
        --body="Nyame Mail",
        --ring2="Regal Ring",
    --})
	
    --sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
    --sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
        --ring2="Crepuscular Ring"
    --})
    
	--Great Katana WS
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
        --head="Mpaca's Cap",
    })
	
    sets.precast.WS['Tachi: Fudo'].Mid = set_combine(sets.precast.WS['Tachi: Fudo'], {
        waist="Fotia Belt"
    })
	
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Mid, {
        head="Flam. Zucchetto +2",
        feet="Flamma Gambieras +2",
    })
	
	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",
		feet="Flamma Gambieras +2",
        neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    })
	
    sets.precast.WS['Tachi: Shoha'].Mid = set_combine(sets.precast.WS['Tachi: Shoha'], {
        waist="Fotia Belt",
    })
	
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'].Mid, {})
	
	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
        --head="Mpaca's Cap",
        neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
        waist="Fotia Belt",
    })
	
    sets.precast.WS['Tachi: Rana'].Mid = set_combine(sets.precast.WS['Tachi: Rana'], {
        body="Sakonji Domaru +3",
    })
	
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
        neck="Fotia Gorget",
        waist="Fotia Belt",
    })
    
    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flamma Manopolas +2",
		legs="Wakido Haidate +3",
        feet="Flamma Gambieras +2",
		waist="Fotia Belt",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},   
    })
    
    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {waist="Fotia Belt"})
    
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Windbuffet Belt +1"})
    
    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Windbuffet Belt +1"})
    
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        waist="Fotia Belt",  
    })
	
	-- Polearm WS
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        --head="Mpaca's Cap",
		feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','DEX+2','Accuracy+13','Attack+4',}},
        neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
        waist="Sailfi Belt +1",    
    })
	
    sets.precast.WS['Impulse Drive'].Mid = set_combine(sets.precast.WS['Impulse Drive'], {
        --head="Mpaca's Cap",
        hands="Kasuga Kote +3",
    })
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'].Mid, {
        feet="Flamma Gambieras +2",
    })
    
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS['Tachi: Shoha'], {
        --head="Mpaca's Cap",
        left_ear="Schere Earring",
        neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
        waist="Fotia Belt"
    })
	
    sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {})
    
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'].Mid, {})
    
	--------------------------------------
    -- Midcast Sets
	--------------------------------------
    --sets.midcast['Blue Magic'] = set_combine(sets.precast.WS['Tachi: Ageha'], {
        --waist="Eschan Stone",
		--left_ear="Crepuscular Earring",
        --left_ring="Crepuscular Ring",
        --right_ring="Weatherspoon Ring",
        --back="Aput Mantle",
    --})
    
    --sets.midcast.FastRecast = {
    	--head="Otomi Helm",
    	--legs="Wakido Haidate +1",
        --feet="Ejekamal Boots",
        --waist="Sailfi Belt +1"
    --}
	
	--------------------------------------
    -- Sets to return to when not performing an action.
    --------------------------------------
    -- Resting sets
    --sets.resting = {
        --ring2="Paguroidea Ring"
    --}
    
	-- Idle set, in-town
    sets.idle.Town = {
        ammo="Coiste Bodhar",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Kasuga Haidate +3",
		feet="Kas. Suna-Ate +3",
		neck="Sam. Nodowa +2",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }
	
	--Idle set, Adoulin
    sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
        body="Councilor's Garb",
    })
    
	--Idle set, in-field
    sets.idle.Field = set_combine(sets.idle.Town, {
        ammo="Staunch Tathlum +1",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Nyame Gauntlets",
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck="Sam. Nodowa +2",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Hearty Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
        body="Sacro Breastplate",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		left_ring="Chirich Ring +1",
    })

    sets.idle.Sphere = set_combine(sets.idle, {
		body="Makora Meikogai",
	})
    
    sets.idle.Weak = set_combine(sets.idle.Field, {
    })
    
    -- Defense sets
    sets.defense.PDT = {
		ammo="Coiste Bodhar",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		--hands="Tatena. Gote +1", augments={'Path: A',}}, 
		hands="Wakido Kote +3",
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.idle.PDT = set_combine(sets.idle, sets.defense.PDT)
    
    sets.defense.Reraise = set_combine(sets.defense.PDT, {
    	--head="Nyame Helm",
    	--body="Nyame Mail"
    })
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Coiste Bodhar",
		head={ name="Nyame Helm", augments={'path: A',}},
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })
    
    sets.Kiting = {feet="Danzo Sune-ate"}
    
    sets.Reraise = {
		head="Nyame Helm",
		body="Nyame Mail",
	}
    
    --------------------------------------
	-- Engaged sets
    --------------------------------------
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    sets.engaged = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +3",
		--hands="Tatena. Gote +1", augments={'Path: A',}}, 
		hands="Wakido Kote +3",
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		--back="Takaha Mantle",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

    sets.engaged.MidAcc = set_combine(sets.engaged, {
		head="Kasuga Kabuto +3",
		--hands="Tatena. Gote +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
    })
	
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		--ammo="Aurgelmir Orb +1",
		ammo="Aurgelmir Orb",
		feet="Wakido Sune. +3",
		left_ring="Regal Ring",
		--left_ear="Schere Earring", -- w/ max augments
		left_ear="Telos Earring",
    })
	
	sets.engaged.Hybrid = set_combine (sets.engaged, {
		ammo="Coiste Bodhar",
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		--hands="Tatena. Gote +1", augments={'Path: A',}}, 
		hands="Wakido Kote +3",
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})

	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		head="Ken. Jinpachi +1", --8
		body="Ken. Samue +1", --12
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --8
		left_ear="Schere Earring", --3
		left_ring="Niqmaddu Ring", --(5)
		right_ring="Chirich Ring +1", --10
	})
    
    sets.engaged.Amanomurakumo = set_combine(sets.engaged, {
    })
    sets.engaged.Amanomurakumo.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM3 = set_combine(sets.engaged, {
    })
    
    sets.buff.Sekkanoki = {hands="Kasuga Kote +3"}
    sets.buff.Sengikori = {feet="Kas. Suna-Ate +3"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
    
    sets.thirdeye = {head="Unkai Kabuto +2", legs="Sakonji Haidate"}
    --sets.seigan = {hands="Otronif Gloves +1"}
    sets.bow = {ammo=gear.RAarrow}
    
    -- sets.MadrigalBonus = {
    --     hands="Composer's Mitts"
    -- }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main =='Nativus Halberd' or player.equipment.main =='Quint Spear' then
			if spell.english:startswith("Tachi:") then
				send_command('@input /ws "Stardiver" '..spell.target.raw)
				eventArgs.cancel = true
			end
		end
	end
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    --if spell.english == 'Third Eye' and not buffactive.Seigan then
    --    cancel_spell()
    --    send_command('@wait 0.5;input /ja Seigan <me>')
    --    send_command('@wait 1;input /ja "Third Eye" <me>')
    --end
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
        --if state.CapacityMode.value then
            --equip(sets.CapacityMantle)
        --end
        --if is_sc_element_today(spell) then
            --if wsList:contains(spell.english) then
                --equip(sets.WSDayBonus)
            --end
        --end
		
        -- if LugraWSList:contains(spell.english) then
        --     if world.time >= (17*60) or world.time <= (7*60) then
        --         if spell.english:lower() == 'namas arrow' then
        --             equip(sets.LugraFlame)
        --         else
        --             equip(sets.LugraMoonshade)
        --         end
        --     else
        --         if spell.english:lower() == 'namas arrow' then
        --             equip(sets.FlameFlame)
        --         else
        --             equip(sets.BrutalMoonshade)
        --         end
        --     end
        -- end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end
	end
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
    update_am_type(spell)
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Effectively lock these items in place.
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 76 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    --if state.TreasureMode.value == 'Fulltime' then
       -- meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    --end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
    	    meleeSet = set_combine(meleeSet, sets.thirdeye)
        else
            meleeSet = set_combine(meleeSet, sets.seigan)
        end
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if player.equipment.range == 'Yoichinoyumi' then
        meleeSet = set_combine(meleeSet, sets.bow)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        if player.inventory['Eminent Arrow'] then
            gear.RAarrow.name = 'Eminent Arrow'
        elseif player.inventory['Tulfaire Arrow'] then
            gear.RAarrow.name = 'Tulfaire Arrow'
        elseif player.equipment.ammo == 'empty' then
            add_to_chat(122, 'No more Arrows!')
        end
    elseif newStatus == 'Idle' then
        determine_idle_group()
    end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end

    -- if S{'madrigal'}:contains(buff:lower()) then
    --     if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
    --         equip(sets.MadrigalBonus)
    --     end
    -- end
    if S{'aftermath'}:contains(buff:lower()) then
        classes.CustomMeleeGroups:clear()
       
        if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
            classes.CustomMeleeGroups:clear()
        elseif player.equipment.main == 'Kogarasumaru'  then
            if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
            end
        elseif buff == "Aftermath" and gain or buffactive.Aftermath then
            classes.CustomMeleeGroups:append('AM')
        end
    end
    
    if not midaction() then
        handle_equipping_gear(player.status)
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	get_combat_form()
    update_melee_groups()
    --get_combat_weapon()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

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
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--function get_combat_weapon()
--    if player.equipment.range == 'Yoichinoyumi' then
--        if player.equipment.main == 'Amanomurakumo' then
--            state.CombatWeapon:set('AmanoYoichi')
--        else
--            state.CombatWeapon:set('Yoichi')
--        end
--    else
--        state.CombatWeapon:set(player.equipment.main)
--    end
--end
-- Handle zone specific rules
-- windower.register_event('Zone change', function(new,old)
--     determine_idle_group()
-- end)

function determine_idle_group()
    classes.CustomIdleGroups:clear()
    -- if areas.Adoulin:contains(world.area) then
    -- 	classes.CustomIdleGroups:append('Adoulin')
    -- end
end

function get_combat_form()
    -- if areas.Adoulin:contains(world.area) and buffactive.ionis then
    -- 	state.CombatForm:set('Adoulin')
    -- else
    --     state.CombatForm:reset()
    -- end
end

function seigan_thirdeye_active()
    return state.Buff['Seigan'] or state.Buff['Third Eye']
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

    if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
        -- prevents using Amano AM while overriding it with Yoichi AM
        classes.CustomMeleeGroups:clear()
    elseif player.equipment.main == 'Kogarasumaru' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
    end
end
-- call this in job_post_precast() 
function update_am_type(spell)
    if spell.type == 'WeaponSkill' and spell.skill == 'Archery' and spell.english == 'Namas Arrow' then
        if player.equipment.main == 'Amanomurakumo' then
            -- Yoichi AM overwrites Amano AM
            state.YoichiAM:set(true)
        end
    else
        state.YoichiAM:set(false)
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 3)
    elseif player.sub_job == 'DNC' then
    	set_macro_page(2, 3)
    else
    	set_macro_page(3, 3)
    end
end
