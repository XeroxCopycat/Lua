function character_user_job_setup()

	-- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Tank','DDTank','Normal')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
	state.PhysicalDefenseMode:options('PDT_HP','PDT','PDT_Reraise')
	state.MagicalDefenseMode:options('MDT_HP','MDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA_HP','MEVA')
	state.IdleMode:options('Tank','Kiting','PDT','Block','MDT','Normal')
	state.Weapons:options('None','SakpataAegis','SakpataOchain','NaeglingBlurred','ClubOchain')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}

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
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
	select_default_macro_book()
	update_defense_mode()
end

function init_gear_sets()
	
-------------------------------------------------------------------------------------------------------------------
-- START DEFINING THE SETS
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- PRECAST SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Enmity ###
	sets.Enmity = {}
	sets.Enmity.SIRD = {}
	sets.Enmity.DT = {}
		
-- ### Fast Cast sets for spells ###
	sets.precast.FC = {}
	sets.precast.FC.DT = {}
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, {})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

-- ### Precast sets to enhance JAs ###
	sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) 
	sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Cover'] = set_combine(sets.Enmity, {}) 
	
	sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{}) 
	sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {}) 
	
	-- add mnd for Chivalry
	sets.precast.JA['Chivalry'] = {}
		
	sets.precast.JA['Chivalry'].DT = {}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {})		
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {})		
	sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})
  
------------------------------------------------------------------------------------------------------------------- 
-- MIDCAST SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Fast recast ###
	sets.midcast.FastRecast = {}
	sets.midcast.FastRecast.DT = {}

-- ### Blue Magic ###
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})

	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})
	
-- ### Divine Magic ###
	sets.midcast['Divine Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Divine Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	
  -- Specific divine magic spells
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
	
-- ### Enhancing Magic ###
	sets.midcast['Enhancing Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Reprisal = {}
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.Enhancing_Received = {}
	sets.Phalanx_Received = {}
	sets.Self_Refresh = {}
	
-- ### Healing Magic ###
	sets.midcast['Healing Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Healing Magic'].SIRD = set_combine(sets.Enmity, {})
	
	sets.midcast.Cure = {}
	sets.midcast.Cure.SIRD = {}
	sets.midcast.Cure.DT = {}
	
	sets.Self_Healing = {}
	sets.Self_Healing.SIRD = {}
	sets.Self_Healing.DT = {}
	
	sets.Cure_Received = {}
	
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	

-------------------------------------------------------------------------------------------------------------------
-- IDLE & RESTING SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Idle sets ###
	sets.idle = {}
		
	sets.idle.PDT = {}
		
	sets.idle.Block = {}
		
	sets.idle.MDT = {}

	sets.idle.Tank = {}
		
	sets.idle.Kiting = {}

	sets.Kiting = {}

	sets.resting = {}
	
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.latent_regen = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

-------------------------------------------------------------------------------------------------------------------
-- DEFENSE SETS
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- ENGAGED SETS
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- WEAPON SETS
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- WEAPONSKILL SETS
-------------------------------------------------------------------------------------------------------------------
-- ### Default weaponskill set ###
	sets.precast.WS = {}
	sets.precast.WS.DT = {}
	sets.precast.WS.Hoxne = {}
	sets.precast.WS.Acc = {}
	sets.precast.WS.PDL = {}

  -- Sword weaponskills
	-- Atonement
	sets.precast.WS['Atonement'] = {}
	
	-- Chant du Cygne
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Chant du Cygne'].DT = set_combine(sets.precast.WS['Chant du Cygne'], sets.precast.WS.Acc, {})
	sets.precast.WS['Chant du Cygne'].Hoxne = set_combine(set_combine(sets.precast.WS['Chant du Cygne'],sets.precast.WS.Hoxne, {})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], sets.precast.WS.Acc, {})
	sets.precast.WS['Chant du Cygne'].PDL = set_combine(sets.precast.WS['Chant du Cygne'], sets.precast.WS.PDL, {})
	
	-- Flat Blade
	sets.precast.WS['Flat Blade'] = {}
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

	-- Imperator
	
	-- Knights of Round

	-- Red Lotus Blade
	
	-- Requiescat
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	-- Sanguine Blade
	sets.precast.WS['Sanguine Blade'] = {}

	-- Savage Blade
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {n})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, })
	
	-- Seraph Blade
	
	-- Swift Blade

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
-------------------------------------------------------------------------------------------------------------------
-- MISCELANEOUS SETS
-------------------------------------------------------------------------------------------------------------------

	

	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------



	--------------------------------------
	-- Defense sets
	--------------------------------------
	
	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
	sets.MP = {}
	sets.passive.AbsorbMP = }
	sets.MP_Knockback = {}
	sets.Twilight = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.SakpataAegis = {}
	sets.weapons.NaeglingBlurred = {}
	sets.weapons.SakpataOchain = {}
	sets.weapons.ClubOchain = {}
	sets.weapons.DualWeapons = {}
	
	sets.defense.Block = {}
		
	sets.defense.PDT = {}
		
	sets.defense.PDT_HP = {}
		
	sets.defense.MDT = {}
		
	sets.defense.MDT_HP = {}

	sets.defense.MEVA = {}
		
	sets.defense.MEVA_HP = {}
		
	sets.defense.PDT_Reraise = set_combine(sets.defense.PDT_HP,{})
	sets.defense.MDT_Reraise = set_combine(sets.defense.MDT_HP,{})
		
	--------------------------------------
	-- Engaged sets
	--------------------------------------
	
	sets.engaged = {}

	sets.engaged.Acc = {}

	sets.engaged.DW = {}

	sets.engaged.DW.Acc = {}

	sets.engaged.Tank = {}
		
	sets.engaged.DDTank = {}
		
	sets.engaged.Acc.DDTank = {}
		
	sets.engaged.NoShellTank = {}
		
	sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
	sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Cover = {"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'NIN' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'RUN' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'BLU' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 19)
	else
		set_macro_page(1, 19) --War/Etc
	end
end