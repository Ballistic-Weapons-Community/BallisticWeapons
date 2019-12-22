// It's the XMV-850 (and that code's too much for it tbh)
class Z250Minigun extends BallisticWeapon;

#exec OBJ LOAD FILE=BallisticWeapons2.utx

var() name		GrenadeLoadAnim;	//Anim for grenade reload
var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//

var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;

var bool bDampingFireLoop;

var Z250FireControl FireControl;

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;
}

//===========================================================================
// BlendFireHold
//
// Called when Raygun starts charging. We blend with Channel 1 to dampen the vibrations when aimed.
//===========================================================================
simulated final function BlendFireHold()
{
	bDampingFireLoop = True;
	
	switch(SightingState)
	{
		case SS_None: AnimBlendParams(1, 0); break;
		case SS_Raising: AnimBlendToAlpha(1, 0.6f, (1-SightingPhase) * SightingTime); break;
		case SS_Lowering: AnimBlendToAlpha(1, 0, SightingPhase * SightingTime); break;
		case SS_Active: AnimBlendParams(1, 0.6f);
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
		if (bDampingFireLoop)
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
	SightingState = SS_Raising;
	if (bDampingFireLoop)
		AnimBlendToAlpha(1, 0.75f, SightingPhase * SightingTime);
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
				if (bDampingFireLoop)
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
				if (bDampingFireLoop)
					AnimBlendToAlpha(1, 0.6f, (1-SightingPhase) * SightingTime);
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

// Notifies for grenade loading sounds
simulated function Notify_GrenadeOut()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_GrenadeIn()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_GrenadeShut()	{	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64); Z250SecondaryFire(FireMode[1]).bLoaded = true; FireMode[1].PreFireTime = FireMode[1].default.PreFireTime; }


simulated function bool IsGrenadeLoaded()
{
	return Z250SecondaryFire(FireMode[1]).bLoaded;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == GrenadeLoadAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
	Super.AnimEnd(Channel);
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
	{
		if (MagAmmo == 0)
		{
			FireMode[0].StopFiring();
			FireMode[0].bIsFiring = False;
		}
		return;
	}
	
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

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || Z250SecondaryFire(FireMode[1]).bLoaded)
		return;
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
	}		
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	if (seq == GrenadeLoadAnim)
		return;

	if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1)
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1/*MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1*/)
		{
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	Z250PrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	Z250PrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
}

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}
simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local string s;

	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(255,128,128);
	s = "Z250Minigun: TraceCount: "$Z250PrimaryFire(FireMode[0]).TraceCount$ ", FireRate: "$1.0/FireMode[0].FireRate$"TurnVelocity: "$Z250PrimaryFire(FireMode[0]).TurnVelocity.Pitch$", "$Z250PrimaryFire(FireMode[0]).TurnVelocity.Yaw;
	Canvas.DrawText(s);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

simulated event PostBeginPlay()
{
	super.PostbeginPlay();
	PlayAnim(IdleAnim, IdleAnimRate, 0, 1);
	FreezeAnimAt(0.0, 1);
	Z250PrimaryFire(FireMode[0]).Minigun = self;
}

simulated function PostNetBeginPlay()
{
	local Z250FireControl FC;

	super.PostNetBeginPlay();
	if (Role == ROLE_Authority && FireControl == None)
	{
		foreach DynamicActors (class'Z250FireControl', FC)
		{
			FireControl = FC;
			return;
		}
		FireControl = Spawn(class'Z250FireControl', None);
	}
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;

	SetBoneRotation('BarrelArray', BT);

	if (CurrentWeaponMode == 0)
		DesiredSpeed = 0.057;
	else DesiredSpeed = 0.2;

	super.WeaponTick(DT);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		Instigator.AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if (FireMode[0].IsFiring())
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.50*DT, 0.50*DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.50*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/21845.33333) < int(BarrelTurn/21845.33333))
		{
			BarrelTurn = int(BarrelTurn/21845.33333) * 21845.33333;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			Instigator.AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		Instigator.AmbientSound = BarrelSpinSound;
		Instigator.SoundPitch = 32 + 96 * BarrelSpeed;
	}

	if (ThirdPersonActor != None)
		Z250Attachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}
	if (!WeaponModes[NewMode].bUnavailable)
		CurrentWeaponMode = NewMode;
}

