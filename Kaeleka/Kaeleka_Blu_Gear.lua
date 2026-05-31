function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow', 'Fodder')
	state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc', 'SubtleBlow', 'Fodder')
    state.CastingMode:options('Normal', 'SIRD', 'MAcc', 'FullMacc', 'Fodder')
    state.IdleMode:options('Normal', 'Refresh', 'Regain', 'Regen')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Naegling', 'Archduke', 'Maxentius', 'Casting', 'None', 'ProcSword', 'ProcClub')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons None;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

-------------------------------------------------------------------------------------------------------------------
-- START DEFINING THE SETS
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- PRECAST SETS
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Cast gear
--------------------------------------
	sets.precast.FC = { --Fast Cast +62/80, Quick Cast +3
		ammo="Sapience Orb", --FC +2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		body="Luhlaza Jubbah +3", --FC +9
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Aya. Cosciales +2", --FC +6
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Voltsurge Torque", --FC +4
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Etiolation Earring", --FC +1 --(Enchanter's Earring +1 FC +2)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Rahab Ring", --FC +2
		right_ring="Kishar Ring", --FC +4
		back="Null Shawl", --(Ambu Cape FC +10)
	}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +2"})

--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
	sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +4", feet="Hashi. Basmak +2"}
	sets.buff['Chain Affinity'] = {head="Hashishin Kavuk +3", feet="Assim. Charuqs +2"}
	sets.buff.Convergence = {head="Luh. Keffiyah +3"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
	sets.buff.Enchainment = {body="Luhlaza Jubbah +3"}
	sets.buff.Efflux = {legs="Hashishin Tayt +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.HPDown = {}
	sets.HPCure = {}
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +3"}

--------------------------------------
-- Waltz sets for /DNC
--------------------------------------
    sets.precast.Waltz = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Passion Jacket",
		hands="Nyame Gauntlets",
		legs="Dashing Subligar",
		feet="Rawhide Boots",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Regal Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back="Null Shawl",
	}
	
	sets.Self_Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

--------------------------------------
-- Step Sets for /DNC
--------------------------------------
	sets.precast.Step = {
		ammo="Hasty Pinion +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Domin. Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
	sets.precast.Flourish1 = set_combine(sets.precast.Step, {
		ammo="Pemphredo Tathlum",
		left_ear="Digni. Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
	})

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast
--------------------------------------
	sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Luhlaza Jubbah +3", --FC +9
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back="Null Shawl", --(Ambu Cape +10 FC)
	}
	
	sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {hands="Hashi. Bazu. +2"})


--------------------------------------
-- Blue Magic Spells
--------------------------------------
-- Blue Magic Spells, Physical
	sets.midcast['Blue Magic'].Physical = {
		ammo="Aurgelmir Orb",
		head="Blistering Sallet +1",
		body="Volte Harness",
		hands="Volte Mittens",
		legs="Luh. Shalwar +4",
		feet="Gleti's Boots",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Odr Earring",
		right_ear="Domin. Earring +1",
		left_ring="Petrov Ring",
		right_ring="Murky Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.midcast['Blue Magic'].Physical.SIRD = {
		ammo="Staunch Tathlum +1", --SIRD -11
		head="Adhara Turban", --SIRD -20
		hands="Rawhide Gloves", --SIRD -15
		legs="Assim. Shalwar +2", --SIRD -22
		feet="Amalric Nails", --SIRD -15
		neck="Loricate Torque +1", --(Augment to R15, SIRD -5)
		--waist="Rumination Sash", --SIRD -10
		left_ring="Evanescence Ring", --SIRD -5
		right_ring="Murky Ring", --SIRD -3
	}
	
	sets.midcast['Blue Magic'].Physical.Resistant = {}
	sets.midcast['Blue Magic'].Physical.Fodder = {}

  -- Physical/Accuracy Based
    sets.midcast['Blue Magic'].PhysicalAcc = {
		ammo="Hasty Pinion +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Alabaster Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder

  -- Physical/STR Based
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {
		right_ring="Sroda Ring",
	})
	
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/DEX Based
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		waist="Kentarch Belt +1",
		left_ear="Odr Earring",
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring",
	})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/VIT Based
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {
		legs="Aya. Cosciales +2",
		neck="Unmoving Collar +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Petrov Ring",
		right_ring="Murky Ring",
	})
	
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/AGI Based
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		waist="Yemaya Belt",
		left_ear="Neritic Earring",
		})
	
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/INT Based
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Sibyl Scarf",
		waist="Acuity Belt +1",
		left_ear="Regal Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back="Aurist's Cape",
	})
	
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/MND Based
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Staunch Tathlum +1",
		body="Cohort Cloak +1",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Plat. Mog. Belt",
		left_ear="Regal Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back="Aurist's Cape",
	})
	
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/CHA Based
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Staunch Tathlum +1",
		body="Cohort Cloak +1",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Chaac Belt",
		left_ear="Regal Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back="Aurist's Cape",
	})
	
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/HP Based
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Ilabrat Ring",
		right_ring="Murky Ring",
		back="Null Shawl",
	})
	
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical Stun-Based Spells
    sets.midcast['Blue Magic'].Stun = {}
	sets.midcast['Blue Magic'].Stun.Resistant = {}
	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun


