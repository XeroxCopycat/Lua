function character_user_job_setup()

	state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
	state.HybridMode:options('DT', 'MEVA')
	state.WeaponskillMode:options('Normal', 'Acc', 'FullAcc', 'PDL')
	state.CastingMode:options('SIRD', 'Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Refresh', 'Regen', 'Sphere')
	state.Weapons:options('None', 'Montante', 'Agwu', 'DualNagling')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'Knockback', 'MP'}
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax', 'SubtleBlow'}
	
	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')

	select_default_macro_book()
end

function init_gear_sets()

-----------------------------------------------------------------------------------------------------------
-- START DEFINING THE SETS
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-- Precast sets
-----------------------------------------------------------------------------------------------------------
-- ### Enmity Sets ###
  -- Base enmity set
	sets.Enmity = {}
		 
  -- Emnity set w/ Spell Interuption Rate Down
	sets.Enmity.SIRD = {}
		
  -- Enmity set w/ damage taken
	sets.Enmity.DT = {}
	
-- ### Fast cast sets for spells ###
	sets.precast.FC = { --FC +54/80, QC +2
		ammo="Impatiens", --QC +2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14 (Rune. Bandeau +4)
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8 (Erilaz Surcoat +3)
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Aya. Cosciales +2", --FC +6
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Voltsurge Torque", --FC +4
		waist="Carrier's Sash", --(Witful Belt)
		left_ear="Loquac. Earring", --FC +2
		right_ear="Etiolation Earring", --FC +1
		left_ring="Lebeche Ring", --QC +2
		right_ring="Kishar Ring", --FC +4
		back="Solemnity Cape", --(Ambu. Cape w/ +10 FC)
	}
	
	sets.precast.FC.Inspiration = {}
	sets.precast.FC.DT = {}
		
  -- Enhancing Magic Fast Cast set
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
  -- Fast Cast sets for specific spells	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga Beads'})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Liement'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
	sets.precast.JA['One for All'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

  -- Precast sets to enhance JAs, damage taken
	sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist's Coat +3", legs="Futhark Trousers +1"})
	sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
	sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist's Boots +3"})
	sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Futhark Bandeau +1"})
	sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +1"})
	sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +3"})
	sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Boots +1"})
	sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +1"})
	sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons +1"})
	sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['One for All'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

	sets.precast.JA['Lunge'] = {}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring1="Archon Ring"}

-- ### Vivacious Pulse sets ###
	sets.precast.JA['Vivacious Pulse'] = {}
	sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
-- ### /DNC Curing Waltz set (chr and vit) ###
	sets.precast.Waltz = {}
	sets.precast.Waltz['Healing Waltz'] = {}	
	
-- ### /DNC step sets ###
	sets.precast.Step = {}
	sets.precast.JA['Violent Flourish'] = {}
		
-----------------------------------------------------------------------------------------------------------
-- Midcast sets
-----------------------------------------------------------------------------------------------------------
-- ### Fast Recast set ###
	sets.midcast.FastRecast = {
		ammo="Impatiens", --QC +2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14 (Rune. Bandeau +4)
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --FC +8 (Erilaz Surcoat +3)
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Aya. Cosciales +2", --FC +6
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Voltsurge Torque", --FC +4
		waist="Carrier's Sash", --(Witful Belt)
		left_ear="Loquac. Earring", --FC +2
		right_ear="Etiolation Earring", --FC +1
		left_ring="Lebeche Ring", --QC +2
		right_ring="Kishar Ring", --FC +4
		back="Solemnity Cape", --(Ambu. Cape w/ +10 FC)
	}
			
  -- Fast Recast w/ DT set 
	sets.midcast.FastRecast.DT = {}
		
  -- Fast recast w/ SIRD set 
	sets.midcast.FastRecast.SIRD = {
		ammo="Staunch Tathlum +1",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}},
		hands="Rawhide Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		neck="Loricate Torque +1",
		waist="Rumination Sash",
		left_ear="Loquac. Earring",
		right_ear="Magnetic Earring",
		left_ring="Murky Ring",
		right_ring="Evanescence Ring",
		back="Solemnity Cape",
	}

