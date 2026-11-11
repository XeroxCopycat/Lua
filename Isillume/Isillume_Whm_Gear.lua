-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow', 'PDL')
    state.CastingMode:options('Normal', 'Resistant', 'SIRD')
    state.IdleMode:options('Normal', 'Refresh', 'RefreshDT', 'Regen', 'RegenDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'BlackHalo', 'Cataclysm')
	state.WeaponskillMode:options('Normal', 'Fodder')

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

-----------------------------------------------------------------------------------------------------------
-- Start Defining the Sets
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-- Precast Sets
-----------------------------------------------------------------------------------------------------------
-- ### PRECAST SETS TO ENHANCE JAS ###
    sets.precast.JA.Benediction = {body="Piety Bliaut +3"} --(Upgrade to +4)
	sets.precast.JA.Devotion = {head="Piety Cap +3"} --(Upgrade to +4)
	sets.precast.JA.Martyr = {hands="Piety Mitts +3"} --(Upgrade to +4)

-- ### FAST CAST SETS FOR SPELLS ###	
    sets.precast.FC = { --FC +69~71, QC +7
		--main="Queller Rod", -- (Cait Palug Hammer)
		--sub="Archduke's Shield", -- (Chanter's Shield)
		ammo="Impatiens", --QC +2
		head="Ebers Cap +3", --FC +13
		body="Inyanga Jubbah +2", --MDT -8, FC +14
		hands={ name="Fanatic Gloves", augments={'MP+5','Healing magic skill +2','"Fast Cast"+1',}}, --FC +1 (Aug. w/ FC +7)
		legs="Volte Brais", --FC +8
		feet="Regal Pumps +1", --FC +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --FC +10
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5% (Malignance Earring)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Kishar Ring", --FC +4
		right_ring="Lebeche Ring", --QC +3%
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10 (Preimede Cape)
	}
    
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, { --FC +61~63, QC +7%, HMCT -20% (73-75)
		main="Vadose Rod", --Heal. Magic Cast Time -5%
		legs="Ebers Pant. +3", --Heal. Magic Cast Time -15%
	})
	
  -- Fast cast for specific spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], { --FC +61~63, QC +7%, HMCT -20%  
		main="Vadose Rod", --HMCT -5%
		legs="Ebers Pant. +3", --HMCT -16%
	})
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})
	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {})
	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

-- ### STEP SET FOR /DNC (Acc) ###
	sets.precast.Steps = {}

