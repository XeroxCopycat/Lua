function user_job_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'Acc', 'Fodder', 'Proc')
	state.CastingMode:options('Normal', 'Resistant')
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
-- ### Precast sets to enhance JAs ###
	sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
	sets.precast.JA['Life Cycle'] = {
		body="Geomancy Tunic +3",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +4"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +3"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +3"}
	
-- ### Fast cast sets for spells ###
	sets.precast.FC = { --FC +80/80, QC +5, DT -22, SIRD +24%
		main="Marin Staff +1", --FC +3
		sub="Khonsu", --DT -6
		range="Dunna", --FC +3
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Agwu's Gages", --FC +6
		legs="Geo. Pants +4", --FC +15, SIRD +24%
		feet="Azimuth Gaiters +3", --DT -11
		neck="Voltsurge Torque", --FC +4
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Malignance Earring", --FC +4
		left_ring="Lebeche Ring", --QC +2
		right_ring="Medada's Ring", --FC +10
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --FC +10
	}
	
  -- Elemental Magic Fast Cast
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		hands="Bagua Mitaines +3",
	})
	
  -- Geomancy Fast Cast
	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna", ammo=empty})

  -- Healing Magic Fast Cast
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})
	
	
  -- Enhancing Magic Fast Cast
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

  -- Fast cast sets for specific spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	--sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	--sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
-- Indi Duration in slots that would normally have skill here to make entrust more efficient.	
	sets.buff.Entrust = {
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +2",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	}

-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {head="Bagua Galero +3"}

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Fast Recast Set ###
    sets.midcast.FastRecast = {
		main="Marin Staff +1", --FC +3
		sub="Khonsu", --DT -6
		range="Dunna", --FC +3
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Agwu's Gages", --FC +6
		legs="Geo. Pants +4", --FC +15, SIRD +24%
		feet="Azimuth Gaiters +3", --DT -11
		neck="Voltsurge Torque", --FC +4
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Loquacious Earring", --FC +2
		right_ear="Malignance Earring", --FC +4
		left_ring="Lebeche Ring", --QC +2
		right_ring="Medada's Ring", --FC +10
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --FC +10
	}

-- ### Dark Magic ###
    sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		head="Geo. Galero +3",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		legs="Azimuth Tights +3",
		feet="Geo. Sandals +3",
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Metamor. Ring +1",
	})
	
  -- Specific Dark Magic Spells
    sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
		head="Bagua Galero +4", --"Drain" and "Aspir" potency +35
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+9','"Drain" and "Aspir" potency +7','Mag. Acc.+6',}}, --"Drain" and "Aspir" potency +7
		hands={ name="Merlinic Dastanas", augments={'"Drain" and "Aspir" potency +7','Mag. Acc.+4','"Mag.Atk.Bns."+10',}}, --"Drain" and "Aspir" potency +7
		feet="Agwu's Pigaches", --"Drain" and "Aspir" potency +20
		neck="Erra Pendant", --"Drain" and "Aspir" potency +5
		left_ring="Archon Ring",
		right_ring="Medada's Ring", --(Evanescence Ring)
	})
	
	sets.midcast.Bio = set_combine(sets.midcast['Dark Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Dark Magic'], sets.TreasureHunter)
    sets.midcast.Drain = sets.midcast.Aspir
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'], {})
	
-- ### Divine Magic ###
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {})

-- ### Elemental Magic ###
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Sroda Tathlum",
		head="Azimuth Hood +3",
		body="Azimuth Coat +2", --(Upgrade to +3)
		hands="Azimuth Gloves +2", --(Upgrade to +3)
		legs="Azimuth Tights +3", --(Upgrade to +3)
		feet="Azimuth Gaiters +3",
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})

  -- Elemental Magic Magic Accuracy
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		head="Geo. Galero +3",
		hands="Geo. Mitaines +3",
		legs="Geo. Pants +4",
		feet="Geo. Sandals +3",
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		left_ear="Malignance Earring",
	})
	
  -- Magic Burst
    sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], { --MBD 46/40, MBD2 16
		main="Bunzi's Rod", --MBD +10 (Augment to R30)
		head="Ea Hat +1", --MBD +7, MBD2 +7
		hands="Bagua Mitaines +4", --MBD +12
		feet="Jhakri Pigaches +2", --MBD +7
		left_ring="Mujin Band", --MBD2 +5
	})
	
  -- Specific elemental magic spells
	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {
		hands="Volte Gloves",
		legs="Jhakri Slops +2",
		waist="Acuity Belt +1",
		left_ear="Malignance Earring",
	})
	
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})

