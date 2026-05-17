function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Fodder','Normal','Acc','FullAcc')
	state.HybridMode:options('Normal','DT')
    state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
    state.CastingMode:options('Normal','SIRD','Resistant','FullMacc','Fodder','Proc')
    state.IdleMode:options('Normal','Sphere','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Naegling', 'Maxentius', 'None', 'ProcSword', 'ProcClub')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons None;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

-------------------------------------------------------------------------------------------------------------------
-- START DEFINING THE SETS
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- PRECAST SETS
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Cast gear
--------------------------------------
	sets.precast.FC = { --Fast Cast +51/80, Quick Cast +6
		ammo="Impatiens", --QC +2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}}, --FC +8
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		legs="Jhakri Slops +2", --(Psycloth Lappas, FC +7)
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}, --FC +8
		neck="Voltsurge Torque", --FC +4
		waist="Witful Belt", --FC +3
		left_ear="Etiolation Earring", --FC +1 --(Enchanter's Earring +1 FC +2)
		right_ear="Loquac. Earring", --FC +2
		left_ring="Lebeche Ring", --QC +4
		right_ring="Kishar Ring", --FC +4
		back="Null Shawl", --(Ambu Cape FC +10)
	}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {})

--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
	sets.buff['Burst Affinity'] = {}
	sets.buff['Chain Affinity'] = {}
	sets.buff.Convergence = {}
	sets.buff.Diffusion = {}
	sets.buff.Enchainment = {}
	sets.buff.Efflux = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.HPDown = {}
	sets.HPCure = {}
	sets.precast.JA['Azure Lore'] = {}

--------------------------------------
-- Waltz sets for /DNC
--------------------------------------
    sets.precast.Waltz = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Passion Jacket",
		hands="Nyame Gauntlets",
		legs="Dashing Subligar",
		feet="Rawhide Boots",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Regal Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back="Null Shawl",
	}
	
	sets.Self_Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

--------------------------------------
-- Step Sets for /DNC
--------------------------------------
	sets.precast.Step = {
		ammo="Hasty Pinion +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Domin. Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
	sets.precast.Flourish1 = set_combine(sets.precast.Step, {
		ammo="Pemphredo Tathlum",
		left_ear="Digni. Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
	})

------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast
--------------------------------------
	sets.midcast.FastRecast = {}
	sets.midcast['Blue Magic'] = {}
	

--------------------------------------
-- Blue Magic Spells
--------------------------------------
-- Physical Blue Magic Spells
	sets.midcast['Blue Magic'].Physical = {}
	sets.midcast['Blue Magic'].Physical.Resistant = {}
	sets.midcast['Blue Magic'].Physical.Fodder = {}

  -- Physical/Accuracy Based
    sets.midcast['Blue Magic'].PhysicalAcc = {}
	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder

  -- Physical/STR Based
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/DEX Based
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/VIT Based
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/AGI Based
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/INT Based
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/MND Based
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/CHA Based
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical/HP Based
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

  -- Physical Stun-Based Spells
    sets.midcast['Blue Magic'].Stun = {
	sets.midcast['Blue Magic'].Stun.Resistant = {}
	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun


-- Magical Blue Magic Spells


-- Breath Based Blue Magic Spells
	sets.midcast['Blue Magic'].Breath = {}

-- Buffing Blue Magic Spells
	sets.midcast['Blue Magic'].SkillBasedBuff = {}
	sets.midcast['Blue Magic'].Buff = {}

  -- Specific Blue Magic Buff Spells
	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {})
	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

-- Healing Blue Magic Spells
	sets.midcast['Blue Magic'].UnlockedAoEHealing = {}
	sets.midcast['Blue Magic'].AoEHealing = {}
	sets.midcast['Blue Magic'].Healing = {}
	sets.midcast['Blue Magic'].UnlockedHealing = {}


--------------------------------------
-- Dark Magic Spells
--------------------------------------
	sets.midcast['Dark Magic'] = {}

--------------------------------------
-- Divine Magic Spells
--------------------------------------
	sets.midcast['Divine Magic'] = {}

--------------------------------------
-- Elemental Magic Spells
--------------------------------------
	sets.midcast['Elemental Magic'] = {}
	sets.midcast['Elemental Magic'].Resistant = {}

--------------------------------------
-- Enfeebling Magic Spells
--------------------------------------
	sets.midcast['Enfeebling Magic'] = {}

--------------------------------------
-- Enhancing Magic Spells
--------------------------------------
	sets.midcast['Enhancing Magic'] = {}
	
-- Specific Enhancing Magic Spells
  -- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

  -- Bar-Element
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
  -- Phalanx
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{})
	
  -- Protect/Shell
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

  -- Refresh
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})

  -- Stoneskin
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})