--------------------------------------
-- Blue Magic Spells, Magical
--------------------------------------
	sets.midcast['Blue Magic'].Magical = {
		ammo="Ghastly Tathlum +1",
		head="Hashishin Kavuk +3",
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu. +2",
		legs="Hashishin Tayt +2",
		feet="Hashi. Basmak +2",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Shiva Ring +1",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
-- Blue Magic Spells, Magical SIRD (SIRD 103/103)
	sets.midcast['Blue Magic'].Magical.SIRD = set_combine(sets.midcast['Blue Magic'], {
		ammo="Staunch Tathlum +1", --SIRD -11
		head="Adhara Turban", --SIRD -20
		hands="Rawhide Gloves", --SIRD -15
		legs="Assim. Shalwar +4", --SIRD -24
		feet="Amalric Nails", --SIRD -15
		neck="Loricate Torque +1", --SIRD -5
		waist="Rumination Sash", --SIRD -10
		right_ring="Murky Ring", --SIRD -3
	})
	
	sets.midcast['Blue Magic'].Magical.MAcc = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].Magical.FullMAcc = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

-- Breath Based Blue Magic Spells
	sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {head="Luh. Keffiyeh +3"})

-- Buffing Blue Magic Spells (Blue Magic Skill +102)
	sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast['Blue Magic'], { 
		head="Luh. Keffiyeh +3", --Blue Magic +17
		body="Assim. Jubbah +3", --Blue Magic +24
		hands="Rawhide Gloves", --Blue Magic +10
		legs="Hashishin Tayt +2", --Blue Magic +28
		feet="Luhlaza Charuqs +3", --Blue Magic +12
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},	--Blue Magic +11
	})
	
	sets.midcast['Blue Magic'].Buff = {}

  -- Specific Blue Magic Buff Spells
	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {
		waist="Gishdubar Sash",
		--back="Grapevine Cape",
	})
	
	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

-- Healing Blue Magic Spells
	sets.midcast['Blue Magic'].UnlockedAoEHealing = {}
	sets.midcast['Blue Magic'].AoEHealing = {}
	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Staunch Tathlum +1",
		head="Adhara Turban",
		body="Hashishin Mintan +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Assim. Shalwar +4",
		feet="Luhlaza Charuqs +3",
		neck="Loricate Torque +1",
		waist="Witful Belt",
		left_ear="Regal Earring",
		right_ear="Alabaster Earring",
		left_ring="Evanescence Ring",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	})
	
	sets.midcast['Blue Magic'].UnlockedHealing = set_combine(sets.midcast['Blue Magic'].Healing, {
		main="Archduke's Sword", 
		sub="Bunzi's Rod",
	})


--------------------------------------
-- Dark Magic Spells
--------------------------------------
	sets.midcast['Dark Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Hashishin Kavuk +3",
		body={ name="Carm. Sc. Mail +1", augments={'MP+80','INT+12','MND+12',}},
		hands="Hashi. Bazu. +2",
		legs="Luh. Shalwar +4",
		feet="Hashi. Basmak +2",
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Regal Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}

