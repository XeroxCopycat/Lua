function user_job_setup()
	
-- ### Options: Override default values ###
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match', 'Proc')
	state.AutoBuffMode:options('Off', 'Auto', 'AutoMelee')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'Refresh', 'Regain', 'Regen')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Savage', 'DualSavage', 'BlackHalo', 'None')

-- ### Additional local binds ###
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
	send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
	send_command('bind !r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons none')
	send_command('bind !q gs c set skipprocweapons false;gs c set weapons DualProcDaggers;gs c set weaponskillmode proc')
	
	select_default_macro_book()
end

function init_gear_sets()

-------------------------------------------------------------------------------------------------------------------
-- START DEFINING THE SETS
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- PRECAST SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	
-- ### Fast cast sets for spells ###
	sets.precast.FC = { --FC +47/42 (Only need +42 to cap on RDM), QC +7, DT -48
		ammo="Impatiens", --QC +2
		head="Atrophy Chapeau +3", --FC +16 (Upgrade to +4)
		body="Viti. Tabard +3", --FC +15 (Upgrade to +4)
		hands="Leth. Ganth. +2", --DT -10 (Upgrade to +3)
		legs="Aya. Cosciales +2", --FC +6, DT -5
		feet="Nyame Sollerets", --DT -7 (Aug to R30)
		neck="Loricate Torque +1",  --DT -6
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --FC +7 (Upgrade to +2)
		left_ring="Murky Ring", --DT -10
		right_ring="Lebeche Ring", --QC +2
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5 (MND/MEVA Cape)
	}
		
	--sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
	--sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Sacro Bulwark"})
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

-------------------------------------------------------------------------------------------------------------------
-- MIDCAST SETS
-------------------------------------------------------------------------------------------------------------------	
------------------------------------------------------------
-- ### Fast recast set ###
------------------------------------------------------------
	sets.midcast.FastRecast = {
		ammo="Impatiens", --QC +2 (Sapience Orb)
		head="Atrophy Chapeau +3", --FC +16 (Upgrade to +4)
		body="Viti. Tabard +3", --FC +12 (Upgrade to +4)
		hands="Leth. Ganth. +2", --DT -10 (Upgrade to +3)
		legs="Aya. Cosciales +2", --FC +6, DT -5
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --FC +7
		left_ring="Murky Ring", --DT -10
		right_ring="Jharki Ring", --FC 
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5 (MND/MEVA Cape)
	}

------------------------------------------------------------
-- ### Dark magic ###
------------------------------------------------------------
	sets.midcast['Dark Magic'] = {
		main="Maxentius", --(Bunzi's Rod aug to R30)
		sub="Ammurapi Shield",
		ammo="Impatiens", --(Ranged: Ullr)
		head="Atrophy Chapeau +3", --(Upgrade to +4)
		body="Atrophy Tabard +3", --(Upgrade to +4)
		hands="Leth. Ganth. +2", --(Atrophy Gloves +4)
		legs="Leth. Fuseau +2", --(Atrophy Tights +4)
		feet="Jhakri Pigaches +2", --(Atrophy Boots +4)
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --(Null Loop)
		waist="Eschan Stone", --(Fucho-no-Obi)
		left_ear="Alabaster Earring", --(Mani Earring)
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --(Upgrade to +2)
		left_ring="Murky Ring", --(Evanescence Ring)
		right_ring="Archon Ring", 
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Null Shawl)
	}
	
  -- Specific dark magic spells
	sets.midcast.Aspir = {
		--head="Pixie Hairpin +1",
		--body="Merlinic Jubbah", --(Aug w/ Drain/Aspir Pot.)
		--hands="Merlinic Dastanas", --(Aug w/ Drain/Aspir Pot.)
		--legs="Merlinic Shalwar" --(Aug w/ Drain/Aspir Pot.)
		--feet="Merlinic Crackows" --(Aug w/ Drain/Aspir Pot.)
		neck="Erra Pendant",
	}
	
	sets.midcast.Bio = set_combine(sets.TreasureHunter)
	sets.midcast.Drain = sets.midcast.Aspir
	sets.midcast.Stun = {}
	sets.midcast.Stun.Resistant = {}

------------------------------------------------------------
-- ### Divine magic ###
------------------------------------------------------------
	sets.midcast['Divine Magic'] = {
		main="Maxentius", --(Bunzi's Rod, Aug to R30)
		sub="Ammurapi Shield",
		ammo="Impatiens", --(Ranged: Ullr)
		head="Atrophy Chapeau +3", --(Upgrade to +4)
		body="Atrophy Tabard +3", --(Upgrade to +4)
		hands="Leth. Ganth. +2", --(Atrophy Gloves +4)
		legs="Leth. Fuseau +2", --(Atrophy Tights +4)
		feet="Jhakri Pigaches +2", --(Atrophy Boots +4)
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --(Null Loop)
		waist="Eschan Stone",
		left_ear="Alabaster Earring", --(Mani Earring)
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --(Upgrade to +2)
		left_ring="Metamor. Ring +1", --(Metamorph Ring +1)
		right_ring="Archon Ring",  
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Null Shawl)
	}

