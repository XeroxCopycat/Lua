-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'Refresh')
	state.HybridMode:options('Normal', 'DT')
	state.Weapons:options('None', 'Club', 'Staff', 'Prime')

	gear.nuke_jse_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Staff;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

-------------------------------------------------------------------------------------------------------------------
-- Start Defining the Sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------
-- ### Precast sets to enhance JAs ###
    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +3"} --(Upgrade to +4)
	sets.precast.JA['Enlightenment'] = {body="Peda. Gown +3"} --(Upgrade to +4)

--------------------------------------
-- Fast cast sets for spells
--------------------------------------
    sets.precast.FC = { --FC +83/80, QC +5, DT -22
		main={ name="Musa", augments={'Path: C',}}, --FC +10
		sub="Khonsu", --DT -6
		ammo="Ghastly Tathlum +1", --(Impatiens)
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8 
		hands="Acad. Bracers +2", --FC +7
		legs="Agwu's Slops", --FC +7
		feet="Peda. Loafers +3", --FC +8
		neck="Loricate Torque +1", --DT -6
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Malignance Earring", --FC +4
		left_ring="Lebeche Ring", --QC +2
		right_ring="Medada's Ring", --FC +10
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10, DT -22
	}

  -- Grimoire Spellcasting Time
	sets.precast.FC.Arts = set_combine(sets.precast.FC, { --FC +71/80, Grimoire: Spellcasting time -23%
		head="Peda. M.Board +3", --Grimoire: Spellcasting Time -13%
		feet="Acad. Loafers +2", --Grimoire: Spellcasting time -10%
		waist="Embla Sash", --FC +5
		left_ring="Kishar Ring", --FC +4
	})

  -- Precast for Specific Spells
	-- Dispelga (Requires Daybreak)
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {}) --main="Daybreak", sub="Ammurapi Shield",
  
	-- Impact (Requires Crespcular / Twilight Cloak)
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {}) --body="Crespcular Cloak",

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- ### Fast Recast ###
--------------------------------------
	sets.midcast.FastRecast = { --FC +83/80 , Haste +20%, DT -32/50
		main={ name="Musa", augments={'Path: C',}}, --FC +10
		sub="Khonsu", --DT -6
		ammo="Ghastly Tathlum +1", --(Sapience Orb)
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14, Haste +6%
		body="Agwu's Robe", --FC +8, Haste +3%
		hands="Acad. Bracers +2", --FC +7, Haste +3%
		legs="Agwu's Slops", --FC +7, Haste +5%
		feet="Peda. Loafers +3", --FC +8, Haste +3%
		neck="Loricate Torque +1", --DT -6 
		waist="Embla Sash", --FC +5
		left_ear="Alabaster Earring", --DT -5 
		right_ear="Malignance Earring", --FC +4
		left_ring="Murky Ring", --DT -10
		right_ring="Medada's Ring", --FC +10
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10, DT -5
	}