-- ### WALTZ SET FOR /DNC (CHA + VIT) ###
    sets.precast.Waltz = { --Base Acc 1249
		head="Ebers Cap +3",
		body="Ebers Bliaut +3",
		hands="Ebers Mitts +3",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +3",
		neck="Loricate Torque +1",
		waist="Null Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Ebers Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

-----------------------------------------------------------------------------------------------------------
-- Midcast Sets
-----------------------------------------------------------------------------------------------------------
-- ### Fast Recast ### 
	sets.midcast.FastRecast = { --FC +69~71, QC +7
		ammo="Impatiens", --QC +2
		head="Ebers Cap +3", --FC +13
		body="Inyanga Jubbah +2", --MDT -8, FC +14
		hands={ name="Fanatic Gloves", augments={'MP+5','Healing magic skill +2','"Fast Cast"+1',}}, --FC +1 (Aug. w/ FC +7)
		legs="Volte Brais", --FC +8
		feet="Regal Pumps +1", --FC +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --FC +10
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5% (Malignance Earring)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Kishar Ring", --FC +4
		right_ring="Lebeche Ring", --QC +3%
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --FC +10 (Preimede Cape)
	}
	
-- ## Dark magic ## 
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius", --MAcc +40, Magic Acc. Skill +250
		sub="Ammurapi Shield", --MAcc +38
		ammo="Staunch Tathlum +1", --DT -3
		head="Ebers Cap +3", --MAcc +61
		body="Ebers Bliaut +3", --MAcc +64
		hands="Inyan. Dastanas +2", --MDT -4, MAcc +43, All magic skills +20
		legs="Ebers Pant. +3", --DT -13, MAcc +63
		feet="Ebers Duckbills +3", --DT -11, MAcc +60
		neck="Erra Pendant", --Dark magic skill +10 (Null Loop)
		waist="Null Belt", --MAcc +30
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30)
		right_ear="Magnetic Earring", 
		left_ring="Metamor. Ring +1", --MAcc +11~15
		right_ring="Archon Ring", --Dark elemental: MAB +5/MAcc +5
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --MAcc +20 (Null Shawl)
	})

  -- Specific Dark Magic spells
	sets.midcast.Bio = set_combine(sets.midcast['Dark Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Dark Magic']
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Drain.Resistant = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'], {})
		
-- ### Divine Magic ### 
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius", --MAcc +40, Magic Acc. Skill +250
		sub="Ammurapi Shield", --MAcc +38
		ammo="Staunch Tathlum +1", --DT -3
		head="Ebers Cap +3", --MAcc +61
		body="Ebers Bliaut +3", --MAcc +64
		hands="Inyan. Dastanas +2", --MDT -4, MAcc +43, All magic skills +20
		legs="Ebers Pant. +3", --DT -13, MAcc +63
		feet="Ebers Duckbills +3", --DT -11, MAcc +60
		neck="Erra Pendant", --MAcc +17 (Null Loop)
		waist="Null Belt", --MAcc +30
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30)
		right_ear="Magnetic Earring", 
		left_ring="Metamor. Ring +1", --MAcc +11~15
		right_ring="Archon Ring", --Dark elemental: MAB +5/MAcc +5
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --MAcc +20 (Null Shawl)
	})
	
  -- Specific Divine Magic Spells
	sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {})
	sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], {hands="Piety Mitts +3"})
	sets.midcast.Repose = set_combine(sets.midcast['Divine Magic'], {hands="Piety Mitts +3"})

-- ### Elemental Magic ### 
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius", --MAcc +40, Magic Acc. Skill +250
		sub="Ammurapi Shield", --MAcc +38
		ammo="Staunch Tathlum +1", --DT -3
		head="Nyame Helm", --DT -7, MAcc +40, MAB +30
		body="Nyame Mail", --DT -9, MAcc +40, MAB +30
		hands="Nyame Gauntlets", --DT -7, MAcc +40, MAB +30
		legs="Nyame Flanchard", --DT -8, MAcc +40, MAB +30
		feet="Nyame Sollerets", --DT -7, MAcc +40, MAB +30
		neck="Erra Pendant", --MAcc +17
		waist="Null Belt", --MAcc +30
		left_ear="Alabaster Earring", --DT -5 (Malignance Earring)
		right_ear="Sortiarius Earring", --MAB +6 (Friomisi Earring)
		left_ring="Metamor. Ring +1", --MAcc +11~15
		right_ring="Stikini Ring +1", --MAcc +11, All magic skills +8
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --MAcc +20, MAB +10 (Alaunus's Cape: INT +30, MAcc/MDmg +20, MAB +10, DT -5)
	})
	
	sets.midcast['Elemental Magic'].Resistant = {}

  -- Specific Elemental Magic Spells
	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast.Impact = {}

-- ### Enfeebling Magic ### 
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius", --MAcc +40, Magic Acc. Skill +250
		sub="Ammurapi Shield", --MAcc +38
		ammo="Staunch Tathlum +1", --DT -3, SIRD 11%
		head="Ebers Cap +3", --MAcc +61
		body="Theo. Bliaut +3", --MAcc +50, Enf. Magic Skill +21
		hands="Piety Mitts +3", --MAcc +38, Enf. Magic Skill +26
		legs="Ebers Pant. +3", --DT -13, MAcc +63
		feet="Theo. Duckbills +4", --MAcc +56, Enf. Magic Skill +22, SIRD 29%
		neck="Erra Pendant", --MAcc +17
		waist="Null Belt", --MAcc +30
		left_ear="Alabaster Earring", --DT -5
		right_ear="Magnetic Earring", --Conserve MP +5, SIRD +8%
		left_ring="Metamor. Ring +1", --MAcc +11~15
		right_ring="Stikini Ring +1", --MAcc +11, All Magic skills +8
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --MAcc +20
	})
	
	sets.midcast['Enfeebling Magic'].Resistant = {}

  -- Specific enfeebling magic sets
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Dispel = {}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
			