------------------------------------------------------------
-- ### Elemental magic ###
------------------------------------------------------------
	sets.midcast['Elemental Magic'] = {
		main="Maxentius", --(Bunzi's Rod, Aug to R30)
		sub="Ammurapi Shield",
		ammo="Impatiens", --(Sroda Tathlum)
		head="Leth. Chappel +2", --(Upgrade to +3)
		body="Lethargy Sayon +2", --(Upgrade to +3)
		hands="Leth. Ganth. +2", --(Upgrade to +3)
		legs="Leth. Fuseau +2", --(Upgrade to +3)
		feet="Jhakri Pigaches +2", --(Viti. Boots +4)
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --(Sibyl Scarf)
		waist="Acuity Belt +1",
		left_ear="Alabaster Earring", --(Malignance Earring)
		right_ear="Sortiarius Earring", --(Regal Earring)
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring", --(Freke Ring)
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
    sets.midcast['Elemental Magic'].Resistant = {head="Atrophy Chapeau +3", body="Atrophy Tabard +3"}
    sets.midcast['Elemental Magic'].Fodder = {}
    sets.midcast['Elemental Magic'].Proc = {}
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
  -- Specific elemental magic spells
	--sets.midcast.Impact = {}
	
  -- Gear for Magic Burst mode.
    sets.MagicBurst = {
		head="Atrophy Chapeau +3", --MBD +10 (Ea Hat +1)
		--body="Ea Houpplande +1",
		--Legs="Ea Slops +1",
		feet="Jharki Pigaches +2", --MBD +7
		right_ring="Mujin Band", --MBD II +5
	}

------------------------------------------------------------
-- ### Enfeebling magic ###
------------------------------------------------------------
	sets.midcast['Enfeebling Magic'] = {
		main="Maxentius", --(Bunzi's Rod, Aug to R30)
		sub="Ammurapi Shield",
		ammo="Impatiens", --(Regal Gem)
		head="Viti. Chapeau +3", --(Upgrade to +4)
		body="Lethargy Sayon +2", --(Upgrade to +3)
		hands="Leth. Ganth. +2", --(Upgrade to +3)
		legs="Leth. Fuseau +2", --(Chironic Hose Aug w/ MND + MACC)
		feet="Vitiation Boots +3", --(Upgrade to +4)
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Eschan Stone", --(Obstin. Sash)
		left_ear="Alabaster Earring", --(Aug to R30)
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --(Snotra Earring)
		left_ring="Metamor. Ring +1",
		right_ring="Jhakri Ring", --(Stikini Ring +1)
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Ambu cape w/ MND + MACC)
	}
	
	sets.midcast['Enfeebling Magic'].Resistant = {
		main="Maxentius", --(Bunzi's Rod, Aug to R30)
		sub="Ammurapi Shield",
		ammo="Impatiens", --(Ranged: Ullr)
		head="Viti. Chapeau +3", --(Upgrade to +4)
		body="Atrophy Tabard +3", --(Upgrade to +4)
		hands="Leth. Ganth. +2", --(Upgrade to +3)
		legs="Leth. Fuseau +2", --(Atrophy Tights +4)
		feet="Jhakri Pigaches +2", --(Atrophy Boots +4)
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --(Null Loop) 
		waist="Eschan Stone", --(Obstin. Sash)
		left_ear="Alabaster Earring", --(Augment to R30)
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
		left_ring="Murky Ring", --(Stikini Ring +1)
		right_ring="Jhakri Ring", --(Stikini Ring +1)
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(MND/MACC)
	}
	
	sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Leth. Chappel +2",
		feet="Leth. Houseaux +1",
	})
	
	sets.midcast.SkillBasedEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {})
	
  -- Specific enfeebling magic spells
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Bind.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Break.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Distract III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Silence.Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling,{})
	sets.midcast.Sleep.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{})

