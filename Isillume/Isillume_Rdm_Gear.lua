function user_job_setup()
	
-- ### Options: Override default values ###
    state.OffenseMode:options('Normal', 'Acc', 'PDL', 'Enspell')
    state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'PDL')
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
	sets.precast.FC = { --FC +42/42 (Only need +42 to cap on RDM), QC +7, DT -48
		ammo="Impatiens", --QC +2
		head="Atrophy Chapeau +3", --FC +16 (Upgrade to +4)
		body="Viti. Tabard +3", --FC +15 (Upgrade to +4)
		hands="Leth. Ganth. +2", --DT -10 (Upgrade to +3)
		legs="Aya. Cosciales +2", --DT -5, FC +6
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring", --DT -10
		right_ring="Lebeche Ring", --QC +2
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}, --DT -5
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
		ammo="Impatiens", --QC +2
		head="Atrophy Chapeau +3", --FC +16 (Upgrade to +4)
		body="Viti. Tabard +3", --FC +15 (Upgrade to +4)
		hands="Leth. Ganth. +2", --DT -10 (Upgrade to +3)
		legs="Aya. Cosciales +2", --DT -5, FC +6
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Witful Belt", --FC +3, QC +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Loquac. Earring", --FC +2
		left_ring="Murky Ring", --DT -10
		right_ring="Lebeche Ring", --QC +2
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}, --DT -5
	}


-- ### Dark magic ###
	sets.midcast['Dark Magic'] = {
		main="Naegling",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Atrophy Chapeau +3",
		body="Atrophy Tabard +4",
		hands="Leth. Ganth. +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +3",
		neck="Erra Pendant",
		waist="Acuity Belt +1",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
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


-- ## Divine magic ##
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


-- ## Elemental magic ##
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


-- ### Enfeebling magic ###
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
		feet="Leth. Houseaux +2",
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


-- ### Enhancing magic ###
	sets.midcast['Enhancing Magic'] = {
		main="Maxentius", --(Colada, Aug. w/ Enhanc. magic duration)
		sub="Ammurapi Shield", --Enhn. magic duration +10%
		ammo="Staunch Tathlum +1", --DT -3, SIRD 11%
		head="Befouled Crown", --Enh. magic skill +16, (Telechne Cap, Aug. w/ Enhanc. magic duration)
		body="Viti. Tabard +3", --Enh. magic skill +23, Enh. magic duration +15%, (Upgrade to +4)
		hands="Atrophy Gloves +3", --Enh. magic duration +20%, (Upgrade to +4)
		legs="Leth. Fuseau +2", --(Telechine Bracconi w/ enhancing magic duration)
		feet="Leth. Houseaux +2", --Enh. magic skill +35, Enh. magic duration +40%
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --Enh. magic duration +25%
		waist="Embla Sash", --Enh. magic duration +10%
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --Enh. magic duration +7% (Lethargy Earring +1 or +2)
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --All magic skills +8
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Ghostfyre Cape w/ Enh. magic skill/Enh. magic duration)
	}
	
  -- Composure
	sets.buff.ComposureOther = {
		main="Maxentius", --(Colada, Aug. w/ Enhanc. magic duration)
		sub="Ammurapi Shield", --Enhn. magic duration +10%
		ammo="Staunch Tathlum +1", --DT -3, SIRD 11%
		head="Leth. Chappel +2", --DT -9, Set (x4 pieces): Augments Composure (Upgrade to +3)
		body="Lethargy Sayon +2", --DT -13 (Upgrade to +3)
		hands="Atrophy Gloves +3", --Enh. magic duration +20%
		legs="Leth. Fuseau +2", --(Upgrade to +3)
		feet="Leth. Houseaux +3", --Enh. magic skill +35, Enh. magic duration +40%
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --Enh. magic duration +25%
		waist="Embla Sash", --Enh. magic duration +10%
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --Enh. magic duration +7% (Lethargy Earring +1 or +2)
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --All magic skills +8
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Ghostfyre Cape w/ Enh. magic skill/Enh. magic duration)
	}
	
  -- Enhancing magic skill
	sets.EnhancingSkill = {
		main="Maxentius", --(Colada, Aug. w/ Enhanc. magic duration)
		sub="Ammurapi Shield", --Enhn. magic duration +10%
		ammo="Staunch Tathlum +1", --DT -3, SIRD 11%
		head="Befouled Crown", --Enh. magic skill +16
		body="Viti. Tabard +3", --Enh. magic skill +23, Enh. magic duration +15% (Upgrade to +4)
		hands="Viti. Gloves +3", --Enh. magic skill +24, Adds Enh. magic duration +15 (Upgrade to +4)
		legs="Atrophy Tights +3", --Enh. magic skill +21 (Upgrade to +4)
		feet="Leth. Houseaux +3", --Enh. magic skill +35, Enh. magic duration +40%
		neck={ name="Dls. Torque +2", augments={'Path: A',}}, --Enh. magic duration +25%
		waist="Embla Sash", --Enh. magic duration +10%
		left_ear="Alabaster Earring", --DT -5
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}, --Enh. magic duration +7% (Lethargy Earring +1 or +2)
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --All magic skills +8
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --(Ghostfyre Cape w/ Enh. magic skill/Enh. magic duration)
	}
	
  -- Specific enhancing magic spells
  -- NOTE: Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works. Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.midcast.Refresh = {body="Atrophy Tabard +3", legs="Leth. Fuseau +2"} --Refresh pot. +5
	sets.midcast.Aquaveil = {legs="Shedir Seraweels"} --Aquaveil effect +1
	sets.midcast.BarElement = {legs="Shedir Seraweels"} --Elem. resist spells +15
	sets.midcast.Temper = sets.EnhancingSkill 
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {})
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {})
	sets.midcast.BoostStat = {hands="Viti. Gloves +3"} --"Gain" magic effect +30
	sets.midcast.Stoneskin = {legs="Shedir Seraweels"} --Stoneskin +35
	sets.midcast.Protect = {right_ring="Sheltered Ring"}
	sets.midcast.Shell = {right_ring="Sheltered Ring"}

  -- Misc. enhancing magic sets
	sets.Self_Refresh = {waist="Gishdubar Sash"} --Refresh duration received +20
	sets.Self_Phalanx = {main="Sakpata's Sword"} --Phalanx received +5
  

