--[[ 
 === Notes ===
 -- Set format is as follows:
	-- sets.midcast.RA.[CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
	-- You can create named sets based off any weapon in the rng_rema list below
	-- you can also append CustomRangedGroups to each other
 
 -- These are the available sets per category
 -- CombatForm = DW
 -- RangedMode = Normal, Mid, Acc
 === Helpful Commands ===
    //gs validate
    //gs showswaps
    //gs debugmode
--]]
 
function get_sets()
        mote_include_version = 2
        -- Load and initialize the include file.
        include('Mote-Include.lua')
        include('organizer-lib')
end

-- setup vars that are user-independent.
function job_setup()
        state.Buff.Barrage = buffactive.Barrage or false
        state.Buff.Camouflage = buffactive.Camouflage or false
        state.Buff.Overkill = buffactive.Overkill or false
        state.Buff['Double Shot'] = buffactive['Double Shot'] or false

        state.FlurryMode = M{['description']='Flurry Mode', 'Normal', 'Hi'}
        state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
        -- settings
        state.CapacityMode = M(false, 'Capacity Point Mantle')

        gear.Gun = "Annihilator"
        gear.Bow = "Yoichinoyumi"
        gear.Xbow = "Gastraphetes"
        
        rng_rema = S{'Annihilator', 'Armageddon', 'Fomalhaut', 'Gastraphetes', 'Yoichinoyumi', 'Gandiva', 'Fail-Not'}       

        rng_sub_weapons = S{'Malevolence', 'Tauret', 'Perun +1', 
            'Perun', 'Odium', 'Atoyac', 'Kaja Sword', 'Naegling'}
        
        -- sam_sj = player.sub_job == 'SAM' or false
        -- used for ammo swaps
        -- rng_xbows = S{'Gastraphetes', 'Illapa'}
        rng_guns = S{'Annihilator', 'Armageddon', 'Fomalhaut'}
        -- rng_bows = S{'Yoichinoyumi', 'Gandiva', 'Fail-Not'}
        state.GunSelector = M{['description']='Gun Selector', 'Annihilator', 'Gastraphetes', 'Armageddon', 'Fomalhaut', 'Anarchy'}
        state.GastraAmmo = M{['description']='Xbow Ammo', "Quelling Bolt", "Abrasion Bolt"}
        state.GunAmmo = M{['description']='Gun Ammo', "Chrono Bullet", "Eradicating Bullet"}
        state.AmmoToggle = M{['description']='Ammo Toggle', "Primary", "Secondary"}
        state.FightingMode = M{['description']='Fighting Mode', 'Default', 'Melee', 'Sword', 'DualSword'}
        --state.ShootingMode = M{['description']='Shooting Mode', 'Default', 'Standard', 'Magic', 'Single'}
        -- state.Ammo = M{['description']='Gastraphetes', "Bloody Bolt", "Achiyalabopa Bolt"}
        state.ShootingMode = M{['description']='Shooting Mode', 'Default', 'Standard', 'Magic', 'Single', 'SingleMagic'}
        
        -- W.I.P ~
        DefaultAmmo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = state.GunAmmo.current, [gear.Xbow] = state.GastraAmmo.current}
        -- U_Shot_Ammo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Eradicating Bullet"} 

        update_combat_form()
        determine_haste_group()
        get_combat_weapon()
        initialize_weapons()
        get_custom_ranged_groups()
end
 
function user_setup()
        -- Options: Override default values
        state.OffenseMode:options('Normal', 'Mid', 'Acc')
        state.RangedMode:options('Normal', 'Mid', 'Acc')
        state.HybridMode:options('Normal', 'PDT')
        state.IdleMode:options('Normal', 'PDT')
        state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
        state.PhysicalDefenseMode:options('PDT')
        state.MagicalDefenseMode:options('MDT')
    
 
        select_default_macro_book()

        send_command('bind != gs c toggle CapacityMode')
        send_command('bind !f9 gs c cycle RangedMode')
        -- send_command('bind !f9 gs c toggle FightingMode')
        send_command('bind f9 gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle HybridMode')
        send_command('bind @f9 gs c cycle HasteMode')
        send_command('bind @= gs c cycle FlurryMode')
        -- send_command('bind ^] gs c cycle WeaponskillMode')
        -- send_command('bind !- gs equip sets.crafting')
        send_command('bind ^[ input /lockstyle on')
        send_command('bind ![ input /lockstyle off')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind ^-')
