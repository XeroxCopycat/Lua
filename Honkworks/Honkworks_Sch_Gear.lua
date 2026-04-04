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
--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +3"} --
	sets.precast.JA['Enlightenment'] = {body="Peda. Gown +3"} --

--------------------------------------
-- Fast cast sets for spells
--------------------------------------
    sets.precast.FC = { --FC +80/80, DT -21
		main="Marin Staff +1", --FC +3 (Musa)
		sub="Khonsu", --DT -6
		ammo="Ghastly Tathlum +1", --(Sapience Orb)
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Acad. Bracers +2", --FC +7
		legs="Agwu's Slops", --FC +7
		feet="Peda. Loafers +3", --FC +8
		neck="Voltsurge Torque", --FC +5
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Medada's Ring", --FC +10
		right_ring="Murky Ring", --DT -10
		back={ name="Lugh's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --FC +10, DT -5
	}

  -- Grimoire Spellcasting Time
	sets.precast.FC.Arts = set_combine(sets.precast.FC, { --FC +62/80, GST -23
		head="Peda. M.Board +3", --GST -13
		feet="Acad. Loafers +2", --GST -10 (Upgrade to +3/+4)
		right_ring="Kishar Ring", --FC +4
	})

  -- Enhancing Magic Precast
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {}) --waist="Siegel Sash"

  -- Elemental Magic Precast
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

  -- Precast for Specific Spells
	-- Cure
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main="Bunzi's Rod",
		sub="Sors Shield",
	})
    
	sets.precast.FC.Curaga = sets.precast.FC.Cure
  
	-- Dispelga (Requires Daybreak)
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {}) --main="Daybreak", sub="Ammurapi Shield",
  
	-- Impact (Requires Crespcular / Twilight Cloak)
	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {}) --body="Crespcular Cloak",


-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast
--------------------------------------
	sets.midcast.FastRecast = { --FC +80/80
		main="Marin Staff +1", --FC +3 (Musa)
		sub="Khonsu", --DT -6
		ammo="Ghastly Tathlum +1", --(Sapience Orb)
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Acad. Bracers +2", --FC +7
		legs="Agwu's Slops", --FC +7
		feet="Peda. Loafers +3", --FC +8
		neck="Voltsurge Torque", --FC +5
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Medada's Ring", --FC +10
		right_ring="Murky Ring", --DT -10
		back={ name="Lugh's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --FC +10, DT -5
	}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})


--------------------------------------	
-- Divine Magic
--------------------------------------
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {})


--------------------------------------
-- Dark Magic 
--------------------------------------
    sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, { --DMS +8, Potency +40
		main="Marin Staff +1", --(Rubicundity (aug w/ dark magic skill +10))
		sub="Khonsu", --(Ammurapi Shield)
		head="Pixie Hairpin +1",
		body="Acad. Gown +3", --(Merlinic Jubbah (aug w/ drain/aspir potency +11))
		hands="Agwu's Gages", --(Merlinic Dastanas (aug w/ drain/aspir potency +11))
		legs="Peda. Pants +3", --Potency +15
		feet="Agwu's Pigaches", --Potency +20
		neck="Erra Pendant", --Potency +5
		waist="Acuity Belt +1", --(Fucho-no-Obi)
		left_ear="Friomisi Earring", --(Hirudinea Earring)
		right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+7',}}, --(Mani Earring)
		left_ring="Metamor. Ring +1", --(Evanescence Ring)
		right_ring="Medada's Ring", --(Archon Ring)
		back={ name="Bookworm's Cape", augments={'INT+2','Helix eff. dur. +10','"Regen" potency+8',}}, --Dark Magic Skill +8
	})