------------------------------------------------------------
-- ### Enhancing magic ###
------------------------------------------------------------
	sets.midcast['Enhancing Magic'] = {
		main="Maxentius", --(Colada w/ enhancing magic duration)
		sub="Ammurapi Shield",
		ammo="Impatiens", --(Staunch Tathlum +1)
		head="Befouled Crown", --(Telechne Cap w/ enhancing magic duration)
		body="Viti. Tabard +3", --(Upgrade to +4)
		hands="Atrophy Gloves +3", --(Upgrade to +4)
		legs="Leth. Fuseau +2", --(Telechine Bracconi w/ enhancing magic duration)
		feet="Leth. Houseaux +1", --(Upgrade to +3)
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --(Augment to R25)
		waist="Eschan Stone", --(Embla Sash)
		left_ear="Alabaster Earring", 
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --(Lethargy Earring +2)
		left_ring="Murky Ring", 
		right_ring="Jhakri Ring", --(Defending Ring)
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Ghostfyre Cape w/ Enh. magic skill/Enh. magic duration)
	}
	
  -- Composure
	sets.buff.ComposureOther = {
		main="Maxentius", --(Colada, Aug w/ enhancing magic duration)
		sub="Ammurapi Shield",
		ammo="Impatiens", --(Staunch Tathlum +1)
		head="Leth. Chappel +2", --(Upgrade to +3)
		body="Lethargy Sayon +2", --(Upgrade to +3)
		hands="Atrophy Gloves +3", --(Upgrade to +4)
		legs="Leth. Fuseau +2", --(Upgrade to +3)
		feet="Leth. Houseaux +1", --(Upgrade to +3)
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --(Augment to R25)
		waist="Eschan Stone", --(Embla Sash)
		left_ear="Alabaster Earring", 
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --(Lethargy Earring +2)
		left_ring="Murky Ring", 
		right_ring="Jhakri Ring", --(Defending Ring)
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Ghostfyre Cape w/ Enh. magic skill/Enh. magic duration)
	}
	
  -- Enhancing magic skill
	sets.EnhancingSkill = {
		head="Befouled Crown", 
		body="Viti. Tabard +3",
		hands="Viti. Gloves +3",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +1",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
		left_ring="Murky Ring",
		right_ring="Shneddick Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
  -- Specific enhancing magic spells
  -- NOTE: Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works. Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.midcast.Refresh = {body="Atrophy Tabard +3", legs="Leth. Fuseau +2"}
	sets.midcast.Aquaveil = {legs="Shedir Seraweels"}
	sets.midcast.BarElement = {legs="Shedir Seraweels"}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {})
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {})
	sets.midcast.BoostStat = {}
	sets.midcast.Stoneskin = {legs="Shedir Seraweels"}
	sets.midcast.Protect = {right_ring="Sheltered Ring"}
	sets.midcast.Shell = {right_ring="Sheltered Ring"}

  -- Misc. enhancing magic sets
	sets.Self_Refresh = {waist="Gishdubar Sash"}
  
------------------------------------------------------------
-- ### Healing magic ###
------------------------------------------------------------
	sets.midcast['Healing Magic'] = {
		main="Maxentius", --(Daybreak)
		sub="Archduke's Shield",
		ammo="Impatiens", --(Staunch Tathlum +1)
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --(Bunzi's Robe)
		hands={ name="Vanya Cuffs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --(Kaykaus Cuffs +1)
		legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}, --(Kaykaus Tights +1)
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Loricate Torque +1", --DT -6
		waist="Carrier's Sash", --(Plat. Mog. Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
		left_ring="Murky Ring", --DT 10
		right_ring="Lebeche Ring",
		back="Solemnity Cape", --(Sucellos Cape w/ MND +30, Eva/MEVA +20, DT -5)
	}
	
  -- Specific healing magic spells
	sets.midcast.Cure = {}
	sets.midcast.Cursna = {
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body="Viti. Tabard +3",
	}
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	sets.midcast.Curaga = sets.midcast.Cure
	
  -- Misc. healing magic sets
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}	
	
-------------------------------------------------------------------------------------------------------------------
-- IDLE AND RESTING SETS
-------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------
-- ### Idle sets ###
------------------------------------------------------------
	sets.idle = { --Refresh +7, DT -51/50, Mv. Speed +18%
		main="Maxentius",
		sub="Archduke's Shield", --Refresh +1
		ammo="Impatiens", --(Homiliary)
		head="Viti. Chapeau +3", --Refresh +3 (Update to +4)
		body="Lethargy Sayon +2", --Refresh +3, DT -13 (Upgrade to +3)
		hands="Leth. Ganth. +2", --DT -10 (Volte Gloves)
		legs="Volte Brais", --Refresh +1 (Chironic legs aug w/ Refresh +2)
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6 (Sibyl Scarf)
		waist="Carrier's Sash", --(Plat. Mog. Belt)
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}, --(Ambu cape with Regen +5)
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {})
	
	sets.idle.Regain = set_combine(sets.idle, {})
	
	sets.idle.Regen = set_combine(sets.idle, {
		main="Chatoyant Staff", 
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		right_ring="Sheltered Ring", --Regen +1
	})
	
	sets.idle.Weakened = set_combine(sets.idle, {right_ring="Sheltered Ring"})
	
------------------------------------------------------------
-- ### Resting sets ###
------------------------------------------------------------
	sets.resting = {
		main="Chatoyant Staff", 
		sub="Oneiros Grip", 
		right_ring="Sheltered Ring",
	}

