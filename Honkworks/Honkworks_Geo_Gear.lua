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
--------------------------------------
-- Fast cast sets for spells (FC +80/80, QC +2)
--------------------------------------
	sets.precast.FC = {
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8				
		hands="Agwu's Gages", --FC +6
		legs="Geomancy Pants +3", --FC +15
		feet="Agwu's Pigaches", --FC +4
		neck="Voltsurge Torque", --FC +5
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Lebeche Ring", --QC +2
		right_ring="Medada's Ring", --FC +10
		back={ name="Nantosuelta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-8%',}}, --FC +10
	}
	
  -- Elemental Magic Fast Cast
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		hands="Bagua Mitaines +3",
	})
	
  -- Geomancy Fast Cast
	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna", ammo=empty})

  -- Healing Magic Fast Cast
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	--sets.Self_Healing = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	--sets.Cure_Received = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	--sets.Self_Refresh = {waist="Gishdubar Sash"}
	
  -- Enhancing Magic Fast Cast
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})


--------------------------------------
-- Specific Spells Fast Cast
--------------------------------------
  -- Impact (Requires Crepuscular Cloak)
	--sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
	
  -- Dispelga (Requires Daybreak)
	--sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})


--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
	sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
	sets.precast.JA['Life Cycle'] = {
		body="Geomancy Tunic +3",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	} 
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +3"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +2"}
	

--------------------------------------
-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
--------------------------------------	
	sets.buff.Entrust = {
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +2",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	}


--------------------------------------
-- Relic hat for Blaze of Glory HP increase.
--------------------------------------
	sets.buff['Blaze of Glory'] = {head="Bagua Galero +3"}


------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast Set
--------------------------------------
    sets.midcast.FastRecast = {
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8				
		hands="Agwu's Gages", --FC +6
		legs="Geomancy Pants +3", --FC +15
		feet="Agwu's Pigaches", --FC +4
		neck="Voltsurge Torque", --FC +5
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Lebeche Ring", --QC +2
		right_ring="Medada's Ring", --FC +10
		back={ name="Nantosuelta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-8%',}}, --FC +10
	}


--------------------------------------
-- Dark Magic
--------------------------------------
    sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Ghastly Tathlum +1", --Augment R15
		head="Bagua Galero +3", --Drain/Aspir Pot +35
		body="Geomancy Tunic +3", --Dark Magic Skill +21
		hands="Nyame Gauntlets",
		legs="Azimuth Tights +1", --Dark Magic Skill +20
		feet="Agwu's Pigaches", --Drain/Aspir Pot +20
		neck="Erra Pendant", --Dark Magic Skill +10, Drain/Aspir Pot +5
		waist="Acuity Belt +1",
		left_ear="Lugalbanda Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
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
	

--------------------------------------
-- Divine Magic
--------------------------------------
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {})
	

--------------------------------------
-- Elemental Magic
--------------------------------------
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		range="Ghastly Tathlum +1",
		head="Agwu's Cap",
		body="Bagua Tunic +3",
		hands="Agwu's Gages",
		legs="Bagua Pants +3",
		neck="Sibyl Scarf",
		waist="Acuity Belt +1",
		left_ear="Sortiarius Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})

  -- Elemental Magic Magic Accuracy
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
  -- Elemental Magic Fodder
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic]'], {})
	
  -- Magic Burst Gearswaps
    sets.MagicBurst = {
		head="Ea Hat +1",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops", 
		feet="Jhakri Pigaches +2",
		--neck="Mizu. Kubikazari",
		left_ring="Mujin Band",
	}
	
	sets.ResistantMagicBurst = set_combine(sets.MagicBurst, {})
	

--------------------------------------
-- Enfeebling Magic
--------------------------------------
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1",
		sub="Khonsu",
		range="Ghastly Tathlum +1",
		head="Bagua Galero +3",
		legs="Agwu's Slops", 
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
	
	-- Dispel/gs
	sets.midcast.Dispel = {main="Daybreak", sub="Ammurapi Shield"}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})
	

--------------------------------------
-- Enhancing Magic
--------------------------------------
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Gada",
		sub="Sors Shield",
		ammo="Ghastly Tathlum +1",
		head="Befouled Crown",
		body={ name="Telchine Chas.", augments={'"Regen" potency+3',}},
		legs="Shedir Seraweels",
		waist="Embla Sash",w
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
		--waist="Siegel Sash",
	})
	