-- ### Healing magic ###
	sets.midcast['Healing Magic'] = { --DT -46, Cure Pot. +50, Cure Pot. II +4, Enmity -18
		main="Bunzi's Rod", --Cure pot. +30
		sub="Thuellaic Ecu +1", --Conserve MP +4
		ammo="Staunch Tathlum +1", --DT -3, SIRD 11%
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Cure Pot. +11, Enmity -6, Heal. magic skill +16, Set (2 pieces): Cure Pot. II +4%
		body="Lethargy Sayon +2", --DT -13 (Upgrade to +3)
		hands="Leth. Ganth. +2", --DT -10 (Upgrade to +3)
		legs="Nyame Flanchard", --DT -8 (Aug. to R30)
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --Cure Pot. +11, Enmity -12
		neck="Loricate Torque +1", --DT -6
		waist="Carrier's Sash", --Elem. Resist
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30)
		right_ear="Magnetic Earring", --Conserve MP +5, SIRD 8%
		left_ring="Menelaus's Ring", --Heal. magic skill +15
		right_ring="Stikini Ring +1", --All magic skill +8
		back="Solemnity Cape", --Conserve MP +5, DT -4
	}
	
  -- Specific healing magic spells
	sets.midcast.Cure = {}
	sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.Cursna = { 
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Heal. magic skill +20, Conserve MP +6
		body="Viti. Tabard +3", --Heal. magic skill +23
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Cursna +5, Heal. magic skill +20, 
		neck="Debilis Medallion", --Cursna +15
		left_ring="Menelaus's Ring", --Cursna +20, Heal. magic skill +15
		right_ring="Haoma's Ring", --Cursna +15, Heal. magic skill +8
	}
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
  -- Misc. healing magic sets
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}	
	