-- ### Enfeebling Magic ###
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		head="Geo. Galero +3",
		body="Geomancy Tunic +3",
		hands="Azimuth Gloves +2",
		feet="Bagua Sandals +4",
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Metamor. Ring +1",
	})
	
  -- Enfeebling Magic, Resistant
	sets.midcast['Enfeebling Magic'].Resistant = {}
	
  -- Specific Enfeeble Spells
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Dispel = {main="Daybreak", sub="Ammurapi Shield"}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})	

-- ### Enhancing Magic ###
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		main={ name="Gada", augments={'"Cure" potency +6%','Mag. Acc.+4','"Mag.Atk.Bns."+2','DMG:+6',}},
		sub="Sors Shield",
		head="Befouled Crown",
		feet="Agwu's Pigaches",
	})
	
  -- Specific Enhancing Spells
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod"})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels"})
	
-- ### Geomancy ###
	sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Sors Shield",
		head="Azimuth Hood +3",
		body="Bagua Tunic +3",
		hands="Geo. Mitaines +3",
		feet="Bagua Sandals +4",
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}},
		left_ring="Murky Ring",
		right_ring="Medada's Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Damage taken-4%',}},
	})

  -- Indi Duration
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +3",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Damage taken-4%',}},
	})
	
-- ### Healing Magic ###
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
		main="Bunzi's Rod",
		sub="Sors Shield",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Malignance Earring",
		left_ring="Murky Ring",
		right_ring="Metamor. Ring +1",
		back="Solemnity Cape",
	})
	
  -- Specific healing magic spells
	sets.midcast.Cursna = {}
	

-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- Base Idle Set 
	sets.idle = { --PDT -55/50, MDT -35/50, Refresh +8, Latent: Refresh +1, Regen +1, Resist Silence +90
		main="Marin Staff +1",
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		range="Dunna", --(Homiliary)
		head="Befouled Crown", --Refresh +1 (Null Masque)
		body="Shamash Robe", --PDT -10, Refresh +3, Resist Silence +90
		hands="Bagua Mitaines +4", --Refresh +2
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Azimuth Gaiters +3", --DT -11
		neck="Sibyl Scarf", --Refresh +1
		waist="Plat. Mog. Belt", --DT -3 (Null Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Azimuth Earring +2", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+16','Damage taken-6%','INT+7 MND+7',}}, --DT -6
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --PDT -10
	}
	
  -- Idle Set When Luopan Active
	sets.idle.Pet = set_combine(sets.idle, { --PDT -37/50, MDT -27/50, Refresh +4~5, Pet: DT -24, Regen +25
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}}, --Pet: DT -6
		sub="Sors Shield", 
		range="Dunna", -- Pet: DT -5
		head="Azimuth Hood +3", --DT -12, Pet: Regen +5
		body="Shamash Robe", --PDT -10, Refresh +3, Resist Silence +90
		hands="Geo. Mitaines +3", --Pet: DT -13
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Bagua Sandals +4", --Pet: Regen +5
		neck={ name="Bagua Charm +2", augments={'Path: A',}}, --Pet: Absorb damage taken +10%
		waist="Carrier's Sash", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Etiolation Earring", --Resist Silence +15
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}}, --Pet: Regen +15
	})
	
  -- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {})
	
  -- Regen Set
	sets.idle.Regen = set_combine(sets.idle, {})

-------------------------------------------------------------------------------------------------------------------
-- Defense sets
-------------------------------------------------------------------------------------------------------------------
-- Physical Damage Taken
	sets.defense.PDT = { --DT -50/50
		main="Marin Staff +1",
		sub="Khonsu", --DT -6
		range="Dunna",
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna", --(Arete del Luna +1, Augment to R15)
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	}

  -- Magic Damage Taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
  -- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		head="Azimuth Hood +3",
		body="Shamash Robe",
		feet="Azimuth Gaiters +3",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})
	
  -- Pet Physical Damage Taken
 	sets.defense.PetPDT = sets.idle.PetPDT
	
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
	sets.weapons.Club = {main="Maxentius", sub="Sors Shield"}
	sets.weapons.Staff = {main="Marin Staff +1", sub="Khonsu"}
	

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Convert elemental damage taken to recover MP.	
	--sets.RecoverMP = {body="Seidr Cotehardie"}

-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}
	
-- Latent Refresh Effects
	--sets.latent_refresh = {waist="Fucho-no-obi"}
	--sets.latent_refresh_grip = {sub="Oneiros Grip"}
	
-- Day & Night Idle Effects
	--sets.DayIdle = {}
	--sets.NightIdle = {}
	
-- Treasure Hunter Effects
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		ammo="Per. Lucky Egg",
		--head="Volte Cap",
		--feet="Volte Boots",
		--waist="Chaac Belt",
	})

-- Gearswaps for Sublimation (/SCH)
	sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
-- Equipment Locked Sets
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

-- Equip when a buff effect is active
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {neck="Arciela's Grace +1"})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 21)
end