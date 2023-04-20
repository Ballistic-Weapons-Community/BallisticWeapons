class Raygun extends BallisticWeapon;

var Actor GlowFX;
var bool	bShieldOn;
var sound ShieldOnSound, ShieldOffSound;

var TexScaler TensTex, UnitsTex;
var int LastMagAmmo;

var bool bLockSecondary;

var config bool bReceiveDebug;

replication
{
	reliable if (Role == ROLE_Authority)
		bShieldOn, bLockSecondary;
	reliable if (Role < ROLE_Authority)
		DisableShield;
}

//===========================================================================
// BlendFireHold
//
// Called when Raygun starts charging. We blend with Channel 1 to dampen the vibrations when aimed.
//===========================================================================
simulated final function BlendFireHold()
{
	switch(SightingState)
	{
		case SS_None: AnimBlendParams(1, 0); break;
		case SS_Raising: AnimBlendToAlpha(1, 0.95f, (1-SightingPhase) * SightingTime); break;
		case SS_Lowering: AnimBlendToAlpha(1, 0, SightingPhase * SightingTime); break;
		case SS_Active: AnimBlendParams(1, 0.95f); break;
	}
}

//===========================================================================
// PlayScopeDown
//
// Release damping for Channel 1.
//===========================================================================
simulated function PlayScopeDown(optional bool bNoAnim)
{
	if (!bNoAnim && HasAnim(ZoomOutAnim))
	    SafePlayAnim(ZoomOutAnim, 1.0);
	else if (SightingState == SS_Active || SightingState == SS_Raising)
	{
		SightingState = SS_Lowering;
		if (FireMode[1].HoldTime > 0)
			AnimBlendToAlpha(1, 0, SightingPhase * SightingTime);
	}
	Instigator.Controller.bRun = 0;
}

//===========================================================================
// PlayScopeUp
//
// Dampen Channel 0, by playing a blended Idle on Channel 1, if the raygun's holding fire.
//===========================================================================
simulated function PlayScopeUp()
{
	if (HasAnim(ZoomInAnim))
	    SafePlayAnim(ZoomInAnim, 1.0);
	else
	{
		SightingState = SS_Raising;
		if (FireMode[1].HoldTime > 0)
			AnimBlendToAlpha(1, 0.95f, SightingPhase * SightingTime);
	}
	if(ZoomType == ZT_Irons)
		PlayerController(Instigator.Controller).bZooming = True;

	Instigator.Controller.bRun = 1;
}

//===========================================================================
// TickSighting
//
// Dampen Channel 0, by playing a blended Idle on Channel 1, if the raygun's holding fire.
//===========================================================================
simulated function TickSighting (float DT)
{
	if (SightingState == SS_None || SightingState == SS_Active)
		return;

	if (SightingState == SS_Raising)
	{	// Raising gun to sight position
		if (SightingPhase < 1.0)
		{
			if ((bScopeDesired || bPendingSightUp) && CanUseSights())
				SightingPhase += DT/SightingTime;
			else
			{
				SightingState = SS_Lowering;
				if (FireMode[1].HoldTime > 0)
					AnimBlendToAlpha(1, 0, SightingPhase * SightingTime);
				Instigator.Controller.bRun = 0;
			}
		}
		else
		{	// Got all the way up. Now go to scope/sight view
			SightingPhase = 1.0;
			SightingState = SS_Active;
			ScopeUpAnimEnd();
		}
	}
	else if (SightingState == SS_Lowering)
	{	// Lowering gun from sight pos
		if (SightingPhase > 0.0)
		{
			if (bScopeDesired && CanUseSights())
			{
				SightingState = SS_Raising;
				if (FireMode[1].HoldTime > 0)
					AnimBlendToAlpha(1, 0.75f, (1-SightingPhase) * SightingTime);
			}
			else
				SightingPhase -= DT/SightingTime;
		}
		else
		{	// Got all the way down. Tell the system our anim has ended...
			SightingPhase = 0.0;
			SightingState = SS_None;
			ScopeDownAnimEnd();
			DisplayFOV = BaseDisplayFOV;
		}
	}
}

//===========================================================================
// BringUp
//
// Reset Pri-block
//===========================================================================
simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp();
	if (Role == ROLE_Authority)
		bLockSecondary=False;
}