--------------------------------------
-- ### Dark Magic ### 
--------------------------------------
    sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		main={ name="Musa", augments={'Path: C',}},
		sub="Khonsu",
		ammo="Ghastly Tathlum +1", --(Pemphedo Tathlum)
		head="Acad. Mortar. +3", --(Upgrade to +4)
		body="Acad. Gown +3", --(Upgrade to +4)
		hands="Acad. Bracers +2", --(Upgrade to +4)
		legs="Acad. Pants +2", --(Upgrade to +4)
		feet="Peda. Loafers +3", --(Upgrade to +4)
		neck="Erra Pendant", --(Argute Stole +2, Aug to R25)
		waist="Witful Belt", 
		left_ear="Abyssal Earring", --(Regal Earring)
		right_ear="Malignance Earring",
		left_ring="Kishar Ring", --(Stikini Ring +1)
		right_ring="Medada's Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})

  -- Specific Dark Magic Spells
    -- Drain
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main={ name="Rubicundity", augments={'Mag. Acc.+1','"Mag.Atk.Bns."+5','"Conserve MP"+1',}},
		sub="Sors Shield", --(Ammurapi Shield)
		ammo="Ghastly Tathlum +1", --(Pemphedo Tathlum)
		head="Pixie Hairpin +1",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+9','"Drain" and "Aspir" potency +7','Mag. Acc.+6',}},
		hands={ name="Merlinic Dastanas", augments={'"Drain" and "Aspir" potency +7','Mag. Acc.+4','"Mag.Atk.Bns."+10',}},
		legs="Peda. Pants +3",
		feet="Agwu's Pigaches", 
		neck="Erra Pendant",
		waist="Eschan Stone", --(Fucho-no-Obi)
		left_ear="Abyssal Earring", --(Mani Earring)
		right_ear="Malignance Earring", --(Hirudiena Earring)
		left_ring="Archon Ring", --(Evanescence Ring)
		right_ring="Medada's Ring",
		back={ name="Bookworm's Cape", augments={'INT+2','Helix eff. dur. +10','"Regen" potency+8',}},
	})
	
    sets.midcast.Drain.Resistant = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant
	sets.midcast.Kaustra = set_combine(sets.midcast['Dark Magic'], {
		main="Bunzi's Rod",
		sub="Sors Shield", --(Ammurapi Shield)
		ammo="Ghastly Tathlum +1", 
		head="Peda. M.Board +3", --(Upgrade to +4)
		body="Agwu's Robe", --(Aug to R30)
		legs="Agwu's Slops", --(Aug to R30)
	})
	
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Stun.Resistant = {}
	
--------------------------------------
-- ### Divine Magic ###
--------------------------------------
	sets.midcast['Divine Magic'] = {}

--------------------------------------
-- ### Elemental Magic ###
--------------------------------------
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1", --(Bunzi's Rod, aug to R30)
		sub="Khonsu", --(Ammurapi Shield)
		ammo="Ghastly Tathlum +1", --(Aug to R15)
		head="Agwu's Cap", --(Aug to R30)
		body="Agwu's Robe", --(Arbatel Gown +3)
		hands="Agwu's Gages", --(Arbatel Bracers +3)
		legs="Agwu's Slops", --(Arbatel Pants +3)
		feet="Agwu's Pigaches", --(Arbatel Loafers +3)
		neck="Sibyl Scarf", --(Argute Stole +2, aug to R25)
		waist="Eschan Stone", --(Hachirin-no-Obi)
		left_ear="Friomisi Earring", --(Regal Earring)
		right_ear="Malignance Earring",
		left_ring="Metamor. Ring +1", 
		right_ring="Medada's Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})
  
    sets.midcast['Elemental Magic'].Resistant = {}
	sets.midcast['Elemental Magic'].Proc = {}
	sets.midcast['Elemental Magic'].OccultAcumen = {}
	sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], {left_ring="Mujin Band"})
	sets.HelixBurst = set_combine(sets.MagicBurst, {})
	sets.ResistantHelixBurst = {}
	
  -- Specific Elemental Magic Spells
	sets.midcast.Impact = {}
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})

--------------------------------------
-- Enfeebling Magic
--------------------------------------
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Marin Staff +1", --(Bunzi's Rod, aug to R30)
		sub="Khonsu", --(Ammurapi Shield)
		ammo="Ghastly Tathlum +1", --(Pemphedo Tathlum)
		head="Acad. Mortar. +3", --(Upgrade to +4)
		body="Agwu's Robe", --(Upgrade to +4)
		hands="Acad. Bracers +2", --(Kaykaus Cuffs +1, Path A)
		legs="Acad. Pants +2", --(Arbatel Pants +3)
		feet="Acad. Loafers +2", --(Upgrade to +4)
		neck="Loricate Torque +1", --(Argute Stole +2, aug to R25)
		waist="Eschan Stone", --(Obstin. Sash, aug to R15)
		left_ear="Alabaster Earring", --(Regal Earring)
		right_ear="Malignance Earring",
		left_ring="Metamor. Ring +1", --(Stikini Ring +1)
		right_ring="Medada's Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})
	
	sets.midcast['Enfeebling Magic'].Resistant = {}
	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- Specific Enfeebling Spells
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']
	