--------------------------------------
-- Healing Magic Spells
--------------------------------------
	sets.midcast.Cure = {}
	sets.midcast.UnlockedCure = {}

-- Specific Healing Magic Spells
  -- Cursena
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
	

--------------------------------------
-- Misc. Magic Sets
--------------------------------------
-- Cure Spells Received
	sets.Cure_Received = {}

-- Phalanx Received
	sets.Phalanx_Received = {}
	
-- Refresh Received
	sets.Self_Refresh = {}
	
-- Magic Burst Set
	sets.MagicBurst = {}
	
-- Self Healing
	sets.Self_Healing = {waist="Gishdubar Sash"}
	

	




-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical damage taken
--------------------------------------
	sets.defense.PDT = {}

-- Magical damage taken
	sets.defense.MDT = {}

-- Magic evasion
    sets.defense.MEVA = {}


-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Base Idle Set
--------------------------------------
	sets.idle = {}
	
-- Refresh
	sets.idle.Refresh = set_combine(sets.idle, {})
	
-- Regen
	sets.idle.Regen = set_combine(sets.idle, {})
	
-- Regain
	sets.idle.Regain = set_combine(sets.idle, {})


-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Engaged Sets
--------------------------------------
	sets.engaged = {}
	sets.engaged.Acc = {}
	sets.engaged.FullAcc = {}
	sets.engaged.Fodder = {}
	sets.engaged.DT = {}
	

---------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gears
--------------------------------------
	sets.precast.WS = {}
	sets.precast.WS.Acc = {}
	sets.precast.WS.FullAcc = {}
	sets.precast.WS.DT = {}
	sets.precast.WS.Fodder = {}
	
--------------------------------------
-- Specific Weaponskill gear
--------------------------------------
-- Club Weaponskills
	sets.precast.WS['Black Halo'] = {}
	sets.precast.WS['Flash Nova'] = {}
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Realmrazer'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

-- Sword Weaponskills
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Chant du Cygne'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Requiescat'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})

	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
	sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc
	sets.precast.WS['Vorpal Blade'].FullAcc = sets.precast.WS['Chant du Cygne'].FullAcc
	sets.precast.WS['Vorpal Blade'].DT = sets.precast.WS['Chant du Cygne'].DT
	sets.precast.WS['Vorpal Blade'].Fodder = sets.precast.WS['Chant du Cygne'].Fodder

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Expiacion'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

	sets.precast.WS['Sanguine Blade'] = {}
	
--------------------------------------
-- Misc. Weaponskill gear
--------------------------------------	


---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
-- Weapons sets
	sets.weapons.Naegling = {main="Naegling", sub="Sakpata's Sword"}
	sets.weapons.Maxentius = {main="Maxentius", sub="Sakpata's Sword"}
	sets.weapons.None = {main=empty, sub=empty}
	sets.weapons.ProcDagger = {main="Qutrub Knife", sub=empty}
	sets.weapons.ProcSword = {main="Ibushi Shinai", sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament", sub=empty}
	sets.weapons.ProcGreatAxe = {main="Helgoland", sub=empty}
	sets.weapons.ProcScythe = {main=Lost Sickle", sub=empty}
	sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade", sub=empty}
	sets.weapons.ProcKatana = {main="Debahocho", sub=empty}
	sets.weapons.ProcGreatKatana = {main="Zanmato", sub=empty}
	sets.weapons.ProcClub = {main="Soulflayer's Wand", sub=empty}
	sets.weapons.ProcStaff = {main"Ranine Staff", sub=empty}
	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Dual Wield Sets
	sets.DWMid = {}
	sets.DWMax = {}

-- Kiting
	sets.Kiting = {legs="Carmine Cuisses +1"}

-- Sets to return to when not performing an action.
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

-- Vs. Debuffs
  -- Doom
  
  -- Knockback
	sets.Knockback = {}
	
  -- Sleep

-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +3"}


	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 2)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 2)
	else
		set_macro_page(6, 2)
	end
end

autows_list = {['Tizbron']='Expiacion',['Tizalmace']='Expiacion',['Almace']='Chant Du Cygne',['MeleeClubs']='Realmrazer',
     ['HybridWeapons']='Sanguine Blade',['Naegbron']='Savage Blade',['Naegmace']='Savage Blade'}