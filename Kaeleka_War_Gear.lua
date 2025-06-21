function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'MaxAcc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Regen', 'Regain', 'Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	state.Passive = M{['description'] = 'Passive Mode', 'None', 'Twilight'}
	state.Weapons:options('Sword', 'Greataxe', 'Club', 'Polearm', 'Greatsword', 'Club', 'Axe', 'DualSword', 'DualDagger',
		'ProcDagger', 'ProcSword', 'ProcGreatSword', 'ProcKatana', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'ProcClub', 'ProcStaff')


	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Greatsword;gs c update')

	--Ikenga_axe_bonus = 300  -- It is 300 at R25. Uncomment if you need to manually adjust because you are using below R25 or above
	
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
	-- Enmity Set
	--------------------------------------
    sets.Enmity = {
		ammo="Sapience Orb",
		head="Pummeler's Mask +3",
		body="Shab. Cuirass +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		left_ring="Defending Ring",
		right_ring="Vengeful Ring",
	}
	
	sets.Knockback = {back="Impassive Mantle"}
	
	sets.passive.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	
	
	--------------------------------------
	-- Fast cast sets for spells
	--------------------------------------
	sets.precast.FC = {
		ammo="Sapience Orb",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
	}
	
	
	--------------------------------------
	-- Fast cast sets / specific spells
	--------------------------------------
	-- Utsusemi
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
	
	--------------------------------------
	-- Precast sets to enhance JAs
	--------------------------------------
	sets.precast.JA['Berserk'] = {body="Pummeler's Lorica +3", feet="Agoge Calligae +3", back="Cichol's Mantle"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
	sets.precast.JA['Defender'] = {hands="Agoge Mufflers +3"}
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +3", body="Agoge Lorica +3"}
	sets.precast.JA['Mighty Strikes'] = {head="Agoge Mufflers +3"}
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +3"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Retaliation'] = {hands="Pummeler's Mufflers +2", feet="Boii Calligae +3"}
	sets.precast.JA['Restraint'] = {hands="Boii Mufflers +3"}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +3"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
    
	
	--------------------------------------
	-- Waltz sets for /DNC
	--------------------------------------
	-- Curing Waltz
	sets.precast.Waltz = {}
    
	-- Flourish I
	sets.precast.Flourish1 = {}
	
	-- Healing Waltz
	sets.precast.Waltz['Healing Waltz'] = {}
    
	-- Steps
	sets.precast.Step = {}


------------------------------------------------------------------------------------------------------------------- 
-- MIDCAST SETS
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Fast recast
	--------------------------------------
	sets.midcast.FastRecast = {
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
	}
	
	
	--------------------------------------
	-- Fast reset for specific spells
	--------------------------------------
	-- Cure
	sets.midcast.Cure = {}
	
	-- Cures received by you
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	
	-- Utsusemi
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
                   
	-- Self Healing
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	
	
-------------------------------------------------------------------------------------------------------------------
-- DEFENSE & IDLE SETS
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Physical Damage Reduction
	--------------------------------------
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	-- PDT reraise set
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})


	--------------------------------------
	-- Magical Damage Reduction
	--------------------------------------
	sets.defense.MDT = set_combine(sets.defense.PDT, {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Tartarus Platemail",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ring="Archon Ring",
	})
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
	
	
	--------------------------------------
	-- Magical Evasion
	--------------------------------------
	sets.defense.MEVA = set_combine(sets.defense.PDT, {
		head="Volte Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Volte Boots",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Hearty Earring",
		left_ring="Vengeful Ring",
		back="Solemnity Cape",
	})
	
	
	--------------------------------------
	-- Misc. Defensive Sets
	--------------------------------------
	sets.Kiting = {left_ring="Shneddick Ring"}
	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {neck="Nicander's Necklace", waist="Gishdubar Sash"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	
	
-------------------------------------------------------------------------------------------------------------------
-- IDLE SETS
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Base Idle Set
	--------------------------------------
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Volte Salade",
		body="Sacro Breastplate",
		hands="Volte Moufles",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	-- Max regen set
	sets.idle.Regen = set_combine(sets.idle, {right_ring="Chirich Ring +1"})
	
	-- Regain set
	sets.idle.Regain = set_combine(sets.idle, {body="Makora Meikogai"})
	
	-- Weakened idle set
	-- sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail"})
	
	-- Reraise idle set
	-- sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm", body="Twilight Mail"})
	
	-- Resting set
	sets.resting = {}


-------------------------------------------------------------------------------------------------------------------
-- ENGAGED SETS
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Engaged Set, Single Wield
	--------------------------------------
	sets.engaged = { 
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	-- Accuracy Set
	sets.engaged.Acc = set_combine(sets.engaged, {waist="Ioskeha Belt +1", right_ring="Regal Ring"})
	
	-- Max Accuracy Set
	sets.engaged.MaxAcc = set_combine(sets.engaged, { -- 1440 Acc
		ammo="Seething Bomblet",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands="Boii Mufflers +3",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		right_ring="Chirich Ring +1",
	})

	-- Fodder set
	sets.engaged.Fodder = set_combine(sets.engaged, {
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands="Boii Mufflers +3",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ring="Niqmaddu Ring",
	})
	
	-- Subtle Blow set
	
	-- Hybrid DT Set
	sets.engaged.DT = set_combine(sets.engaged, {
		head="Hjarrandi Helm",
		body="Boii Lorica +3",
		waist="Ioskeha Belt +1",
	})
	
	
	--------------------------------------
	-- Engaged Set, Dual Wield
	--------------------------------------
	sets.engaged.DW = { 
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','Crit.hit rate+7','STR+11 VIT+11',}},
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	-- Accuracy set
	
	-- Max Accuracy set
	
	-- Fodder set
	
	-- Hybrid DT set
	sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
		head="Hjarrandi Helm",
		body="Boii Lorica +3",
	})

-------------------------------------------------------------------------------------------------------------------
-- WEAPON SETS
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Single handed weapons
	--------------------------------------
	sets.weapons.Axe = {main="Ikenga's Axe", sub="Blurred Shield +1"}
	sets.weapons.Club = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	sets.weapons.Greataxe = {main="Chango", sub="Utu Grip"}
	sets.weapons.Greatsword = {main="Agwu's Claymore", sub="Utu Grip"}
	sets.weapons.Polearm = {main="Shining One", sub="Utu Grip"}
	sets.weapons.Sword = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.Dagger = {main="Crepuscular Knife", sub="Blurred Shield +1"}
	
	--------------------------------------
	-- Dual weapons
	--------------------------------------
	sets.weapons.DualSword = {main="Naegling", sub="Blurred Knife +1"}
	sets.weapons.DualDagger = {main="Crepuscular Knife", sub="Blurred Knife +1"}
	
	
	--------------------------------------
	-- Proc weapons (Enabled in Abyssea only)
	--------------------------------------
	sets.weapons.ProcDagger = {main="Qutrub Knife", sub=empty}
	sets.weapons.ProcSword = {main="Ibushi Shinai", sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament", sub=empty}
	sets.weapons.ProcKatana = {main="Debahocho", sub=empty}
	sets.weapons.ProcScythe = {main="Lost Sickle", sub=empty}
	sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade", sub=empty}
	sets.weapons.ProcGreatKatana = {main="Zanmato", sub=empty}
	sets.weapons.ProcClub = {main="Soulflayer's Wand", sub=empty}
	sets.weapons.ProcStaff = {main="Ranine Staff", sub=empty}
	
	
-------------------------------------------------------------------------------------------------------------------
-- WEAPONSKILL SETS
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Default sets
	--------------------------------------
    sets.precast.WS = {
		ammo="Knobkierrie",
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
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
	})
	
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})

	
	--------------------------------------
	-- Axe Weaponskills
	--------------------------------------
    -- Calamity
	sets.precast.WS["Calamity"] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
	})
	
	sets.precast.WS["Calamity"].Acc = set_combine(sets.precast.WS["Calamity"], {
		body="Pumm. Lorica +3",
		waist="Ioskeha Belt +1",
	})
    
	sets.precast.WS["Calamity"].Fodder = set_combine(sets.precast.WS["Calamity"], {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
	})
	
	
	-- Decimation
	sets.precast.WS["Decimation"] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	})
	
	sets.precast.WS["Decimation"].Acc = set_combine(sets.precast.WS["Decimation"], {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		waist="Ioskeha Belt +1",
	})
	
	sets.precast.WS["Decimation"].Fodder = set_combine(sets.precast.WS["Decimation"], {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})
	 
	 
	-- Mistral Axe
	sets.precast.WS["Mistral Axe"] = set_combine(sets.precast.WS["Calamity"], {})
    sets.precast.WS["Mistral Axe"].Acc = set_combine(sets.precast.WS["Calamity"].Acc, {})
	sets.precast.WS["Mistral Axe"].Fodder = set_combine(sets.precast.WS["Calamity"].Fodder, {})
	
	
	-- Ruination
	sets.precast.WS["Ruination"] = set_combine(sets.precast.WS["Decimation"], {})
	sets.precast.WS["Ruination"].Acc = set_combine(sets.precast.WS["Decimation"].Acc, {})
	sets.precast.WS["Ruination"].Fodder = set_combine(sets.precast.WS["Decimation"].Fodder, {})
	
	--------------------------------------
	-- Club Weaponskills
	--------------------------------------
	-- Black Halo
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",	
	})
    
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
		waist="Ioskeha Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
	})

    sets.precast.WS['Black Halo'].Fodder = set_combine(sets.precast.WS['Black Halo'], {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		right_ring="Sroda Ring",
	})
	
	
	-- Judgement
    sets.precast.WS['Judgement'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

    sets.precast.WS['Judgement'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Judgement'].Fodder = set_combine(sets.precast.WS.Fodder, {
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		right_ring="Sroda Ring"
	})
	
	
	--------------------------------------
	-- Great Axe Weaponskills
	--------------------------------------
	-- Fell Cleave
    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})

    sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS['Fell Cleave'], {})
    sets.precast.WS['Fell Cleave'].Fodder = set_combine(sets.precast.WS['Fell Cleave'], {})
	
	
	-- Full Break
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Boii Cuisses +3",
		feet={ name="Sakpata's Leggings", augments={'Path: A',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		right_ear="Digni. Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Crepuscular Ring",	
	})

    sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Full Break"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	-- Ukko's Fury
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS["Ukko's Fury"], {})

    sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {right_ring="Sroda Ring"})
	
   
	-- Upheaval
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Gelatinous Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		right_ring="Sroda Ring",
	}) 
	

	--------------------------------------
	-- Great Sword Weaponskills
	--------------------------------------
    -- Resolution
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		head="Hjarrandi Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Pumm. Calligae +3",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ring="Niqmaddu Ring",
	})

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	-- Shockwave
	sets.precast.WS["Shockwave"] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
	})
	
	sets.precast.WS["Shockwave"].Acc = set_combine(sets.precast.WS["Shockwave"], {})
	
	sets.precast.WS["Shockwave"].Fodder = set_combine(sets.precast.WS["Shockwave"], {})
	
	--------------------------------------
	-- Polearm Weaponskills
	--------------------------------------
	-- Impulse Drive
    sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, { -- 1266 Acc
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		right_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Impulse Drive"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Impulse Drive"].Fodder = set_combine(sets.precast.WS.Fodder, {
		head="Blistering Sallet +1",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		legs="Boii Cuisses +3",
	})
	
	
	-- Sonic Thrust
	sets.precast.WS["Sonic Thrust"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Sonic Thrust"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Sonic Thrust"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	-- Stardiver
	sets.precast.WS["Stardiver"] = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Boii Mask +3",
		hands="Boii Mufflers +3",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Stardiver"].Acc = set_combine(sets.precast.WS["Stardiver"], {})

    sets.precast.WS["Stardiver"].Fodder = set_combine(sets.precast.WS["Stardiver"], {
		ammo="Crepuscular Pebble",
		head="Boii Mask +3",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	
	-- Vorpal Thrust
	sets.precast.WS["Vorpal Thrust"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		right_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Vorpal Thrust"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Vorpal Thrust"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	--------------------------------------
	-- Staff Weaponskills
	--------------------------------------
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Full Break"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	-- Circle Blade
	sets.precast.WS["Circle Blade"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Sroda Ring",
	})

    sets.precast.WS["Circle Blade"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Circle Blade"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	-- Requiscat
	sets.precast.WS["Requiscat"] = set_combine(sets.precast.WS, {
		head="Boii Mask +3",
		legs="Boii Cuisses +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ring="Niqmaddu Ring",
	})

    sets.precast.WS["Requiscat"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Requiscat"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	-- Sanguine Blade
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		right_ear="Friomisi Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Archon Ring",
	})

    sets.precast.WS["Sanguine Blade"].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Sanguine Blade"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		hands="Boii Mufflers +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	})

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
	})


	--------------------------------------
	-- Swaps when using WS at 3000 TP
	--------------------------------------
	sets.MaxTP = {left_ear="Lugra Earring +1"}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}
	
	
	--------------------------------------
	-- Specialty weaponskill set overrides
	--------------------------------------
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}

	
-------------------------------------------------------------------------------------------------------------------
-- MISCELANEOUS SETS
-------------------------------------------------------------------------------------------------------------------
	--------------------------------------
	-- Special Sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {hands="Pumm. Mufflers +2", feet="Boii Calligae +3"}
	sets.buff.Restraint = {hands="Boii Mufflers +3"}
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Volte Cap",
        body="Volte Jupon",
		waist="Chaac Belt",
	})
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end