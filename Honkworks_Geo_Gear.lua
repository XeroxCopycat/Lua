function user_job_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'Acc', 'Fodder', 'Proc')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder')
    state.IdleMode:options('Normal', 'Refresh', 'Regen', 'PetPDT', 'Indi')
	state.PhysicalDefenseMode:options('PDT', 'PetPDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Club', 'Staff')

	autoindi = "Haste"
	autogeo = "Frailty"
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 310
	
	select_default_macro_book()
end

function init_gear_sets()
-------------------------------------------------------------------------------------------------------------------
-- Start defining the sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------
-- Fast cast sets for spells (FC +59/80)
	sets.precast.FC = {
		range="Dunna", -- FC +5
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, -- FC +14
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Geomancy Pants +3", -- FC +15
		feet="Jhakri Pigaches +2",
		neck="Voltsurge Torque", -- FC +4
		waist="Acuity Belt +1",
		left_ear="Loquac. Earring", -- FC +2
		right_ear="Alabaster Earring",
		left_ring="Jhakri Ring", -- FC +9 (4 piece)
		right_ring="Lebeche Ring", -- QC +2
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, -- FC +10
	}
	
  -- Elemental Magic Fast Cast
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		hands="Bagua Mitaines +3",
	})
	
  -- Geomancy Fast Cast
	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna", ammo=empty})

  -- Healing Magic Fast Cast
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		right_ring="Lebeche Ring",
	})
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.Self_Healing = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
  -- Enhancing Magic Fast Cast
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

  -- Specific Spells Fast Cast
  -- Impact (Requires Crepuscular Cloak)
	--sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
	
  -- Dispelga (Requires Daybreak)
	--sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})


-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
	sets.precast.JA['Life Cycle'] = {
		body="Geomancy Tunic +3",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	} 
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +3"}
	sets.precast.JA['Full Circle'] = {hands="Bagua Mitaines +3"} --head="Azimuth Hood +1"
	
-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +1",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	}

-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {head="Bagua Galero +3"}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- Fast Recast Set
    sets.midcast.FastRecast = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Sors Shield",
		range="Dunna",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Geomancy Pants +3", -- FC +15
		feet="Jhakri Pigaches +2",
		neck="Voltsurge Torque", -- FC +4
		waist="Acuity Belt +1",
		left_ear="Loquac. Earring", -- FC +2
		right_ear="Alabaster Earring",
		left_ring="Jhakri Ring", -- FC +9 (4 pc.)
		right_ring="Murky Ring",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}


-- Dark Magic
    sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Sors Shield",
		ammo="Ghastly Tathlum +1",
		head="Bagua Galero +3",
		legs="Azimuth Tights +1",
		feet="Geo. Sandals +3",
		neck="Erra Pendant",
		waist="Refoccilation Stone",
		right_ring="Metamor. Ring +1",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})
	
  -- Specific Dark Magic Spells
	-- Aspir
    sets.midcast.Aspir = sets.midcast.Drain
	
    -- Bio
	sets.midcast.Bio = set_combine(sets.midcast['Dark Magic'])
	sets.midcast['Bio II'] = set_combine(sets.midcast['Dark Magic'])
	
	-- Drain
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
    
	-- Stun
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'], {})
	
	-- Impact
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {})
	

-- Divine Magic
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	
-- Elemental Magic
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Ghastly Tathlum +1",
		head="Bagua Galero +3",
		body="Bagua Tunic +3",
		hands="Bagua Mitaines +3",
		legs="Bagua Pants +3",
		feet="Jhakri Pigaches +2",
		neck="Sybil Scarf",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Sortiarius Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Mujin Band", -- Medada's Ring OR Freke Ring
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})

  -- Elemental Magic Magic Accuracy
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
  -- Elemental Magic Fodder
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic]'], {})
	