-- ### Enhancing Magic ### 
	sets.midcast['Enhancing Magic'] = {
		main="Maxentius",
		sub="Ammurapi Shield", --Enh. Magic duration +10%
		ammo="Staunch Tathlum +1", --DT -3, SIRD 11%
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Inyan. Dastanas +2", --MDT -4, All Magic Skills +20
		legs="Piety Panta. +4", --Enh. Magic skill +27
		feet="Ebers Duckbills +3", --DT -11, Enh. Magic skill +35
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, 
		waist="Olympus Sash", --Enh. Magic Skill +5 (Embla Sash)
		left_ear="Alabaster Earring", --DT -5
		right_ear="Magnetic Earring", --Conserve MP +5, SIRD 8%
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --All magic skills +8
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --DT -4
	}

  -- Specific Enhancing magic spells
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +3"}) --Auspice +19
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod", legs="Shedir Seraweels"}) --Aquaveil +2
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		head="Ebers Cap +3", --Set (x4 pieces): Augments elemental resistance spells
		body="Ebers Bliaut +3", 
		hands="Ebers Mitts +3",
		legs="Piety Panta. +4", --Ele. resistance magic +36
		feet="Ebers Duckbills +3",
	})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {feet="Theo. Duckbills +3",	right_ring="Sheltered Ring"}) --Enh. magic duration +20%
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], { --Regen pot. +66, Regen dur. +48, Enh. magic duration +20%
		head="Inyanga Tiara +2", --Regen pot. +14
		body="Piety Bliaut +3", --Regen pot. +52
		hands="Ebers Mitts +2", --Regen dur.+24
		legs="Th. Pant. +3", --Regen dur. +24
		feet="Theo. Duckbills +4", --Enhancing magic duration +10%
	})

	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {feet="Theo. Duckbills +4", right_ring="Sheltered Ring"})
	sets.midcast.Shellra = sets.midcast.Shell
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir Seraweels", --Stoneskin +35
		feet="Theo. Duckbills +4", --Enh. magic duration +10%
		neck="Nodens Gorget", --Stoneskin +30
		--waist="Siegel Sash", 
	})

-- ### Healing Magic ###
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecast, {  --DT -31, Cure Pot. +50%, Cure Pot. II +24%, Enmity -50, Conserve MP +16
		main="Raetic Rod +1", --Cure Pot. +23%, Cure Pot. II +10%, Cure effect +50, Cure MP consumed +30%
		sub="Thuellaic Ecu +1", --Conserve MP +4
		ammo="Staunch Tathlum +1", --DT -3, SIRD 11%
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Set (x2 Pieces): Cure Pot. II, +4%, Cure pot. +11%, Enmity -6 
		body="Theo. Bliaut +3", --Cure Pot. II +6%, Enmity -6
		hands="Theophany Mitts +3", --Cure Pot. II +4%, Heal. magic skill +21, Enmity -7,
		legs="Ebers Pant. +3", --DT -13, Divine Benison effect +4, Convert 8% of "Cure" ammount to MP
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Cure Pot. +11%, Enmity -6, Conserve MP +7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --Cure Pot. +10%, Enmity -25, Erase effect +1
		waist="Carrier's Sash", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Magnetic Earring", --Conserve MP +5, SIRD 8%
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --All magic skills +8
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, 
	})
	
  -- Specific healing magic spells
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], {})
	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'], { --DT -5, Cursna +101, Heal. magic skill +77, Divine Veil +28
		head="Ebers Cap +3", --Divine Veil +26
		body="Ebers Bliaut +3", --Heal. magic skill +34
		hands={ name="Fanatic Gloves", augments={'MP+5','Healing magic skill +2','"Fast Cast"+1',}}, --Cursna +15
		legs="Th. Pant. +3", --Cursna +21
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Cursna +5, Heal. magic skill +20
		neck="Debilis Medallion", --Cursna +15 
		waist="Carrier's Sash", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Magnetic Earring", --Conserve MP +5, SIRD 8%
		left_ring="Menelaus's Ring", --Cursna +20, Heal. magic skill +15
		right_ring="Haoma's Ring", --Cursna +15, Heal. magic skill +8
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --DT -4, Cursna +25
	})

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {})
	sets.midcast['Full Cure'] = sets.midcast.FastRecast['Healing Magic']
	sets.midcast.StatusRemoval = set_combine(sets.midcast['Healing Magic'], {
		head="Ebers Cap +3", --Divine Veil +26
	}) 