--------------------------------------
-- Geomancy
--------------------------------------
	sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Sors Shield",
		range="Dunna",
		head="Azimuth Hood +2",
		hands="Geo. Mitaines +3",
		legs="Agwu's Slops",
		feet="Bagua Sandals +3",
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt", --Isa Belt
		right_ear="Alabaster Earring",
		right_ring="Murky Ring",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}},
	})

  -- Indi Duration
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
		hands="Geo. Mitaines +3",
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +2",
		waist="Plat. Mog. Belt",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Damage taken-4%',}},
	})
	

--------------------------------------	
-- Healing Magic
--------------------------------------
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
		main="Bunzi's Rod", --Cure Pot +30
		sub="Sors Shield", -- Cure Pot +3
		--ammo="Hasty Pinion +1",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, -- Cure Pot +10
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, -- Cure Pot +5
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		--left_ear="Malignance Earring",
		--right_ear="Mendi. Earring",
	})
	
  -- Specific healing magic spells
    -- Cursna
	sets.midcast.Cursna = {}
	

-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Base Idle Set 
--------------------------------------
	sets.idle = { --DT 50/50, Refresh +8~9, Movement Speed +18%
		main="Marin Staff +1",
		sub="Khonsu", -- DT -6
		range="Dunna", -- Homiliary
		head="Azimuth Hood +2", -- DT -11, Null Masque
		body="Jhakri Robe +2", -- Refresh +4
		hands="Bagua Mitaines +3", -- Refresh +2
		legs="Assid. Pants +1", -- Refresh +1~2
		feet="Azimuth Gaiters", -- DT -10
		neck="Sibyl Scarf", --Refresh +1
		waist="Plat. Mog. Belt", -- DT -3
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring", -- DT -5
		left_ring="Shneddick Ring",
		right_ring="Murky Ring", -- DT -10
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5
	}
	
  -- Idle Set When Luopan Active
	sets.idle.Pet = set_combine(sets.idle, { --DT 52/50, Pet DT -13, Pet Regen +20
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}}, --Pet DT -6
		sub="Sors Shield",
		range="Dunna",
		head="Azimuth Hood +2", -- DT -11
		body="Nyame Mail", --DT -9
		hands="Geo. Mitaines +3", -- Pet DT -13
		legs="Nyame Flanchard", --DT -8
		feet="Bagua Sandals +3", -- Pet Regen +5
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Lugalbanda Earring",
		right_ear="Alabaster Earring", --DT -5
		left_ring="Shneddick Ring",
		right_ring="Murky Ring", --DT -10
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10','Pet: "Regen"+5',}}, --Pet Regen +15
})
	
  -- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {
		head="Befouled Crown",
		--feet="Volte Gaiters",
		neck="Sibyl Scarf",
		--left_ring="Stikini Ring +1",
		--right_ring=Stikini Ring +1",
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
--------------------------------------
-- DT sets
--------------------------------------
-- Physical Damage Taken
	sets.defense.PDT = { --DT -73
		main="Marin Staff +1",
		sub="Khonsu", -- DT -6
		--ammo="Staunch Tathlum +1",
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Lugalbanda Earring",
		right_ear="Alabaster Earring", --DT -5
		left_ring="Shneddick Ring",
		right_ring="Murky Ring", --DT -10
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5
	}

-- Magic Damage Taken
	--sets.defense.MDT = set_combine(sets.defense.PDT, {
		--neck="Warder's Charm +1",
		--waist="Carrier's Sash",
		--right_ring="Archon Ring",
	--})
	
-- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		head="Azimuth Hood +2",
		feet="Azimuth Gaiters +2",
		--waist="Null Loop",
		left_ear="Lugalbanda Earring"
		--right_ear="Eabani Earring",
		--right_ring="Vengeful Ring",
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
	--sets.weapons.Staff = {main="Malignance Pole", sub="Ajja Grip"}
	

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Misc. Sets
--------------------------------------
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
    -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace", 
		waist="Gishdubar Sash",
	})
	
	-- Sleep
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})
	
	-- Reive Mark
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {
		neck="Arciela's Grace +1",
	})
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 21)
end