-- Specific Dark Magic Spells
  -- Drain
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
	
  -- Drain, Resistant
    sets.midcast.Drain.Resistant = set_combine(sets.midcast['Dark Magic'], {})
	
  -- Aspir
    sets.midcast.Aspir = sets.midcast.Drain
	
  -- Aspir, Resistant
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant
	
  -- Kaustra
	sets.midcast.Kaustra = set_combine(sets.midcast['Dark Magic'], {
		main="Bunzi's Rod",
		sub="Sors Shield", --(Ammurapi Shield)
		ammo="Ghastly Tathlum +1", --(Arbatel Bonnet +3)
		head="Peda. M.Board +3", --(Upgrade to +4)
		body="Agwu's Robe", --(Aug to R30)
		legs="Agwu's Slops", --(Aug to R30)
	})

  -- Stun
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		head="Acad. Mortar. +2",
		hands="Acad. Bracers +2",
		legs="Acad. Pants +2",
		feet="Peda. Loafers +3",
		--neck="Argute Stole +2",
		--waist="Witful Belt",
		left_ear="Etiolation Earring",
		--left_ring="Stikini Ring +1",
		--right_ring="Stikini Ring +1,
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})

  -- Stun, Resistant
    sets.midcast.Stun.Resistant = {}


--------------------------------------
-- Elemental Magic
--------------------------------------
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Bunzi's Rod", --(Aug to R30)
		sub="Sors Shield", --Ammurapi Shield
		ammo="Ghastly Tathlum +1", --(Aug to R15)
		head="Agwu's Cap", --(Aug to R30)
		body="Peda. Gown +3", --Arbatel Gown +3
		hands="Agwu's Gages", --(Aug to R30)
		legs="Agwu's Slops", --(Aug to R30)
		feet="Peda. Loafers +3", --Arbatel Loafers +3
		neck="Sibyl Scarf", --Argute Stole +2
		waist="Acuity Belt +1", --Hachirin-no-Obi
		left_ear="Friomisi Earring", --Regal Earring
		right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+7',}}, --Malignance Earring
		left_ring="Medada's Ring", 
		right_ring="Metamor. Ring +1",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})
  
  -- Elemental Magic, Resistant
    sets.midcast['Elemental Magic'].Resistant = {}
		
  -- Elemental Magic, Proc
    sets.midcast['Elemental Magic'].Proc = {}
		
  -- Elemental Magic, Occult Acumen
    sets.midcast['Elemental Magic'].OccultAcumen = {}
		
-- Gear for Magic Burst
  -- Elemental Magic Burst
    sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], {
		head="Peda. M.Board +3",
		body="Agwu's Robe",
		feet="Agwu's Pigaches",
		left_ring="Mujin Band",
	})

  -- Helix Burst
    sets.HelixBurst = set_combine(sets.MagicBurst, {})
		
  -- Helix Burst, Resistant
    sets.ResistantHelixBurst = {}
	
-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}

-- Specific Elemental Magic Spells
  -- Impact
	sets.midcast.Impact = {}
		
  -- Impact, Occult Acumen
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})


--------------------------------------
-- Enhancing Magic
--------------------------------------
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		main={ name="Gada", augments={'"Cure" potency +6%','Mag. Acc.+4','"Mag.Atk.Bns."+2','DMG:+6',}},
		sub="Sors Shield",
		ammo="Ghastly Tathlum +1",
		head="Befouled Crown",
		body="Peda. Gown +3",
		legs="Acad. Pants +1",
		left_ring="Metamor. Ring +1",
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	})

-- Specific Enhancing Spells
  -- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod", 
		legs="Shedir Seraweels",
	})
	
  -- Barspells
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {
		legs="Shedir Seraweels",
	})
	
  -- Protect/Protectra
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = sets.midcast.Protect
  
  -- Regen
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		body={ name="Telchine Chas.", augments={'"Regen" potency+3',}},
		legs={ name="Telchine Braconi", augments={'"Regen" potency+3',}},
		back={ name="Bookworm's Cape", augments={'INT+2','Helix eff. dur. +10','"Regen" potency+8',}},
	})

  -- Refresh
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
  -- Shell/Shellra
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shellra = sets.midcast.Shell
	
  -- Stoneskin
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir Seraweels",
		--waist="Siegel Sash",
	})
	
  -- Storm
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})