end
 
function init_gear_sets()
    --sets.Organizer = {
        --ear2="Reraise Earring",
        --back="Linkpearl",
        --main="Annihilator",
        --head="Gastraphetes",
        --neck="Nusku Shield",
        --body="Armageddon",
        --hands="Naegling", 
        --legs="Fomalhaut",
        --feet="Malevolence",
        --ring1="Perun +1",
        --ring2="Perun"
    --}

	------------------------------------------------
    -- Job Ability precasts
	------------------------------------------------
    --sets.precast.JA['Bounty Shot'] = {
		--hands="Amini Glovelettes +1",
		--waist="Chaac Belt", legs=HercLegs.TH
	--}
	
    --sets.precast.JA['Double Shot'] = {head="Amini Gapette"}
    
	--sets.precast.JA['Camouflage'] = {body="Orion Jerkin +3"}
    
	--sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
    
	--sets.precast.JA['Velocity Shot'] = {
		--body="Amini Caban +1",
		--back=Belenus.Snap
	--}
    
	--sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
    
	--sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}

    --sets.CapacityMantle = {back="Apptitude Mantle +1"}

    sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA, {
		head="Meghanada Visor +2",
		body="Nisroch Jerkin",
		hands="Malignance Gloves",
		legs={ name="Arc. Braccae +1", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
    })

    sets.precast.FC = {
		head={ name="Herculean Helm", augments={'Accuracy+17','Weapon skill damage +3%','STR+5',}}, --7% FC
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --7% FC
		neck="Baetyl Pendant", --4% FC
		left_ear="Etiolation Earring", --1% FC
		right_ear="Loquac. Earring", --2% FC
    }
	
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })
    
    sets.idle = { --55/43
		head={ name="Nyame Helm", augments={'Path: B',}}, --7/7
		body="Nyame Mail", --9/9
		hands="Nyame Gauntlets", --7/7
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets", --7/7
		neck="Loricate Torque", --5/5
		waist="Flume Belt +1", --4/0
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Gelatinous Ring", --6/-2
		right_ring="Defending Ring", --10/10
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
    sets.idle.Regen = set_combine(sets.idle, {
        head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		feet="Meg. Jam. +2",
		neck="Sanctity Necklace",
		left_ear="Dawn Earring",
		right_ear="Hearty Earring",
		left_ring="Chirich Ring +1",
    })
	
    sets.idle.Town = set_combine(sets.idle, {
		head={ name="Arcadian Beret +1", augments={'Enhances "Recycle" effect',}},
		body="Nisroch Jerkin",
		hands={ name="Arc. Bracers +1", augments={'Enhances "Flashy Shot" effect',}},
		legs="Carmine Cuisses +1",
		feet={ name="Arcadian Socks +1", augments={'Enhances "Stealth Shot" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })
	
	------------------------------------------------
	--Melee TP Sets
	------------------------------------------------
    sets.engaged.Melee = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Anu Torque",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Eabani Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}},
    }

    sets.engaged.Melee.MidAcc = set_combine(sets.engaged.Melee, {
        --neck="Lissome Necklace",
        body="Tatenashi Haramaki +1",
        feet="Tatenashi Sune-ate +1",
		right_ring="Ilabrat Ring",
    })

	sets.engaged.Melee.HighAcc = set_combine(sets.engaged.Melee.MidAcc, {
		--hands="Tatena. Gote +1",
		hands="Malignance Gloves",
		legs="Tatena. Haidate +1",
	})	

	sets.engaged.Melee.Hybrid = set_combine(sets.engaged.Melee, { --41% PDT/MDT
		--head="Malignance Chapeau",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		right_ring="Defending Ring",
		-- Need to add PDT -10% to melee cape
		back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}},
    })


    ------------------------------------------------------------------
    -- Preshot / Snapshot sets 
    -- 50 snap in gear will cap
    -- Pieces that provide delay reduction via velocity shot, do NOT
    -- count towards cap.
    ------------------------------------------------------------------
    sets.precast.RA = { --Rapid Shot 16/Snapshot 41
        head={ name="Ikenga's Hat", augments={'Path: A',}}, --0/6
		body="Ikenga's Vest", --0/9
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, --11/8
		legs={ name="Ikenga's Trousers", augments={'Path: A',}}, --0/8
		feet="Meg. Jam. +2", --0/10
		--neck="Scout's Neck +2",
		neck="Sanctity Necklace",
		waist="Yemaya Belt", --5/0
		left_ear="Sherida Earring",
		right_ear="Eabani Earring",
		left_ring="Epona's Ring",
		right_ring="Defending Ring",
		--Replace with Snapshot Cape
		back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}},
    }
    
	--sets.precast.RA.F1 = set_combine(sets.precast.RA, {
        --head="Orion Beret +3",
        --legs=AdhemarLegs.Snap, -- 9
        --waist="Yemaya Belt"
    --})
	
    --sets.precast.RA.F2 = set_combine(sets.precast.RA.F1, {
        -- waist="Yemaya Belt",
        --feet="Arcadian Socks +3"
    --})
	
    --sets.precast.RA.Gastraphetes = set_combine(sets.precast.RA, {
        --head="Orion Beret +3",
        --legs="Orion Braccae +3",
    --})
	
    --sets.precast.RA.Gastraphetes.F1 = set_combine(sets.precast.RA, {
        --feet="Arcadian Socks +3",
        --legs=AdhemarLegs.Snap, -- 9
    --})
	
    --sets.precast.RA.Gastraphetes.F2 = sets.precast.RA.Gastraphetes.F1
    
    ------------------------------------------------------------------
    -- Default Base Gear Sets for Ranged Attacks. Geared for Gastraphetes
    ------------------------------------------------------------------
    sets.midcast.RA = { 
		--head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
        head={ name="Arcadian Beret +1", augments={'Enhances "Recycle" effect',}},
		body="Nisroch Jerkin",
		hands="Malignance Gloves",
		legs={ name="Ikenga's Trousers", augments={'Path: A',}},
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
    }
	
    --sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA, {
        --ear1="Crepuscular Earring",
        --body="Malignance Tabard",
        --waist="Kwahu Kachina Belt", 
        --legs="Malignance Tights", 
    --})
	
    --sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Mid, {
        --head="Malignance Chapeau",
        --ear1="Beyla Earring",
        --ring1="Cacoethic Ring +1",
        --body="Orion Jerkin +3", 
        --ring1="Regal Ring",
        --legs="Malignance Tights", 
        --feet="Malignance Boots"
    --})
    
    -- Double Shot 
    sets.midcast.RA.DoubleShot = set_combine(sets.midcast.RA, {
		body="Arcadian Jerkin +1",
        --hands="Oshosi Gloves",
        --legs="Oshosi Trousers",
        --feet="Oshosi Leggings"
    })
	
    sets.midcast.RA.DoubleShot.MidAcc = set_combine(sets.midcast.RA.MidAcc, {
		body="Arcadian Jerkin +1", 
        hands="Malignance Gloves",
        --legs="Oshosi Trousers",
        --feet="Oshosi Leggings"
    })
	
    sets.midcast.RA.DoubleShot.HighAcc = set_combine(sets.midcast.RA.HighAcc, {
        hands="Malignance Gloves",
        legs="Malignance Tights", 
        body="Malignance Tabard",
        --feet="Oshosi Leggings"
    })

    -- Annihilator
    -- TODO: get crit+10% cape
    --sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA, {
        -- head="Meghanada Visor +2",
        --body="Nisroch Jerkin",
        --ring2="Regal Ring",
    --})
	
    --sets.midcast.RA.Annihilator.Mid = set_combine(sets.midcast.RA.Mid, {
        --body="Nisroch Jerkin",
    --})
	
    --sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc, {
        --ammo="Eradicating Bullet"
    --})
	
    --sets.midcast.RA.DoubleShot.Annihilator = sets.midcast.RA.DoubleShot
    --sets.midcast.RA.DoubleShot.Annihilator.Mid = sets.midcast.RA.DoubleShot.Mid
    --sets.midcast.RA.DoubleShot.Annihilator.Acc = sets.midcast.RA.DoubleShot.Acc

    --sets.midcast.RA.Armageddon = set_combine(sets.midcast.RA, {
        --body="Nisroch Jerkin",
    --})
	
    --sets.midcast.RA.Armageddon.AME = set_combine(sets.midcast.RA.Armageddon, {
        --head="Meghanada Visor +2",
        --body="Nisroch Jerkin",
        --hands="Mummu Wrists +2",
        --waist="Kwahu Kachina Belt", 
    --})
	
    --sets.midcast.RA.Armageddon.Mid = set_combine(sets.midcast.RA.Mid, {
        --head="Meghanada Visor +2",
        --body="Nisroch Jerkin",
        --waist="Kwahu Kachina Belt", 
    --})
	
    --sets.midcast.RA.Armageddon.Mid.AME = set_combine(sets.midcast.RA.Armageddon.Mid, {
        --head="Meghanada Visor +2",
        --body="Nisroch Jerkin",
        --hands="Mummu Wrists +2",
        --waist="Kwahu Kachina Belt", 
    --})
	
    --sets.midcast.RA.Armageddon.Acc = set_combine(sets.midcast.RA.Acc, {
        --ammo="Eradicating Bullet"
    --})
	
    --sets.midcast.RA.Armageddon.Acc.AME = set_combine(sets.midcast.RA.Armageddon.Acc, {
        --head="Meghanada Visor +2",
        --body="Nisroch Jerkin",
        --hands="Mummu Wrists +2"
    --})
	
    --sets.midcast.RA.DoubleShot.Armageddon = sets.midcast.RA.DoubleShot
    --sets.midcast.RA.DoubleShot.Armageddon.Mid = sets.midcast.RA.DoubleShot.Mid
    --sets.midcast.RA.DoubleShot.Armageddon.Acc = sets.midcast.RA.DoubleShot.Acc

	-- Yoichinoyumi
    --sets.midcast.RA.Yoichinoyumi = {
        --head="Malignance Chapeau",
        --neck="Scout's Gorget +2",
        --ear1="Dedition Earring",
        --ear2="Telos Earring",
        --body="Nisroch Jerkin",
        --hands="Malignance Gloves",
        --ring1="Crepuscular Ring",
        --ring2="Ilabrat Ring",
        --back=Belenus.STP,
        --waist="Kwahu Kachina Belt",
        --legs="Malignance Tights", 
        --feet="Malignance Boots"
    --}
	
    --sets.midcast.RA.Yoichinoyumi.Mid = set_combine(sets.midcast.RA.Yoichinoyumi, {
        --ear1="Crepuscular Earring",
        --hands="Malignance Gloves",
        --body="Malignance Tabard", 
        --legs="Malignance Tights", 
    --})
	
    --sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi.Mid, {
        --ear1="Beyla Earring",
        --hands="Malignance Gloves",
        --body="Orion Jerkin +3",
        --ring1="Regal Ring",
    --})
    
	------------------------------------------------------------------
    -- Weaponskill sets  
	------------------------------------------------------------------
    sets.precast.WS = {
        head={ name="Nyame Helm", augments={'Path: B',}},
		body="Nyame Mail",
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
    --sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
        --body="Arcadian Jerkin +3",
    --})
	
    --sets.precast.WS.HighAcc = set_combine(sets.precast.WS.MidAcc, {
        --body="Orion Jerkin +3",
        --legs=AdhemarLegs.TP,
    --})
	
	------------------------------------------------------------------
	--Melee Weaponskills
	------------------------------------------------------------------
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Nyame Mail",
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		--head="",
		--body="Cohort Cloak +1",
        hands={ name="Carmine Fin. Ga. +1", augments={'Path: D',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		right_ear="Friomisi Earring",
		left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
    })
	
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Meg. Cuirie +2",
		hands="Mummu Wrists +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','MND+8',}},
		feet="Mummu Gamash. +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Mache Earring",
		left_ring="Mummu Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })
	
	------------------------------------------------------------------
	--Ranged Weaponskills
	------------------------------------------------------------------
    -- Wildfire
    sets.precast.WS['Wildfire'] = {
		--head="",
		head={ name="Nyame Helm", augments={'Path: B',}},
		--body="Cohort Cloak +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
    --sets.precast.WS['Wildfire'].MidAcc = set_combine(sets.precast.WS['Wildfire'], {
        --body="Nyame Mail",
        --hands="Nyame Gauntlets",
        --legs="Nyame Flanchard"
    --})
	
    --sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'].Mid, {
        --body="Nyame Mail",
        --hands="Nyame Gauntlets",
    --})
	
    -- every other weapon uses standard ammo set via toggle
    --sets.precast.WS['Wildfire'].Gun = set_combine(sets.precast.WS['Wildfire'], { ammo="Devastating Bullet"})
    --sets.precast.WS['Wildfire'].Mid.Gun = set_combine(sets.precast.WS['Wildfire'].Mid, { ammo="Devastating Bullet"})
    --sets.precast.WS['Wildfire'].Acc.Gun = set_combine(sets.precast.WS['Wildfire'].Acc, { ammo="Devastating Bullet"})
    
    --sets.precast.WS['Trueflight'] = {
        --head="",
        --body="Cohort Cloak +1",
        --ear1="Friomisi Earring",
        --ear2="Moonshade Earring",
        --neck="Scout's Gorget +2",
        --hands="Carmine Fin. Ga. +1",
        --ring1="Weatherspoon Ring",
        --ring2="Dingir Ring",
        --back=Belenus.MAB,
        --waist="Sveltesse Gouriz +1",
        --legs=HercLegs.MAB,
        --legs="Arcadian Braccae +3", 
        --legs="Arcadian Braccae +3", 
        --eet=HercFeet.MAB
    --}
	
    --sets.precast.WS['Trueflight'].MidAcc = set_combine(sets.precast.WS['Trueflight'], {
        --legs="Arcadian Braccae +3", 
        --hands="Nyame Gauntlets",
        --hands="Carmine Finger Gauntlets +1",
        --legs="Arcadian Braccae +3", 
    --})
	
    --sets.precast.WS['Trueflight'].HighAcc = set_combine(sets.precast.WS['Trueflight'].MidAcc, {
        -- body="Nyame Mail",
        --hands="Nyame Gauntlets",
        --legs="Arcadian Braccae +3", 
    --})
    
	--sets.precast.WS['Trueflight'].Gun = set_combine(sets.precast.WS['Trueflight'], {ammo="Devastating Bullet"})
    --sets.precast.WS['Trueflight'].Mid.Gun = set_combine(sets.precast.WS['Trueflight'].Mid, {ammo="Devastating Bullet"})
    --sets.precast.WS['Trueflight'].Acc.Gun = set_combine(sets.precast.WS['Trueflight'].Acc, {ammo="Devastating Bullet"})

    -- Coronach
    --sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, {
        --neck="Scout's Gorget +2",
        --ear1="Sherida Earring",
        --ear2="Ishvara Earring",
        --body=HercBody.WSD,
        --waist="Thunder Belt",
        --ring1="Regal Ring",
        --ring2="Dingir Ring",
        --back=Belenus.WSD,
        --legs="Arcadian Braccae +3", 
    --})
	
    --sets.precast.WS['Coronach'].Mid = set_combine(sets.precast.WS['Coronach'], {
    --})
	
    --sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS['Coronach'].Mid, {
        --body="Orion Jerkin +3", 
        --legs="Arcadian Braccae +3", 
    --})

    -- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
        head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','MND+8',}},
		feet="Meg. Jam. +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })
	
    --sets.precast.WS['Last Stand'].Mid = set_combine(sets.precast.WS['Last Stand'], {
        --body="Arcadian Jerkin +3",
    --})
    
	--sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'].Mid, {
        --legs="Arcadian Braccae +3", 
        --feet="Meghanada Jambeaux +2"
    --})

    -- Detonator
    sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, {
        head="Meghanada Visor +2",
		body="Nisroch Jerkin",
		hands="Meg. Gloves +2",
		legs="Malignance Tights",
		feet="Meg. Jam. +2",
		neck="Fotia Gorget",
		waist="Svelt. Gouriz +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })
	
    sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, sets.Detonator)
    sets.precast.WS['Detonator'].Mid = set_combine(sets.precast.WS.Mid, sets.Detonator)
    sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS.Acc, sets.Detonator)
    
    -- SLUG SHOT
    --sets.SlugShot = {
        --neck="Breeze Gorget",
        --ear2="Moonshade Earring",
        --waist="Light Belt",
    --}
	
    --sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
    --sets.precast.WS['Slug Shot'].Mid = set_combine(sets.precast.WS.Mid, sets.SlugShot)
    --sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)
    
    --sets.precast.WS['Heavy Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
    --sets.precast.WS['Heavy Shot'].Mid = set_combine(sets.precast.WS.Mid, sets.SlugShot)
    --sets.precast.WS['Heavy Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)

    -- NAMAS
    --sets.Namas = {
        --neck="Aqua Gorget",
        --waist="Light Belt",
        --back=Belenus.WSD,
    --}
    
	--sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, sets.Namas)
    --sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS.Mid, sets.Namas)
    --sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.Namas)
    
    -- JISHNUS
    --sets.Jishnus = {
        --neck="Flame Gorget",
        --ear2="Moonshade Earring",
        --waist="Light Belt",
        --body="Nisroch Jerkin",
        --back=Belenus.WSD,
        --ring1="Regal Ring",
        --ring2="Ilabrat Ring",
        --legs="Arcadian Braccae +3", 
    --}
	
    --sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, sets.Jishnus)
    --sets.precast.WS['Jishnu\'s Radiance'].Mid = set_combine(sets.precast.WS.Mid, {
        --neck="Flame Gorget",
        --ear2="Moonshade Earring",
        --waist="Light Belt",
        --legs="Arcadian Braccae +3", 
        --feet="Mummu Gamashes +2"
    --})
    
	--sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS.Acc, {
        --neck="Flame Gorget",
        --ear2="Moonshade Earring",
        --waist="Light Belt"
    --})
    
	-- just a test (it works)
    -- sets.precast.WS['Jishnu\'s Radiance'].Yoichinoyumi = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
    --     neck="Iskur Gorget"
    -- })

    -- SIDEWINDER
    --sets.Sidewinder = {
        --neck="Aqua Gorget",
        --ear2="Moonshade Earring",
        --waist="Light Belt",
    --}
    
	--sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, sets.Sidewinder)
    --sets.precast.WS['Sidewinder'].Mid = set_combine(sets.precast.WS.Mid, sets.Sidewinder)
    --sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS.Acc, sets.Sidewinder)

    --sets.precast.WS['Refulgent Arrow'] = sets.precast.WS['Sidewinder']
    --sets.precast.WS['Refulgent Arrow'].Mid = sets.precast.WS['Sidewinder'].Mid
    --sets.precast.WS['Refulgent Arrow'].Acc = sets.precast.WS['Sidewinder'].Acc

	------------------------------------------------------------------
	--Defensive & Misc Sets
    ------------------------------------------------------------------
    -- Resting sets
    sets.resting = {}
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {})
    sets.defense.MDT = set_combine(sets.idle, {})
    
	sets.Kiting = {legs="Carmine Cuisses +1"}
    
    --sets.buff.Barrage = {
        --head="Arcadian Beret +3",
        --neck="Scout's Gorget +2",
        --ear1="Crepuscular Earring",
        --ear2="Telos Earring",
        --body="Orion Jerkin +3",
        --hands="Orion Bracers +2",
        --ring1="Regal Ring",
        --ring2="Ilabrat Ring",
        --back=Belenus.STP,
        --waist="Kwahu Kachina Belt",
        --legs="Malignance Tights",
        --feet="Malignance Boots"
    --}
	
    --sets.buff.Camouflage =  {body="Orion Jerkin +3"}

    -- sets.Overkill =  {
    --     body="Arcadian Jerkin +3"
    -- }
    -- sets.Overkill.Preshot = set_combine(sets.precast.RA, sets.Overkill)

