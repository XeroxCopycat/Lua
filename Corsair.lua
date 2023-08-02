-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+Home ]       Quick Draw primary shot element cycle forward.
--              [ CTRL+End ]        Quick Draw primary shot element cycle backward.
--              [ ALT+Home ]        Quick Draw secondary shot element cycle forward.
--              [ ALT+End ]         Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+X ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+NumLock ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Leaden Salute
--              [ CTRL+Numpad5 ]    Requiescat
--              [ CTRL+Numpad6 ]    Wildfire
--              [ CTRL+Numpad1 ]    Aeolian Edge
--              [ CTRL+Numpad2 ]    Evisceration
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Enhance', 'Potency', 'TH'}

    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
              "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch"}
    elemental_ws = S{"Aeolian Edge", "Leaden Salute", "Wildfire"}
    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    define_roll_values()

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'HighAcc', 'STP')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('STP', 'Normal', 'Acc', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    state.WeaponSet = M{['description']='Weapon Set', 'DeathPenalty_M', 'DeathPenalty_R', 'Armageddon_M', 'Armageddon_R', 'Fomalhaut_M', 'Fomalhaut_R', 'Ataktos'}
    -- state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.RAbullet = "Chrono Bullet"
    gear.RAccbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet"
    gear.QDbullet = "Chrono Bullet"
    options.ammo_warning_limit = 10

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind @t gs c cycle treasuremode')
    --send_command('bind ^` input /ja "Double-up" <me>')
    --send_command('bind ^c input /ja "Crooked Cards" <me>')
    --send_command('bind ^s input /ja "Snake Eye" <me>')
    --send_command('bind ^f input /ja "Fold" <me>')
    --send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    --send_command ('bind @` gs c toggle LuzafRing')

    send_command('bind ^home gs c cycleback mainqd')
    send_command('bind ^end gs c cycle mainqd')
    send_command('bind !home gs c cycle altqd')
    send_command('bind !end gs c cycleback altqd')
    --send_command('bind ^pageup gs c toggle selectqdtarget')
    --send_command('bind ^pagedown gs c toggle usealtqd')

    --send_command('bind @c gs c toggle CP')
    --send_command('bind @q gs c cycle QDMode')
    --send_command('bind @e gs c cycleback WeaponSet')
    --send_command('bind @r gs c cycle WeaponSet')
    --send_command('bind @w gs c toggle WeaponLock')

    --send_command('bind ^numlock input /ja "Triple Shot" <me>')

    if player.sub_job == 'WAR' then
        --send_command('bind ^numpad/ input /ja "Berserk" <me>')
        --send_command('bind ^numpad* input /ja "Warcry" <me>')
        --send_command('bind ^numpad- input /ja "Aggressor" <me>')
    end

    --send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    --send_command('bind ^numpad8 input /ws "Last Stand" <t>')
    --send_command('bind ^numpad4 input /ws "Leaden Salute" <t>')
    --send_command('bind ^numpad5 input /ws "Requiescat" <t>')
    --send_command('bind ^numpad6 input /ws "Wildfire" <t>')
    --send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')
    --send_command('bind ^numpad2 input /ws "Evisceration" <t>')

    --send_command('bind %numpad0 input /ra <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    --send_command('unbind ^`')
    --send_command('unbind ^c')
    --send_command('unbind ^s')
    --send_command('unbind ^f')
    --send_command('unbind !`')
    --send_command('unbind @t')
    --send_command('unbind @`')
    --send_command('unbind ^insert')
    --send_command('unbind ^delete')
    --send_command('unbind ^home')
    --send_command('unbind ^end')
    --send_command('unbind ^pageup')
    --send_command('unbind ^pagedown')
    --send_command('unbind ^,')
    -- send_command('unbind @c')
    --send_command('unbind @q')
    --send_command('unbind @w')
    --send_command('unbind @e')
    --send_command('unbind @r')
    --send_command('unbind ^numlock')
    --send_command('unbind ^numpad/')
    --send_command('unbind ^numpad*')
    --send_command('unbind ^numpad-')
    --send_command('unbind ^numpad8')
    --send_command('unbind ^numpad4')
    --send_command('unbind ^numpad5')
    --send_command('unbind ^numpad6')
    --send_command('unbind ^numpad1')
    --send_command('unbind ^numpad2')
    --send_command('unbind numpad0')

    --send_command('unbind #`')
    --send_command('unbind #1')
    --send_command('unbind #2')
    --send_command('unbind #3')
    --send_command('unbind #4')
    --send_command('unbind #5')
    --send_command('unbind #6')
    --send_command('unbind #7')
    --send_command('unbind #8')
    --send_command('unbind #9')
    --send_command('unbind #0')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

	-- Phantom Roll precast
    sets.precast.CorsairRoll = {
        head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Malignance Tabard",
		hands="Chasseur's Gants +3",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Regal Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Luzaf's Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
    }

	-- Phantom Roll Duration / Lower Delay
    --sets.precast.CorsairRoll.Duration = {main="Rostam", range="Compensator"}
    --sets.precast.CorsairRoll.LowerDelay = {legs="Desultor Tassets"}
	
	-- Equipment for specific rolls
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})

	-- Luzaf's Ring for larger area of effect
    sets.precast.LuzafRing = {left_ring="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

	-- Precast for Curing Waltz when /DNC
    sets.precast.Waltz = {
        --body="Passion Jacket",
        --left_ring="Asklepian Ring",
        --waist="Gishdubar Sash",
    }

	-- Precast for Healing Waltz when /DNC
    sets.precast.Waltz['Healing Waltz'] = {}

	-- Precast for Fast Cast
    sets.precast.FC = {
        --head="Carmine Mask +1", --Path D
		head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Enmity-1','MND+4','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Taeon Tabard", augments={'DEF+19','"Fast Cast"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		--legs="Herculean Trousers" --Fast Cast
		legs="Malignance Tights",
		--Feet="Carmine Greaves +1", --Path D
		feet="Malignance Boots",
		--neck="Orunmila's torque",
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		--left_ring="Rahab Ring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		--back="Camulus's Mantle", --Fast Cast
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
    }

	-- Precast for Utsusemi when /NIN
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        --body="Passion Jacket",
		neck="Magoraga Beads",
    })

    -- Precast for Ranged Attack
    sets.precast.RA = {
        head="Chass. Tricorne +3", --18 RS/0 SS
		--body="Oshosi Vest +1", --0 RS/14 SS
		body="Laksa. Frac +3", --20 RS/0 SS
		hands="Lanun Gants +3", --0 RS/13 SS
		legs="Adhemar Kecks +1", augments={'Path: D',}, --13 RS/10 SS 
		feet="Meg. Jam. +2", --0 RS/10 SS
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, --0 RS/4 SS
		waist="Yemaya Belt", --0 RS/5 SS
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+8','"Store TP"+10','Mag. Evasion+15',}},
    } 

	-- Ranged Attack Precast w/ Flurry
    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body="Laksa. Frac +3",
    })

	-- Ranged Attack Precast w/ Flurry II
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        hands="Carmine Fin. Ga. +1", --8/11
        --feet="Pursuer's Gaiters", --0/10
    })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = { 
        head={ name="Nyame Helm", augments={'Path: B',}},
		body="Laksa. Frac +3",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Cornelia's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
    }
    

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        feet="Meg. Jam. +2",
        neck="Iskur Gorget",
		left_ear="Telos Earring",
    })

    --------------------------------------
	-- Dagger Weaponskills
	--------------------------------------
	--Aeolian Edge
	sets.precast.WS['Aeolian Edge'] = {
		head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Enmity-1','MND+4','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		--waist="Orpheus's Sash",
		waist="Eschan Stone",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
    --Evisceration
	sets.precast.WS['Evisceration'] = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		--body="Abnoba Kaftan",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		--legs="Herculean Trousers", --Dex/Atk/Acc/CritDmg
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet="Mummu Gamash. +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Mummu Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	--------------------------------------
	-- Gun Weaponskills
	--------------------------------------
	-- Last Stand
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		legs="Meg. Chausses +2",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})
	
	-- Last Stand Acc
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		left_ear="Telos Earring",
	})
	
	--Leaden Salute
	sets.precast.WS['Leaden Salute'] = {
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Archon Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	--Wildfire
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'], {
		head={ name="Nyame Helm", augments={'Path: B',}}, 
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Cornelia's Ring",
	})
	
	--------------------------------------
	-- Sword Weaponskills
	--------------------------------------
	--Requiescat
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
	})
	
	-- Savage Blade Acc
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		head="Meghanada Visor +2",
		waist="Grunfeld Belt",
		left_ear="Telos Earring",
	})
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	-- Midcast Fast Cast
    sets.midcast.FastRecast = sets.precast.FC

	-- Midcast Spell Interuption Rate Gear
    sets.midcast.SpellInterrupt = {
        --body=gear.Taeon_Phalanx_body, --10
        --hands="Rawhide Gloves", --15
        --legs="Carmine Cuisses +1", --20
        --feet=gear.Taeon_Phalanx_feet, --10
        --neck="Loricate Torque +1", --5
        --ear1="Halasz Earring", --5
        --ear2="Magnetic Earring", --8
        --right_ring="Evanescence Ring", --5
        --waist="Rumination Sash", --10
    }

	-- Midcast Utsusemi Gear
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	-- Midcast Cure Gear
    sets.midcast.Cure = {
        --neck="Incanter's Torque",
        --ear1="Roundel Earring",
        --ear2="Mendi. Earring",
        --left_ring="Lebeche Ring",
        --right_ring="Haoma's Ring",
        --waist="Bishop's Sash",
    }

	-- Quick Draw Midcast
    sets.midcast.CorsairShot = {
		head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Enmity-1','MND+4','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','DEX+8','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
		feet="Chass. Bottes +3",
		neck="Baetyl Pendant",
		--waist="Skrymir Cord +1",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		--right_ring="Fenrir Ring +1",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	-- Quick Draw Midcast Acc
    sets.midcast.CorsairShot.Acc = {
		head="Laksa. Tricorne +3",
		body="Malignance Tabard",
		hands="Chasseur's Gants +3",
		legs="Malignance Tights",
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		--waist="K. Kachina Belt +1",
		waist="Eschan Stone",
		--left_ear="Digni. Earring",
		left_ear="Telos Earring",
		right_ear="Gwati Earring",
		--left_ring="Stikini Ring +1",
		left_ring="Mummu Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	-- Quick Draw Midcast StoreTP
	sets.midcast.CorsairShot.StoreTP = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Melignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		left_ring="Mummu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

    --sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot.Acc,
	--sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot.Acc, {
		--head="Pixie Hairpin +1",
		--left_ring="Archon Ring",
	--})
    sets.midcast.CorsairShot.Enhance = {feet="Chass. Bottes +3"}

    -- Midcast Ranged Attack
    sets.midcast.RA = {
		head="Ikenga's Hat",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Chas. Culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+8','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Midcast Ranged Attack Acc
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, { })

	-- Midcast Ranged Attack High Acc
    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
        legs="Laksa. Trews +3",
		--waist="K. Kachina Belt +1",
        left_ring="Regal Ring",
    })

	-- Micast Ranged Attack Critical Hit
    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
        head="Meghanada Visor +2",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +2",
        legs="Mummu Kecks +2",
        feet="Osh. Leggings",
		--waist="K. Kachina Belt +1",
        --left_ring="Begrudging Ring",
        right_ring="Mummu Ring",
    })

	-- Micast Ranged Attack StoreTP
    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
        left_ear="Dedition Earring",
        left_ring="Chirich Ring +1",
        --right_ring={name="Chirich Ring +1", bag="wardrobe4"},
    })

	-- Midcast Triple Shot
    sets.TripleShot = {
        --head="Oshosi Mask", 
        body="Chasseur's Frac +3",
        hands="Lanun Gants +3",
        --legs="Osh. Trousers", 
        --feet="Osh. Leggings", 
    } 

	-- Midcast Triple Shot Critical Hit
    sets.TripleShotCritical = {
        head="Meghanada Visor +2",
        waist="K. Kachina Belt +1",
    }

	-- Midcast True Shot
    sets.TrueShot = {
        body="Nisroch Jerkin",
        --legs="Osh. Trousers",
    }


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

	-- Idle Set in field
    sets.idle = {
        head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Hearty Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}

	--Idle Damage Taken Set
    --sets.idle.DT = set_combine(sets.idle, {
	
	--Idle Refresh Set
	--sets.idle.Refresh = set_combine(sets.idle, {
	
	--Idle Regen set
	sets.idle.Regen = set_combine(sets.idle, {
        head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Sanctity Necklace",
		left_ring="Shneddick Ring",
        right_ring="Chirich Ring +1",		
	})

	--Idle In-Town Set
    sets.idle.Town = set_combine(sets.idle, {
        head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Physical Damage Taken
	sets.defense.PDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Hearty Earring",
		left_ring="Vengeful Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}},
	}

	-- Magical Damage Taken
    sets.defense.MDT = set_combine(sets.defense.PDT, {right_ear="Etiolation Earring"})
	
	-- Kiting/Movement Speed
	sets.Kiting = {left_ring="Shneddick Ring"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

	-------------------------------------
    -- Engaged sets
	-------------------------------------
    sets.engaged = {
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+3','STR+10','Attack+9',}},
		neck="Iskur Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	-- Engaged Acc Gear
    sets.engaged.Acc = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Torque",
	})

	-- Engaged High Accuracy Gear
    sets.engaged.HighAcc = set_combine(sets.engaged.Acc, {
		head="Chass. Tricorne +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
	})

	-- Engaged Store TP Gear
    sets.engaged.STP = set_combine(sets.engaged, {
        left_ring="Chirich Ring +1",
	})

	-------------------------------------
    -- Dual Wield sets
	-------------------------------------
    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%
	-- Requires the GearInfo plugin to function
	-- properly. Otherwise will fallback to engaged sets.
	
    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = { -- +70 Dual Wield
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}},
		legs="Malignance Tights",
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+4','STR+5 DEX+5',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
    }
	
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		neck="Sanctity Necklace",
		right_ring="Regal Ring",
	})
	
    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.Acc, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
	})
	
    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
	})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = { --+66 Dual Wield
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}},
		legs="Malignance Tights",
		feet={ name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+4','STR+5 DEX+5',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.DW.Acc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		neck="Sanctity Necklace",
		left_ear="Telos Earring",
		right_ring="Regal Ring",
	})
    
	sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
	})
    
	sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
	})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
        head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}, --DW +5
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai", --DW +7
		left_ear="Dedition Earring",
		right_ear="Suppanomimi", --DW +5
		left_ring="Petrov ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --DW +10
	}
	
    sets.engaged.DW.Acc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		neck="Sanctity Necklace",
		left_ear="Telos Earring",
		right_ring="Regal Ring",
	})
	
    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		left_ring="Chirich Ring +1",
	})
    
	sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		legs="Chas. Culottes +3",
		left_ring="Chirich Ring +1",
	})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}, --DW +5
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai", --DW +7
		left_ear="Eabani Earring", --DW +4
		right_ear="Suppanomimi", --DW +5
		left_ring="Petrov ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.DW.Acc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		neck="Sanctity Necklace",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})
	
    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, {
		head="Chass. Tricorne +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		left_ear="Telos Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --DW +10
	})
	
    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		legs="Chas. Culottes +3",
		left_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --DW +6
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai", --DW +7
		left_ear="Dedition Earring", 
		right_ear="Telos Earring",
		left_ring="Petrov ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.DW.Acc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		neck="Sanctity Necklace",
		left_ring="Chirich Ring +1",
		right_ring="Regal Ring",
	})
	
    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, {
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		feet="Chass. Bottes +3",
	})
	
    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		legs="Chas. Culottes +3",
		left_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
	})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head="Malignance Chapeau", --6/6
        body="Malignance Tabard", --9/9
        hands="Malignance Gloves", --5/5
        legs="Malignance Tights", --7/7
        feet="Malignance Boots", --4/4
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        --left_ring={name="Eshmun's Ring", bag="wardrobe3"}, --20
        --right_ring={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
    }

    --sets.FullTP = {ear1="Crematio Earring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Aptitude Mantle +1"}
    sets.Reive = {neck="Ygnas's Resolve +1"}

    --sets.TreasureHunter = {head="Volte Cap", hands=gear.Herc_TH_hands, feet="Volte Boots", waist="Chaac Belt"}

    --sets.DeathPenalty_M = {main={name="Rostam", bag="wardrobe3"}, sub="Tauret", ranged="Death Penalty"}
    --sets.DeathPenalty_M.Acc = {main={name="Rostam", bag="wardrobe3"}, sub={name="Rostam", bag="wardrobe"}, ranged="Death Penalty"}
    --sets.DeathPenalty_R = {main="Lanun Knife", sub="Tauret", ranged="Death Penalty"}
    --sets.DeathPenalty_R.Acc = {main="Lanun Knife", sub={name="Rostam", bag="wardrobe"}, ranged="Death Penalty"}
    --sets.Armageddon_M = {main="Naegling", sub="Tauret", ranged="Armageddon"}
    --sets.Armageddon_M.Acc = {main={name="Rostam", bag="wardrobe3"}, sub={name="Rostam", bag="wardrobe4"}, ranged="Armageddon"}
    --sets.Armageddon_R = {main="Lanun Knife", sub="Kustawi +1", ranged="Armageddon"}
    --sets.Armageddon_R.Acc = sets.Armageddon_R
    --sets.Fomalhaut_M = {main={name="Rostam", bag="wardrobe3"}, sub="Blurred Knife +1", ranged="Fomalhaut"}
    --sets.Fomalhaut_M.Acc = {main={name="Rostam", bag="wardrobe3"}, sub="Kustawi +1", ranged="Fomalhaut"}
    --sets.Fomalhaut_R = {main="Lanun Knife", sub="Kustawi +1", ranged="Fomalhaut"}
    --sets.Fomalhaut_R.Acc = sets.Fomalhaut_R
    --sets.Ataktos = {main="Naegling", sub="Blurred Knife +1", ranged="Ataktos"}
    --sets.Ataktos.Acc = {main="Naegling", sub="Demers. Degen +1", ranged="Ataktos"}

    sets.DefaultShield = {sub="Nusku Shield"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    --if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
       -- do_bullet_checks(spell, spellMap, eventArgs)
    --end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false then
            equip(sets.precast.CorsairRoll.Duration)
        end
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    end
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
		if flurry == 2 then
			equip(sets.precast.RA.Flurry2)
		elseif flurry == 1 then
			equip(sets.precast.RA.Flurry1)
		end
		elseif spell.type == 'WeaponSkill' then
        if spell.skill == 'Marksmanship' then
            special_ammo_check()
    end
        
	-- Replace TP-bonus gear if not needed.
    --if spell.english == 'Leaden Salute' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
        --equip(sets.FullTP)
    --end
    if elemental_ws:contains(spell.name) then
        -- Matching double weather (w/o day conflict).
        if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
            equip({waist="Hachirin-no-Obi"})
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Matching day and weather.
        elseif spell.element == world.day_element and spell.element == world.weather_element then
			equip({waist="Hachirin-no-Obi"})
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Match day or weather.
        elseif spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
            if state.QDMode.value == 'Enhance' then
                equip(sets.midcast.CorsairShot.Enhance)
            elseif state.QDMode.value == 'TH' then
                equip(sets.midcast.CorsairShot)
                equip(sets.TreasureHunter)
            elseif state.QDMode.value == 'STP' then
                equip(sets.midcast.CorsairShot.STP)
            end
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot)
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
    --if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        --check_weaponset()
    --end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('left_ring','right_ring','waist')
        else
            enable('left_ring','right_ring','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('ranged')
    else
        enable('ranged')
    end

    --check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default melee set after it was constructed.
--function customize_melee_set(meleeSet)
    --check_weaponset()
	--return meleeSet
--end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if spell.skill == 'Marksmanship' then
        if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
    else
        if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'

    local e_msg = state.Mainqd.current
    if state.UseAltqd.value == true then
        e_msg = e_msg .. '/'..state.Altqd.current
    end

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end)