simulated function string GetHUDAmmoText(int Mode)
{
	return string(Ammo[Mode].AmmoAmount);
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy != None) )
		return 0;

	if (Instigator.bIsCrouched && B.Squad.IsDefending(B) && fRand() > 0.6)
		return 1;

	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	if (Dist < 2048)
		return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.2, Dist, 0, 2048);

	if (Dist > 4096)
		return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 4096, 2048);
		
	return Rating;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.1;	}
// End AI Stuff =====

defaultproperties
{
     GrenadeLoadAnim="GLReload"
     GrenOpenSound=Sound'BallisticSounds2.M50.M50GrenOpen'
     GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
     GrenCloseSound=Sound'BallisticSounds2.M50.M50GrenClose'
     BarrelSpinSound=Sound'BallisticSounds2.XMV-850.XMV-BarrelSpinLoop'
     BarrelStopSound=Sound'BallisticSounds2.XMV-850.XMV-BarrelStop'
     BarrelStartSound=Sound'BallisticSounds2.XMV-850.XMV-BarrelStart'
     PlayerSpeedFactor=0.800000
     PlayerJumpFactor=0.800000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBPOtherPackTex2.Z250.BigIcon_Z250'
     BigIconCoords=(X1=30,X2=470,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=8
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Primary fire spins up the barrels, delivering a hail of explosive rounds which inflict damage to the target and any nearby enemies."
     ManualLines(1)="Secondary fire launches a fuel grenade, which spreads fuel on the ground. This fuel can be ignited using the primary fire or other fire-based weapons. Enemies hit by the grenade or who walk into the fuel spilled will be ignited and receive damage, in addition to the damage inflicted by the ground fires."
     ManualLines(2)="Effective against groups of players and at area denial."
     SpecialInfo(0)=(Info="480.0;60.0;2.0;100.0;0.5;0.5;0.5")
     BringUpSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-Putaway')
     MagAmmo=50
     CockSound=(Sound=Sound'BallisticSounds2.M353.M353-Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-ClipIn')
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="100 RPM",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="350 RPM",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="400 RPM",bUnavailable=True)
     CurrentWeaponMode=1
     bNoCrosshairInScope=True
     SightOffset=(X=50.000000,Y=-10.690000,Z=45.400002)
     SightDisplayFOV=45.000000
     SightingTime=0.550000
     CrouchAimFactor=1.500000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     JumpOffSet=(Pitch=-6000,Yaw=2000)
     AimAdjustTime=0.800000
     AimSpread=256
     ChaosSpeedThreshold=1200.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.350000,OutVal=0.400000),(InVal=0.500000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.050000
     RecoilYFactor=0.150000
     RecoilMax=8192.000000
     RecoilDeclineTime=2.500000
     FireModeClass(0)=Class'BWBPOtherPackPro.Z250PrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.Z250SecondaryFire'
     SelectAnimRate=0.750000
     PutDownTime=0.800000
     BringUpTime=2.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     Description="Add me."
     DisplayFOV=45.000000
     Priority=47
     HudColor=(B=50,G=200,R=25)
     CustomCrossHairColor=(A=219)
     CustomCrossHairScale=1.008803
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     GroupOffset=2
     PickupClass=Class'BWBPOtherPackPro.Z250Pickup'
     PlayerViewOffset=(Y=15.000000,Z=-25.000000)
     AttachmentClass=Class'BWBPOtherPackPro.Z250Attachment'
     IconMaterial=Texture'BWBPOtherPackTex2.Z250.Icon_Z250'
     IconCoords=(X2=127,Y2=31)
     ItemName="Z-250 Minigun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Z250_FP'
     DrawScale=0.600000
     SoundRadius=128.000000
}
