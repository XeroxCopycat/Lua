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
-------------------------------------------------------------------------------------------------------------------
-- Start defining the sets
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
    sets.precast.JA['Mana Wall'] = {}
    sets.precast.JA.Manafont = {}

--------------------------------------
-- Fast cast sets for spells
--------------------------------------
    sets.precast.FC = { --FC +62/80
		ammo="Ghastly Tathlum +1", -- Sapience Orb
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Agwu's Gages", --FC +6
		legs="Agwu's Slops", --FC +7
		feet="Agwu's Pigaches", --FC +4
		neck="Voltsurge Torque", --FC +5
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Jhakri Ring", 
		right_ring="Medada's Ring", --FC +10
		back="Solemnity Cape",
	}
	
--------------------------------------
-- Fast cast sets for specific spells
--------------------------------------
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
	

-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast set
--------------------------------------
    sets.midcast.FastRecast = { --FC +62/80
		ammo="Ghastly Tathlum +1", -- Sapience Orb
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}}, --FC +14
		body="Agwu's Robe", --FC +8
		hands="Agwu's Gages", --FC +6
		legs="Agwu's Slops", --FC +7
		feet="Agwu's Pigaches", --FC +4
		neck="Voltsurge Torque", --FC +5
		waist="Embla Sash", --FC +5
		left_ear="Etiolation Earring", --FC +1
		right_ear="Loquac. Earring", --FC +2
		left_ring="Jhakri Ring", 
		right_ring="Medada's Ring", --FC +10
		back="Solemnity Cape",
	}

--------------------------------------
-- Dark magic sets
--------------------------------------
    sets.midcast['Dark Magic'] = {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Agwu's Pigaches",
		neck="Erra Pendant",
		waist="Refoccilation Stone",
		left_ear="Sortiarius Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back="Solemnity Cape",
	}


  -- Drain
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head="Pixie Hairpin +1",
		--waist="Fucho-no-Obi",
		--left_ring="Archon Ring",
	})
    
	
  -- Aspir
    sets.midcast.Aspir = sets.midcast.Drain
	
	
  -- Aspir, death mode
	sets.midcast.Aspir.Death = sets.midcast.Drain
	
	
  -- Comet
	sets.midcast.Comet = set_combine(sets.midcast['Dark Magic'], {})
	
	
  -- Death
	sets.midcast.Death = set_combine(sets.midcast['Dark Magic'], {})
	
  -- Stun
	sets.midcast.Stun = {}
		
    sets.midcast.Stun.Resistant = sets.midcast.Stun
	

--------------------------------------
-- Divine magic sets
--------------------------------------
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})


--------------------------------------
-- Elemental magic sets
--------------------------------------
    -- Elemental magic nukes
	sets.midcast['Elemental Magic'] = {
		main="Marin Staff +1",
		sub="Khonsu",
		ammo="Ghastly Tathlum +1",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Sibyl Scarf",
		waist="Acuity Belt +1",
		left_ear="Sortiarius Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back="Solemnity Cape",
	}
	
	
	-- Elemental magic nukes, Resistant
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	
	-- Elemental enfeebles
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {})
	
	-- Elemental Magic nukes, high tier
	sets.midcast['Elemental Magic'].HighTierNuke = sets.midcast['Elemental Magic']
	
	
	-- Elemental Magic nukes, high tier resistant
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	
	-- Magic Burst gear.
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
	
	
	-- Proc gear (minimum damage, max recast)
    sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast['Elemental Magic'], {})
	
	
	-- Recover MP gear
	sets.RecoverMP = {
		body="Spaekona's Coat"
	}
	
	
	-- Specific Spells
	 -- Helix (/sch)
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
	
	-- Impact
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {})
	 
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})
	
	
--------------------------------------
-- Enhancing magic sets
--------------------------------------
	sets.midcast['Enhancing Magic'] = {}
    
	
  -- Specific spells
	-- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		legs="Shedir Seraweels",
	})
	
	-- BarSpells
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {
		legs="Shedir Seraweels",
	})
	
	-- Refresh
	--sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	-- Stoneskin
    --sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	