-- ### Conserve MP ###
	sets.ConserveMP = { --Conserve MP +27
		sub="Thuellaic Ecu +1", --Conserve MP +4
		head="Vanya Hood", --Conserve MP +6
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Conserve MP +7 
		left_ear="Magnetic Earring", --Conserve MP +5
		back="Solemnity Cape", --Conserve MP +5
	}
	
	sets.midcast.Teleport = sets.ConserveMP
	
-- ### Magic Burst ###
    sets.MagicBurst = {
		right_ring="Mujin Band",
	}

-- ## Misc. Midcast Sets ##
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
-- ## Situational sets, equiped in response to a spell or effect received ##
	sets.Cure_Received = {waist="Gishdubar Sash"} --Cure effect received +10%
	sets.Phalanx_Received = {}
	sets.Self_Healing = {waist="Gishdubar Sash"} 
	sets.Self_Refresh = {feet="Inspirited Boots", waist="Gishdubar Sash"} --Refresh duration received +35

-----------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-----------------------------------------------------------------------------------------------------------
-- ### Idle sets ###
	sets.idle = { --DT -50, Regen +8, Refresh +9~10
		main="Queller Rod", --Refresh +1
		sub="Archduke's Shield", --Refresh +1
		ammo="Staunch Tathlum +1", --DT -3
		head="Befouled Crown", --Refresh +1 (Null Masque)
		body="Ebers Bliaut +3", --Refresh +4, Regen +5
		hands="Ebers Mitts +3", --DT -11
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Ebers Duckbills +3", --DT -11
		neck="Loricate Torque +1", --DT -6 (Sibyl Scarf)
		waist="Null Loop", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna +1", --(Infused Earring)
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --Refresh +1 (Gurebu's Ring)
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --DT -4
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {
		hands="Inyan. Dastanas +2", --Set (x3 pieces): Refresh +2
		feet="Inyan. Crackows +2",
		left_ring="Inyanga Ring",
		right_ring="Stikini Ring +1", --Refresh +1
	})
	
	sets.idle.Regain = set_combine(sets.idle, {
		--head="Null Masque", --Regen +3, Refresh +1
	})
	
	sets.idle.Regen = set_combine(sets.idle, {
		--neck="Bathy Gorget +1", --Regen +3
		--head="Null Masque", --Regen +3, Refresh +1
		waist="Null Loop", --Regen +3
		left_ring="Sheltered Ring", --Regen +1
		--right_ring="Gurebu's Ring" --Regen +2/Refresh +2
	})

-- ## Resting sets ##
	sets.resting = { --MP recovered while healing +10, Regen +5, Refresh +10~11
		main="Chatoyant Staff", --MP recovered while healing +10
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		ammo="Staunch Tathlum +1", --(Homiliary)
		head="Inyanga Tiara +2", --Set (x4 pieces): Refresh +3
		body="Ebers Bliaut +3", --Regen +5, Refresh +4
		hands="Inyan. Dastanas +2", 
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Inyan. Crackows +2", 
		neck="Loricate Torque +1", --(Sibyl Scarf)
		waist="Fucho-no-Obi", --Latent: Refresh +1
		left_ear="Alabaster Earring", --
		right_ear="Arete del Luna +1", --(Infused Earring)
		left_ring="Inyanga Ring",
		right_ring="Stikini Ring +1", --Refresh +1 (Gurebu's Ring)
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}}, --(Alanus's Cape: MND +30, Eva/MEva +20, FC +10, Regen +5)
	}
	
-- ## Misc. idle set swaps ##
	sets.Kiting = {right_ring="Shneddick Ring"}
    sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}


