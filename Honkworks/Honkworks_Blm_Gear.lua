function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc', 'Fodder')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant', 'Proc', 'OccultAcumen')
	state.IdleMode:options('Normal', 'Refresh', 'Regen')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Staff', 'Club')


	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode') 
	send_command('bind ~^` gs c cycleback ElementalMode') --Robbiewobbie's idea
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons Default;gs c reset CastingMode;gs c reset DeathMode;gs c reset MagicBurstMode')
	send_command('bind !r gs c set DeathMode Single;gs c set MagicBurstMode Single')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir III" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
    
	select_default_macro_book()
end

function init_gear_sets()
------------------------------------------------------------------------------------------------------------
-- Start defining the sets
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- Precast Sets
------------------------------------------------------------------------------------------------------------
-- ### Fast cast sets for spells ###
    sets.precast.FC = { --FC +71/80, QC +5
		ammo="Ghastly Tathlum +1", --(Impatens)
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}},
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Voltsurge Torque",
		waist="Witful Belt", --QC +3
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring", 
		left_ring="Lebeche Ring", --QC +2
		right_ring="Medada's Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Damage taken-1%',}},
	}
	
-- ### Fast cast sets for specific spells
  -- Dark Magic
	sets.precast.FC['Dark Magic'] = set_combine(sets.precast.FC, {})
	
    -- Death
	--sets.precast.FC.Death = set_combine(sets.precast.FC, {})

  -- Enfeebling Magic
	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {})  
	
    -- Dispelga (Requires Daybreak)
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
  -- Enhancing Magic
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    -- Stoneskin
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
    
  -- Elemental Magic
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
	
    -- Impact
	--sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})

  -- Healing Magic
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {left_ring="Lebeche Ring"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
-- ### Precast sets to enhance JAs ###
  -- Mana Wall
	sets.precast.JA['Mana Wall'] = {back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},}
    
  -- Manafont
	sets.precast.JA.Manafont = {}
	
  -- Convert (/RDM. Equip to maximize HP and minimize MP loss before use)
	sets.precast.JA.Convert = {}
	
-------------------------------------------------------------------------------------------------------------- Midcast Sets
-----------------------------------------------------------------------------------------------------------
-- ### Fast Recast set ###
    sets.midcast.FastRecast = { --FC +77/80
		ammo="Ghastly Tathlum +1", --(Impatens)
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}},
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring", 
		left_ring="Kishar Ring",
		right_ring="Medada's Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Damage taken-1%',}},
	}

-- ### Dark magic sets ###
	sets.midcast['Dark Magic'] = {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+9','"Drain" and "Aspir" potency +7','Mag. Acc.+6',}},
		hands={ name="Merlinic Dastanas", augments={'"Drain" and "Aspir" potency +7','Mag. Acc.+4','"Mag.Atk.Bns."+10',}},
		legs="Spaekona's Tonban",
		feet="Agwu's Pigaches",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear={ name="Wicce Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Enmity-1',}},
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}

  -- Specific dark magic spells
    -- Drain
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
    
    -- Aspir
    sets.midcast.Aspir = sets.midcast.Drain
		
    -- Aspir, death mode
	sets.midcast.Aspir.Death = sets.midcast.Drain
	
    
	
    -- Death
	sets.midcast.Death = set_combine(sets.midcast['Dark Magic'], {})
	
    -- Stun
	sets.midcast.Stun = {}
    sets.midcast.Stun.Resistant = sets.midcast.Stun
	
-- ### Divine magic sets ###
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

-- ### Elemental magic sets ###
    sets.midcast['Elemental Magic'] = {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Sroda Tathlum",
		head="Jhakri Coronal +2",
		body="Shamash Robe",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear={ name="Wicce Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Enmity-1',}},
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	-- High tier nukes (Tier III single target+, tier II aoe, and -ja spells. MAB focused.)
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	-- Low tier nukes (Tier I/II single target, tier I aoe. Magic damage focused.)
	sets.midcast['Elemental Magic'].LowTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].LowTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	
	-- Proc nuke (Minimizes damage for proc'ing in Abyssea. Fast cast focused)
    sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast['Elemental Magic'], {})
	
-- Elemental status ailment effects
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {
		legs="Agwu's Slops",
	})
	
  -- Specific elemental magic spells
    -- Comet (Dark elemental magic based)
	sets.midcast.Comet = set_combine(sets.midcast['Elemental Magic'], {
		head="Pixie Hairpin +1",
		right_ring="Archon Ring",
	})
  
	-- Helix (/SCH)
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
	-- Impact (Dark elemental magic based, requires Crepuscular Cloak/Twilight Cloak)
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})
	