-- Enfeebling Magic
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		head="Bagua Galero +3",
		legs="Jhakri Slops +2",
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
	})
	
  -- Enfeebling Magic, Resistant
	sets.midcast['Enfeebling Magic'].Resistant = {}
	
  -- Elemental Enfeebles
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- INT Based Enfeebles
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- MND Based Enfeebles
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- Specific Enfeeble Spells
	-- Dia
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	-- Dispel
	sets.midcast.Dispel = {main="Daybreak", sub="Ammurapi Shield"}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})
	
	
-- Enhancing Magic
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {})
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir Seraweels",
		waist="Siegel Sash",
	})
	
	-- Refresh
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		--sub="Ammurapi Shield",
		legs="Shedir Seraweels",
	}) 
	
	-- Barspell
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
	-- Protect
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Shell
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})
	
	
-- Geomancy
	sets.midcast.Geomancy = {
		head="Azimuth Hood +1",
		body="Bagua Tunic +3",
		hands="Geo. Mitaines +3",
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +1",
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
	}

	-- Indi Duration
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {})
	
	
-- Healing Magic
	sets.midcast.Cure = {
		main={ name="Gada", augments={'"Cure" potency +6%','Mag. Acc.+4','"Mag.Atk.Bns."+2','DMG:+6',}}, -- Cure Pot +24
		sub="Sors Shield", -- Cure Pot +3
		--ammo="Hasty Pinion +1",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, -- Cure Pot +10
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, -- Cure Pot +5
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		--neck="Voltsurge Torque",
		--waist="Plat. Mog. Belt",
		--left_ear="Malignance Earring",
		--right_ear="Mendi. Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Lebeche Ring", -- Cure Pot +3
	}
	

-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- Base Idle Set --DT 34/50 (PDT 44), Refresh +7~8, Movement Speed +18%
	sets.idle = {
		main="Marin Staff +1",
		sub="Khonsu", --6/6
		range="Dunna",
		head="Nyame Helm",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +3",
		legs="Assid. Pants +1",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Acuity Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	
  -- Idle Set When Luopan Active
	sets.idle.Pet = set_combine(sets.idle, {
		range="Dunna",
		head="Azimuth Hood +1",
		feet="Bagua Sandals +3",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	})

	sets.idle.PetPDT = set_combine(sets.idle.Pet, {})
	
-- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {
		--main="Daybreak",
		--sub="Ammurapi Shield",
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +3",
		legs="Assid. Pants +1",
		--feet="Volte Gaiters",
		neck="Sibyl Scarf",
	})
	
-- Regen Set
	sets.idle.Regen = set_combine(sets.idle, {
		--main="Malignance Pole",
		--sub="Oneiros Grip",
		--neck="Sanctity Necklace",
		--right_ear="Dawn Earring",
		--left_ring="Chirich Ring +1",
	})

-------------------------------------------------------------------------------------------------------------------
-- Defense sets
-------------------------------------------------------------------------------------------------------------------
-- Physical Damage Taken
	sets.defense.PDT = {
		--ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		--waist="Plat. Mog. Belt",
		--left_ear="Odnowa Earring +1",
		right_ear="Alabaster Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Murky Ring",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, 
	}

-- Magic Damage Taken
	--sets.defense.MDT = set_combine(sets.defense.PDT, {
		--neck="Warder's Charm +1",
		--waist="Carrier's Sash",
		--right_ring="Archon Ring",
	--})
	
-- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		neck="Unmoving Collar +1",
		--right_ear="Eabani Earring",
		--right_ring="Vengeful Ring",
	})
	
-- Pet Physical Damage Taken
	sets.defense.PetPDT = sets.idle.PetPDT
	
-- Equipment Locked Sets
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

-- Misc. Defensive Sets
	sets.Kiting = {left_ring="Shneddick Ring"}
	--sets.latent_refresh = {waist="Fucho-no-obi"}
	--sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.DayIdle = {}
	--sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		ammo="Per. Lucky Egg",
		--head="Volte Cap",
		--feet="Volte Boots",
		--waist="Chaac Belt",
	})
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace", 
		--waist="Gishdubar Sash",
	})


