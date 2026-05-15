-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.RangedMode:options('Normal', 'Acc', 'FullAcc', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.CastingMode = M{['description']='Quick Draw Mode', 'Normal', 'Fodder'}
    state.IdleMode:options('Normal', 'Regen', 'Refresh')
	state.HybridMode:options('Normal', 'DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMid', 'DWMax'}
	state.Weapons:options('Savage', 'Aeolian')
	state.CompensatorMode:options('Always', '300', '1000', 'Never')

    gear.RAbullet = "Bronze Bullet"
    gear.WSbullet = "Bronze Bullet"
    gear.MAbullet = "Bronze Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Bronze Bullet"
    options.ammo_warning_limit = 15
    --Ikenga_vest_bonus = 190  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20

    -- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')
	--send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
	send_command('bind ^q gs c weapons Savage;gs c update')
	send_command('bind !q gs c weapons LeadenSalute;gs c update')
	send_command('bind @pause roller roll')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
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
    sets.precast.FC = { --FC +51/80
		--head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		--body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}}, --FC +8
		--hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		--legs="Chas. Culottes +3", --(Taeon Tights, Aug FC +5)
		--feet="Carmine Greaves +1", --FC +8  
		--neck="Voltsurge Torque", --FC +5
		--waist="Plat. Mog. Belt", 
		--left_ear="Etiolation Earring", --FC +1
		--right_ear="Loquac. Earring", --FC +2
		--left_ring="Rahab Ring", --FC +2
		right_ring="Kishar Ring", --FC +4
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}

-- Fast cast for specific spells
  -- Cure
	--sets.precast.FC.Cure = set_combine(sets.precast.FC, {right_ear="Mendi. Earring"})
	
  -- Utsusemi
    --sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"}) -- body="Passion Jacket"

--------------------------------------
-- Phantom Roll precast
--------------------------------------
    sets.precast.CorsairRoll = {
		main={ name="Rostam", augments={'Path: C',}},
		range="Compensator",
		head="Lanun Tricorne +3",
		body="Chasseur's Frac +1",
		hands="Chasseur's Gants +1",
		left_ring="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}

-- Larger AOE on Phantom Roll
	sets.precast.LuzafRing = {left_ring="Luzaf's Ring"}
    
-- Precast sets for Specific rolls
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

--------------------------------------
-- Precast sets to enhance JAs
--------------------------------------
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"} --(Upgrade to +4)
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"} --(Upgrade to +4)
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"} --(Upgrade to +4)
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"} --(Upgrade to +4)

--------------------------------------
-- Quick Draw Sests
--------------------------------------
-- Quick Draw, Normal
	sets.precast.CorsairShot = {
		ammo="Hauksbok Bullet",
		head="Laksa. Tricorne +2",
		body="Lanun Frac +3",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Laksa. Trews +2",
		feet="Lanun Bottes +3",
		neck="Voltsurge Torque",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Sortiarius Earring",
		left_ring="Mummu Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+9','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}

  -- Quick Draw, Fodder (Chass. Bottes +3 for +31% elemental bonus on quick draw)
	sets.precast.CorsairShot.Fodder = set_combine(sets.precast.CorsairShot, {feet="Chass. Bottes +1"}) --(Upgrade to +3)
		
  -- Specific Quickdraw shots
	--sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})
	--sets.precast.CorsairShot['Light Shot'] = set_combine{sets.precast.CorsairShot.Resistant, {}}

--------------------------------------
-- Ranged preshot gear
--------------------------------------
-- No Flurry / Snapshot 60%
    sets.precast.RA = {
		head="Chass. Tricorne",
		--body="Oshosi Vest +1",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		--legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		--neck={ name="Comm. Charm +2", augments={'Path: A',}},
		--waist="Impulse Belt",
		--left_ring="Crepuscular Ring",
		--back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}
	
  -- Flurry I / Snapshot 45%
	--sets.precast.RA.Flurry = set_combine(sets.precast.RA, {body="Laksa. Frac +4", waist="Yemaya Belt"})
	
  -- Flurry II / Snapshop 30%
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
		--body="Laksa. Frac +4", 
		--waist="Yemaya Belt",
		--feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
	})

--------------------------------------
-- Step Sets for /DNC
--------------------------------------
	sets.precast.Steps = {
		head="Chass. Tricorne",
		body="Chasseur's Frac",
		hands="Chasseur's Gants",
		legs="Chas. Culottes",
		feet="Chass. Bottes",
		--neck="Null Loop",
		--waist="Kentarch Belt +1",
		--left_ear="Odr Earring",
		--right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		--left_ring="Cacoethic Ring +1",
		--right_ring="Chirich Ring +1",
		--back="Null Shawl",
	}
	
