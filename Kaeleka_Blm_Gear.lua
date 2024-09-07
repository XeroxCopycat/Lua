function user_job_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal', 'Resistant', 'Proc', 'OccultAcumen')
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'DT')
	state.IdleMode:options('Normal', 'Refresh', 'Regen', 'DT')
	state.Weapons:options('None', 'BurstWeapons', 'Staff', 'Club')


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
	-- Weapons sets
	--------------------------------------
	sets.weapons.BurstWeapons = {main={ name="Bunzi's Rod", augments={'Path: A',}}, sub="Ammurapi Shield"}
	sets.weapons.Staff = {main="Malignance Staff", sub="Emki Strap"}
	sets.weapons.Club = {main={ name="Bunzi's Rod", augments={'Path: A',}}, sub="Ammurapi Shield"}
	
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
    -- Precast sets to enhance JAs
	--------------------------------------
    sets.precast.JA['Mana Wall'] = {back=gear.nuke_jse_back,feet="Wicce Sabots +3"}
    sets.precast.JA.Manafont = {} body="Arch. Coat +3"
    
	--------------------------------------
    -- equip to maximize HP and minimize MP loss before using convert
	--------------------------------------
    sets.precast.JA.Convert = {}

	--------------------------------------
    -- Fast cast sets for spells
	--------------------------------------
    sets.precast.FC = {
		ammo="Impatiens",
		head={ name="Merlinic Hood", augments={'Attack+10','"Fast Cast"+7','DEX+1','Mag. Acc.+6',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+16','"Fast Cast"+6','MND+5',}},
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+7','Mag. Acc.+2','"Mag.Atk.Bns."+13',}},
		legs={ name="Agwu's Slops", augments={'Path: A',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+13','"Fast Cast"+7',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	
	--------------------------------------
    -- Fast cast sets for specific spells
	--------------------------------------
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	sets.precast.FC.Death = set_combine(sets.precast.FC, {})

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
    -- Default set for any weaponskill that isn't any more specifically defined
	--------------------------------------
    sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Saevus Pendant +1",
		waist="Fotia Belt",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Freke Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}

	--------------------------------------
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    --------------------------------------
	--------------------------------------
    -- Club weaponskills
    --------------------------------------
	-- Black Halo
	sets.precast.WS["Black Halo"] = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Cornelia's Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}
	
	
	--------------------------------------
    -- Staff weaponskills
    --------------------------------------
	-- Earth Crusher
	sets.precast.WS["Earth Crusher"] = {
		ammo="Sroda Tathlum",
		head={ name="Agwu's Cap", augments={'Path: A',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Wicce Gloves +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Saevus Pendant +1",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring="Cornelia's Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}
	
	-- Vidohunir
	sets.precast.WS['Vidohunir'] = {}

	-- Myrkr
    sets.precast.WS['Myrkr'] = {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Wicce Coat +3",
		hands="Spae. Gloves +2",
		legs="Spae. Tonban +3",
		feet="Wicce Sabots +3",
		neck="Sanctity Necklace",
		waist="Belisama's Rope +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Etiolation Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Lebeche Ring",
		back="Aurist's Cape",
	}
		
	sets.MaxTPMyrkr = {ear1="Evans Earring",ear2="Etiolation Earring"}
    
    
-------------------------------------------------------------------------------------------------------------------
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
    -- Fast Recast set
    --------------------------------------
    sets.midcast.FastRecast = {
		ammo="Impatiens",
		head={ name="Merlinic Hood", augments={'Attack+10','"Fast Cast"+7','DEX+1','Mag. Acc.+6',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+16','"Fast Cast"+6','MND+5',}},
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+7','Mag. Acc.+2','"Mag.Atk.Bns."+13',}},
		legs={ name="Agwu's Slops", augments={'Path: A',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+13','"Fast Cast"+7',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
    -- Cure sets
    --------------------------------------
    sets.midcast.Cure = {
		main="Daybreak",
		sub="Sors Shield",
		ammo="Impatiens",
		head={ name="Merlinic Hood", augments={'Attack+10','"Fast Cast"+7','DEX+1','Mag. Acc.+6',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+16','"Fast Cast"+6','MND+5',}},
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+7','Mag. Acc.+2','"Mag.Atk.Bns."+13',}},
		legs={ name="Agwu's Slops", augments={'Path: A',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+13','"Fast Cast"+7',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back="Solemnity Cape",
	}
	
	-- Cure Lightsday / Light Weather
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi"})
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi"})

	-- Curaga set
    sets.midcast.Curaga = sets.midcast.Cure
	
	-- Cursna set
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {right_ring="Menelaus's Ring"})
	
	-- Status removal set
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	--------------------------------------
    -- Elemental magic sets
    --------------------------------------
    -- Elemental magic nukes
	sets.midcast['Elemental Magic'] = {
		main={ name="Bunzi's Rod", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo="Sroda Tathlum",
		head="Wicce Petasos +3",
		body="Spaekona's Coat +3",
		hands="Wicce Gloves +3",
		legs="Wicce Chausses +3",
		feet="Wicce Sabots +3",
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Freke Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}
	
	
	-- Elemental magic nukes, Resistant
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	
	-- Elemental enfeebles
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'], {
		ammo="Pemphredo Tathlum",
		hands="Spae. Gloves +2", -- Upgrade to +3
		legs={ name="Arch. Tonban +3", augments={'Increases Elemental Magic debuff time and potency',}},
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		right_ring="Kishar Ring", -- Stikini Ring +1
		back="Aurist's Cape", -- Upgrade to +1 and augment
	})
	
	-- Elemental Magic nukes, high tier
	sets.midcast['Elemental Magic'].HighTierNuke = sets.midcast['Elemental Magic']
	
	
	-- Elemental Magic nukes, high tier resistant
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {
		ammo="Pemphredo Tathlum",
	})
	
	
	-- Magic Burst gear.
    sets.MagicBurst = {
		main={ name="Bunzi's Rod", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head="Ea Hat +1",
		body="Wicce Coat +3",
		hands="Spae. Gloves +2",
		legs="Wicce Chausses +3",
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Freke Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}

	
	-- Magic burst gear, resistant
	sets.ResistantMagicBurst = set_combine(sets.MagicBurst, {ammo="Pemphredo Tathlum"})
		
	
	-- Occult Acumen gear
    sets.midcast['Elemental Magic'].OccultAcumen = {
		ammo="Pemphredo Tathlum",
		head="Mall. Chapeau +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Jhakri Slops +2",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Combatant's Torque",
		waist="Plat. Mog. Belt",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Petrov Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}
	
	
	-- Proc gear (minimum damage, max recast)
    sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast['Elemental Magic'], {
		main=empty,
		sub=empty,
		ammo="Impatiens",
		head={ name="Merlinic Hood", augments={'Attack+10','"Fast Cast"+7','DEX+1','Mag. Acc.+6',}},
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+7','Mag. Acc.+2','"Mag.Atk.Bns."+13',}},
		legs="Assid. Pants +1",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+13','"Fast Cast"+7',}},
		neck="Loricate Torque +1",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
	
	
	-- Recover MP gear
	sets.RecoverMP = {body="Spaekona's Coat +3"}
	
	
	-- Specific Spells
	 -- Helix (/sch)
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
	
	-- Impact
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		head=empty,
		body="Crepuscular Cloak",
		hands="Spae. Gloves +2",
		legs="Spae. Tonban +3",
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Jhakri Ring",
		back="Aurist's Cape",
	})
	 
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Crepuscular Cloak"})
	
	
	--------------------------------------
    -- Enhancing magic sets
    --------------------------------------
	sets.midcast['Enhancing Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",
		body="Wicce Coat +3",
		hands="Wicce Gloves +3",
		legs="Wicce Chausses +3",
		feet="Volte Gaiters",
		neck="Mizu. Kubikazari",
		waist="Embla Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mephitas's Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
    
	
	-- Specific spells
	 -- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif +1",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	 -- BarSpells
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
	 -- Refresh
	--sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	 -- Stoneskin
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	

	--------------------------------------
    -- Enfeebling magic sets
    --------------------------------------
    sets.midcast['Enfeebling Magic'] = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head=empty,
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Wicce Gloves +3", -- Regal Gloves
		legs="Wicce Chausses +3",
		feet="Wicce Sabots +3",
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}}, -- Stikini Ring +1
		right_ring="Kishar Ring", 
		back="Aurist's Cape",
	}
	
	
	-- Enfeebling magic, resistant
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
		--left_ring="Stikini Ring +1",
		--right_ring="Stikini Ring +1",
	})
	
	
	-- Enfeebling magic, INT based
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Ea Hat +1",
		body="Wicce Coat +3",
		hands="Spae. Gloves +2",
		legs="Mallquis Trews +2",
		feet="Mallquis Clogs +2",
		right_ring="Freke Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	})
	
	sets.midcast.IntEnfeebles.Resistant = sets.midcast.IntEnfeebles


	-- Enfeebling Magic, MND based
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {main="Daybreak", sub="Ammurapi Shield"})
	
	
	-- Specific Spells
	 -- Dia
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	 -- Bio
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	
	--------------------------------------
    -- Divine magic sets
    --------------------------------------
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})


	--------------------------------------
    -- Dark magic sets
    --------------------------------------
	-- Dark Magic Accuracy Set
    sets.midcast['Dark Magic'] = {
		main={ name="Bunzi's Rod", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",
		body="Spaekona's Coat +3",
		hands={ name="Arch. Gloves +3", augments={'Increases Elemental Magic accuracy',}},
		legs="Spae. Tonban +3",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+13','"Fast Cast"+7',}},
		neck="Erra Pendant",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Evanescence Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}


	-- Drain set
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head="Pixie Hairpin +1",
		waist="Fucho-no-Obi",
		left_ring="Archon Ring",
	})
    
	
	-- Aspir set
    sets.midcast.Aspir = sets.midcast.Drain
	
	
	-- Aspir set in death mode
	sets.midcast.Aspir.Death = sets.midcast.Drain
	
	
	-- Comet
	sets.midcast.Comet = set_combine(sets.midcast['Dark Magic'], {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Wicce Coat +3",
		hands="Wicce Gloves +3",
		legs="Wicce Chausses +3",
		feet="Wicce Sabots +3",
		neck="Saevus Pendant +1",
		waist="Eschan Stone",
		left_ring="Archon Ring",
		right_ring="Freke Ring",
	})
	
	
	-- Death
	sets.midcast.Death = set_combine(sets.midcast['Dark Magic'], {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Wicce Coat +3",
		hands="Wicce Gloves +3",
		legs="Wicce Chausses +3",
		feet="Wicce Sabots +3",
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist="Eschan Stone",
		right_ear="Barkaro. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Archon Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
	
	
	-- Stun
	sets.midcast.Stun = {    
		main={ name="Bunzi's Rod", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head="Wicce Petasos +3",
		body="Wicce Coat +3",
		hands="Wicce Gloves +3",
		legs="Wicce Chausses +3",
		feet="Wicce Sabots +3",
		neck="Unmoving Collar +1",
		waist="Witful Belt",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Vengeful Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}
		
    sets.midcast.Stun.Resistant = sets.midcast.Stun

	
    --------------------------------------
    -- Resting set
    --------------------------------------
    -- Resting sets
    sets.resting = {
		main="Daybreak", -- Mpaca's Staff
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Volte Beret",
		body="Wicce Coat +3",
		hands="Wicce Gloves +3",
		legs="Assid. Pants +1",
		feet="Volte Gaiters",
		neck="Sibyl Scarf",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring", -- "Stikini Ring +1"
		right_ring="Shneddick Ring", -- "Stikini Ring +1"
		back="Solemnity Cape",
	}


-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
    --------------------------------------
    -- Normal idle set
	--------------------------------------
	sets.idle = { -- Refresh +8~10
		main="Malignance Pole",
		sub="Ajja Grip",
		ammo="Staunch Tathlum +1",
		head="Volte Beret",
		body="Wicce Coat +3",
		hands="Wicce Gloves +3",
		legs="Assid. Pants +1",
		feet="Volte Gaiters",
		neck="Sibyl Scarf",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back="Solemnity Cape",
	}
	
	
	-- Refresh idle set, max refresh, Refresh +9~11 (possible +14~16)
    sets.idle.Refresh = set_combine(sets.idle, { 
		main="Daybreak", -- Mpaca's Staff
		sub="Ammurapi Shield", -- Oneiros Grip
		--hands Merlinic Gloves w/ Refresh
		--left_ring="Stikini Ring +1"
		--right_right="Stikini Ring +1"
	})
	
	
	-- Regen idle set, max regen
	sets.idle.Regen = set_combine(sets.idle, {
		main="Malignance Pole",
		sub="Oneiros Grip",
		neck="Sanctity Necklace",
		right_ear="Dawn Earring",
		left_ring="Chirich Ring +1",
		--right_ring=Chirichi Ring +1",
	})


	-- Death idle set, prioritizes mp and refresh
	sets.idle.Death = set_combine(sets.idle, {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Wicce Petasos +3",
		feet="Wicce Sabots +3",
		left_ear="Loquac. Earring",
		right_ear="Eabani Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})

	-- Weakened idle set, prioritizes dmg taken and refresh
    sets.idle.Weak = sets.idle


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical Damage Reduction
	--------------------------------------
    sets.defense.PDT = {
		main="Malignance Pole",
		sub="Ajja Grip",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back="Solemnity Cape",
	}


	--------------------------------------
	-- Magical Damage Reduction
	--------------------------------------
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
	
	--------------------------------------
	-- Magic evasion
	--------------------------------------
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		main="Daybreak",
		sub="Ammurapi Shield",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})


	sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {feet=gear.merlinic_refresh_feet}
	sets.NightIdle = {}
	
    --------------------------------------
	-- Misc. Defensive Sets
	--------------------------------------
	sets.Kiting = {right_ring="Shneddick Ring",}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.TPEat = {neck="Chrys. Torque"}
	--sets.DayIdle = {feet=gear.merlinic_refresh_feet}
	--sets.NightIdle = {}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
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
    sets.engaged = {ammo="Staunch Tathlum +1",
        head="Jhakri Coronal +2",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.stp_jse_back,waist="Olseni Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
		
    sets.engaged.DT = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.stp_jse_back,waist="Olseni Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end