end

function get_rng_gearset()
    local set = {}
    if state.FightingMode.current ~= 'Default' then 
        ---------------------------------------
       setmod = sets[state.FightingMode.current]
       set = set_combine(setmod, sets[state.GunSelector.current])
        ---------------------------------------
    end
    if state.ShootingMode.current ~= 'Default' then 
        ---------------------------------------
       setmod = sets[state.ShootingMode.current]
       set = set_combine(setmod, sets[state.GunSelector.current])
        ---------------------------------------
    end
    return set
end

function job_pretarget(spell, action, spellMap, eventArgs)
    -- if state.Buff[spell.english] ~= nil then
    --     state.Buff[spell.english] = true
    -- end
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' then
        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
    end
    -- Safety checks for weaponskills 
    if spell.type:lower() == 'weaponskill' then
        if player.tp < 1000 then
            eventArgs.cancel = true
            return
        end
        if spell.target.distance > 22 then
            add_to_chat(122,"Outside WS Range! /Canceling")
            eventArgs.cancel = true
            return
        elseif state.DefenseMode.value ~= 'None' then
            -- Don't gearswap for weaponskills when Defense is on.
            eventArgs.handled = true
        end
    end
    local gearset = get_rng_gearset()
    equip(gearset)
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
-- This is where you place gear swaps you want in precast but applied on top of the precast sets
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    -- elseif state.Buff.Overkill then
    --     equip(sets.Overkill.Preshot)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Trueflight' then
            if world.weather_element == 'Light' or world.day_element == 'Light' then
                equip(sets.Obi)
            end
        end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if spell.action_type == 'Ranged Attack' and state.CapacityMode.value then
        equip(sets.CapacityMantle)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if buffactive["Barrage"] then
        equip(sets.buff.Barrage)
    end