--------------------------------------
-- Waltz sets for /DNC
--------------------------------------
-- Curing Waltz on others
    sets.precast.Waltz = {
		head="Lanun Tricorne +3",
		body="Lanun Frac +3",
		hands="Lanun Gants +3",
		legs="Lanun Trews +3",
		feet="Lanun Bottes +3",
		neck="Loricate Torque +1",
		left_ring="Archon Ring",
		right_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}
		
  -- Curing Waltz on aelf
	sets.Self_Waltz = set_combine(sets.precast.waltz, {
		head="Mummu Bonnet +2",
		--body="Passion Jacket",
		--left_ring="Asklepian Ring",
	})
        
  -- Healing Waltz
    sets.precast.Waltz['Healing Waltz'] = {}
	
------------------------------------------------------------------------------------------------------------------- 
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Fast Recast
--------------------------------------
    sets.midcast.FastRecast = {
        --head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --FC +14
		--body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}}, --FC +8
		--hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, --FC +7
		--legs="Chas. Culottes +3", --(Taeon Tights, Aug FC +5)
		--feet="Carmine Greaves +1", --FC +8  
		--neck="Voltsurge Torque", --FC +5
		--waist="Plat. Mog. Belt", 
		--left_ear="Etiolation Earring", --FC +1
		--right_ear="Loquac. Earring", --FC +2
		--left_ring="Rahab Ring", --FC +2
		--right_ring="Kishar Ring", --FC +4
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}
        
  -- Fast recast for specific spells
	--sets.Cure_Received = {waist="Gishdubar Sash"}
    --sets.midcast.Utsusemi = sets.midcast.FastRecast

--------------------------------------
-- Midshot Gear
--------------------------------------
-- Ranged Attack, Normal
	sets.midcast.RA = {
        head="Lanun Tricorne +3",
		body="Lanun Frac +3",
		hands="Lanun Gants +3",
		legs="Lanun Trews +3",
		feet="Lanun Bottes +3",
		neck="Loricate Torque +1",
		waist="Eschan Stone",
		right_ear="Neritic Earring",
		left_ring="Mummu Ring",
		right_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}},
	}

-- Ranged Attack, Accuracy 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		--left_ear="Enervating Earring",
	})
	
-- Ranged Attack, Full Accuracy
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA, {
		head="Mummu Bonnet +2",
		body="Meg. Cuirie +2",
		feet="Meg. Jam. +2",
	})
	
-- Ranged Attack, Subtble Blow
	sets.midcast.RA.SubtleBlow = set_combine(sets.midcast.RA, {
		--body="Volte Harness",
		--hands="Volte Mittens",
		--legs="Volte Tights",
		--feet="Volte Spats",
		--left_ear="Beyla Earring",
		--left_ring="Chirich Ring +1",
	})
	
--------------------------------------
-- Triple Shot gear
--------------------------------------	
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
		--head="Oshosi Mask +1",
		body="Chasseur's Frac",
		hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}}, --(Upgrade to +4)
		--legs="Osh. Trousers +1",
		--feet="Osh. Leggings +1",
	})

-------------------------------------------------------------------------------------------------------------------
-- Defense Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Physical damage taken
--------------------------------------
    sets.defense.PDT = { --PDT -23/50, DT -26/50
        head="Meghanada Visor +2",  --PDT -5
		body="Meg. Cuirie +2", --PDT -8
		head="Meghanada Visor +2", --PDT -4
		legs="Mummu Kecks +2", --DT -5
		feet="Lanun Bottes +3", --PDT -6
		neck="Loricate Torque +1", --DT -6
		right_ear="Alabaster Earring", --DT -5
		right_ring="Murky Ring", --DT -10
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	}

-- Magical damage taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Warder's Charm +1",
		--waist="Carrier's Sash",
		right_ring="Archon Ring",
	})
	
-- Magic Evasion
    sets.defense.MEVA = set_combine(sets.defense.PDT, {
		--neck="Unmoving Collar +1",
		--left_ear="Hearty Earring", --(Lugalbanda Earring)
		--back="Null Shawl",
	})
	
-------------------------------------------------------------------------------------------------------------------
-- Idle Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Base Idle Set
--------------------------------------
    sets.idle = {
		head="Meghanada Visor +2", --PDT -5
		body="Meg. Cuirie +2", --PDT -8
		hands="Meg. Gloves +2", --PDT -4
		legs="Carmine Cuisses +1", -- Mv Spd +18%
		feet="Lanun Bottes +3", --PDT -6
		neck="Loricate Torque +1", --DT -6
		right_ear="Alabaster Earring", --DT -5
		right_ring="Murky Ring", --DT -10
		back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','"Fast Cast"+10','Damage taken-5%',}}, --DT -5
	}
		
  -- Regen idle set
	sets.idle.Regen = set_combine(sets.idle, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		feet="Meg. Jam. +2",
		--neck="Bathy Choker +1",
		--left_ear="Dawn Earring",
		--right_ring="Chirich Ring +1",
	}) 

  -- Refresh idle set
	--sets.idle.Refresh = set_combine(sets.idle.Regen, {neck="Sybil Scarf"}) --(Stikini Ring x2)
	