--------------------------------------
-- Enfeebling magic sets
--------------------------------------
    sets.midcast['Enfeebling Magic'] = {
		ammo="Ghastly Tathlum +1",
		head="Jhakri Coronal +2",
		body="Agwu's Robe",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Erra Pendant",
		waist="Refoccilation Stone",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Medada's Ring",
		back="Solemnity Cape",
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


--------------------------------------
-- Healing Magic
--------------------------------------
    sets.midcast.Cure = {
		main="Bunzi's Rod",
		sub="Sors Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
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


-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Idle set
--------------------------------------
	sets.idle = { --DT -39, Refresh +7~8
		main="Marin Staff +1", 
		sub="Khonsu",						--DT -6
		head="Befouled Crown", 				--Refresh +1
		body="Jhakri Robe +2", 				--Refresh +4
		hands="Nyame Gauntlets",			--DT -7
		legs="Assid. Pants +1", 			--Refresh +1~2
		feet="Nyame Sollerets",				--DT -7
		neck="Sibyl Scarf", 				--Refresh +1
		waist="Plat. Mog. Belt",
		left_ear="Lugalbanda Earring",
		right_ear="Alabaster Earring",		--DT -5
		left_ring="Shneddick Ring",			
		right_ring="Murky Ring",			--DT -10
		back="Solemnity Cape",				--DT -4
	}
	
	
  -- Refresh idle set
    sets.idle.Refresh = set_combine(sets.idle, {})
	
	
  -- Regen idle set, max regen
	sets.idle.Regen = set_combine(sets.idle, {})


  -- Death idle set, prioritizes mp and refresh
	sets.idle.Death = set_combine(sets.idle, {})

  -- Weakened idle set
    sets.idle.Weak = sets.idle
	
	
--------------------------------------
-- Resting set
--------------------------------------
    sets.resting = {}


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical Damage Reduction
	--------------------------------------
    sets.defense.PDT = { --DT -72/50
		main="Marin Staff +1",				
		sub="Khonsu",						--DT -6
		ammo="Ghastly Tathlum +1",			--Staunch Tathlum +1
		head="Nyame Helm",					--DT -7
		body="Nyame Mail",					--DT -9
		hands="Nyame Gauntlets",			--DT -7
		legs="Nyame Flanchard",				--DT -8
		feet="Nyame Sollerets",				--DT -7
		neck="Loricate Torque +1",			--DT -6
		waist="Plat. Mog. Belt",			--DT -3
		left_ear="Lugalbanda Earring",		
		right_ear="Alabaster Earring",		--DT -5
		left_ring="Shneddick Ring",			
		right_ring="Murky Ring",			--DT -10
		back="Solemnity Cape",				--DT -4
	}


	--------------------------------------
	-- Magical Damage Reduction
	--------------------------------------
	sets.defense.MDT = set_combine(sets.defense.PDT, {})
	
	
	--------------------------------------
	-- Magic evasion
	--------------------------------------
    sets.defense.MEVA = set_combine(sets.defense.PDT, {})


--------------------------------------
-- Misc. Defensive Sets
--------------------------------------
	sets.Kiting = {left_ring="Shneddick Ring"}
    sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	

--------------------------------------
-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
    sets.buff['Mana Wall'] = {
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
		feet="Wicce Sabots +3",
	}
	
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Engaged Set
	--------------------------------------
    -- Normal melee group
    sets.engaged = {}
		
    sets.engaged.DT = {}


	

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill set
--------------------------------------
    sets.precast.WS = {}

--------------------------------------
-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
--------------------------------------
--------------------------------------
-- Club weaponskills
--------------------------------------
-- Black Halo
	sets.precast.WS["Black Halo"] = {}
	
	
--------------------------------------
-- Staff weaponskills
--------------------------------------
  -- Earth Crusher
	sets.precast.WS["Earth Crusher"] = {}
	
  -- Vidohunir
	sets.precast.WS['Vidohunir'] = {}

  -- Myrkr
    sets.precast.WS['Myrkr'] = {}
		
	sets.MaxTPMyrkr = {}

	
--------------------------------------
-- Weapons sets
--------------------------------------
	sets.weapons.None = {}
	sets.weapons.Staff = {main="Marin Staff +1", sub="Khonsu"}
	sets.weapons.Club = {main="Bunzi's Rod", sub="Sors Shield"}


-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Sublimation sets
--------------------------------------
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}	
	
--------------------------------------
-- Treasure Hunter set
--------------------------------------
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		ammo="Per. Lucky Egg",
		head="Volte Cap",
		feet="Volte Boots",
		waist="Chaac Belt",
	})
    

--------------------------------------
-- equip to maximize HP and minimize MP loss before using convert
--------------------------------------
    sets.precast.JA.Convert = {}

--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end