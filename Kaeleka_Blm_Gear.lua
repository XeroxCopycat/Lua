function user_job_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen')
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal','DT')
	state.IdleMode:options('Normal','PDT','DTHippo')
	state.Weapons:options('None','BurstWeapons','Khatvanga','Lathi')

	gear.nuke_jse_back = {name="Taranus's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.stp_jse_back = {name="Taranus's Cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}

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
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Fast cast for elemental Magic
	sets.precast.FC['Elemental Magic'] = sets.precast.FC
	
	-- Fast cast for enhancing magic
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	-- Specific Spells
	  -- Cure
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
		sub="Oneiros Grip",
		right_ear="Mendi. Earring",
	})
	  -- Curaga
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	  -- Death
	sets.precast.FC.Death = set_combine(sets.precast.FC, {
		body={ name="Agwu's Robe", augments={'Path: A',}}, 
		hands={ name="Agwu's Gages", augments={'Path: A',}},
		right_ring="Mephitas's Ring +1",
	})
	  -- Dispelga
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Genmei Shield"})
	  -- Impact
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
	  -- Stoneskin
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
    -- Precast sets to enhance JAs
      -- Mana Wall
	sets.precast.JA['Mana Wall'] = {
		feet="Wicce Sabots +3"
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	  -- Manafont
	sets.precast.JA.Manafont = {body="Arch. Coat +3}
	
	
	--------------------------------------
	-- Sublimation sets
	--------------------------------------
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	
	--------------------------------------
	-- Treasure Hunter
	--------------------------------------
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		ammo="Per. Lucky Egg",
		head="Volte Cap",
		feet="Volte Boots",
		waist="Chaac Belt",
	})
	
	
	--------------------------------------
	-- Weapon sets
	--------------------------------------
	sets.weapons.BurstWeapons = {main={ name="Marin Staff +1", augments={'Path: A',}}, sub="Enki Strap"}
	sets.weapons.Club = {main={ name="Bunzi's Rod", augments={'Path: A',}}, sub="Ammurapi Shield"}
	sets.weapons.Staff = {main="Malignance Pole", sub="Ajja Grip",}
    
	
------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Fast Recast Set
	--------------------------------------
    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Zendik Robe",hands="Volte Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Cure = {main=gear.gada_healing_club,sub="Sors Shield",ammo="Hasty Pinion +1",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Zendik Robe",hands="Telchine Gloves",ring1="Janniston Ring",ring2="Menelaus's Ring",
        back="Tempered Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Vanya Clogs"}
		
    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Vanya Hood",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Janniston Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Psycloth Lappas",feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Vanya Hood",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Zendik Robe",hands="Telchine Gloves",ring1="Janniston Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Psycloth Lappas",feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",back="Oretan. Cape +1"})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club,sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Perimede Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif +1",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

    sets.midcast['Enfeebling Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Mall. Chapeau +2",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +3",hands="Regal Cuffs",ring1="Kishar Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
    sets.midcast['Enfeebling Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Mall. Chapeau +2",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +3",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}
		
    sets.midcast.ElementalEnfeeble = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Mall. Chapeau +2",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +3",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Mallquis Trews +2",feet="Mallquis Clogs +2"}
		
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Ea Hat +1",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Ea Hat +1",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak",sub="Ammurapi Shield"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {main="Daybreak",sub="Ammurapi Shield"})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +3",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +3",hands="Regal Cuffs",ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Merlinic Shalwar",feet="Agwu's Pigaches"}
    
    sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Aspir.Death = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
	
	sets.midcast.Death = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Mizu. Kubikazari",ear1="Malignance Earring",ear2="Etiolation Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet="Amalric Nails +1"}

	sets.midcast.Comet = {main="Lathi",sub="Enki Strap",ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",neck="Saevus Pendant +1",ear1="Malignance Earring",ear2="Regal Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Freke Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet="Amalric Nails +1"}
	
	    sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
        head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
        body="Zendik Robe",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Zendik Robe",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Witful Belt",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}

    sets.midcast.BardSong = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
        head="Amalric Coif +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Regal Earring",
        body="Zendik Robe",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Luminary Sash",legs="Merlinic Shalwar",feet="Medium's Sabots"}
		
	sets.midcast.Impact = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
		body="Twilight Cloak",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Mallquis Trews +2",feet="Mallquis Clogs +2"}
		
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
        head="Agwu's Cap",neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
        back=gear.nuke_jse_back,waist="Sekhmet Corset",legs="Merlinic Shalwar",feet="Amalric Nails +1"}
		
    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Agwu's Cap",neck="Sanctity Necklace",ear1="Malignance Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Mallquis Cuffs +2",ring1="Freke Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet="Agwu's Pigaches"}
		
	sets.midcast['Elemental Magic'].HighTierNuke = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
        head="Merlinic Hood",neck="Saevus Pendant +1",ear1="Malignance Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet="Amalric Nails +1"}
	
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Malignance Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet="Jhakri Pigaches +2"}
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main=empty,sub=empty,ammo="Impatiens",
        head="Vanya Hood",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Loquac. Earring",
        body="Spaekona's Coat +3",hands="Regal Cuffs",ring1="Kishar Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Assid. Pants +1",feet="Regal Pumps +1"}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {main="Khatvanga",sub="Bloodrain Strap",ammo="Seraphic Ampulla",
        head="Mall. Chapeau +2",neck="Combatant's Torque",ear1="Dedition Earring",ear2="Telos Earring",
        body=gear.merlinic_occult_body,hands=gear.merlinic_occult_hands,ring1="Rajas Ring",ring2="Petrov Ring",
        back=gear.stp_jse_back,waist="Oneiros Rope",legs="Perdition Slops",feet=gear.merlinic_occult_feet}
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +3"}

	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Ea Hat +1",neck="Mizukage-no-Kubikazari",ear1="Malignance Earring",ear2="Regal Earring",
		body="Ea Houppe. +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Mujin Band",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Ea Slops +1",feet="Amalric Nails +1"}

	sets.ResistantMagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Ea Hat +1",neck="Mizukage-no-Kubikazari",ear1="Malignance Earring",ear2="Regal Earring",
		body="Ea Houppe. +1",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Ea Slops +1",feet="Amalric Nails +1"}
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Etiolation Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Umbra Cape",waist="Carrier's Sash",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}


