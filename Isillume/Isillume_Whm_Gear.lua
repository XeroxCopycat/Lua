-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow', 'PDL')
    state.CastingMode:options('Normal', 'Resistant', 'SIRD')
    state.IdleMode:options('Normal', 'Refresh', 'RefreshDT', 'Regen', 'RegenDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'BlackHalo')
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
    sets.precast.FC = { --Fast Cast +62~64, Quick Cast +7%
		--main="Queller Rod", -- (Cait Palug Hammer)
		--sub="Archduke's Shield", -- (Chanter's Shield)
		ammo="Impatiens", --Quick Cast +2
		head="Ebers Cap +2", --Fast Cast +10
		body="Inyanga Jubbah +2", --Fast Cast +14
		hands="Ebers Mitts +2", --Damage Taken -10% (Fanatic Gloves with Fast Cast +7)
		legs="Volte Brais", --Fast Cast +8
		feet="Regal Pumps +1", --Fast Cast +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --Fast Cast +10
		waist="Witful Belt", --Fast Cast +3, Quick Cast +3
		left_ear="Alabaster Earring", --Damage Taken -5% (Malignance Earring)
		right_ear="Loquac. Earring", --Fast Cast +2
		left_ring="Murky Ring", --Damage Taken -10%
		right_ring="Lebeche Ring", --Quick Cast +3%
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --Fast Cast +10 (Preimede Cape)
	}
    
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, { --FC +54~56, QC +7%, HMCT -19% (73-75)
		main="Vadose Rod",
		legs="Ebers Pant. +3",
	})
	
  -- Fast cast for specific spells
	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], { --FC +39, QC +7, Cure Spellcasting Time -27%, Healing Magic Cast Time -19% (80) 
		main="Vadose Rod", --HMCT -5%
		sub="Sors Shield", --CST -5%
		head="Piety Cap +3", --CST -12%
		legs="Ebers Pant. +3", --HMCT -14%
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --CST -7%
		left_ear="Nourish. Earring", --CST -3%
	})
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {})
	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {})
	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

-- ### STEP SET FOR /DNC ###
	sets.precast.Steps = {}

-- ### WALTZ SET FOR /DNC (CHA + VIT) ###
    sets.precast.Waltz = {
		ammo="Impatiens",
		head="Piety Cap +3",
		body="Ebers Bliaut +3",
		hands="Piety Mitts +3",
		legs="Ebers Pant. +3",
		feet="Piety Duckbills +3",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Mephitas's Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}

-----------------------------------------------------------------------------------------------------------
-- Midcast Sets
-----------------------------------------------------------------------------------------------------------
-- ### FAST RECAST ### 
	sets.midcast.FastRecast = { --FC +60~62
		ammo="Impatiens", --Quick Cast +2
		head="Ebers Cap +2", --Fast Cast +10
		body="Inyanga Jubbah +2", --Fast Cast +14
		hands="Ebers Mitts +2", --Damage Taken -10% (Fanatic Gloves with Fast Cast +7)
		legs="Volte Brais", --Fast Cast +8
		feet="Regal Pumps +1", --Fast Cast +5~7
		neck={ name="Clr. Torque +2", augments={'Path: A',}}, --Fast Cast +10
		waist="Witful Belt", --Fast Cast +3, Quick Cast +3
		left_ear="Alabaster Earring", --Damage Taken -5% (Malignance Earring)
		right_ear="Loquac. Earring", --Fast Cast +2
		left_ring="Murky Ring", --Damage Taken -10%
		right_ring="Lebeche Ring", --Quick Cast +3%
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --Fast Cast +10 (Preimede Cape)
	}
	
-- ## DARK MAGIC ## 
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		body="Ebers Bliaut +2",
		hands="Inyan. Dastanas +2",
		legs="Ebers Pant. +3",
		feet="Inyan. Crackows +2",
		waist="Refoccilation Stone",
		right_ear="Magnetic Earring",
		left_ring="Murky Ring", --(Evanescence Ring)
		right_ring="Archon Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
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
		
-- ### DIVINE MAGIC ### 
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands={ name="Fanatic Gloves", augments={'MP+10','Healing magic skill +2','"Conserve MP"+1',}},
		legs="Ebers Pant. +3",
		feet="Inyan. Crackows +2",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Refoccilation Stone",
		right_ring="Inyanga Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
	})
	
  -- Specific Divine Magic Spells
	sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {})
	sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], {hands="Piety Mitts +3"})
	sets.midcast.Repose = set_combine(sets.midcast['Divine Magic'], {hands="Piety Mitts +3"})

-- ### ELEMENTAL MAGIC ### 
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands={ name="Fanatic Gloves", augments={'MP+10','Healing magic skill +2','"Conserve MP"+1',}},
		legs="Ebers Pant. +3",
		feet="Inyan. Crackows +2",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Refoccilation Stone",
		right_ear="Sortiarius Earring",
		right_ring="Inyanga Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
	})
	
	sets.midcast['Elemental Magic'].Resistant = {}

  -- Specific Elemental Magic Spells
	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast.Impact = {}

-- ### ENFEEBLING MAGIC ### 
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Maxentius",
		sub="Archduke's Shield",
		body="Theo. Bliaut +3",
		hands="Piety Mitts +3",
		legs="Ebers Pant. +3",
		feet="Piety Duckbills +3",
		waist="Refoccilation Stone",
		right_ring="Inyanga Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
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
			