-- ### Magic Burst gear ###
    sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], {
		head="Ea Hat +1",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		left_ring="Mujin Band",
	})
	
  -- Magic burst gear, resistant
	sets.ResistantMagicBurst = set_combine(sets.MagicBurst, {})
		
  -- Occult Acumen gear
    sets.midcast['Elemental Magic'].OccultAcumen = {}
	
  -- Recover MP gear
	sets.RecoverMP = {
		body="Spaekona's Coat"
	}

-- ### Enhancing magic sets ###
	sets.midcast['Enhancing Magic'] = {}
    
  -- Specific enhancing magic spells
	-- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		legs="Shedir Seraweels",
	})
	
	-- Bar spells
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {
		legs="Shedir Seraweels",
	})
	
	-- Refresh
	--sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Stoneskin
    --sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	
  -- Refresh effect received
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
-- ### Enfeebling magic sets ###
	sets.midcast['Enfeebling Magic'] = {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Ghastly Tathlum +1",
		head="Ea Hat +1",
		body="Shamash Robe",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear={ name="Wicce Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Enmity-1',}},
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
		 
  -- Enfeebling magic, resistant
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
		--left_ring="Stikini Ring +1",
		--right_ring="Stikini Ring +1",
	})

  -- Enfeebling magic, INT based
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = sets.midcast.IntEnfeebles

  -- Enfeebling Magic, MND based
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	
  -- Specific Spells
	 -- Dia
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	 -- Bio
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

-- Healing Magic
    sets.midcast.Cure = { --Cure Pot. 53/50, Conserve MP +23 Cure Spellcasting Time -35%
		main="Bunzi's Rod",
		sub="Sors Shield", 
		ammo="Ghastly Tathlum +1", 
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Loricate Torque +1",
		waist="Carrier's Sash",
		left_ear="Alabaster Earring",
		right_ear="Magnetic Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back="Solemnity Cape",
	}
	
  -- Cure Lightsday / Light Weather
    --sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi"})
    --sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi"})

  -- Curaga set
    sets.midcast.Curaga = sets.midcast.Cure
	
  -- Cursna set
	--sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {right_ring="Menelaus's Ring"})
	
  -- Status removal set
	--sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
  -- Cure effect received
	sets.Self_Healing = {neck="Phalaina Locket", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", waist="Gishdubar Sash"}


------------------------------------------------------------------------------------------------------------
-- Idle & resting sets
------------------------------------------------------------------------------------------------------------
-- ### Idle set ###
	sets.idle = { --Refresh +6~7, PDT -43/MDT -33, Resist Silence +90
		main="Marin Staff +1", 
		sub="Khonsu", --DT -6
		ammo="Ghastly Tathlum +1", --(Homiliary)
		head="Befouled Crown", --Refresh +1 (Null Masque)
		body="Shamash Robe", --PDT -10, Refresh +3, Resist Silence +90
		hands="Volte Gloves", --Refresh +1
		legs="Assid. Pants +1", --Refresh +1~2
		feet="Nyame Sollerets", --DT -7
		neck="Warder's Charm +1", 
		waist="Carrier's Sash", 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Arete del Luna",
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5
	}
	
  -- Refresh idle set
    sets.idle.Refresh = set_combine(sets.idle, { --Refresh +8~9
		neck="Sibyl Scarf",
		body="Jhakri Robe +2", 
	})
	
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {})

  -- Death idle set, prioritizes mp and refresh
	sets.idle.Death = set_combine(sets.idle, {})

  -- Weakened idle set
    sets.idle.Weak = sets.idle

