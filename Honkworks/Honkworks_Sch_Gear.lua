-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc', 'OccultAcumen', '9k')
    state.IdleMode:options('Normal', 'Refresh')
	state.HybridMode:options('Normal','PDT')
	state.Weapons:options('None', 'SpiritTaker')

	gear.nuke_jse_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
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
    sets.precast.JA['Tabula Rasa'] = {} --legs="Peda. Pants +1"
	sets.precast.JA['Enlightenment'] = {} --body="Peda. Gown +1"

--------------------------------------
-- Fast cast sets for spells
--------------------------------------
    sets.precast.FC = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}},
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Voltsurge Torque",
		waist="Acuity Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Alabaster Earring",
		left_ring="Jhakri Ring",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}

--------------------------------------
-- Arts?
--------------------------------------
	sets.precast.FC.Arts = {}
	
--------------------------------------
-- Enhancing Magic Precast
--------------------------------------
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {}) --waist="Siegel Sash"

--------------------------------------
-- Elemental Magic Precast
--------------------------------------
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {}) --left_ear="Malignance Earring"

--------------------------------------
-- Precast for Specific Spells
--------------------------------------
-- Cure
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Vadose Rod", sub="Sors Shield"})
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
	sets.midcast.FastRecast = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','INT+9','Mag. Acc.+12',}},
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Voltsurge Torque",
		waist="Acuity Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Alabaster Earring",
		left_ring="Jhakri Ring",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1"} --ring2="Archon Ring"


--------------------------------------	
-- Divine Magic
--------------------------------------
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring2="Stikini Ring +1",feet=gear.chironic_nuke_feet})


--------------------------------------
-- Dark Magic 
--------------------------------------
    sets.midcast['Dark Magic'] = {}

-- Specific Dark Magic Spells
  -- Aspir
    sets.midcast.Aspir = sets.midcast.Drain
	
  -- Aspir, Resistant
	--sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant
	
  -- Drain
    sets.midcast.Drain = {
        head="Pixie Hairpin +1",
		neck="Erra Pendant",
	}
	
  -- Drain, Resistant
    sets.midcast.Drain.Resistant = {}
	
  -- Kaustra
    sets.midcast.Kaustra = {}
		
  -- Kaustra, Resistant
    sets.midcast.Kaustra.Resistant = {}

  -- Stun
    sets.midcast.Stun = {}

  -- Stun, Resistant
    sets.midcast.Stun.Resistant = {}


--------------------------------------
-- Elemental Magic
--------------------------------------
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
		waist="Refoccilation Stone",
		left_ear="Sortiarius Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Jhakri Ring",
		back="Solemnity Cape",
	}
  
-- Elemental Magic, Resistant
    sets.midcast['Elemental Magic'].Resistant = {}
		
-- Elemental Magic, 9k(?)
    sets.midcast['Elemental Magic']['9k'] = {}
		
-- Elemental Magic, Proc
    sets.midcast['Elemental Magic'].Proc = {}
		
-- Elemental Magic, Occult Acument
    sets.midcast['Elemental Magic'].OccultAcumen = {}
		
-- Gear for Magic Burst
  -- Elemental Magic Burst
    sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], {
		right_ring="Mujin Band",
	})

  -- Helix Burst
    sets.HelixBurst = {right_ring="Mujin Band"}
		
  -- Helix Burst, Resistant
    sets.ResistantHelixBurst = {}
		
-- Custom refinements for certain nuke tiers
  -- High Tier Nuke
	sets.midcast['Elemental Magic'].HighTierNuke = {}
		
  -- High Tier Nuke, Resistant	
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {}

  -- High Tier Helix
	sets.midcast.Helix = {}
	
  -- High Tier Helix, Resistant
	sets.midcast.Helix.Resistant = {}
		
  -- High Tier Helix, Proc
	sets.midcast.Helix.Proc = {}

-- Specific Elemental Magic Spells
  -- Impact
	sets.midcast.Impact = {}
		
  -- Impact, Occult Acumen
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})


--------------------------------------
-- Enhancing Magic
--------------------------------------
	sets.midcast['Enhancing Magic'] = {}

-- Specific Enhancing Spells
  -- Aquaveil
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod", 
		legs="Shedir Seraweels",
	})
	
  -- Barspells
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
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
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
  -- Shell/Shellra
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell
	
  -- Stoneskin
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir Seraweels",
		waist="Siegel Sash",
	})
	
  -- Storm
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})


--------------------------------------
-- Enfeebling Magic
--------------------------------------
	sets.midcast['Enfeebling Magic'] = {}
	
-- Enfeebling Magic, Resistant
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
-- Elemental Enfeeble
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
  -- Int Based Enfeebles
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
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
    sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
		main="Gada",
		sub="Sors Shield",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Loricate Torque +1",
		left_ring="Metamor. Ring +1",
		back="Solemnity Cape",
	})
		
-- Healing Magic, Lightsday/Light Weather
    sets.midcast.LightWeatherCure = {}
    sets.midcast.LightDayCure = {}


-- Self Healing/Refresh
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

-- Specific Healing Spells 
  -- Curaga
    sets.midcast.Curaga = sets.midcast.Cure	
    
  -- Cursna
	sets.midcast.Cursna = {}
		
  -- Status Removal Spells
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
	
---------------------------------------------------------------------------------------------------------------
-- Idle Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Base idle set
--------------------------------------
    sets.idle = { -- Refresh +4
		ammo="Ghastly Tathlum +1", -- Homilary
		head="Nyame Helm",
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Acuity Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Alabaster Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back="Solemnity Cape", -- Lugh's Cape (Regen, DT -5)
	}
		