--------------------------------------
-- ### Enhancing Magic ###
--------------------------------------
	sets.midcast['Enhancing Magic'] = {
		main={ name="Musa", augments={'Path: C',}},
		sub="Khonsu", 
		ammo="Ghastly Tathlum +1",  --(Pemphedo Tathlum)
		head="Telchine Cap", --(Aug w/ Enhancing magic duration +10)
		body="Peda. Gown +3", --(Upgrade to +4)
		hands="Arbatel Bracers", --(Upgrade to +3)
		legs={ name="Telchine Braconi", augments={'"Regen" potency+3',}}, --(Aug w/ Enhancing magic duration +10)
		feet="Telchine Pigaches", --(Aug w/ Enhancing magic duration +10)
		neck="Loricate Torque +1", --(Hoxne Torque)
		waist="Embla Sash",
		left_ear="Alabaster Earring", --(Mimir Earring)
		right_ear="Arete del Luna +1", --(Andoaa Earring)
		left_ring="Murky Ring", --(Stikini Ring +1)
		right_ring="Medada's Ring", --(Stikini Ring +1)
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --(Fi Folet Cape +1, aug to R15)
	}

  -- Specific Enhancing Spells
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod", legs="Shedir Seraweels"}) --(Amalric Coif +1, Regal Cuffs, Empathkos Rope)
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"}) --(Mendicant's Earring, Mephitas Ring +1 aug to r15, 
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		body={ name="Telchine Chas.", augments={'"Regen" potency+3',}}, --(Aug w/ Enhancing magic duration +10) 
		hands="Arbatel Bracers", --(Upgrade to +3)
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})	
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shellra = sets.midcast.Shell
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels"}) --(Nodens Gorget, Siegel Sash, Earthcry Earring)
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})

--------------------------------------
-- Healing Magic
--------------------------------------
    sets.midcast['Healing Magic']= set_combine(sets.midcast.FastRecast, { --Cure Pot. +51/50, DT -52/50
		main="Bunzi's Rod", --Cure Pot. +30
		sub="Sors Shield", --Cure Pot. +3
		ammo="Ghastly Tathlum +1", --(Staunch Tathlum +1)
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Cure Pot. +10
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Acad. Pants +2", --Cure Pot. +8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Magnetic Earring",
		left_ring="Murky Ring", --DT -10
		right_ring="Metamor. Ring +1",
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	})
		
    sets.midcast.LightWeatherCure = {}
    sets.midcast.LightDayCure = {}
	sets.Self_Healing = {}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

  -- Specific Healing Spells
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], {})
    sets.midcast.Curaga = sets.midcast.Cure	
    sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'], {
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs="Acad. Pants +2", --(Upgrade to +4)
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Potency +5, CST -7, Skill +20
	})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- ### Base idle set ###
--------------------------------------
    sets.idle = { --DT -40/50 (PDT -50), Refresh +5~6
		main={ name="Musa", augments={'Path: C',}}, --(Mpaca's Staff)
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		ammo="Ghastly Tathlum +1", --(Homiliary)
		head="Befouled Crown", --Refresh +1 (Null Masque)
		body="Shamash Robe", --Refresh +3, PDT -10
		hands="Nyame Gauntlets", --DT -7
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Carrier's Sash", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	}
		
  -- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {
		head="Befouled Crown", --(Null Masque)
		--left_ring="Stikini Ring +1",
		--right_ring="Stikini Ring +1",
	})

  -- Regen Set
    sets.idle.Regen = set_combine(sets.idle, {})

  -- Misc. idle sets
	sets.Resting = sets.idle
	sets.latent_refresh = {} --waist="Fucho-no-obi"
	sets.latent_refresh_grip = {sub="Oneiros Grip"} 
	sets.TPEat = {} --neck="Chrys. Torque"
	sets.DayIdle = {}
	sets.NightIdle = {}
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- ### Damage Taken Sets ###
--------------------------------------
    sets.defense.PDT = { --DT -55/50
		main={ name="Musa", augments={'Path: C',}},
		sub="Oneiros Grip",
		ammo="Ghastly Tathlum +1", --(Staunch Tathlum +1)
		head="Nyame Helm", --DT -7 (Null Masque)
		body="Nyame Mail", --DT -9 (Adamantite Armor)
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6 (Aug to R15)
		waist="Carrier Sash",
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna +1", 
		left_ring="Murky Ring", --DT -10
		right_ring="Archon Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	}

  -- Magical damage taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		right_ear="Lugalbanda Earring",
		right_ring="Archon Ring",
	})
	
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		waist="Plat. Mog. Belt", --(Null Belt)
		--left_ear="Eabani Earring",
		right_ear="Lugalbanda Earring",
		--back="Null Shawl",
	})

  -- Misc. Defense Sets
	sets.Kiting = {left_ring="Shnedick Ring"}
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Engaged Sets
--------------------------------------
    sets.engaged = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	--sets.engaged.Acc = set_combine(sets.engaged, {})
	--sets.engaged.FullAcc = set_combine(sets.engaged, {})
	--sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
		
  -- Engaged DT set
	sets.engaged.DT = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}

