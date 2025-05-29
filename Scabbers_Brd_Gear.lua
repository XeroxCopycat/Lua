function user_job_setup()
	-- options: override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant', 'AoE')
	state.IdleMode:options('Normal', 'NoRefresh', 'DT')
	state.Weapons:options('None', 'Naegling', 'Twashtar', 'NaeglingTernion', 'TauretAeneas', 'AeolianEdge')
	state.WeaponskillMode:options('Normal')

	info.ExtraSongInstrument = 'Daurdabla'

	-- how many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2

	-- set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, 'Use Custom Timers')

	gear.macc_casting_jse_back = { name = "Intarabus's Cape", augments = { 'CHR+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc.+10', '"Fast Cast"+10', 'Damage taken-5%', } }
	gear.stp_tp_jse_back = { name = "Intarabus's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Damage taken-5%', } }
	gear.str_wsd_jse_back = { name = "Intarabus's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-5%', } }

	-- additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')

	-- unlock brd weapons by default
	send_command('gs c toggle unlockweapons')
	send_command('gs c set Weapons NaeglingTernion')

	select_default_macro_book()
end

autows_list = {
	['None'] = 'Evisceration',
	['Naegling'] = 'Savage Blade',
	['Twashtar'] = 'Rudra\'s Storm',
	['NaeglingTernion'] = 'Savage Blade',
	['TauretAeneas'] = 'Aeolian Edge',
	['AeolianEdge'] = 'Aeolian Edge'
}

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	sets.weapons.Naegling = { main = "Naegling" }
	sets.weapons.Twashtar = { main = { name = "Twashtar", augments = { 'Path: A', } } }
	sets.weapons.NaeglingTernion = { main = "Naegling", sub = { name = "Ternion Dagger +1", augments = { 'Path: A', } }, }
	sets.weapons.TauretAeneas = { main = "Tauret", sub = { name = "Aeneas" } }
	sets.weapons.AeolianEdge = {
		main = "Aeneas",
		sub = { name = "Malevolence", augments = { 'INT+10', 'Mag. Acc.+10', '"Mag.Atk.Bns."+8', '"Fast Cast"+5', } },
	}
	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }
	
	-- precast Sets

	-- fast cast sets for spells
	sets.precast.FC = {
		main = "Carnwenhan",
		-- ammo="Sapience Orb",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		sub = { name = "Genbu's Shield", augments = { '"Cure" potency +5%', 'Mag. Acc.+5', 'MND+6', } },
		body = "Inyanga Jubbah +2",
		hands = "Inyan. Dastanas +2",
		legs = "Aya. Cosciales +2",
		feet = "Fili Cothurnes +2",
		neck = "Mnbw. Whistle +1",
		waist = "Embla Sash",
		left_ear = "Musical Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Weather. Ring",
		back = gear.macc_casting_jse_back
	}

	-- sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})
	-- sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	-- sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

	sets.precast.FC.BardSong = {
		main = "Carnwenhan",
		sub = { name = "Genbu's Shield", augments = { '"Cure" potency +5%', 'Mag. Acc.+5', 'MND+6', } },
		head = { name = "Vanya Hood", augments = { 'MP+50', '"Fast Cast"+10', 'Haste+2%', } },
		body = "Brioso Justau. +3",
		hands = "Fili Manchettes +2",
		legs = "Aya. Cosciales +2",
		feet = "Fili Cothurnes +2",
		neck = "Mnbw. Whistle +1",
		waist = "Embla Sash",
		left_ear = "Musical Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = gear.macc_casting_jse_back
	}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, { range = "Gjallarhorn" })
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong, { range = "Gjallarhorn" })

	sets.precast.FC.Lullaby = { range = "Blurred Harp +1" }
	sets.precast.FC.Lullaby.Resistant = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.precast.FC['Horde Lullaby'] = set_combine(sets.midcast.Lullaby, { range = "Blurred Harp +1" })
	sets.precast.FC['Horde Lullaby'].Resistant = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.precast.FC['Horde Lullaby'].AoE = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.precast.FC['Horde Lullaby II'] = set_combine(sets.midcast.Lullaby, { range = "Blurred Harp +1" })
	sets.precast.FC['Horde Lullaby II'].Resistant = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.precast.FC['Horde Lullaby II'].AoE = set_combine(sets.midcast.Lullaby, { range = "Blurred Harp +1" })


	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, { range = "Gjallarhorn" })
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, { range = info.ExtraSongInstrument })
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
	sets.precast["Army's Paeon"] = sets.precast.DaurdablaDummy

	-- precast sets to enhance JAs
	sets.precast.JA.Nightingale = { feet = "Bihu Slippers +3" }
	sets.precast.JA.Troubadour = { body = { name = "Bihu Jstcorps. +3", augments = { 'Enhances "Troubadour" effect', } } }
	sets.precast.JA['Soul Voice'] = { legs = "Bihu Cannions +3" }

	-- waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- general set for recast times.
	sets.midcast.FastRecast = {}


	sets.midcast.Lullaby = {
		main = "Carnwenhan",
		sub = { name = "Genbu's Shield", augments = { '"Cure" potency +5%', 'Mag. Acc.+5', 'MND+6', } },
		range = "Blurred Harp +1",
		head = "Brioso Roundlet +3",
		body = "Brioso Justau. +3",
		hands = "Brioso Cuffs +3",
		legs = "Inyanga Shalwar +2",
		feet = { name = "Bihu Slippers +3", augments = { 'Enhances "Nightingale" effect', } },
		neck = "Mnbw. Whistle +1",
		waist = "Embla Sash",
		left_ear = "Musical Earring",
		right_ear = "Gersemi Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = { name = "Intarabus's Cape", augments = { 'CHR+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc.+5', '"Fast Cast"+10', 'Damage taken-5%', } },
	}

	-- gear to enhance certain classes of songs
	sets.midcast.Ballad = set_combine(sets.midcast.Ballad, { range = "Miracle Cheer", legs = "Fili Rhingrave +2" })

	sets.midcast.Lullaby.Resistant = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.Lullaby, { range = "Blurred Harp +1" })
	sets.midcast['Horde Lullaby'].Resistant = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.midcast['Horde Lullaby'].AoE = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.midcast['Horde Lullaby II'] = set_combine(sets.midcast.Lullaby, { range = "Blurred Harp +1" })
	sets.midcast['Horde Lullaby II'].Resistant = set_combine(sets.midcast.Lullaby, { range = "Daurdabla" })
	sets.midcast['Horde Lullaby II'].AoE = set_combine(sets.midcast.Lullaby, { range = "Blurred Harp +1" })

	sets.midcast.Madrigal = { head = "Fili Calot +2" }
	sets.midcast.Paeon = { range = "Daurdabla" }
	sets.midcast.March = { hands = "Fili Manchettes +2" }
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, { range = "Marsyas" })
	sets.midcast.Minuet = { body = "Fili Hongreline +2" }
	sets.midcast.Minne = {}
	sets.midcast.Carol = { hands = "Mousai Gages +1", }
	sets.midcast["Sentinel's Scherzo"] = { feet = "Fili Cothurnes +2" }
	sets.midcast['Magic Finale'] = { range = "Gjallarhorn" }
	sets.midcast.Mazurka = { range = "Gjallarhorn" }


	-- for song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main = "Carnwenhan",
		sub = { name = "Genbu's Shield", augments = { 'MND+6', 'Mag. Acc+5', '"Cure" Potency +5%' } },
		range = "Gjallarhorn",
		head = "Fili Calot +2",
		body = "Fili Hongreline +2",
		hands = "Fili Manchettes +2",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +3",
		neck = "Mnbw. Whistle +1",
		waist = "Channeler's Stone",
		left_ear = "Musical Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = { name = "Intarabus's Cape", augments = { 'CHR+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc+5', '"Fast Cast"+10', 'Damage taken-5%', } },
	}

	sets.midcast.SongEffect.DW = {
		main = "Carnwenhan",
		sub = { name = "Kali", augments = { 'Mag. Acc.+15', 'String instrument skill +10', 'Wind instrument skill +10', } }
	}

	-- for song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
		main = "Carnwenhan",
		sub = { name = "Genbu's Shield", augments = { 'MND+6', 'Mag. Acc+5', '"Cure" Potency +5%' } },
		range = "Gjallarhorn",
		head = "Fili Calot +2",
		body = "Fili Hongreline +2",
		hands = "Fili Manchettes +2",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +3",
		neck = "Mnbw. Whistle +1",
		waist = "Witful Belt",
		left_ear = "Musical Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = gear.macc_casting_jse_back
	}

	sets.midcast.SongDebuff.DW = {
		main = "Carnwenhan",
		sub = { name = "Kali", augments = { 'Mag. Acc.+15', 'String instrument skill +10', 'Wind instrument skill +10', } }
	}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {
		main = "Carnwenhan",
		sub = { name = "Genbu's Shield", augments = { '"Cure" potency +5%', 'Mag. Acc.+5', 'MND+6', } },
		range = "Gjallarhorn",
		head = "Fili Calot +2",
		body = "Fili Hongreline +2",
		hands = "Fili Manchettes +2",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +3",
		neck = "Mnbw. Whistle +1",
		waist = "Witful Belt",
		left_ear = "Musical Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = gear.macc_casting_jse_back
	}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {
		main = "Carnwenhan",
		sub = { name = "Genbu's Shield", augments = { '"Cure" potency +5%', 'Mag. Acc.+5', 'MND+6', } },
		head = "Fili Calot +2",
		body = "Fili Hongreline +2",
		hands = "Fili Manchettes +2",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +3",
		neck = "Mnbw. Whistle +1",
		waist = "Channeler's Stone",
		right_ear = "Loquac. Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = gear.macc_casting_jse_back
	}

	sets.midcast.SongDebuff.DW = {}

	-- cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = { range = info.ExtraSongInstrument }

	-- dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, { range = info.ExtraSongInstrument })
	sets.midcast["Army's Paeon"] = sets.midcast.DaurdablaDummy

	-- other general spells and classes.
	
	-- sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Pemphredo Tathlum",
	--     head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
	--     body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring",ring2="Menelaus's Ring",
	--     back="Tempered Cape +1",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}

	-- sets.midcast.Curaga = sets.midcast.Cure
	-- sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	-- sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}

	sets.Cure_Received = {
		neck="Phalaina Locket",
		--hands="Buremte Gloves",
		ring2="Kunaji Ring",
		waist="Gishdubar Sash"
	}
	
	sets.Cursna_Received = { waist = "Gishdubar Sash" }

	-- sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
	-- 	head="Telchine Cap",neck="Voltsurge Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
	-- 	body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
	-- 	back="Intarabus's Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}

	-- sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})

	-- sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
	-- 	head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
	-- 	body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
	-- 	back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}

	-- sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
	-- 	head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
	-- 	body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
	-- 	back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}

	-- sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
	-- 	back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})

	-- sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	-- Resting sets
	-- 	sets.resting = {
	--     range="Daurdabla",
	--     head={ name="Nyame Helm", augments={'Path: B',}},
	--     body={ name="Nyame Mail", augments={'Path: B',}},
	--     hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	--     legs={ name="Nyame Flanchard", augments={'Path: B',}},
	--     feet={ name="Nyame Sollerets", augments={'Path: B',}},
	--     neck="Elite Royal Collar",
	--     waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	--     left_ear="Telos Earring",
	--     right_ear="Eabani Earring",
	--     left_ring="Warden's Ring",
	--     right_ring="Defending Ring",
	--     back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	-- }

	sets.idle = {
		main = "Sangoma",
		sub = { name = "Genbu's Shield", augments = { '"Cure" potency +5%', 'Mag. Acc.+5', 'MND+6', } },
		range = "Daurdabla",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Fili Cothurnes +2",
		neck="Elite Royal Collar",
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		right_ear="Arete del Luna +1",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back = gear.stp_tp_jse_back,
	}

	-- defense sets

	sets.Kiting = { feet = "Fili Cothurnes +2" }
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {
		range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +2%','Quadruple Attack +3',}},
		head="Fili Calot +2",
		body="Fili Hongreline +2",
		hands="Fili Manchettes +2",
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +2",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Eabani Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back = gear.stp_tp_jse_back,
	}

    sets.precast.WS['Savage Blade'] = {
		range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +2%','Quadruple Attack +3',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Sroda Ring",
		right_ring="Cornelia's Ring",
        back = gear.str_wsd_jse_back,
    }

	sets.precast.WS['Aeolian Edge'] = {
		head = { name = "Nyame Helm", augments = { 'Path: B', } },
		body = { name = "Nyame Mail", augments = { 'Path: B', } },
		hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
		legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
		feet = "Fili Cothurnes +2",
		neck = "Sibyl Scarf",
		waist = "Tengu-no-Obi",
		left_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
		right_ear = "Ishvara Earring",
		left_ring = "Cornelia's Ring",
		right_ring = "Sroda Ring",
		back = gear.str_wsd_jse_back,
	}
	
	-- 	sets.engaged.Acc = {
	--     range={ name="Linos", augments={'Attack+15','"Store TP"+2','Quadruple Attack +3',}},
	--     head={ name="Nyame Helm", augments={'Path: B',}},
	--     body={ name="Nyame Mail", augments={'Path: B',}},
	--     hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	--     legs={ name="Nyame Flanchard", augments={'Path: B',}},
	--     feet={ name="Nyame Sollerets", augments={'Path: B',}},
	--     neck={ name="Bard's Charm +2", augments={'Path: A',}},
	--     waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	--     left_ear="Telos Earring",
	--     right_ear="Eabani Earring",
	--     left_ring="Chirich Ring +1",
	--     right_ring="Chirich Ring +1",
	--     back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	-- }
	-- 	sets.engaged.DW = {
	--     range={ name="Linos", augments={'Attack+15','"Store TP"+2','Quadruple Attack +3',}},
	--     head={ name="Nyame Helm", augments={'Path: B',}},
	--     body={ name="Nyame Mail", augments={'Path: B',}},
	--     hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	--     legs={ name="Nyame Flanchard", augments={'Path: B',}},
	--     feet={ name="Nyame Sollerets", augments={'Path: B',}},
	--     neck={ name="Bard's Charm +2", augments={'Path: A',}},
	--     waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	--     left_ear="Telos Earring",
	--     right_ear="Eabani Earring",
	--     left_ring="Chirich Ring +1",
	--     right_ring="Chirich Ring +1",
	--     back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	-- }
	-- 	sets.engaged.DW.Acc = {
	--     range={ name="Linos", augments={'Attack+15','"Store TP"+2','Quadruple Attack +3',}},
	--     head={ name="Nyame Helm", augments={'Path: B',}},
	--     body={ name="Nyame Mail", augments={'Path: B',}},
	--     hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	--     legs={ name="Nyame Flanchard", augments={'Path: B',}},
	--     feet={ name="Nyame Sollerets", augments={'Path: B',}},
	--     neck={ name="Bard's Charm +2", augments={'Path: A',}},
	--     waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	--     left_ear="Telos Earring",
	--     right_ear="Eabani Earring",
	--     left_ring="Chirich Ring +1",
	--     right_ring="Chirich Ring +1",
	--     back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	-- }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- set_macro_page(1, 1)
end