-----------------------------------------------------------------------------------------------------------
-- Defense Sets
-----------------------------------------------------------------------------------------------------------
-- ## Physical damage taken ##
	sets.defense.PDT = { --Base Def 1518, DT -50
		ammo="Staunch Tathlum +1", --DT -3
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Carrier's Sash", --Elemental resists +15
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna +1", 
		left_ring="Murky Ring", --DT -10
		right_ring="Archon Ring", --(Warden's Ring)
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	}
	
  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
  -- Magic evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		head="Ebers Cap +3",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +3",
		waist="Carrier's Sash",
		waist="Null Belt",
		left_ring="Inyanga Ring",
	})

-----------------------------------------------------------------------------------------------------------
-- Engaged Sets
-----------------------------------------------------------------------------------------------------------
-- ## Engaged set, single wield ##
	sets.engaged = { --Acc 1271, DT -50, DA +8, Store TP +29 
		ammo="Staunch Tathlum +1", --DT -3
		head="Aya. Zucchetto +2", --DT -3, Store TP +6
		body="Ayanmo Corazza +2", --DT -6, DA +7
		hands="Ebers Mitts +3", --DT -11
		legs="Ebers Pant. +3", --DT -13
		feet="Ebers Duckbills +3", --DT -11
		neck="Warder's Charm +1", 
		waist="Null Belt", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Neritic Earring", --Store TP +4
		left_ring="Petrov Ring", --DA +1, Store TP +4
		right_ring="Rajas Ring", --Store TP +5
		back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --Store TP +10
	}
	
    sets.engaged.Acc = set_combine(sets.engaged, {
		ead="Ebers Cap +3",
		body="Ebers Bliaut +3",
	})
	
	sets.engaged.PDL = set_combine(sets.engaged, {})
	
	
-- ## Engaged set, hybrid DT (Default set has DT -50) ##
	sets.engaged.DT = set_combine(sets.engaged, {})
	
	
-- ## Misc. engaged sets (applied on top of engaged sets) ###
	sets.DWMid = {right_ear="Suppanomimi"} --Dual wield +5
    sets.DWMax = {}
	sets.SubtleBlow = {right_ring="Rajas Ring"} --Subtle Blow +5

-----------------------------------------------------------------------------------------------------------
-- Weapon sets
-----------------------------------------------------------------------------------------------------------
-- ## Weapons sets ##
	sets.weapons.None ={main=empty, sub=empty}
	sets.weapons.BlackHalo = {main="Maxentius", sub="Archduke's Shield"}
	sets.weapons.Cataclysm = {main="Chatoyant Staff", sub="Benthos Grip"}

-----------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-----------------------------------------------------------------------------------------------------------
-- ## Default weaponskill sets ##
    --sets.precast.WS = {}
    --sets.precast.WS.PDL = {}

  -- Club weaponskills
	--sets.precast.WS['Black Halo'] = {}
	--sets.precast.WS['Flash Nova'] = {}

  -- Staff weaponskills
    --sets.precast.WS['Mystic Boon'] = {}

-----------------------------------------------------------------------------------------------------------
-- Misc. Sets
-----------------------------------------------------------------------------------------------------------
-- Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +3"}
	
	
-- Reive mark, worn within colonization/lair reives
	sets.buff["Reive Mark"] = set_combine(sets.buff["Reive Mark"], {neck="Arciela's Grace +1"})


-- Sublimation for /SCH
    sets.buff.Sublimation = {}
    sets.buff.DTSublimation = {}


-- Vs. Debuffs
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 1)
end

autows_list = {['BlackHalo']='BlackHalo'}