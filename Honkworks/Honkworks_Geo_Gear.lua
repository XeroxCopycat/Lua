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
	state.Weapons:options('None', 'BlackHalo', 'Mykyr', 'Casting')

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
-- ### Fast cast sets for spells ### 
	sets.precast.FC = { --FC 82/80, QC +5, PDT/MDT -27/-17
		main="Marin Staff +1", --FC +3
		sub="Khonsu", --DT -6
		range="Dunna", --FC +3
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Agwu's Gages", --FC +6
		legs="Geo. Pants +4", --FC +15
		feet="Agwu's Pigaches", --FC +4
		neck="Loricate Torque +1", --DT -6
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Malignance Earring", --FC +4
		left_ring="Lebeche Ring", --QC +2
		right_ring="Medada's Ring", --FC +10
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --FC +10
	}
	
  -- Elemental Magic Fast Cast
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { --FC 84/80, QC +5, PDT/MDT -37/-27
		hands="Bagua Mitaines +4", --Elemental magic cast time -14%
		feet="Azimuth Gaiters +3", --DT -10
	})


	--sets.Self_Healing = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	--sets.Cure_Received = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	--sets.Self_Refresh = {waist="Gishdubar Sash"}

  -- Fast Cast for specific spells
    -- Impact (Requires Crepuscular Cloak)
	--sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
	
    -- Dispelga (Requires Daybreak)
	--sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

-- ### Precast sets to enhance JAs ###
	-- Bolster
	sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
	
	-- Full Circle
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +3"}
	
	-- Life Cycle
	sets.precast.JA['Life Cycle'] = {
		body="Geomancy Tunic +3",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	} 
	
	-- Mending Halation
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +3"}
	
	-- Radial Arcana
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}

-- ### Indi Duration in slots that would normally have skill here to make entrust more efficient ###
	sets.buff.Entrust = {
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +3",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	}
	
-- ### Relic hat for Blaze of Glory HP increase. ###
	sets.buff['Blaze of Glory'] = {head="Bagua Galero +3"}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Base fast recast set ###
    sets.midcast.FastRecast = { --FC 82/80, PDT/MDT -37/-27
		main="Marin Staff +1", --FC +3
		sub="Khonsu", --DT -6
		range="Dunna", --FC +3
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Agwu's Gages", --FC +6
		legs="Geo. Pants +4", --FC +15
		feet="Agwu's Pigaches", --FC +4
		neck="Loricate Torque +1", --DT -6
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Malignance Earring", --FC +4
		left_ring="Murky Ring", --DT -10
		right_ring="Medada's Ring", --FC +10
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --FC +10
	}

-- ### Dark Magic ###
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {	
		main="Marin Staff +1",
		sub="Khonsu",
		range="Dunna",
		head="Geo. Galero +3",
		body="Geomancy Tunic +3", --Dark Magic Skill +21
		hands="Geo. Mitaines +3", 
		legs="Azimuth Tights +2", --Dark Magic Skill +25
		feet="Azimuth Gaiters +3",
		neck="Erra Pendant", --Dark Magic Skill +10
		waist="Acuity Belt +1", --(Augment to R15)
		left_ear="Abyssal Earring", --Dark Magic Skill +5
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Archon Ring",
		right_ring="Medada's Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})
	
-- Specific Dark Magic Spells
  -- Aspir
    sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
		head="Bagua Galero +4", --Drain/Aspir Potency +35
		feet="Agwu's Pigaches", --Drain/Aspir Potency +20
		neck="Erra Pendant", --Drain/Aspir Potency +5
	})

  -- Bio
	sets.midcast.Bio = set_combine(sets.midcast['Dark Magic'])
	sets.midcast['Bio II'] = set_combine(sets.midcast['Dark Magic'])

  -- Drain
    sets.midcast.Drain = sets.midcast.Aspir
   
  -- Stun
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'], {})
	
-- ### Divine Magic ###
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {})
	