-------------------------------------------------------------------------------------------------------------------
-- IDLE AND RESTING SETS
-------------------------------------------------------------------------------------------------------------------
-- ## Idle sets ##
	sets.idle = { --DT -50, Refresh +9, Regen +3
		main="Maxentius",
		sub="Archduke's Shield", --Refresh +1
		ammo="Staunch Tathlum +1", --DT -3 (Homiliary)
		head="Viti. Chapeau +3", --Refresh +3
		body="Lethargy Sayon +2", --DT -13, Refresh +3 (Upgrade to +3)
		hands="Leth. Ganth. +2", --DT -10
		legs="Volte Brais", --Refresh +1
		feet="Nyame Sollerets", --DT -7
		neck="Warder's Charm +1", --Elemental resist
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --Refresh +1
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5 (Sucellos's Cape: MND +30, Eva/MEva +20, FC +10, Regen +5)
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {})
	sets.idle.Regain = set_combine(sets.idle, {})
	sets.idle.Regen = set_combine(sets.idle, {
		main="Chatoyant Staff", 
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		--head="Null Masque",
		--neck="Bathy Choker +1",
		left_ring="Sheltered Ring", --Regen +1 (Chirich Ring +1)
		--right_ring="Gurebu's Ring",
	})
	

-- ### Resting sets ###
	sets.resting = {
		main="Chatoyant Staff", 
		sub="Oneiros Grip", 
		ammo="Staunch Tathlum +1", --DT -3 (Homiliary)
		head="Viti. Chapeau +3", --Refresh +3 (Null Masque)
		body="Lethargy Sayon +2", --DT -13, Refresh +3 (Upgrade to +4)
		hands="Leth. Ganth. +2", --DT -10
		legs="Volte Brais", --Refresh +1
		feet="Nyame Sollerets", --DT -7
		neck="Warder's Charm +1", --Elemental resist
		waist="Null Belt", --Regen +3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna +1",
		left_ring="Murky Ring", --DT -10
		right_ring="Stikini Ring +1", --Refresh +1
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5 (Sucellos's Cape: MND +30, Eva/MEva +20, FC +10, Regen +5)
	}

-------------------------------------------------------------------------------------------------------------------
-- DEFENSE SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
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
    sets.defense.MEVA = {
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +3",
		waist="Null Belt",
	}
	
	
 -- ### Misc. defensive sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	

-------------------------------------------------------------------------------------------------------------------
-- OFFENSE SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Engaged, single wield ###
	sets.engaged = { --DT -29 [PDT -33], DA +24, Store TP +45 
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Aya. Zucchetto +2", --DT -3, Store TP +6
		body="Ayanmo Corazza +2", --DT -6, DA +7
		hands="Bunzi's Gloves", --DT -8, DA +8
		legs="Jhakri Slops +2", --Store TP +9
		feet="Nyame Sollerets", --DT -7
		neck="Anu Torque", --Store TP +7
		waist="Flume Belt +1", --PDT -4, Convert 2% of damage taken to MP
		left_ear="Sherida Earring", --DA +5, Store TP +5
		right_ear="Neritic Earring", --Store TP +5
		left_ring="Petrov Ring", --DA +1, Store TP +5
		right_ring="Rajas Ring", --Store TP +5
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}, --DT -5
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {waist="Null Belt"})
	sets.engaged.PDL = set_combine(sets.engaged, {})
	sets.engaged.Enspell = set_combine(sets.engaged, {hands="Aya. Manopolas +2"})
	
	
-- ## Engaged, hybrid DT ##
	sets.engaged.DT = { --DT -47 [PDT -50], DA +22, Store TP +32 
		ammo="Staunch Tathlum +1", --DT -3
		head="Aya. Zucchetto +2", --DT -3, Store TP +6
		body="Ayanmo Corazza +2", --DT -6, DA +7
		hands="Bunzi's Gloves", --DT -8, DA +8 (Aug. to R30)
		legs="Jhakri Slops +2", --Store TP +9
		feet="Nyame Sollerets", --DT -7 (Aug. to R30)
		neck="Anu Torque", --Store TP +7
		waist="Flume Belt +1", --PDT -4, Convert 2% of damage taken to MP (Reiki Yotai)
		left_ear="Alabaster Earring", --DT -5 (Aug. to R30)
		right_ear="Sherida Earring", --DA +5, Store TP +5 
		left_ring="Murky Ring", --DT -10 (Aug. to R30)
		right_ring="Rajas Ring", --Store TP +5
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}, --DT -5
	}