-- Refresh Set
	sets.idle.Refresh = set_combine(sets.idle, {
		head="Befouled Crown",
		body="Jhakri Robe +2",
		legs="Assid. Pants +1",
		neck="Sibyl Scarf",
	})

-- Regen Set
    sets.idle.Regen = set_combine(sets.idle, {})


-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical damage taken -- DT 64/50
--------------------------------------
    sets.defense.PDT = {
		ammo="Ghastly Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Acuity Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Alabaster Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Murky Ring",
		back="Solemnity Cape",
	}

-- Magical damage taken
    --sets.defense.MDT = set_combine(sets.defense.PDT, {
		--neck="Warder's Charm +1",
		--waist="Carrier's Sash",
		--left_ring="Archon Ring",
	--})
	
-- Magic Evasion
	sets.defense.MEVA = set_combine(sets.defense.PDT, {})
	
-- Misc. Defense Sets
  -- Kiting
	sets.Kiting = {} --left_ring="Shnedick Ring"
    
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
    --sets.engaged = {
		--ammo="Hasty Pinion +1",
		--head={ name="Blistering Sallet +1", augments={'Path: A',}},
		--body={ name="Nyame Mail", augments={'Path: B',}},
		--hands={ name="Gazu Bracelets +1", augments={'Path: A',}},
		--legs="Jhakri Slops +2",
		--feet={ name="Nyame Sollerets", augments={'Path: B',}},
		--neck="Combatant's Torque",
		--waist="Grunfeld Rope",
		--left_ear="Digni. Earring",
		--right_ear="Telos Earring",
		--left_ring="Chirich Ring +1",
		--right_ring="Chirich Ring +1",
		--back="Null Shawl",
	--}
	
	--sets.engaged.Acc = set_combine(sets.engaged, {})
	--sets.engaged.FullAcc = set_combine(sets.engaged, {})
	--sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
		
-- Engaged DT set
	--sets.engaged.DT = {
		--ammo="Staunch Tathlum +1",
		--head={ name="Nyame Helm", augments={'Path: B',}},
		--body={ name="Nyame Mail", augments={'Path: B',}},
		--hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		--legs={ name="Nyame Flanchard", augments={'Path: B',}},
		--feet={ name="Nyame Sollerets", augments={'Path: B',}},
		--neck="Combatant's Torque",
		--waist="Grunfeld Rope",
		--left_ear="Digni. Earring",
		--right_ear="Telos Earring",
		--left_ring="Chirich Ring +1",
		--right_ring="Defending Ring",
		--back="Null Shawl",
	--}


---------------------------------------------------------------------------------------------------------------
-- Weapon sets
---------------------------------------------------------------------------------------------------------------
	sets.weapons.None = {main=empty, sub=empty}
	sets.weapons.SpiritTaker = {main="Marin Staff +1", sub="Khonsu"}
	--sets.weapons.Akademos = {main="Akademos",sub="Enki Strap"}
	--sets.weapons.Khatvanga = {main="Khatvanga",sub="Bloodrain Strap"}


---------------------------------------------------------------------------------------------------------------
-- Weaponskill sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gear
--------------------------------------
    --sets.precast.WS = {
		--ammo="Oshasha's Treatise",
		--head={ name="Nyame Helm", augments={'Path: B',}},
		--body={ name="Nyame Mail", augments={'Path: B',}},
		--hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		--legs={ name="Nyame Flanchard", augments={'Path: B',}},
		--feet={ name="Nyame Sollerets", augments={'Path: B',}},
		--neck="Combatant's Torque",
		--waist="Grunfeld Rope",
		--left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		--right_ear="Ishvara Earring",
		--left_ring="Cornelia's Ring",
		--right_ring="Chirich Ring +1",
		--back="Null Shawl",
	--}
	
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
	--sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		--ammo="Sroda Tathlum",
		--head="Pixie Hairpin +1",
		--body={ name="Nyame Mail", augments={'Path: B',}},
		--hands="Jhakri Cuffs +2",
		--legs={ name="Nyame Flanchard", augments={'Path: B',}},
		--feet={ name="Nyame Sollerets", augments={'Path: B',}},
		--neck="Saevus Pendant +1",
		--waist="Hachirin-no-Obi",
		--left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		--right_ear="Malignance Earring",
		--left_ring="Cornelia's Ring",
		--right_ring="Archon Ring",
		--back="Null Shawl",
	--})
	
-- Myrkr
	--sets.precast.WS['Myrkr'] = set_combine(sets.precast.WS, {})
	
-- Omniscience
	--sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {})
	
	
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------	
--------------------------------------
-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
--------------------------------------
    --sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    --sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    --sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    --sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    --sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    --sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    --sets.buff['Celerity'] = {feet="Peda. Loafers +1"}
    --sets.buff['Alacrity'] = {feet="Peda. Loafers +1"}
    --sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
	
	--sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		--body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		--back="Swith Cape +1",waist="Carrier's Sash",legs="Shedir Seraweels",feet=""}
		
    --sets.HPCure = {main="Daybreak",sub="Sors Shield",range=empty,ammo="Hasty Pinion +1",
        --head="Gende. Caubeen +1",neck="Unmoving Collar +1",ear1="Gifted Earring",ear2="Mendi. Earring",
        --body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Gelatinous Ring +1",ring2="Meridian Ring",
        --back="Moonlight Cape",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
	
	--sets.buff.Doom = set_combine(sets.buff.Doom, {})
	--sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
	--sets.buff['Dark Arts'] = {} --body="Academic's Gown +3"

    --sets.buff.Sublimation = {
		--head="Acad. Mortar. +3",
		--waist="Embla Sash",
	--}
	
    --sets.buff.DTSublimation = {waist="Embla Sash"}
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