end

 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.name] ~= nil then
        state.Buff[spell.name] = not spell.interrupted or buffactive[spell.english]
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then

    if buff == 'Double Shot' and gain then
        windower.send_command('wait 90;input /echo **DOUBLE SHOT OFF**;wait 90;input /echo **DOUBLE SHOT READY**')
    elseif buff == 'Decoy Shot' and gain then
        windower.send_command('wait 170;input /echo **DECOY SHOT** Wearing off in 10 Sec.];wait 120;input /echo **DECOY SHOT READY**')
    end

    -- DoubleShot CombatForm
    if (buff == 'Double Shot' and gain or buffactive['Double Shot']) then
        state.CombatForm:set('DoubleShot')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        if state.CombatForm.current ~= 'Melee' and state.CombatForm.current ~= 'DualSword' then
            state.CombatForm:reset()
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

    if buff:startswith('Aftermath') then
        if player.equipment.range == 'Armageddon' then
            classes.CustomRangedGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Empy AM3 UP-------------')
            -- elseif (buff == "Aftermath: Lv.3" and not gain) then
            --     add_to_chat(8, '-------------Mythic AM3 DOWN-------------')
            end
            if (buff == "Aftermath: Lv.2" and gain) or buffactive['Aftermath: Lv.2'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Empy AM2 UP-------------')
            -- elseif (buff == "Aftermath: Lv.3" and not gain) then
            --     add_to_chat(8, '-------------Mythic AM3 DOWN-------------')
            end
            if (buff == "Aftermath: Lv.1" and gain) or buffactive['Aftermath: Lv.1'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Empy AM1 UP-------------')
            -- elseif (buff == "Aftermath: Lv.3" and not gain) then
            --     add_to_chat(8, '-------------Mythic AM3 DOWN-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomRangedGroups:clear()

            if buff == "Aftermath" and gain or buffactive.Aftermath then
                classes.CustomRangedGroups:append('AM')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
    -- if buff == "Camouflage" or buff == "Overkill" or buff == "Samurai Roll" or buff == "Courser's Roll" then
    --     if not midaction() then
    --         handle_equipping_gear(player.status)
    --     end
    -- end

    if (( string.find(buff:lower(), 'flurry') and gain ) or buff:startswith('Aftermath')) then
        get_custom_ranged_groups()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    --select_earring()
end
 
function customize_idle_set(idleSet)
    if state.HybridMode.value == 'PDT' then
        state.IdleMode.value = 'PDT'
    elseif state.HybridMode.value ~= 'PDT' then
        state.IdleMode.value = 'Normal'
    end
    if state.Buff.Camouflage then
        idleSet = set_combine(idleSet, sets.buff.Camouflage)
    end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    local gearset = get_rng_gearset()
    return set_combine(idleSet, gearset)
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Camouflage then
        meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        meleeSet = set_combine(meleeSet, sets.Overkill)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    local gearset = get_rng_gearset()
    return set_combine(meleeSet, gearset)
end
 
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
        get_combat_weapon()
    end
    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
-- function job_self_command(cmdParams, eventArgs)
-- end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    get_combat_weapon()
    get_custom_ranged_groups()
    -- sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    add_to_chat(122, 'Ranged: '..state.RangedMode.value..'/'..state.HybridMode.value..', WS: '..state.WeaponskillMode.value)
    
    eventArgs.handled = true
 
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if player.equipment.range == 'Armageddon' or player.equipment.range == 'Annihilator' or player.equipment.range == 'Fomalhaut' then
        return 'Gun'
    end
end

function initialize_weapons()
    if player.equipment.range == 'Gastraphetes' then
        state.GunSelector:set('Gastraphetes')
    elseif player.equipment.range == 'Fomalhaut' then
        state.GunSelector:set('Fomalhaut')
    elseif player.equipment.range == 'Annihilator' then
        state.GunSelector:set('Annihilator')
    elseif player.equipment.range == 'Armageddon' then
        state.GunSelector:set('Armageddon')
    end
    -- SJ
    --if player.sub_job ~= 'DNC' and player.sub_job ~= 'NIN' then
    --    if state.FightingMode.current == 'Sword' then 
    --        state.FightingMode:set('Sword')
    --    else 
    --        state.ShootingMode:set('Single')
    --    end
    --end
end
function get_combat_weapon()
    state.CombatWeapon:reset()
    if rng_rema:contains(player.equipment.range) then
        state.CombatWeapon:set(player.equipment.range)
    end
end

function get_custom_ranged_groups()
    
    classes.CustomRangedGroups:clear()
    -- Flurry I = 265, Flurry II = 581
    if buffactive['Flurry'] then
        if state.FlurryMode.value == 'Hi' then
            classes.CustomRangedGroups:append('F2')
        else
            classes.CustomRangedGroups:append('F1')
        end

    end
    
    if player.equipment.range == 'Armageddon' then
        if buffactive['Aftermath: Lv.3'] or buffactive['Aftermath: Lv.1'] or buffactive['Aftermath Lv.2'] then
            classes.CustomRangedGroups:append('AME')
        end
    else
    -- relic aftermath is just "Aftermath", while empy + mythic are numbered
        if buffactive.Aftermath then
            classes.CustomRangedGroups:append('AM')
        elseif buffactive['Aftermath: Lv.1'] then
            classes.CustomRangedGroups:append('AM1')
        elseif buffactive['Aftermath: Lv.2'] then
            classes.CustomRangedGroups:append('AM2')
        elseif buffactive['Aftermath: Lv.3'] then
            classes.CustomRangedGroups:append('AM2')
        end
    end
end

function update_combat_form()
    state.CombatForm:reset()
    if buffactive['Double Shot'] then
        state.CombatForm:set('DoubleShot')
    end
    if state.FightingMode.current == 'Melee' or state.FightingMode.current == 'DualSword' then 
        state.CombatForm:set('Melee')
    elseif state.FightingMode.current == 'Sword' then 
        state.CombatForm:set('Sword')
    end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
                ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
                ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
            ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
            ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
            ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
            ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            ( buffactive[580] ) or  -- geo haste
            ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

function job_state_change(stateField, newValue, oldValue)
    -- W.I.P ~
     --if stateField == 'Ammo Toggle' then
     --    if player.equipment.range == 'Gastraphetes' then
     --    --if rng_xbows:contains(player.equipment.range) then
     --        send_command('@input /console gs c cycle GastraAmmo')
     --    elseif rng_guns:contains(player.equipment.range) then
     --        send_command('@input /console gs c cycle GunAmmo')
     --    end
     --end
    if stateField == 'Xbow Ammo' then 
        -- if rng_xbows:contains(player.equipment.range) then
        -- if state.GunSelector.current == 'Gastraphetes' then
        equip({ammo=newValue})
        -- end
    elseif stateField == 'Gun Ammo' then 
        -- if state.GunSelector.current ~= 'Gastraphetes' then
        equip({ammo=newValue})
        -- end
    elseif stateField == 'Shooting Mode' then
        state.FightingMode:set('Default')
    elseif stateField == 'Fighting Mode' then
        state.ShootingMode:set('Default')
    --elseif stateField == 'Gun Selector' then
        --equip({range=state.GunSelector.current})
    end
end


function camo_active()
    return state.Buff['Camouflage']
end
-- Orestes uses Samurai Roll. The total comes to 5!
--function detect_cor_rolls(old,new,color,newcolor)
--    if string.find(old,'uses Samurai Roll. The total comes to') then
--        add_to_chat(122,"SAM Roll")
--    end
--end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR'then
            set_macro_page(3, 5)
    elseif player.sub_job == 'DNC' then
            set_macro_page(4, 5)
    else
        set_macro_page(4, 5)
    end
end