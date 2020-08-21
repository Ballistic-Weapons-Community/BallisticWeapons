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
			if ((bScopeHeld || bPendingSightUp) && CanUseSights())
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
			if (bScopeHeld && CanUseSights())
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
			bScopeHeld=False;
			ScopeDownAnimEnd();
			DisplayFOV = default.DisplayFOV;
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
			ReAim(0.05);
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
		ReAim(0.05);
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
	
	TensTex = TexScaler(Skins[2]);
	UnitsTex = TexScaler(Skins[1]);
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
				xPawn(Instigator).SetOverlayMaterial( Material'BWBPOtherPackTex.General.BlueExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBPOtherPackTex.General.BlueExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBPOtherPackTex.General.BlueExplosiveShieldMat', 300, true );
			}
			else
			{
				xPawn(Instigator).SetOverlayMaterial( Material'BWBPOtherPackTex.General.RedExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBPOtherPackTex.General.RedExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBPOtherPackTex.General.RedExplosiveShieldMat', 300, true );
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
     ShieldOnSound=Sound'BWBPOtherPackSound.Raygun.ShieldOn'
     ShieldOffSound=Sound'BWBPOtherPackSound.Raygun.ShieldOff'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=6)
     BigIconMaterial=Texture'BWBPOtherPackTex.Raygun.raygun_icon_512'
     BigIconCoords=(Y1=32,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Energy=True
     SpecialInfo(0)=(Info="240.0;20.0;0.9;80.0;0.0;0.4;0.1")
     BringUpSound=(Sound=Sound'BallisticSounds2.A73.A73Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A73.A73Putaway')
     MagAmmo=24
     ClipHitSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipIn')
     ClipInFrame=0.700000
     bNonCocking=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
	 ManualLines(0)="Launches a stream of projectiles. These projectiles do not gain damage over range."
     ManualLines(1)="Charged ray attack. Targets hit by this attack will receive damage and become irradiated. Irradiation causes damage over time and can be spread through the enemy's team by proximity to the irradiated enemy. The duration of irradiation against a target is extended when hit by the primary fire."
     ManualLines(2)="The Raygun also possesses a shield, activated by the Weapon Function key. When active, this shield reduces damage from any source which is not locational, such as flames and explosions, by 75%, but makes the user highly visible. Effective at close range, against groups of clustered players and against explosives."
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     bNoCrosshairInScope=True
     SightPivot=(Pitch=450)
     SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
     SightDisplayFOV=25.000000
     SightingTime=0.250000
     SightAimFactor=1
	 SightZoomFactor=0.85
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=0.600000
     ChaosDeclineTime=1.250000
	 
	 ViewRecoilFactor=0.35
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.140000),(InVal=0.600000,OutVal=0.120000),(InVal=0.700000,OutVal=0.120000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.150000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=0.320000),(InVal=0.450000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.050000
     RecoilYFactor=0.050000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.230000
	 
	 
     FireModeClass(0)=Class'BWBPOtherPackPro.RaygunPrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.RaygunSecondaryFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     bShowChargingBar=True
     Description="E38 Indivisible Particle Smasher||Manufacturer: United States Defense Department, 20th Century||Commissioned towards the end of the 20th century, the E38 "
     Priority=39
     HudColor=(B=50,G=175)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=1
     PickupClass=Class'BWBPOtherPackPro.RaygunPickup'
     PlayerViewOffset=(X=5.000000,Z=-5.000000)
     AttachmentClass=Class'BWBPOtherPackPro.RaygunAttachment'
     IconMaterial=Texture'BWBPOtherPackTex.Raygun.raygun_icon_128'
     IconCoords=(X2=127,Y2=31)
     ItemName="E58 Raygun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Raygun_FP'
     DrawScale=0.187500
     Skins(0)=Shader'BWBPOtherPackTex.Raygun.raygun_body_SH1'
	 Skins(1)=TexScaler'BWBPOtherPackTex.Raygun.RaygunNumbersScaler'
	 Skins(2)=TexScaler'BWBPOtherPackTex.Raygun.RaygunNumbersScaler2'
     SoundPitch=56
     SoundRadius=32.000000
}