--------------------------------------
-- Enfeebling Magic
--------------------------------------
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast, {
		main="Bunzi's Rod",
		sub="Sors Shield",
		ammo="Ghastly Tathlum +1",
		head="Agwu's Cap",
		feet="Agwu's Pigaches",
		neck="Loricate Torque +1",
		waist="Acuity Belt +1",
		left_ear="Lugalbanda Earring",
		right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+7',}},
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
	})
	
  -- Enfeebling Magic, Resistant
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
  -- Elemental Enfeeble
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- Int Based Enfeebles
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	})
	
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

  -- MND Based Enfeebles
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
-- Specific Enfeebling Spells
  -- Dia/Diaga
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	
  -- Bio/Bio II
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

	
--------------------------------------
-- Healing Magic
--------------------------------------
    sets.midcast.Cure = set_combine(sets.midcast.FastRecast, { --Potency +54, CST -21, Skill +82, DT -36
		main="Bunzi's Rod", --Potency +30
		sub="Sors Shield", --Potency +3, CST -3
		ammo="Ghastly Tathlum +1", --(Staunch Tathlum +1)
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Potency +10, CST -7, Skill +20
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --CSt -7, Skill +20
		hands="Nyame Gauntlets", --DT -7
		legs="Acad. Pants +2", --Potency +8, Skill +22
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Potency +5, CST -7, Skill +20
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Lugalbanda Earring", 
		right_ear="Alabaster Earring", --DT -5
		left_ring="Lebeche Ring", --Potency +3
		right_ring="Murky Ring", --DT -10
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	})
		
-- Healing Magic, Lightsday/Light Weather
    sets.midcast.LightWeatherCure = {}
    sets.midcast.LightDayCure = {}

-- Self Healing/Refresh
	sets.Self_Healing = {}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

-- Specific Healing Spells 
  -- Curaga
    sets.midcast.Curaga = sets.midcast.Cure	
    
  -- Cursna
	sets.midcast.Cursna = {
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Potency +5, CST -7, Skill +20
	}
		
  -- Status Removal Spells
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
	
---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Base idle set
--------------------------------------
    sets.idle = { -- DT -50, Refresh +6~7
		main="Marin Staff +1",
		sub="Khonsu", --DT -6
		ammo="Ghastly Tathlum +1", --(Staunch Tathlum +1)
		head="Nyame Helm", --DT -7 (Null Masque)
		body="Jhakri Robe +2", --Refresh +4
		hands="Nyame Gauntlets", --DT -7
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Nyame Sollerets", --DT -7
		neck="Sibyl Scarf", --Refresh +1
		waist="Plat. Mog. Belt", --DT -3 (Null Belt)
		left_ear="Lugalbanda Earring", 
		right_ear="Alabaster Earring", --DT -5
		left_ring="Shneddick Ring", --MS +18%
		right_ring="Murky Ring", --DT -10
		back={ name="Lugh's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	}
		
-- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {
		head="Befouled Crown", --(Null Masque)
		--left_ring="Stikini Ring +1",
		--right_ring="Stikini Ring +1",
	})

-- Regen Set
    sets.idle.Regen = set_combine(sets.idle, {})


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical damage taken -- DT 58/50
--------------------------------------
    sets.defense.PDT = { 
		ammo="Ghastly Tathlum +1", --(Staunch Tathlum +1)
		head="Nyame Helm", -- DT -7 (Aug to R30)
		body="Nyame Mail", -- DT -8 (Aug to R30)
		hands="Nyame Gauntlets", --DT -7 (Aug to R30)
		legs="Nyame Flanchard", --DT -8 (Aug to R30)
		feet="Nyame Sollerets", --DT -7 (Aug to R30)
		neck="Loricate Torque +1", --DT -6
		right_ring="Murky Ring", -- DT -10
		back={ name="Lugh's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	}

  -- Magical damage taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Lugalbanda Earring",
		--left_ring="Archon Ring",
	})
	
  -- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		waist="Plat. Mog. Belt", --(Null Belt)
		left_ear="Lugalbanda Earring",
		--back="Null Shawl",
	})