simulated function PlayIdle()
{
	if (MeleeState == MS_Pending)
	{
		MeleeState = MS_Held;
		MeleeFireMode.PlayPreFire();
		if (SprintControl != None && SprintControl.bSprinting)
			PlayerSprint(false);
		ServerMeleeHold();
		return;
	}
	
	
	if (IsFiring())
		return;
	
	if (SightingState != SS_None)
	{
		if (SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	
	else if (bScopeView)
	{
		if(HasAnim(ZoomOutAnim) && SafePlayAnim(ZoomOutAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	
	else
	    SafeLoopAnim(IdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Role == ROLE_Authority && Channel == 0 && bLockSecondary)
		bLockSecondary=False;
	
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		if (Role == ROLE_Authority)
			bLockSecondary=False;
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (MeleeState < MS_Held)
			bPreventReload=false;
		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			AimComponent.ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		AimComponent.ReAim(0.05);
	}
	
	if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	PlayAnim(IdleAnim, IdleAnimRate, 0, 1);
	FreezeAnimAt(0.0, 1);
	
	TensTex = TexScaler(Skins[3]);
	UnitsTex = TexScaler(Skins[2]);
}

simulated function WeaponTick(float DeltaTime)
{
	Super.WeaponTick(DeltaTime);
	
	if (LastMagAmmo != MagAmmo && Instigator.IsLocallyControlled() && Instigator.IsHumanControlled())
		OffsetNumbers();
}

simulated function OffsetNumbers()
{
	local int Tens;
	local int Units;
	
	if (TensTex == None)
		return;
	
	Tens = MagAmmo / 10;
	Units = MagAmmo - Tens * 10;
	
	if (bool(Tens & 1)) //odd
		TensTex.UOffset = 64;
	else 
		TensTex.UOffset = 0;
	TensTex.VOffset = Tens/2 * 102;
	
	if (bool(Units & 1)) //odd
		UnitsTex.UOffset = 64;
	else 
		UnitsTex.UOffset = 0;
	UnitsTex.VOffset = Units/2 * 102;
	
	LastMagAmmo = MagAmmo;
}

simulated function float ChargeBar()
{
	if (FireMode[1].bIsFiring)
		return FMin(1, FireMode[1].HoldTime / RaygunSecondaryFire(FireMode[1]).ChargeTime);
	return FMin(1, RaygunSecondaryFire(FireMode[1]).DecayCharge / RaygunSecondaryFire(FireMode[1]).ChargeTime);
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
		class'BUtil'.static.KillEmitterEffect (GlowFX);
	super.Timer();
}

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}

function float GetAIRating()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		if (RecommendHeal(B))
			return 1.2;
	}

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Super.GetAIRating(), 0.5, Dist, 1024, 2048); 
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (bPreventReload || bServerReloading)
		return;
	ServerWeaponSpecial(i);
	ReloadState = RS_GearSwitch;
	PlayAnim('SwitchPress');
}

function ServerWeaponSpecial(optional byte i)
{
	if (bPreventReload || bServerReloading)
		return;
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	PlayAnim('SwitchPress');
}