-- ### Blue magic set ###
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].DT = set_combine(sets.Enmity.DT, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})

  -- Specific Blue Magic spells
	-- Jettatura
	sets.midcast.Jettatura = set_combine(sets.Enmity, {})
	sets.midcast.Jettatura.DT = set_combine(sets.Enmity.DT, {})

	-- Wild Carrot
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
	
-- ### Enhancing magic set ###
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {})
	sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast.FastRecast.SIRD,{})
	
  -- Specific enhancing magic spell sets 
    -- Phalanx
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{})
	sets.midcast['Phalanx'].SIRD = set_combine(sets.midcast.FastRecast.SIRD,{})
	
	-- Protect/Shell
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	
	-- Regen
	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{}) 
	
	-- Refresh
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{}) 
	
	-- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.DT = set_combine(sets.Enmity.DT, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
	sets.midcast.Foil.DT = set_combine(sets.Enmity.DT, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.DT = set_combine(sets.Enmity.DT, {})

	-- Enhancing magic effects received
	sets.Self_Refresh = {}
	sets.Phalanx_Received = {
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}}, --Phalanx received +3
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4','Phalanx +3',}}, --Phalanx received +3
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}}, --Phalanx received +2
		legs={ name="Taeon Tights", augments={'Phalanx +3',}}, --Phalanx received +3
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','Phalanx +2',}}, --Phalanx received +2
	}
	
-- ### Healing Magic set ###
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecst, {})
	sets.midcast['Healing Magic'].SIRD = set_combine(sets.midcast.FastRecast.SIRD, {})
	
  -- Specific healing magic spells
	-- Cure
	sets.midcast.Cure = {}
	
	-- Cure and self-healing effects received
	sets.Self_Healing = {}
	sets.Cure_Received = {}

------------------------------------------------------------------------------------------------------------
-- Idle & Resting Sets
------------------------------------------------------------------------------------------------------------
-- ### Base Idle set ###
	sets.idle = { --DT -26, Refresh +2, Regen +7
		ammo="Staunch Tathlum +1",
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+7','Accuracy+3','"Refresh"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}, --Refresh +1 (Null Masque)
		body="Nyame Mail", --(Erilaz Galea)
		hands="Nyame Gauntlets", --(Regal Gauntlets)
		legs="Turms Subligar", --Regen +7
		feet="Nyame Sollerets", --DT -7
		neck="Sibyl Scarf", --Refresh +1
		waist="Fucho-no-obi", --Latent: Refresh +1 
		left_ear="Alabaster Earring", --DT -5
		right_ear="Infused Earring", --Regen +1
		left_ring="Murky Ring", --DT -10
		right_ring="Shneddick Ring", --Mv. Speed +18%
		back="Solemnity Cape", --DT -4
	}
  
  -- Refresh set
	sets.idle.refresh = set_combine(sets.idle, {})
	
  -- Regen set
	sets.idle.regen = set_combine(sets.idle, {})
	
  -- Sphere set
	sets.idle.Sphere = set_combine(sets.idle,{})

-- ### Misc. idle sets ###
	sets.Kiting = {right_ring="Shneddick Ring"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
-- ### Resting set ###
	sets.resting = {}

	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
	sets.MP = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		waist="Chaac Belt",
	})
	
------------------------------------------------------------------------------------------------------------
-- Defensive sets
------------------------------------------------------------------------------------------------------------
-- ### Physical damage taken sets (PDT) ###
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Infused Earring",
		left_ring="Murky Ring",
		right_ring="Moonlight Ring",
		back="Solemnity Cape",
	}
	sets.defense.PDT_HP = {}
	
--- ### Magical damage taken set (MDT) ###
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
	sets.defense.MDT_HP = {}
	