-- ### ENHANCING MAGIC ### 
	sets.midcast['Enhancing Magic'] = {
		ammo="Impatiens",
		head="Ebers Cap +2",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs="Piety Pantaln. +3",
		feet="Ebers Duckbills +2",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Lebeche Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}

  -- Specific Enhancing magic spells
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +2"})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod", legs="Shedir Seraweels"})
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands="Ebers Mitts +2",
	})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {feet="Theo. Duckbills +2",	right_ring="Sheltered Ring"})
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], { --Regen Potency +66, Regen Duration +43, Enh. Magic Duration +5% 
		head="Inyanga Tiara +2", --Regen pot. +14
		body="Piety Bliaut +3", --Regen pot. +52
		hands="Ebers Mitts +1", --Regen duration +22
		legs="Th. Pant. +3", --Regen duration +24
		feet="Theo. Duckbills +2", --Enhancing magic duration +5%
	})

	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {feet="Theo. Duckbills +2", right_ring="Sheltered Ring"})
	sets.midcast.Shellra = sets.midcast.Shell
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels", feet="Theo. Duckbills +2"})

-- ### HEALING MAGIC ###
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecast, { 
		main="Raetic Rod +1", 
		sub="Archduke's Shield",
		ammo="Impatiens", --(Pemphredo Tathlum)
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Ebers Bliaut +3",
		hands="Theophany Mitts +3", --(Upgrade to +4)
		legs="Ebers Pant. +3",
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt", --(Hachirin-no-Obi)
		left_ear="Alabaster Earring", --(Glorious Earring)
		right_ear="Magnetic Earring",
		left_ring="Murky Ring", --(Janniston Earring)
		right_ring="Mephitas's Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	})
	
  -- Specific healing magic spells
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], {})
	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'], { --Cursna +112, Divine Veil +22
		main="Vadose Rod",
		head="Ebers Cap +2",
		body="Ebers Bliaut +3",
		hands={ name="Fanatic Gloves", augments={'MP+10','Healing magic skill +2','"Conserve MP"+1',}},
		legs="Th. Pant. +3",
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Debilis Medallion",
		left_ring="Haoma's Ring",
		right_ring="Mephitas's Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	})

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {})
	sets.midcast['Full Cure'] = sets.midcast.FastRecast['Healing Magic']
	sets.midcast.StatusRemoval = set_combine(sets.midcast['Healing Magic'], {
		head="Ebers Cap +2", --Divine Veil +24
	}) 
  
-- ## MISC. MIDCAST SETS ##
    sets.Kiting = {}
    sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
-- ## SITUATIONAL SETS: GEAR THAT IS EQUIPPED ON CERTAIN TARGETS ##
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

-- ## CONSERVE MP SET ##
	sets.ConserveMP = { --Conserve MP +17
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, 
		left_ear="Magnetic Earring", 
		back="Solemnity Cape",
	}
	
	sets.midcast.Teleport = sets.ConserveMP
	
-- ### MAGIC BURST ###
    sets.MagicBurst = {
		right_ring="Mujin Band",
	}
		
-----------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
-----------------------------------------------------------------------------------------------------------
-- ### IDLE SETS ###
	sets.idle = {
		main="Queller Rod", 
		sub="Archduke's Shield",
		ammo="Impatiens", --(Homiliary)
		head="Inyanga Tiara +2", --(Null Masque)
		body="Ebers Bliaut +3",
		hands="Inyan. Dastanas +2", --(Chironic Hands w/ Refresh +2)
		legs="Assid. Pants +1", --(Chironic Legs w/ Refresh +2)
		feet="Inyan. Crackows +2", --(Chironic Feet w/ Refresh +2)
		neck="Warder's Charm +1", --(Sibyl Scarf)
		waist="Witful Belt", --(Null Belt)
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1", 
		left_ring="Inyanga Ring", --(Gurebu's Ring)
		right_ring="Shneddick Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --(Ambu cape w/ regen +5)
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {})
	sets.idle.Regen = set_combine(sets.idle, {})

-- ## RESTING SETS ##
	sets.resting = set_combine(sets.idle, {})

-----------------------------------------------------------------------------------------------------------
-- Defense Sets
-----------------------------------------------------------------------------------------------------------
-- ### DAMAGE TAKEN ###
	sets.defense.PDT = {
		ammo="Impatiens",
		head="Ebers Cap +2",
		body="Ebers Bliaut +3",
		hands="Ebers Mitts +2",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +2",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Archon Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {})
	
  -- Magic evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {})

-----------------------------------------------------------------------------------------------------------
-- Engaged Sets
-----------------------------------------------------------------------------------------------------------
-- ## ENGAGED SETS, SINGLE WIELD ##
	sets.engaged = {
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
    sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		head="Ebers Cap +2",
		body="Ebers Bliaut +3",
		hands="Ebers Mitts +2",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +2",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Dominance Earring",
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	})
	
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	sets.engaged.PDL = set_combine(sets.engaged, {})
	
  -- Engaged hybrid DT set
	sets.engaged.DT = set_combine(sets.engaged, {})
	
-- ### ENGAGED SETS, DUAL WIELD ###
	sets.engaged.DW = {}
    sets.engaged.DW.Acc = {}

-----------------------------------------------------------------------------------------------------------
-- Weapon sets
-----------------------------------------------------------------------------------------------------------
-- ### Weapons sets ###
	sets.weapons.None ={main=empty, sub=empty}
	sets.weapons.BlackHalo = {main="Maxentius", sub="Archduke's Shield"}

-----------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-----------------------------------------------------------------------------------------------------------
-- ### Default weaponskill sets ###
    --sets.precast.WS = {}
    --sets.precast.WS.PDL = {}

  -- Club weaponskills
    --sets.precast.WS['Flash Nova'] = {}

  -- Staff weaponskills
    --sets.precast.WS['Mystic Boon'] = {}

-----------------------------------------------------------------------------------------------------------
-- Misc. Sets
-----------------------------------------------------------------------------------------------------------
-- Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +2"}
	
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