--------------------------------------
-- Divine Magic Spells
--------------------------------------
	sets.midcast['Divine Magic'] = {}

--------------------------------------
-- Elemental Magic Spells
--------------------------------------
	sets.midcast['Elemental Magic'] = {}
	sets.midcast['Elemental Magic'].Resistant = {}

--------------------------------------
-- Enfeebling Magic Spells
--------------------------------------
	sets.midcast['Enfeebling Magic'] = {}

--------------------------------------
-- Enhancing Magic Spells
--------------------------------------
	sets.midcast['Enhancing Magic'] = {
		ammo="Staunch Tathlum +1",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Nyame Sollerets",
		neck="Melic Torque",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Evanescence Ring",
		right_ring="Murky Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
-- Specific Enhancing Magic Spells
  -- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels"}) --Amalric Coif +2, Regal Cuffs

  -- Bar-Element
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
  -- Phalanx
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{
		main="Sakpata's Sword",
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
	})
	
  -- Protect/Shell
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

  -- Refresh
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})

  -- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels", waist="Siegel Sash"})

--------------------------------------
-- Healing Magic Spells
--------------------------------------
	sets.midcast.Cure = {
		ammo="Staunch Tathlum +1",
		head="Hashishin Kavuk +3",
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu. +2",
		legs="Hashishin Tayt +2",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Regal Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back="Solemnity Cape",
	}
	
	sets.midcast.UnlockedCure = set_combine(sets.midcast.Cure, {main="Sakpata's Sword", sub="Bunzi's Rod"})

-- Specific Healing Magic Spells
  -- Cursna
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	

--------------------------------------
-- Misc. Magic Sets
--------------------------------------
-- Cure Spells Received
	sets.Cure_Received = {waist="Gishdubar Sash"}

-- Phalanx Received
	sets.Phalanx_Received = { --Phalanx +18
		sub="Sakpata's Sword",
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}},
	}
	
-- Refresh Received
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
-- Magic Burst Set
	sets.MagicBurst = {
		main="Maxentius",
		sub="Bunzi's Rod",
		ammo="Ghastly Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Assim. Shalwar +4",
		feet="Hashi. Basmak +2",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Shiva Ring +1",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
-- Self Healing
	sets.Self_Healing = {waist="Gishdubar Sash"}
	
	
-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
-- Physical damage taken
	sets.defense.PDT = {
		ammo="Eluder's Sachet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		right_ear="Alabaster Earring",
		left_ring="Warden's Ring",
		right_ring="Murky Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

-- Magical damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ring="Archon Ring",
	})

-- Magic evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		left_ring="Shneddick Ring",
		right_ring="Icecrack Ring",
		back="Null Shawl",
	})


-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
-- Base Idle Set
	sets.idle = { --PDT -20, DT -35, Refresh +5, Regain +7
		ammo="Staunch Tathlum +1",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}, --Refresh +1
		body="Hashishin Mintan +2", --Refresh +3
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Sibyl Scarf", --Refresh +1
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
-- Refresh
	sets.idle.Refresh = set_combine(sets.idle, {
		body="Jhakri Robe +2",
		neck="Sibyl Scarf",
		--left_ring="Stikini Ring +1",
		--right_ring="Stikini Ring +1",
	})
	
-- Regen
	sets.idle.Regen = set_combine(sets.idle, {
		neck="Bathy Choker +1",
		left_ear="Dawn Earring",
		right_ring="Chirich Ring +1",
	})
	
-- Regain
	sets.idle.Regain = set_combine(sets.idle, {	body="Gleti's Cuirass"})


-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+29','"Triple Atk."+4','AGI+7','Accuracy+13',}},
		neck="Combatant's Torque", --(Mirage Stole +2)
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
	})
	
	sets.engaged.FullAcc = set_combine(sets.engaged, { --1452 Acc
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	})
	
	sets.engaged.Fodder = set_combine(sets.engaged, {
		waist="Sailfi Belt +1",
		right_ear="Dedition Earring",
		right_ring="Epona's Ring",
		back="Null Shawl",
	})
	
	sets.engaged.DT = set_combine(sets.engaged, {
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		waist="Reiki Yotai",
		right_ring="Murky Ring",
	})
	