-- ### Elemental Magic ###
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		range="Dunna", --(Ghastly Tathlum +1, augment to R15)
		head="Azimuth Hood +3",
		body="Azimuth Coat +2", --(Upgrade to +3)
		hands="Azimuth Gloves +2", --(Upgrade to +3)
		legs="Azimuth Tights +2", --(Upgrade to +3)
		feet="Azimuth Gaiters +3", --(Upgrade to +3)
		neck="Sibyl Scarf", --(Baetyl Pendant)
		waist="Acuity Belt +1", --(Sacro Cord)
		left_ear="Malignance Earring", --(Regal Earring)
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Metamor. Ring +1", --(Freke Ring)
		right_ring="Medada's Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})

  -- Elemental Magic Magic Accuracy
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
	})
	
  -- Elemental Magic Fodder
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})
	
  -- Magic Burst Gearswaps
    sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], { --Magic Burst Dmg. 41/40, Magic Burst Dmg, II 16
		main="Bunzi's Rod", --Magic Burst Damage +10
		sub="Sors Shield",
		head="Ea Hat +1", --Magic Burst Damage +7, Magic Burst Damage II +7
		body="Azimuth Coat +2", --Magic Burst Damage II +4
		hands="Agwu's Gages", --Magic Burst Damage +8
		legs="Agwu's Slops", --Magic Burst Damage +9
		feet="Jhakri Pigaches +2", --Magic Burst Damage +7
		left_ring="Mujin Band", --Magic Burst Damage II +5
	})
	
	sets.ResistantMagicBurst = set_combine(sets.MagicBurst, {})
	
  -- Specific elemental magic spells
	-- Elemental debuffs
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
  
    -- Impact
	--sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {})
	
-- ### Enfeebling Magic ###
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		range="Dunna", --(Ammo: Phemphedro Tathlum)
		head="Geo. Galero +3", --(Upgrade to +4)
		body="Geomancy Tunic +3", --(Upgrade to +4)
		hands="Azimuth Gloves +2", --(Regal Cuffs)
		legs="Geo. Pants +4", 
		feet="Geo. Sandals +3", --(Upgrade to +4)
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Eschan Stone", --(Luminary Sash)
		left_ear="Malignance Earring",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Metamor. Ring +1", --(Stikini Ring +1)
		right_ring="Medada's Ring",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
	
  -- Enfeebling Magic, Resistant
	sets.midcast['Enfeebling Magic'].Resistant = {}
	
  -- INT Based Enfeebles
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"}) --(Augment to R15)
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"}) --(Augment to R15)
	
  -- MND Based Enfeebles
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- Specific Enfeeble Spells
	-- Dia
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	-- Dispel/Dispelga
	--sets.midcast.Dispel = {main="Daybreak", sub="Ammurapi Shield"}
	--sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})
	
-- ### Enhancing Magic ###
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, { --Enhancing Magic Skill +49, PDT -36/MDT -26
		main={ name="Gada", augments={'"Cure" potency +6%','Mag. Acc.+4','"Mag.Atk.Bns."+2','DMG:+6',}}, --Enhancing Magic Skill +18
		sub="Sors Shield",
		range="Dunna",
		head="Befouled Crown", --Enhancing Magic Skill +16
		body="Shamash Robe", 
		hands="Azimuth Gloves +2", --DT -11 (Regal Cuffs)
		legs="Shedir Seraweels", --Enhancing Magic Skill +15, Enhances "Stoneskin" effect, Enhances "Aquaveil" effect
		feet="Azimuth Gaiters +3", --DT -10
		neck="Warder's Charm +1",
		waist="Embla Sash", --Enhancing Magic Duration +10%
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Metamor. Ring +1", 
		right_ring="Medada's Ring",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --PDT -10
	})
	
  -- Specific Enhancing Spells
	-- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		--sub="Ammurapi Shield",
	})
	
	-- Barspell
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	-- Protect
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Refresh
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Shell
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir Seraweels",
	})
	
-- ### Geomancy ###
	sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}}, --(Idris)
		sub="Sors Shield",
		range="Dunna",
		head="Azimuth Hood +3",
		body="Azimuth Coat +2", --(Upgrade to +3)
		hands="Azimuth Gloves +2", --(Upgrade to +3)
		legs="Azimuth Tights +2", --(Upgrade to +3)
		feet="Azimuth Gaiters +3", --(Upgrade to +3)
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt", --(Isa Belt)
		left_ear="Alabaster Earring",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Murky Ring",
		right_ring="Medada's Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Damage taken-4%',}},
	})

  -- Indi Duration
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}}, --Indi. Spell Duration +15 (Idris)
		legs="Bagua Pants +3", --Indi. Spell Duration +21 (Upgrade to +4)
		feet="Azimuth Gaiters +3", --Indi. Spell Duration +25 (Upgrade to +3)
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Damage taken-4%',}}, --Indi. Spell Duration +20%
	})
	
-- ### Healing Magic ###
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, { --Cure Pot. +48/50
		main="Bunzi's Rod", --Cure Pot. +30
		sub="Sors Shield", --Cure Pot. +3, Enmity -5
		range="Dunna",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Cure Pot. +10, Conserve MP +6, Healing Magic Skill +20
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Healing Magic Skill +20
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Healing Magic Skill +20
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Healing Magic Skill +20
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Healing Magic Skill +20, Cursna +5
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Magnetic Earring", --Conserve MP +5
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}}, --DT -6
		left_ring="Metamor. Ring +1",
		right_ring="Lebeche Ring", --Cure Pot. +3
		back="Solemnity Cape", --Cure Pot. +7, Conserve MP +5, DT -4
	})
	
  -- Specific healing magic spells
    -- Cursna
	sets.midcast.Cursna = {}
	
