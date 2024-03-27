function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','DDTank','Normal')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None', 'AbsorbMP')
    state.PhysicalDefenseMode:options( 'PDT_HP','PDT','PDT_Reraise')
    state.MagicalDefenseMode:options( 'MDT_HP','MDT','MDT_Reraise')
	state.ResistDefenseMode:options( 'MEVA_HP','MEVA')
	state.IdleMode:options('Tank', 'Kiting', 'PDT', 'Block', 'MDT', 'Normal')
	state.Weapons:options('None', 'SakpataAegis', 'SakpataOchain', 'NaeglingBlurred', 'NaeglingPriwen', 'ClubOchain')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind ^q gs c set IdleMode Kiting')
	send_command('bind !q gs c set IdleMode PDT')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body="Chev. Cuirass +3",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +3",
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Cacoethic Ring +1",
		right_ring="Vengeful Ring",
		back={ name="Weard Mantle", augments={'VIT+5','DEX+1','Enmity+7','Phalanx +3',}},}
		
    sets.Enmity.SIRD = {
		ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",
		body="Chev. Cuirass +3",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Founder's Hose", augments={'MND+3','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Cacoethic Ring +1",
		right_ring="Vengeful Ring",
		back={ name="Weard Mantle", augments={'VIT+5','DEX+1','Enmity+7','Phalanx +3',}},
	}
		
    sets.Enmity.DT = {
		ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Weard Mantle", augments={'VIT+5','DEX+1','Enmity+7','Phalanx +3',}},
	}
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +2"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{head="Cab. Coronet +1"})
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +3"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {head="Rev. Coronet +1", body="Cab. Surcoat +1"})
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +2"})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{head="Cab. Coronet +1"}) 
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +3"})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {head="Rev. Coronet +1", body="Cab. Surcoat +1"})
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",left_ear="Nourish. Earring",right_ear="Nourish. Earring +1",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +1",ring1="Stikini Ring +1",ring2="Rufescent Ring",
		back=gear.enmity_jse_back,waist="Luminary Sash",legs="Nyame Flanchard",feet="Carmine Greaves +1"}
		
    sets.precast.JA['Chivalry'].DT = {ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",left_ear="Odnowa Earring +1",right_ear="Tuisto Earring",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Luminary Sash",legs="Nyame Flanchard",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1", left_ear="Knightly Earring",})	
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +1", left_ear="Knightly Earring",})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Unmoving Collar +1",left_ear="Odnowa Earring +1",right_ear="Tuisto Earring",
		body="Rev. Surcoat +3",hands="Regal Gauntlets",ring1="Asklepian Ring",ring2="Valseur's Ring",
		back="Moonlight Cape",waist="Chaac Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Aurgelmir Orb +1",
        head="Carmine Mask +1",neck="Combatant's Torque",left_ear="Mache Earring +1",right_ear="Telos Earring",
        body="Flamma Korazin +2",hands="Regal Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Flam. Gambieras +2"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Erra Pendant",left_ear="Gwati Earring",right_ear="Digni. Earring",
        body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		main="Sakpata's Sword",
		ammo="Sapience Orb",
		head="Chev. Armet +3",
		body="Rev. Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Chev. Sabatons +3",
		neck="Baetyl Pendant",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
    sets.precast.FC.DT = {
		main="Sakpata's Sword",
		ammo="Sapience Orb",
		head="Chev. Armet +3",
		body="Rev. Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Chev. Sabatons +3",
		neck="Baetyl Pendant",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {left_ear="Mendi. Earring",	right_ear="Nourish. Earring +1"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Aurgelmir Orb",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}
		
	sets.precast.WS.Acc = {
		ammo="Aurgelmir Orb",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Kentarch Belt",
		left_ear="Mache Earring",
		right_ear="Telos Earring",
		left_ring="Cornelia's Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.precast.WS.DT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}

    

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	-- Dagger Weaponskills
	sets.precast.WS['Aeolian Edge'] = {
		ammo="Pemphredo Tathlum",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		--legs="Augury Cuirass +1",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	
	-- Sword Weaponskills
	-- Atonement
	--sets.precast.WS['Atonement'] = {ammo="Paeapua",
        --head="Loess Barbuta +1",neck="Moonlight Necklace",left_ear="Friomisi Earring",right_ear="Trux Earring",
        --body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        --back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Eschite Greaves"}
	
	-- Chant du Cygne
	sets.precast.WS['Chant du Cygne'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		--head="Blistering Sallet +1" --Needs augmented
		head={ name="Nyame Helm", augments={'Path: B',}},
		--head="Agony Jerkin +1" --Needs augmented
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Flam. Manopolas +2",
		--legs="Lust. Subligar +1" --Path B
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		--legs="Lust. Leggings +1" --Path D
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		--left_ear="Mache Earring +1",
		left_ear="Mache Earring",
		--right_ear="Lugra Earring +1", --Needs Augmented
		right_ear="Thrud Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Regal Ring",
		--Cape is DEX +30, WSD +10%
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget", left_ear="Mache Earring +1", right_ear="Moonshade Earring"})
	
	
	-- Flat Blade
	sets.precast.WS['Flat Blade'] = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Flamma Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS['Flat Blade'], {left_ear="Mache Earring", right_ear="Telos Earring"})
	
	
	-- Requiescat
	sets.precast.WS['Requiescat'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hjarrandi Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Requiescat'], {left_ear="Mache Earring", right_ear="Telos Earring"})
	
	
	-- Sanguine Blade
    sets.precast.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Cornelia's Ring",
		right_ring="Archon Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Requiescat'], {})
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Regal Ring",
		--Cape is STR +30, WSD +10%
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {left_ear="Mache Earring",right_ear="Telos Earring"})
	
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {left_ear="Cessance Earring",right_ear="Brutal Earring",}
	sets.AccMaxTP = {left_ear="Mache Earring +1",right_ear="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {
		main="Sakpata's Sword",
		ammo="Sapience Orb",
		head="Chev. Armet +3",
		body="Rev. Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Chev. Sabatons +3",
		neck="Baetyl Pendant",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}
		
	sets.midcast.FastRecast.DT = {
		main="Sakpata's Sword",
		ammo="Sapience Orb",
		head="Chev. Armet +3",
		body="Rev. Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Chev. Sabatons +3",
		neck="Baetyl Pendant",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {
		main="Sakpata's Sword",
		--sub="Sacro Bulwark",
		ammo="Staunch Tathlum +1",
		head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		body="Chev. Cuirass +3",
		hands="Macabre Gaunt. +1",
		legs={ name="Founder's Hose", augments={'MND+3','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Knightly Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}
		
    sets.midcast.Cure.SIRD = {
		--main="Deacon Sword",
		--sub="Sacro Bulwark",
		ammo="Staunch Tathlum +1",
		head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		body="Chev. Cuirass +3",
		hands="Macabre Gaunt. +1",
		legs={ name="Founder's Hose", augments={'MND+3','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Loricate Torque +1",
		waist="Audumbla Sash",
		left_ear="Mendi. Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}
		
    sets.midcast.Cure.DT = {
		--main="Deacon Sword",
		--sub="Sacro Bulwark",
		ammo="Staunch Tathlum +1",
		head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}
		
    sets.midcast.Reprisal = {
		main="Sakpata's Sword",
		ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}

	sets.Self_Healing = {
		--main="Deacon Sword",
		--sub="Sacro Bulwark",
		ammo="Staunch Tathlum +1",
		head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		body="Chev. Cuirass +3",
		hands="Macabre Gaunt. +1",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Audumbla Sash",
		left_ear="Mendi. Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
	sets.Self_Healing.SIRD = {
		ammo="Staunch Tathlum +1",
		head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		body="Chev. Cuirass +3",
		hands="Macabre Gaunt. +1",
		legs={ name="Founder's Hose", augments={'MND+3','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Loricate Torque +1",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
	sets.Self_Healing.DT = {
		ammo="Staunch Tathlum +1",
		head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {main="Colada",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",neck="Incanter's Torque",left_ear="Mimir Earring",right_ear="Andoaa Earring",
		body="Shab. Cuirass +1",hands="Regal Gauntlets",ring1="Defending Ring",ring2="Kishar Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
    sets.midcast['Enhancing Magic'].SIRD = {main="Colada",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Incanter's Torque",left_ear="Mimir Earring",right_ear="Tuisto Earring",
		body="Shab. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Rev. Leggings +3",feet="Odyssean Greaves"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
		main="Sakpata's Sword",
		sub="Priwen",
		hands="Souv. Handschuhs",
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs +1",
		back="Weard Mantle",
	})
	
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {
		main="Sakpata's Sword",
		sub="Priwen",
		hands="Souv. Handschuhs",
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs +1",
		back="Weard Mantle",
	})
	
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	
	sets.Phalanx_Received = {
		main="Sakpata's Sword",
		sub="Priwen",
		hands="Souv. Handschuhs",
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs +1",
		back="Weard Mantle",
	}
	
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",left_ear="Etiolation Earring",right_ear="Ethereal Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Fucho-no-obi",legs="Sulev. Cuisses +2",feet="Cab. Leggings +1"}

    -- Idle sets
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Rev. Surcoat +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Hippo. Socks +1",
		neck="Sibyl Scarf",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},}
		
    sets.idle.PDT = {
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Warden's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
    sets.idle.Block = {
		--main="Deacon Sword",
		--sub="Sacro Bulwark",
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.idle.MDT = {
		main="Sakpata's Sword",
		--sub="Aegis",
		sub="Priwen",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Archon Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}


	sets.idle.Tank = {
		main="Sakpata's Sword",
		--sub="Ochain",
		sub="Priwen",
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs="Chev. Cuisses +3",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.idle.Kiting = {main="Sakpata's Sword",
		--sub="Sacro Bulwark",
		sub="Priwen",
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Hippo. Socks +1",
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Warden's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Coatl Gorget +1",right_ear="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
	sets.passive.AbsorbMP = {head="Chev. Armet +3", body="Tartarus Platemail", feet="Rev. Leggings +2", waist="Flume Belt +1",}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.SakpataAegis = {main="Sakpata's Sword", sub="Priwen"}
	sets.weapons.NaeglingBlurred = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.NaeglingPriwen = {main="Naegling", sub="Priwen"}
	sets.weapons.SakpataOchain = {main="Sakpata's Sword", sub="Priwen"}
	sets.weapons.ClubOchain = {main="Mafic Cudgel", sub="Ochain"}
	sets.weapons.DualWeapons = {main="Naegling", sub="Demersal Degen +1"}
    
    sets.defense.Block = {
		main="Sakpata's Sword",
		--sub="Duban",
		sub="Blurred Shield +1",
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.defense.PDT = {
		main="Sakpata's Sword",
		--sub="Duban",
		sub="Blurred Shield +1",
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Warden's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.defense.PDT_HP = {
		main="Sakpata's Sword",
		--sub="Duban",
		sub="Blurred Shield +1",
		ammo="Staunch Tathlum +1",
		head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
	sets.defense.MDT = {
		--main="Malignance Sword",
		--sub="Duban",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Archon Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
		
    sets.defense.MDT_HP = {
		--main="Malignance Sword",
		--sub="Duban",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Archon Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.defense.MEVA = {
		--main="Malignance Sword",
		--sub="Aegis",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
    sets.defense.MEVA_HP = {
		--main="Malignance Sword",
		--sub="Aegis",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
    sets.defense.PDT_Reraise = set_combine(sets.defense.PDT_HP,{head="Twilight Helm",body="Twilight Mail"})
    sets.defense.MDT_Reraise = set_combine(sets.defense.MDT_HP,{head="Twilight Helm",body="Twilight Mail"})
		
	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

    sets.engaged.Acc = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Flam. Gambieras +2",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

    sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

	sets.engaged.Tank = {main="Sakpata's Sword",sub="Ochain",
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body="Tartarus Platemail",
		hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs="Chev. Cuisses +3",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Digni. Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Warden's Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
	sets.engaged.DDTank = {
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Tartarus Platemail",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Loricate Torque +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Warden's Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
	sets.engaged.Acc.DDTank = {
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Tartarus Platemail",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Loricate Torque +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring",
		right_ear="Telos Earring",
		left_ring="Warden's Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
	sets.engaged.NoShellTank = {
		main="Sakpata's Sword",
		--sub="Ochain",
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Rev. Surcoat +3",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+1','"Dbl.Atk."+4','Attack+14',}},
		feet={ name="Cab. Leggings +3", augments={'Enhances "Guardian" effect',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
	}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +3"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'BLU' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 6)
    else
        set_macro_page(1, 6) --War/Etc
    end
end