---------------------------------------------------------------------------------------------------------------
-- Weapon & Weaponskill sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gear
--------------------------------------
	sets.weapons.None = {main=empty, sub=empty}
	sets.weapons.Club = {main="Maxentius", sub="Sors Shield"} 
	sets.weapons.Staff = {main={name="Musa", augments={'Path: C',}},sub="Khonsu"}
	sets.weapons.Prime = {main="Opashoro",sub="Khonsu"}

--------------------------------------
-- Default weaponskill gear
--------------------------------------
    sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear="Etiolation Earring",
		left_ring="Murky Ring",
		right_ring="Mujin Band",
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	--sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		--right_ear="Mache Earring +1",
	--})
	
	--sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, {})
	
	--sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		--right_ring="Sroda Ring",
	--})

--------------------------------------
-- Club weaponskills
--------------------------------------
-- Black Halo
	--sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
		--neck="Fotia Gorget",
		--waist="Fotia Belt",
		--right_ear="Regal Earring",
		--right_ring="Metamor. Ring +1",
	--})
	
-- Realmrazer
	--sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	
--------------------------------------
-- Staff weaponskills
--------------------------------------
-- Cataclysm
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {})
	
-- Myrkr
	--sets.precast.WS['Myrkr'] = set_combine(sets.precast.WS, {})
	
-- Omniscience
	--sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {})
	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------	
--------------------------------------
-- Gear worn when a buff is active
--------------------------------------
	sets.buff['Alacrity'] = {feet="Peda. Loafers +3"} -- (Upgrade to +4)
	sets.buff['Celerity'] = {feet="Peda. Loafers +3"} --(Upgrade to +4)
	sets.buff['Dark Arts'] = {body="Acad. Gown +3"} --(Upgrade to +4)
	sets.buff['Klimaform'] = {feet="Arbatel Loafers +2"} --(Upgrade to +4)
	sets.buff['Light Arts'] = {legs="Acad. Pants +2"} --(Upgrade to +4) 
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +2"} --(Upgrade to +3)
    sets.buff['Immanence'] = {hands="Arbatel Bracers +2"} --(Upgrade to +3)
	sets.buff['Parsimony'] = {legs="Arbatel Pants +2"} --(Upgrade to +3)
	sets.buff['Penury'] = {legs="Arbatel Pants +2"} --(Upgrade to +3)
	sets.buff['Perpetuance'] = {hands="Arbatel Bracers +2"} --(Upgrade to +3)
	sets.buff['Rapture'] = {head="Arbatel Bonnet +2"} --(Upgrade to +3)
    
--------------------------------------
-- Gear that converts elemental damage done to recover MP.
--------------------------------------
	sets.RecoverMP = {}

--------------------------------------
-- Vs. Debuffs
--------------------------------------
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
	})

  --Sleep
	sets.buff.Sleep = {main="Opashoro"}
	
--------------------------------------
-- Sublimation
--------------------------------------
    sets.buff.Sublimation = {
		head="Acad. Mortar. +3", --(Upgrade to +4)
		body="Peda. Gown +3", --(Upgrade to +4)
		waist="Embla Sash",
	}
end

--------------------------------------
-- Select default macro book on initial load or subjob change.
--------------------------------------
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 18)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 18)
	elseif player.sub_job == 'WHM' then
		set_macro_page(3, 18)
	else
		set_macro_page(1, 18)
	end
end