-- ### Engaged, dual wield ###
	sets.engaged.DW = { --DT -29 [PDT -33], DA +24, Store TP +40, DW +15
		ammo="Coiste Bodhar", --DA +3, Store TP +3
		head="Aya. Zucchetto +2", --DT -3, Store TP +6
		body="Ayanmo Corazza +2", --DT -6, DA +7
		hands="Bunzi's Gloves", --DT -8, DA +8 (Aug. to R30)
		legs="Jhakri Slops +2", --Store TP +9
		feet="Nyame Sollerets", --DT -7 (Aug. to R30)
		neck="Anu Torque", --Store TP +7 
		waist="Flume Belt +1", --PDT -4, Convert 2% of damage taken to MP (Reiki Yotai)
		left_ear="Suppanomimi", --DW +5
		right_ear="Sherida Earring", --DA +5, Store TP +5 
		left_ring="Petrov Ring", --DA +1, Store TP +5
		right_ring="Rajas Ring", --Store TP +5
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}, --DT -5, DW +10
	}
	

-- ## Misc. engaged sets (added on top of engaged sets) ##
	sets.DWMid = {}
	sets.DWMax = {}
	sets.SubtleBlow = {left_ear="Sherida Earring"} --Subtle Blow II +5


-------------------------------------------------------------------------------------------------------------------
-- WEAPONS & WEAPONSKILL SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Weapons sets ###
  -- Single wield
	sets.weapons.Savage = {main="Naegling", sub="Archduke's Shield"}
	--sets.weapons.Evisceration = {main="Tauret", sub="Almace"}
	sets.weapons.Aeolian = {main="Tauret", sub="Ammurapi Shield"}
	sets.weapons.BlackHalo = {main="Maxentius", sub="Archduke's Shield"}
	
  -- Dual wield
	sets.weapons.DualSavage = {main="Naegling", sub="Gleti's Knife"}
	
  -- Enspell
	--sets.weapons.Enspell = {main="Crocea Mors", sub="Archduke's Shield"} --(Path C) 
	sets.weapons.EnspellOnly = {main="Norgish Dagger",sub="Aern Dagger"}
	--sets.weapons.DualEnspell = {main="Blurred Knife +1", sub="Atoyac"}
	
	
-- ### Weaponskill sets ###
  -- Default weaponskill sets
	sets.precast.WS = {
		ammo="Coiste Bodhar", --DA +3
		head="Viti. Chapeau +3", --STR +24, WSD +6
		body="Nyame Mail", --STR +35 (Aug. to R30)
		hands="Atrophy Gloves +3", --STR +21, WSD +6
		legs="Nyame Flanchard", --STR +43, (Aug. to R30)
		feet="Leth. Houseaux +3", --STR +22, WSD +12
		neck="Anu Torque", 
		waist="Null Belt",
		left_ear="Sherida Earring", --STR +5, DA +5 
		right_ear="Neritic Earring",
		left_ring="Petrov Ring", --STR +3, DA +1
		right_ring="Rajas Ring", --STr +5
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}, --STR +30, WSD +10
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {})
	
	
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
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
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