--------------------------------------
-- Misc. Defense Sets
--------------------------------------
  -- Kiting
	sets.Kiting = {left_ring="Shnedick Ring"}
    
  -- Latent refresh effect
	sets.latent_refresh = {} --waist="Fucho-no-obi"
	sets.latent_refresh_grip = {} --sub="Oneiros Grip"
	
  -- TP Eat
	sets.TPEat = {} --neck="Chrys. Torque"
	
  -- Daytime idle
	sets.DayIdle = {}
	
  -- Nighttime idle
	sets.NightIdle = {}


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
		waist="Acuity Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
		left_ring="Rajas Ring",
		right_ring="Murky Ring",
		back="Solemnity Cape",
	}
	
	--sets.engaged.Acc = set_combine(sets.engaged, {})
	--sets.engaged.FullAcc = set_combine(sets.engaged, {})
	--sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
		
  -- Engaged DT set
	sets.engaged.DT = {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Acuity Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
		left_ring="Rajas Ring",
		right_ring="Murky Ring",
		back="Solemnity Cape",
	}


---------------------------------------------------------------------------------------------------------------
-- Weapon sets
---------------------------------------------------------------------------------------------------------------
	sets.weapons.None = {main=empty, sub=empty}
	sets.weapons.Club = {main="Maxentius", sub="Sors Shield"} 
	sets.weapons.Staff = {main="Marin Staff +1",sub="Khonsu"}
	sets.weapons.Prime = {main="Opashoro",sub="Khonsu"}


---------------------------------------------------------------------------------------------------------------
-- Weaponskill sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gear
--------------------------------------
    sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm", -- Augment to R25
		body="Nyame Mail", -- Augment to R25
		hands="Jhakri Cuffs +2",
		legs="Nyame Flanchard", -- Augment to R25
		feet="Nyame Sollerets", -- Augment to R25
		neck="Loricate Torque +1", --
		waist="Acuity Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
		left_ring="Rajas Ring",
		right_ring="Murky Ring",
		back="Solemnity Cape",
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
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		--ammo="Sroda Tathlum",
		head="Pixie Hairpin +1",
		hands="Jhakri Cuffs +2",
		--neck="Saevus Pendant +1",
		--waist="Hachirin-no-Obi",
		--left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		--right_ear="Malignance Earring",
		--left_ring="Cornelia's Ring",
		--right_ring="Archon Ring",
		--back="Null Shawl",
	})
	
-- Myrkr
	--sets.precast.WS['Myrkr'] = set_combine(sets.precast.WS, {})
	
-- Omniscience
	--sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {})
	
	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------	
--------------------------------------
-- Buff sets to be worn when a buff is active
--------------------------------------
    --sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    --sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    --sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    --sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    --sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    --sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"} -- Upgrade to +3/+4
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"} -- Upgrade to +3/+4
    --sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

	
--------------------------------------
-- HP Down set (?)
--------------------------------------
	--sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		--body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		--back="Swith Cape +1",waist="Carrier's Sash",legs="Shedir Seraweels",feet=""}
		
    --sets.HPCure = {main="Daybreak",sub="Sors Shield",range=empty,ammo="Hasty Pinion +1",
        --head="Gende. Caubeen +1",neck="Unmoving Collar +1",ear1="Gifted Earring",ear2="Mendi. Earring",
        --body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Gelatinous Ring +1",ring2="Meridian Ring",
        --back="Moonlight Cape",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}


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
-- Light & Dark Arts
--------------------------------------
	sets.buff['Light Arts'] = {legs="Academic's Pants +1"} 
	sets.buff['Dark Arts'] = {body="Acad. Gown +1"}


--------------------------------------
-- Sublimation
--------------------------------------
    sets.buff.Sublimation = {
		head="Acad. Mortar. +1", --Upgrade to +3/+4
		body="Peda. Gown +3",
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