function Notify_ButtonPress()
{
	if (!bShieldOn)
	{
		bShieldOn = True;
		PlaySound(ShieldOnSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
		if (Instigator.PlayerReplicationInfo != None)
		{
			if (Instigator.PlayerReplicationInfo.Team == None || Instigator.PlayerReplicationInfo.Team.TeamIndex == 1)
			{
				xPawn(Instigator).SetOverlayMaterial( Material'BWBP_OP_Tex.General.BlueExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBP_OP_Tex.General.BlueExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBP_OP_Tex.General.BlueExplosiveShieldMat', 300, true );
			}
			else
			{
				xPawn(Instigator).SetOverlayMaterial( Material'BWBP_OP_Tex.General.RedExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBP_OP_Tex.General.RedExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBP_OP_Tex.General.RedExplosiveShieldMat', 300, true );
			}
		}
	}
	else
	{
		bShieldOn = False;
		PlaySound(ShieldOffSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
		xPawn(Instigator).SetOverlayMaterial ( None, 0, true );
		ThirdPersonActor.SetOverlayMaterial ( None, 0, true );
		SetOverlayMaterial ( None, 0, true );
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		DisableShield();
		return true;
	}
	return false;
}

function DisableShield()
{
	bShieldOn = False;
	PlaySound(ShieldOffSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	SetOverlayMaterial ( None, 0, true );
	xPawn(Instigator).SetOverlayMaterial ( None, 0, true );
}

// Aim goes bad when player takes damage
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (bShieldOn && !DamageType.default.bLocationalHit)
	{
		Damage *= 0.25;
		Momentum *= 0.25;
		return;
	}
	
	Super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	if (Dist > 3000)
		return 1;
		
	return 0;
}


function bool FocusOnLeader(bool bLeaderFiring)
{
	local Bot B;
	local Pawn LeaderPawn;
	local Actor Other;
	local vector HitLocation, HitNormal, StartTrace;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return false;
	if ( PlayerController(B.Squad.SquadLeader) != None )
		LeaderPawn = B.Squad.SquadLeader.Pawn;
	else
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( V != None )
		{
			LeaderPawn = V;
			bLeaderFiring = (LeaderPawn.Health < LeaderPawn.HealthMax) && (V.LinkHealMult > 0)
							&& ((B.Enemy == None) || V.bKeyVehicle);
		}
	}
	if ( LeaderPawn == None )
	{
		LeaderPawn = B.Squad.SquadLeader.Pawn;
		if ( LeaderPawn == None )
			return false;
	}
	if (!bLeaderFiring)
		return false;
	if ( (Vehicle(LeaderPawn) != None) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		if ( VSize(LeaderPawn.Location - StartTrace) < FireMode[0].MaxRange() )
		{
			Other = Trace(HitLocation, HitNormal, LeaderPawn.Location, StartTrace, true);
			if ( Other == LeaderPawn )
			{
				B.Focus = Other;
				return true;
			}
		}
	}
	return false;
}

simulated function PassDelay(float Delay)
{
	FireMode[0].NextFireTime = Level.TimeSeconds + Delay;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.7;	}
// End AI Stuff =====

defaultproperties
{
	ShieldOnSound=Sound'BWBP_OP_Sounds.Raygun.ShieldOn'
	ShieldOffSound=Sound'BWBP_OP_Sounds.Raygun.ShieldOff'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
	BigIconMaterial=Texture'BWBP_OP_Tex.Raygun.raygun_icon_512'
	BigIconCoords=(Y1=32,Y2=220)
	
	bWT_Energy=True
	SpecialInfo(0)=(Info="240.0;20.0;0.9;80.0;0.0;0.4;0.1")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Putaway')
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipIn')
	ClipInFrame=0.700000
	bNonCocking=True
	WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	ManualLines(0)="Launches a stream of projectiles. These projectiles do not gain damage over range."
	ManualLines(1)="Charged ray attack. Targets hit by this attack will receive damage and become irradiated. Irradiation causes damage over time and can be spread through the enemy's team by proximity to the irradiated enemy. The duration of irradiation against a target is extended when hit by the primary fire."
	ManualLines(2)="The Raygun also possesses a shield, activated by the Weapon Function key. When active, this shield reduces damage from any source which is not locational, such as flames and explosions, by 75%, but makes the user highly visible. Effective at close range, against groups of clustered players and against explosives."
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightPivot=(Pitch=450)
	SightOffset=(X=-8,Y=0,Z=0.8)
	SightZoomFactor=1.2
	ParamsClasses(0)=Class'RaygunWeaponParamsComp'
	ParamsClasses(1)=Class'RaygunWeaponParamsClassic'
	ParamsClasses(2)=Class'RaygunWeaponParamsRealistic'
    ParamsClasses(3)=Class'RaygunWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_OP_Pro.RaygunPrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.RaygunSecondaryFire'
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.A73InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=86,R=0),Color2=(G=140),StartSize1=65,StartSize2=61)
    NDCrosshairInfo=(SpreadRatios=(Y2=0.500000))
	AIRating=0.750000
	CurrentRating=0.750000
	bShowChargingBar=True
	Description="E38 Indivisible Particle Smasher||Manufacturer: United States Defense Department, 20th 'The truth is out there, I know it.  I've seen those skrith bastards up close back in '59 in Roswell, they're the ones who landed in Roswell in Area 51, with their creepy two headed dogs and all.  They tried to take over the base using their plasma peashooters, only it looked more like what you see in those B-movies.  Those bastards, they shot up the place, melting all the soldiers into piles of goo. I swear to you, I'm not making this up, they even activated some weird shield doohicky that made them immune to the bazookas and other explosives. You gotta believe me, please.  I can prove it to you, I just need you guys to take me to Area 51, where the original model is still being held at, sealed away in a vault!  Wait, why are you looking at me like that?  Why are you putting cuffs on me!?  HEY-'  The last known words of James Kilroy Sr.  Before he was sent to the FBI for interrogation."
	Priority=39
	HudColor=(B=50,G=175)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=5
	GroupOffset=1
	PickupClass=Class'BWBP_OP_Pro.RaygunPickup'

	PlayerViewOffset=(X=16,Y=1.6,Z=-3)
	SightBobScale=0.25
	
	AttachmentClass=Class'BWBP_OP_Pro.RaygunAttachment'
	IconMaterial=Texture'BWBP_OP_Tex.Raygun.raygun_icon_128'
	IconCoords=(X2=127,Y2=31)
	ItemName="E58 Raygun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Raygun'
	DrawScale=0.3
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BWBP_OP_Tex.Raygun.raygun_body_SH1'
	Skins(2)=TexScaler'BWBP_OP_Tex.Raygun.RaygunNumbersScaler'
	Skins(3)=TexScaler'BWBP_OP_Tex.Raygun.RaygunNumbersScaler2'
	SoundPitch=56
	SoundRadius=32.000000
}