-------------------------------------------------------------------------------------------------------------------
-- Offensive Sets
-------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Engaged Sets
--------------------------------------
	sets.engaged = {
		head="Mummu Bonnet +2",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs="Meg. Chausses +2",
		feet="Mummu Gamash. +2",
		neck="Loricate Torque +1",
		waist="Eschan Stone",
		left_ear="Neritic Earring",
		right_ear="Alabaster Earring",
		left_ring="Rajas Ring",
		right_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
  -- Engaged set, accuracy 
    sets.engaged.Acc = set_combine(sets.engaged, {})
	
  -- Engaged set, full acc
	sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
  -- Engaged set, subtle blow
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	
  -- Engaged set, hybrid DT
    sets.engaged.DT = set_combine(sets.engaged, {})
	
	
---------------------------------------------------------------------------------------------------------------
-- Weapon Sets
---------------------------------------------------------------------------------------------------------------
	sets.weapons.Savage = {main="Kaja Sword", sub="Demersal Degen +1", range="Compensator"}
	--sets.weapons.LeadenSalute = {main="Naegling", sub="Tauret", range="Death Penalty"}
	--sets.weapons.LastStand = {main="Naegling", sub="Gleti's Knife", range="Fomalhaut"}
	sets.weapons.Aeolian = {main={ name="Rostam", augments={'Path: C',}}, sub="Blurred Knife", range="Compensator"}
	
---------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
---------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Default weaponskill gear
--------------------------------------
    sets.precast.WS = {
		head="Mummu Bonnet +2",
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Mummu Kecks +2",
		feet="Lanun Bottes +3",
		neck="Loricate Torque +1",
		waist="Eschan Stone",
		left_ear="Neritic Earring",
		right_ear="Alabaster Earring",
		left_ring="Rajas Ring",
		right_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

  -- Default weaponskill accuracy gear
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
  -- Default weaponskill fodder gear
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})


--------------------------------------
-- Dagger Weaponskills
--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {})
	
    --Evisceration
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], { })
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {left_ear="Mache Earring +1"})


--------------------------------------
-- Gun Weaponskills
--------------------------------------
-- Hot Shot
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS['Hot Shot'].Fodder = set_combine(sets.precast.WS, {})

-- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	sets.precast.WS['Last Stand'].Fodder = set_combine(sets.precast.WS['Last Stand'], {})
	
-- Leaden Salute
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], {})
	sets.precast.WS['Leaden Salute'].Fodder = set_combine(sets.precast.WS['Leaden Salute'], {})

-- Terminus
	sets.precast.WS['Terminus'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Terminus'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Terminus'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
-- Wildfire
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Wildfire'].Fodder = set_combine(sets.precast.WS.Fodder, {})


--------------------------------------
-- Sword Weaponskills
--------------------------------------
  -- Requiescat
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
  -- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
--------------------------------------
-- Swaps when using WS at 3000 TP
--------------------------------------
	sets.MaxTP = {left_ear="Lugra Earring +1"} -- right_ear="Lugra Earring"
	sets.AccMaxTP = {}
 
-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous Sets
-------------------------------------------------------------------------------------------------------------------
-- Kiting
    sets.Kiting = {right_ring="Shneddick Ring"}
	
-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
		body="Volte Jupon",
		legs="Volte Hose",	
	})

--------------------------------------
-- Dual Wield Sets
--------------------------------------
	sets.DWMid = {}
	sets.DWMax = {}
	
-- Doom
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
-- Resting sets
    sets.resting = {}
	
-- Bullet Pouch
	sets.BulletPouch = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Miscelaneous
-------------------------------------------------------------------------------------------------------------------
	-- Selects default macro book on initial load or subjob change.
	function select_default_macro_book()
		set_macro_page(1, 17)
	end

--------------------------------------
--AutoWS when a specific weapon set is selected
--------------------------------------
	autows_list = {
		['Default']='Savage Blade',
		['Savage']='Savage Blade',
		['LeadenSalute']='Leaden Salute',
		['HotShot']='Hot Shot',
		['LastStand']='Last Stand',
		['Wildfire']='Wildfire',
		['Aeolian']='Aeolian Edge',
		['Evisceration']='Evisceration',
	}