-- Determines how much dual wield we have and what haste set to use
-- Requires GearInfo addon to function
function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

-- Sets us to our regen set if we are below a certain % of HP
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet

end
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end

        send_command('@input /ja "'..doqd..'" <t>')
    end

    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function define_roll_values()
    rolls = {
        ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and string.char(129,157)) or ''

    if rollinfo then
        add_to_chat(001, string.char(129,115).. '  ' ..string.char(31,210)..spell.english..string.char(31,001)..
            ' : '..rollinfo.bonus.. ' ' ..string.char(129,116).. ' ' ..string.char(129,195)..
            '  Lucky: ' ..string.char(31,204).. tostring(rollinfo.lucky)..string.char(31,001).. ' /' ..
            ' Unlucky: ' ..string.char(31,167).. tostring(rollinfo.unlucky)..string.char(31,002)..
            '  ' ..rollsize)
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                --bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                --bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        --bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        --bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

function special_ammo_check()
    -- Stop if Animikii/Hauksbok equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
    end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("left_ring")
    else
        enable("left_ring")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("right_ring")
    else
        enable("right_ring")
    end
    if no_swap_gear:contains(player.equipment.waist) then
        disable("waist")
    else
        enable("waist")
    end
end

--function check_weaponset()
    --if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
        --equip(sets[state.WeaponSet.current].Acc)
    --else
        --equip(sets[state.WeaponSet.current])
    --end
    --if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
        --equip(sets.DefaultShield)
    --end
--end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("left_ring")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("right_ring")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.waist) then
            enable("waist")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 1)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 20 ' .. lockstyleset)
end