--- ### Magic evasion set (MEVA) ###
	sets.defense.MEVA = {}
	sets.defense.MEVA_HP = {}

------------------------------------------------------------------------------------------------------------
-- Offensive sets
------------------------------------------------------------------------------------------------------------
--- ### Engaged sets ###
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Sailfi Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight Ring",
		back="Null Shawl",
	}
	
	sets.engaged.Acc = {}
	sets.engaged.FullAcc = {}
	sets.engaged.PDL = {}
			
  -- Hybrid damage taken/engaged sets
	sets.engaged.DT = {
		ammo="Aurgelmir Orb",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Sailfi Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Telos Earring",
		left_ring="Murky Ring",
		right_ring="Moonlight Ring",
		back="Null Shawl",
	}
	
	sets.engaged.Acc.DT = {}
	sets.engaged.FullAcc.DT = {}
	
  -- Hybrid magic evasion/engaged sets
	sets.engaged.MEVA = {}
	sets.engaged.Acc.MEVA = {}
	sets.engaged.FullAcc.EVA = {}
	
  -- Extra melee mode sets
	sets.DWMid = {}
	sets.DWMax = {}
	sets.SubtleBlow = {}
	
------------------------------------------------------------------------------------------------------------
-- Weapon sets
------------------------------------------------------------------------------------------------------------
-- Weapons sets
	sets.weapons.Montante = {main="Montante +1", sub="Utu Grip"}
	sets.weapons.Agwu = {main="Agwu's Claymore", sub="Utu Grip"}
	sets.weapons.DualNaegling = {main="Naegling", sub="Loxotic Mace +1"}
	
------------------------------------------------------------------------------------------------------------
-- Weaponskill sets
------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill sets, used when a specific WS is not defined ###
	sets.precast.WS = {
		ammo="Knobkierrie",  
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Domin. Earring +1",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back="Alabaster Mantle",
	}
	
	sets.precast.WS.Acc = {}
	sets.precast.WS.FullAcc = {}
	sets.precast.WS.PDL = {}

-- ### Specific weaponskill sets ###
  -- Great Sword weaponskills
	-- Dimidiation
	sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,{})
	sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
	sets.precast.WS['Dimidiation'].PDL = set_combine(sets.precast.WS.PDL,{})
	
	-- Ground Strike
	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,{})
	sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
	sets.precast.WS['Ground Strike'].PDL = set_combine(sets.precast.WS.PDL,{})
	
	-- Herculean Slash	
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.JA['Lunge'], {})
	
	-- Resolution
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{})
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
	sets.precast.WS['Resolution'].PDL = set_combine(sets.precast.WS.PDL,{})

  -- Sword weaponskills
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.JA['Lunge'], {})

-- ### Misc. weaponskill swaps if at 3000 TP ###
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

------------------------------------------------------------------------------------------------------------
-- Misc. gear sets
------------------------------------------------------------------------------------------------------------
-- ### Gear that needs to be worn to actively enhance a current player buff. ###
	sets.buff.Battuta = {hands="Turms Mittens +1"}
	sets.buff.Embolden = {back="Evasionist's Cape"}

-- ### Vs. Debuff gear ###
  -- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
  -- Sleep
	sets.buff.Sleep = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 19)
	elseif player.sub_job == 'RDM' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'SCH' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'BLU' then
		set_macro_page(6, 19)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 19)
	elseif player.sub_job == 'SAM' then
		set_macro_page(8, 19)
	elseif player.sub_job == 'DRK' then
		set_macro_page(9, 19)
	elseif player.sub_job == 'NIN' then
		set_macro_page(10, 19)
	else
		set_macro_page(5, 19)
	end
end

function user_job_lockstyle()
	if state.Weapons.value == 'Lionheart' then
		windower.chat.input('/lockstyleset 034')
	else
		windower.chat.input('/lockstyleset 033')
	end
end