-- ### Idle Sets ###
  -- Idle Set 
	sets.idle = { --PDT/MDT -43/-33, Refresh +4~5. Pet: DT -24, Regen +25
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}}, --Pet: DT -6
		sub="Sors Shield",
		range="Dunna", --Pet: DT -5
		head="Azimuth Hood +3", --DT -12, Pet: Regen +5
		body="Shamash Robe", --PDT -10, Refresh +3
		hands="Geo. Mitaines +3", --Pet: DT -13
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Bagua Sandals +4", --Pet: Regen +5
		neck={ name="Bagua Charm +2", augments={'Path: A',}}, --Luopon Duration +25%, Luopan: Absorb damage taken +10%
		waist="Plat. Mog. Belt", --(Isa Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}}, --DT -6
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}}, --Pet: Regen +15
	}
	
  -- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, { --PDT/MDT -47/-37, Refresh +9~10
		main="Marin Staff +1",
		sub="Khonsu", --DT -6
		head="Befouled Crown", --Refresh +1 (Null Masque)
		body="Jhakri Robe +2", --Refresh +4
		hands="Bagua Mitaines +4", --Refresh +2
		legs="Assid. Pants +1", --Refresh 1~2
		feet="Azimuth Gaiters +3", --DT -10 (Geo. Sandels +4)
		neck="Sibyl Scarf", --Refresh +1
		waist="Carrier's Sash", --(Null Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}}, --DT -6
		left_ring="Murky Ring", --DT -10 (Stikini Ring +1)
		right_ring="Shneddick Ring", --Mv. Speed +18% (Stikini Ring +1)
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --PDT -10
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
-- ### Physical Damage Taken ###
	sets.defense.PDT = { --DT -53
		main="Marin Staff +1",
		sub="Khonsu", --DT -6
		range="Dunna",
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna", 
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring",
		back="Solemnity Cape", --DT -4
	}

-- Magic Damage Taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		right_ring="Lugalbanda Earring",
	})
	
-- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		head="Azimuth Hood +2",
		feet="Azimuth Gaiters +3",
		--waist="Null Belt",
		left_ear="Lugalbanda Earring"
		--right_ear="Eabani Earring",
		--right_ring="Vengeful Ring",
	})
	
  -- Pet Physical Damage Taken
 	sets.defense.PetPDT = sets.idle.PetPDT
	
-------------------------------------------------------------------------------------------------------------------
-- Offense Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged set ###
	sets.engaged = {
		main="Maxentius",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Murky Ring",
		right_ring="Jhakri Ring",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},}
	
	sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.Fodder = set_combine(sets.engaged, {})
	
-- Hybrid Engaged Sets
	sets.engaged.DT = set_combine(sets.engaged, {})	
	sets.engaged.DT.Acc = set_combine(sets.engaged.DT, {})
	sets.engaged.DT.Fodder = set_combine(sets.engaged.DT, {})


-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill gear ###
	sets.precast.WS = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Murky Ring",
		right_ring="Jhakri Ring",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

-------------------------------------------------------------------------------------------------------------------
-- Weapons sets
-------------------------------------------------------------------------------------------------------------------
	sets.weapons.None = {}
	sets.weapons.BlackHalo = {main="Maxentius", sub="Sors Shield"}
	sets.weapons.Mykyr = {main="Marin Staff +1", sub="Khonsu"}
	sets.weapons.Casting = {main="Bunzi's Rod", sub="Sors Shield"}

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Convert elemental damage dealt to recover MP ###	
	--sets.RecoverMP = {body="Seidr Cotehardie"}
	
-- ### Day & Night Idle Effects ###
	--sets.DayIdle = {}
	--sets.NightIdle = {}
	
-- ### Equip when a specific buff/debuff effect is active ###
    -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace", 
		--waist="Gishdubar Sash",
	})
	
	-- Sleep
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})
	
	-- Reive Mark
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {
		neck="Arciela's Grace +1",
	})
	
-- Equipment Locked Sets
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi
	
-- ### Kiting ###
	sets.Kiting = {right_ring="Shneddick Ring"}
	
-- ### Latent Refresh Effects ###
	--sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}

-- ### Sublimation (/SCH) ###
	sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}

-- ### Treasure Hunter Effects ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		--head="Volte Cap",
		--feet="Volte Boots",
		--waist="Chaac Belt",
	})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 21)
end