-------------------------------------------------------------------------------------------------------------------
-- DEFENSE SETS
-------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------
-- ### Physical damage taken ###
------------------------------------------------------------
	sets.defense.PDT = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring",
		right_ring="Archon Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
	}
	
  -- Magic damage taken
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
  -- Magic evasion
    sets.defense.MEVA = {}
	
 -- ### Misc. defensive sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

-------------------------------------------------------------------------------------------------------------------
-- OFFENSE SETS
-------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------
-- ### Engaged, single wield ###
------------------------------------------------------------
	sets.engaged = {
		ammo="Impatiens",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Nyame Gauntlets",
		legs="Jhakri Slops +2",
		feet="Atro. Boots +3",
		neck="Loricate Torque +1",
		waist="Eschan Stone",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back="Solemnity Cape",
	}
	
	sets.engaged.EnspellOnly = set_combine(sets.engaged, {hands="Aya. Manopolas +2"})
	sets.engaged.Acc = {}	
	sets.engaged.FullAcc = {}
	sets.engaged.DT = {}

------------------------------------------------------------
-- ### Engaged, dual wield ###
------------------------------------------------------------
	sets.engaged.DW = {
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Leth. Ganth. +2",
		legs="Jhakri Slops +2",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Suppanomimi",
		right_ear="Sherida Earring",
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
	}
	
	sets.engaged.DW.Acc = {}
	sets.engaged.DW.FullAcc = {}
	sets.engaged.DW.DT = {}

-------------------------------------------------------------------------------------------------------------------
-- WEAPONS & WEAPONSKILL SETS
-------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------
-- ### Weapons sets ###
------------------------------------------------------------
	sets.weapons.Savage = {main="Kaja Sword", sub="Archduke's Shield"}
	sets.weapons.DualSavage = {main="Kaja Sword", sub="Blurred Knife +1"}
	--sets.weapons.Evisceration = {main="Tauret", sub="Almace"}
	--sets.weapons.Aeolian = {main="Tauret", sub="Bunzi's Rod"}
	sets.weapons.BlackHalo = {main="Maxentius", sub="Archduke's Shield"}
	sets.weapons.Enspell = {main="Norgish Dagger",sub="Aern Dagger"}
	--sets.weapons.DualEnspell = {main="Blurred Knife +1", sub="Atoyac"}
	
------------------------------------------------------------
-- ### Weaponskill sets ###
------------------------------------------------------------
  -- Default weaponskill sets
	sets.precast.WS = {
		head="Viti. Chapeau +3",
		body="Nyame Mail",
		hands="Atrophy Gloves +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Suppanomimi",
		right_ear="Sherida Earring",
		left_ring="Murky Ring",
		right_ring="Rajas Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS.PDL = {}
	sets.precast.WS.Proc = 	{}
	
  -- Specific weaponskill sets
	-- Club
	sets.precast.WS['Black Halo'] = {}
  
	-- Dagger  
	sets.precast.WS['Aeolian Edge'] = {}
	sets.precast.WS['Evisceration'] = {}

    -- Sword
	sets.precast.WS['Chant Du Cygne'] = {}
	sets.precast.WS['Requiescat'] = {}
	sets.precast.WS['Red Lotus Blade'] = {}
	sets.precast.WS['Sanguine Blade'] = {}
	sets.precast.WS['Seraph Blade'] = {}
	sets.precast.WS['Savage Blade'] = {}

------------------------------------------------------------
-- ### Auto weaponskill lists ###
------------------------------------------------------------
	autows_list = {
		['Savage']='Savage Blade',
		['DualSavage']='Savage Blade',
		['Evisceration']='Evisceration',
		['BlackHalo']='Black Halo',
		['Aeolian']='Aeolian Edge',
		['EnspellDW']='Sanguine Blade'
	}

-------------------------------------------------------------------------------------------------------------------
-- MISC. SETS
-------------------------------------------------------------------------------------------------------------------
-- Sets for special buff conditions on spells.
	sets.buff.Saboteur = {}
	sets.HPDown = {}
    sets.HPCure = {}

-- ### Convert elemental damage done to MP ###	
	sets.RecoverMP = {}

-- ### Treasure hunter ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
-- ### Vs. debuff ###
	sets.buff.Doom = set_combine(sets.buff.Doom, {waist="Gishdubar Sash"})
	sets.buff.Sleep = set_combine(sets.buff.Sleep, {})
	
-- ### Sublimation (/SCH) ### 
    sets.buff.Sublimation = {}
    sets.buff.DTSublimation = {}
end

-- ### Select default macro book on initial load or subjob change. ###
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(3, 4)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 4)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 4)
	else
		set_macro_page(1, 4)
	end
end