---------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gears
--------------------------------------
	sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Hashishin Kavuk +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Petrov Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		right_ring="Chirich Ring +1",
	})
	
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu. +2",
		legs="Luhlaza Shalwar +4",
		neck="Null Loop",
		waist="Kentarch Belt +1",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		right_ring="Chirich Ring +1",
	})
	
	sets.precast.WS.DT = set_combine(sets.precast.WS, {neck="Null Loop", right_ear="Alabaster Earring"})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		legs="Gleti's Breeches", 
		right_ring="Sroda Ring",
	})
	
--------------------------------------
-- Specific Weaponskill gear
--------------------------------------
-- Club Weaponskills
	sets.precast.WS['Black Halo'] = {}
	sets.precast.WS['Flash Nova'] = {}
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Realmrazer'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

-- Sword Weaponskills
  -- Chant du Cygne
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		ammo="Aurgelmir Orb",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		waist="Fotia Belt",
		left_ear="Domin. Earring +1",
		right_ear="Odr Earring",
		left_ring="Epona's Ring",
		right_ring="Murky Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	})
	
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Chant du Cygne'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})
	
  -- Expiacion
	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Expiacion'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

  -- Red Lotus Blade
	sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		hands="Jhakri Cuffs +2",
		legs="Luh. Shalwar +4",
		neck="Erra Pendant",
		waist="Orpheus's Sash",
		right_ear="Regal Earring",
	})
	
	sets.precast.WS['Red Lotus Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Red Lotus Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Red Lotus Blade'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Red Lotus Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})
  
  -- Resquiescat
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Requiescat'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})
	
  -- Sanguine Blade
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		hands="Jhakri Cuffs +2",
		legs="Luh. Shalwar +4",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring", --(Hoxne Earring, Rank 7+)
		right_ring="Archon Ring",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})
  
  -- Savage Blade 
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})


---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
-- Weapons sets
	sets.weapons.Naegling = {main="Naegling", sub="Thibron"}
	sets.weapons.Maxentius = {main="Maxentius", sub="Thibron"}
	sets.weapons.Archduke = {main="Archduke's Sword", sub="Bunzi's Rod"}
	sets.weapons.Casting = {main="Maxentius", sub="Bunzi's Rod"}
	sets.weapons.None = {main=empty, sub=empty}
	
-- Abyssea Proc Sets
	sets.weapons.ProcDagger = {main="Qutrub Knife", sub=empty}
	sets.weapons.ProcSword = {main="Ibushi Shinai", sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament", sub=empty}
	sets.weapons.ProcGreatAxe = {main="Helgoland", sub=empty}
	sets.weapons.ProcScythe = {main="Lost Sickle", sub=empty}
	sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade", sub=empty}
	sets.weapons.ProcKatana = {main="Debahocho", sub=empty}
	sets.weapons.ProcGreatKatana = {main="Zanmato", sub=empty}
	sets.weapons.ProcClub = {main="Soulflayer's Wand", sub=empty}
	sets.weapons.ProcStaff = {main="Ranine Staff", sub=empty}


-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Dual Wield Sets
	sets.DWMid = {}
	sets.DWMax = {}

-- Kiting
	sets.Kiting = {left_ring="Shneddick Ring"}

-- Sets to return to when not performing an action.
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {left_ring="Dawn Earring"}
	sets.NightIdle = {}
	
-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		hands="Volte Bracers",
	})

-- Vs. Debuffs
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
  
  -- Knockback
	sets.Knockback = {}
	
  -- Sleep

-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +4"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 16)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 16)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 16)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 16)
	elseif player.sub_job == 'THF' then
		set_macro_page(2, 16)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 16)
	else
		set_macro_page(6, 2)
	end
end

autows_list = {['Tizbron']='Expiacion',['Tizalmace']='Expiacion',['Almace']='Chant Du Cygne',['MeleeClubs']='Realmrazer',
     ['HybridWeapons']='Sanguine Blade',['Naegbron']='Savage Blade',['Naegmace']='Savage Blade'}