-- ### Resting set ###
	sets.resting = {
		main="Marin Staff +1", --(Mpaca's Staff)
		sub="Oneiros Grip", --Regen +1, Latent: Refresh +1
		ammo="Ghastly Tathlum +1", --(Homiliary)
		head="Befouled Crown", --Refresh +1 (Null Masque)
		body="Jhakri Robe +2", --Refresh +4
		hands="Volte Gloves", --Refresh +1 (Chironic Gloves w/ Refresh +2)
		legs="Assid. Pants +1", --Refresh +1~2 (Chironic Pants w/ Refresh +2)
		feet="Nyame Sollerets", --DT -7 (Chironic Boots w/ Refresh +2)
		neck="Sibyl Scarf", --Refresh +1
		waist="Carrier's Sash", --(Fucho-No-Obi)
		left_ear="Alabaster Earring", --DT -5 (Infused Earring)
		right_ear="Magnetic Earring", --Resting MP +1
		left_ring="Murky Ring", --DT -10 (Stikini Ring +1)
		right_ring="Shneddick Ring", --Mv. Speed +18% (Stikini Ring +1)
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5 (Regen +5)
	}

------------------------------------------------------------------------------------------------------------
-- Defense Sets
------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken ###
	sets.defense.PDT = { --DT -50
		main="Marin Staff +1",
		sub="Khonsu", --DT -6
		ammo="Ghastly Tathlum +1",
		head="Nyame Helm", --DT -7
		body="Nyame Mail", --DT -9
		hands="Nyame Gauntlets", --DT -7
		legs="Nyame Flanchard", --DT -8
		feet="Nyame Sollerets", --DT -7
		neck="Loricate Torque +1", --DT -6
		waist="Plat. Mog. Belt", --DT -3
		left_ear="Alabaster Earring", --DT -5
		right_ear="Etiolation Earring",
		left_ring="Murky Ring", --DT -10
		right_ring="Archon Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}, --DT -5
	}

  -- Magical Damage Reduction
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ear="Arete del Luna",
		right_ring="Shneddick Ring",
	})
	
  -- Magic evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		body="Shamash Robe",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Etoilation Earring"
	})

-- ### Misc. Defensive Sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}
    sets.latent_refresh = {}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
		
------------------------------------------------------------------------------------------------------------
-- Engaged Sets
------------------------------------------------------------------------------------------------------------
-- ### Engaged Set ###
	sets.engaged = {}
	sets.engaged.Acc = {}
	sets.engaged.FullAcc = {}
    sets.engaged.DT = {}

------------------------------------------------------------------------------------------------------------
-- Weaponskill sets
------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill set ###
	sets.precast.WS = {}

-- ### Specific weaponskill sets ###
  -- Club weaponskills
	-- Black Halo
	sets.precast.WS["Black Halo"] = {}
	
  -- Staff weaponskills
	-- Earth Crusher
	sets.precast.WS["Earth Crusher"] = {}
	
	-- Vidohunir
	sets.precast.WS['Vidohunir'] = {}

	-- Myrkr
    sets.precast.WS['Myrkr'] = {}	
	sets.MaxTPMyrkr = {}

-- ### Weapons sets ###
	sets.weapons.None = {}
	sets.weapons.Staff = {main="Marin Staff +1", sub="Khonsu"}
	sets.weapons.Club = {main="Bunzi's Rod", sub="Sors Shield"}

------------------------------------------------------------------------------------------------------------
-- Miscelaneous sets
------------------------------------------------------------------------------------------------------------
-- ### Conserve MP set for miscelanous spells such as teleport/warp ###
	sets.ConserveMP = { --Conserve MP +22
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Conserve MP +6
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --Conserve MP +6
		left_ear="Magnetic Earring", --Conserve MP +5
		back="Solemnity Cape", --Conserve MP +5
	}
	
	sets.midcast.Recall = sets.ConserveMP
	sets.midcast.Retrace = sets.conserveMP
	sets.midcast.Teleport = sets.ConserveMP
	sets.midcast.Warp = sets.ConserveMP

-- ### Sublimation sets ###
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}	
	
-- ### Treasure Hunter set ###
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		ammo="Per. Lucky Egg",
		feet="Volte Boots",
		waist="Chaac Belt",
	})

-- ### Situational sets that are equipped when a buff/condition is active ###
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
    
  -- Mana Wall
	sets.buff['Mana Wall'] = {
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
		feet="Wicce Sabots +3",
	}
	
  -- Reive Mark (Active during colonization and lair reives)
	sets.buff['Reive Mark'] = {neck="Arciela's Grace +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end