-------------------------------------------------------------------------------------------------------------------
-- Offense Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged set
	--sets.engaged = {
		--ammo="Hasty Pinion +1",
		--head={ name="Nyame Helm", augments={'Path: B',}},
		--body={ name="Nyame Mail", augments={'Path: B',}},
		--hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		--legs={ name="Nyame Flanchard", augments={'Path: B',}},
		--feet={ name="Nyame Sollerets", augments={'Path: B',}},
		--neck="Combatant's Torque",
		--waist="Grunfeld Rope",
		--left_ear="Telos Earring",
		--right_ear="Cessance Earring",
		--left_ring="Chirich Ring +1",
		--right_ring="Cacoethic Ring +1",
		--back="Solemnity Cape",
	--}
	
	--sets.engaged.Acc = set_combine(sets.engaged, {})
	--sets.engaged.Fodder = set_combine(sets.engaged, {})
	
-- Hybrid Engaged Sets
	--sets.engaged.DT = {
		--ammo="Hasty Pinion +1",
		--head={ name="Nyame Helm", augments={'Path: B',}},
		--body={ name="Nyame Mail", augments={'Path: B',}},
		--hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		--legs={ name="Nyame Flanchard", augments={'Path: B',}},
		--feet={ name="Nyame Sollerets", augments={'Path: B',}},
		--neck="Combatant's Torque",
		--waist="Grunfeld Rope",
		--left_ear="Telos Earring",
		--right_ear="Cessance Earring",
		--left_ring="Defending Ring",
		--right_ring="Cacoethic Ring +1",
		--back="Solemnity Cape",
	--}
	
	--sets.engaged.DT.Acc = set_combine(sets.engaged.DT, {})
	--sets.engaged.DT.Fodder = set_combine(sets.engaged.DT, {})


-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default weaponskill gear
	--------------------------------------
	--sets.precast.WS = {
		--ammo="Oshasha's Treatise",
		--head={ name="Nyame Helm", augments={'Path: B',}},
		--body={ name="Nyame Mail", augments={'Path: B',}},
		--hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		--legs={ name="Nyame Flanchard", augments={'Path: B',}},
		--feet={ name="Nyame Sollerets", augments={'Path: B',}},
		--neck="Rep. Plat. Medal",
		--waist="Grunfeld Rope",
		--left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		--right_ear="Regal Earring",
		--left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		--right_ring="Cornelia's Ring",
		--back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: Damage taken -5%',}},
	--}

-------------------------------------------------------------------------------------------------------------------
-- Weapons sets
-------------------------------------------------------------------------------------------------------------------
	sets.weapons.None = {}
	--sets.weapons.Club = {main="Beryllium Mace +1", sub="Ammurapi Shield"}
	--sets.weapons.Staff = {main="Malignance Pole", sub="Ajja Grip"}
	

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Gear that converts elemental damage done to recover MP.	
	--sets.RecoverMP = {body="Seidr Cotehardie"}
	
-- Gearwaps for Magic Burst Mode
    sets.MagicBurst = {
		head="Ea Hat +1",
		--body={ name="Agwu's Robe", augments={'Path: A',}},
		hands="Bagua Mitaines +3", --hands={ name="Agwu's Gages", augments={'Path: A',}},
		--legs={ name="Agwu's Slops", augments={'Path: A',}},
		feet="Jhakri Pigaches +2",
		--neck="Mizu. Kubikazari",
		right_ring="Mujin Band",
	}
	
	sets.ResistantMagicBurst = set_combine(sets.MagicBurst, {})
	
-- Gearswaps for Sublimation
	--sets.buff.Sublimation = {waist="Embla Sash"}
    --sets.buff.DTSublimation = {waist="Embla Sash"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 21)
end