-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default weaponskill gear
	--------------------------------------
    sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Combatant's Torque",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Freke Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-6%',}},
	}

	--------------------------------------
	-- Specific weaponskill sets.	
	--------------------------------------
	--------------------------------------
	-- Club Weaponskills
	--------------------------------------
	
	
	--------------------------------------
	-- Staff Weaponskills
	--------------------------------------
	-- Cataclysm
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		ammo="Sroda Tathlum",
		head="Pixie Hairpin +1",
		hands="Wicce Gloves +3",
		neck="Saevus Pendant +1",
		waist="Orpheus's Sash",
		right_ear="Malignance Earring",
		right_ring="Archon Ring",
	})
	
	-- Earth Crusher
	sets.precast.WS['Earth Crusher'] = set_combine(sets.precast.WS,{
		ammo="Sroda Tathlum",
		head="Agwu's Cap",
		hands="Wicce Gloves +3",
		neck="Saevus Pendant +1",
		right_ear="Malignance Earring",
		right_ring="Archon Ring",
	})
	
	-- Myrkr
    sets.precast.WS['Myrkr'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		head="Wicce Petasos +3",
		body="Wicce Coat +3",
		hands="Spae. Gloves +2",
		legs="Spae. Tonban +3",
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		neck="Sanctity Necklace",
		waist="Carrier's Sash",
		right_ear="Loquac. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
		
	sets.MaxTPMyrkr = {right_ear="Etiolation Earring"}
	
    -- Vidohunir
	sets.precast.WS['Vidohunir'] = {}
	
	
	--------------------------------------
	-- Scythe Weaponskills
	--------------------------------------


	
	
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Base Idle Set
	--------------------------------------
    sets.idle = {
		main="Malignance Pole",
		sub="Oneiros Grip",
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
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {
		main="Daybreak",
		sub="Ammurapi Shield",
		--left_ring="Stikini Ring +1",
		--right_ring="Stikini Ring +1",
	})

	-- Regen Set
	sets.idle.Regen = set_combine(sets.idle, {
		main="Malignance Pole",
		sub="Oneiros Grip",
		neck="Sanctity Necklace",
		right_ear="Dawn Earring",
		left_ring="Chirich Ring +1",
		--right_ring="Chirich Ring +1",
	})
	
	-- Death mode idle
	sets.idle.Death = set_combine(sets.idle, {
		head="Pixie Hairpin +1",
		feet="Wicce Sabots +3",
		neck="Loricate Torque +1",
		right_ear="Loquac. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
	})
 

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
    sets.engaged = {
		ammo="Amar Cluster",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Combatant's Torque",
		waist="Grunfeld Rope",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Chirich Ring +1",
		right_ring="Petrov Ring",
		back="Aurist's Cape",
	}
		
    sets.engaged.DT = set_combine(sets.engaged, {waist="Plat. Mog. Belt", left_ring="Defending Ring"})


	--------------------------------------
	-- Special Sets
	--------------------------------------
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end