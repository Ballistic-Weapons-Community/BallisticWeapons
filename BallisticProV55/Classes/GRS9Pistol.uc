//=============================================================================
// GRS9Pistol.
//
// Glock style low power, high capacity, low recoil, high accuracy light pistol
// with low power burning laser attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9Pistol extends BallisticHandgun;

var   bool			bLaserOn;
var   LaserActor	Laser;
var   Emitter		LaserBlast;
var   Emitter		LaserDot;
var	  byte			CurrentWeaponMode2;
var	  Actor			GlowFX;// SightFX;
var() float			LaserAmmo;
var   bool			bBigLaser;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn, LaserAmmo;
}


simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		FireModeClass[1]=Class'BallisticProV55.GRS9SecondaryFlashFire';
	}
}

/*
//simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}
simulated function bool SlaveCanUseMode(int Mode)
{
	return Mode == 0 || GRS9Pistol(OtherGun) != None;
}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0 && OtherGun != None && GRS9Pistol(Othergun) != None)
		return false;
	return super.CanAlternate(Mode);
}
*/

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);
	if (GlowFX != None)
	{
		GRS9AmbientFX(GlowFX).SetReadyIndicator (FireMode[1]!=None && !FireMode[1].IsFiring() && level.TimeSeconds - GRS9SecondaryFire(FireMode[1]).StopFireTime >= 0.8 && LaserAmmo > 0);
		if (FireMode[1]!=None && FireMode[1].IsFiring())
		{
			GRS9AmbientFX(GlowFX).SetRedIndicator (2);
			GRS9AmbientFX(GlowFX).SetFireGlow(true);
		}
		else if (FireMode[1]!=None && LaserAmmo < default.LaserAmmo)
		{
			GRS9AmbientFX(GlowFX).SetRedIndicator (1);
			GRS9AmbientFX(GlowFX).SetFireGlow(false);
		}
		else
		{
			GRS9AmbientFX(GlowFX).SetRedIndicator (0);
			GRS9AmbientFX(GlowFX).SetFireGlow(false);
		}
	}

}

simulated event Tick (float DT)
{
	super.Tick(DT);
	if (LaserAmmo < default.LaserAmmo && ( FireMode[1]==None || !FireMode[1].IsFiring() ))
		LaserAmmo = FMin(default.LaserAmmo, LaserAmmo + (DT / 6) * (1 + LaserAmmo/default.LaserAmmo) );
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (CurrentWeaponMode != CurrentWeaponMode2)
		CurrentWeaponMode2 = CurrentWeaponMode;
	if (bLaserOn != default.bLaserOn)
	{
		if (bLaserOn)
			AimComponent.AimAdjustTime *= 1.5;
		else
			AimComponent.AimAdjustTime *= 0.667;

		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn)
		return;
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	if (ThirdPersonActor != None)
		GRS9Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
		AimComponent.AimAdjustTime *= 1.5;
	else
	{
		AimComponent.AimAdjustTime *= 0.667;
		bServerReloading = false;
		bPreventReload=False;
		ReloadState = RS_None;
	}
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (!bLaserOn)
		KillLaserDot();
	PlayIdle();
	bUseNetAim = default.bUseNetAim || bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.bHidden=false;
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'IE_GRS9LaserHit',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			GRS9Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;

	if (GlowFX != None)
		GlowFX.Destroy();
	if (SightFX != None)
		SightFX.Destroy();
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;
    local bool bAimAligned;

	if ((ClientState == WS_Hidden) || (!bLaserOn))
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*3000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.1)
		bAimAligned = true;

	if (bAimAligned && Other != None)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}

	if (LaserBlast != None)
	{
		LaserBlast.SetLocation(Laser.Location);
		LaserBlast.SetRotation(Laser.Rotation);
		Canvas.DrawActor(LaserBlast, false, false, DisplayFOV);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	if (bBigLaser)
	{
		Scale3D.Y = 4;
		Scale3D.Z = 4;
	}
	else
	{
		Scale3D.Y = 1.5;
		Scale3D.Z = 1.5;
	}
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	local Vector V;
	local Rotator R;
	local Coords C;

	super.RenderOverlays(Canvas);
	if (IsInState('Lowered'))
		return;
	DrawLaserSight(Canvas);

///	if (IsInState('Lowered'))
//		return;
	if (GlowFX != None)
	{
		C = GetBoneCoords('tip2');
		V = C.Origin;

        
		//if ((IsSlave() && Othergun.Hand >= 0) || (!IsSlave() && Hand < 0))
        if (Hand < 0)
			R = OrthoRotation(C.XAxis, -C.YAxis, C.ZAxis);
		else
			R = OrthoRotation(C.XAxis, C.YAxis, C.ZAxis);
		GlowFX.SetLocation(V);
		GlowFX.SetRotation(R);
		Canvas.DrawActor(GlowFX, false, false, DisplayFOV);
	}
}

simulated function UpdateNetAim()
{
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

// Change some properties when using sights...
simulated function OnScopeViewChanged()
{
	super.OnScopeViewChanged();

	if (Hand < 0)
		SightOffset.Y = default.SightOffset.Y * -1;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_GRSNine');
	if (Instigator != None && LaserBlast == None && PlayerController(Instigator.Controller) != None)
	{
		LaserBlast = Spawn(class'GRS9LaserOnFX');
		class'DGVEmitter'.static.ScaleEmitter(LaserBlast, DrawScale);
	}
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if (GlowFX != None)
		GlowFX.Destroy();
	if (SightFX != None)
		SightFX.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	GlowFX = None;
    	SightFX = None;

		GlowFX = Spawn(class'GRS9AmbientFX');
		class'BallisticEmitter'.static.ScaleEmitter(Emitter(GlowFX), DrawScale);

		SightFX = Spawn(class'GRS9SightLEDs');
		class'BallisticEmitter'.static.ScaleEmitter(Emitter(SightFX), DrawScale);

//		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'GRS9AmbientFX', DrawScale, self, 'tip2');
//		class'BUtil'.static.InitMuzzleFlash (SightFX, class'GRS9SightLEDs', DrawScale, self, 'SightBone');
		
        
        //if ((IsSlave() && Othergun.Hand >= 0) || (!IsSlave() && Hand < 0))
        if (Hand < 0)
		{
			GRS9AmbientFX(GlowFX).InvertY();
			GRS9SightLEDs(SightFX).InvertY();
//			GRS9AmbientFX(GlowFX).InvertZ();
//			GRS9SightLEDs(SightFX).InvertZ();
		}
	}
}

simulated event Timer()
{
	if (bBigLaser)
	{
		FireMode[1].StopFiring();
		bBigLaser=false;
		if (ThirdPersonActor != None)
			GRS9Attachment(ThirdPersonActor).bBigLaser=false;
	}
	if (Clientstate == WS_PutDown)
	{
		class'BUtil'.static.KillEmitterEffect (GlowFX);
		class'BUtil'.static.KillEmitterEffect (SightFX);
	}
	super.Timer();
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');
}

function ServerWeaponSpecial(optional byte i)
{
	if (!FireMode[1].IsFiring() && level.TimeSeconds - GRS9SecondaryFire(FireMode[1]).StopFireTime >= 0.8 && LaserAmmo == default.LaserAmmo && !class'BallisticReplicationInfo'.static.IsRealism() /* && !IsInState('DualAction') && !IsInState('PendingDualAction')*/)
	{
		ClientWeaponSpecial(i);
		CommonWeaponSpecial(i);
	}
    /*
    else if (IsMaster() && GRS9Pistol(OtherGun)!=None)
	 	OtherGun.ServerWeaponSpecial(i);
    */
}

simulated function ClientWeaponSpecial(optional byte i)
{
	if (level.NetMode == NM_Client)
		CommonWeaponSpecial(i);
}

simulated function CommonWeaponSpecial(optional byte i)
{
	bBigLaser=true;
	if (ThirdPersonActor != None)
		GRS9Attachment(ThirdPersonActor).bBigLaser=true;

    // Set instant fire props
	BallisticInstantFire(FireMode[1]).Damage = 75;
	BallisticInstantFire(FireMode[1]).HeadMult = 1f;
	BallisticInstantFire(FireMode[1]).LimbMult = 1f;
	BallisticInstantFire(FireMode[1]).XInaccuracy = 16;
	BallisticInstantFire(FireMode[1]).YInaccuracy = 16;


	FireMode[1].ModeDoFire();
	LaserAmmo = FMax(0, LaserAmmo - default.LaserAmmo);

    // Reset props
	BallisticInstantFire(FireMode[1]).Damage = BallisticInstantFire(FireMode[1]).default.Damage;
	BallisticInstantFire(FireMode[1]).HeadMult = BallisticInstantFire(FireMode[1]).default.HeadMult;
	BallisticInstantFire(FireMode[1]).LimbMult = BallisticInstantFire(FireMode[1]).default.LimbMult;
	BallisticInstantFire(FireMode[1]).XInaccuracy = 2;
	BallisticInstantFire(FireMode[1]).YInaccuracy = 2;

	if (ClientState != WS_PutDown && ClientState != WS_BringUp)
		SetTimer(0.15, false);
}


simulated function float ChargeBar()
{
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		if (level.TimeSeconds >= FireMode[1].NextFireTime)
		{
			if (FireMode[1].bIsFiring)
				return FMin(1, FireMode[1].HoldTime / FireMode[1].MaxHoldTime);
			return FMin(1, AM67SecondaryFire(FireMode[1]).DecayCharge / FireMode[1].MaxHoldTime);
		}
		return (FireMode[1].NextFireTime - level.TimeSeconds) / FireMode[1].FireRate;
	}
	else
	{
		return FClamp(LaserAmmo/default.LaserAmmo, 0, 1);
	}
}

// Rechargable laser unit means it always has ammo!
simulated function bool HasAmmo()
{
	return true;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (LaserAmmo < 0.3 || level.TimeSeconds - GRS9SecondaryFire(FireMode[1]).StopFireTime < 0.8)
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	if (Dist > 3000)
		return 0;
	Result = FRand()*0.2 + FMin(1.0, LaserAmmo / (default.LaserAmmo/2));
	if (Dist < 500)
		Result += 0.5;
	else if (Dist > 1500)
		Result -= 0.3;
	if (Result > 0.5)
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =====

defaultproperties
{
	AIRating=0.6
	CurrentRating=0.6
	LaserAmmo=3.500000
	bShouldDualInLoadout=True
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Glock.BigIcon_Glock'
	BigIconCoords=(Y1=30,Y2=230)
	SightFXBone="SightBone"
	
	ManualLines(0)="Automatic fire. Short ranged, but has higher DPS than most pistols. Recoil is moderate."
	ManualLines(1)="Projects a laser beam. Has extremely low DPS, but consistent damage over range and recharges over time."
	ManualLines(2)="The Weapon Function key causes a hitscan single-shot beam to be projected from the unit, dealing good damage. The GRS-9 is effective at close range."
	SpecialInfo(0)=(Info="120.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	CockAnimRate=1.200000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Cock',Volume=0.600000)
	ReloadAnimRate=1.350000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipHit',Volume=0.700000)
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(bUnavailable=True)
	bNoCrosshairInScope=True
	SightOffset=(X=-15.000000,Z=5.900000)
	SightDisplayFOV=60.000000
	ParamsClasses(0)=Class'GRS9WeaponParamsComp'
	ParamsClasses(1)=Class'GRS9WeaponParamsClassic' //todo: auto to semi
	ParamsClasses(2)=Class'GRS9WeaponParamsRealistic' //todo: auto to semi
    ParamsClasses(3)=Class'GRS9WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.GRS9PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.GRS9SecondaryFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806InA',USize2=256,VSize2=256,Color1=(R=96,A=175),Color2=(B=255),StartSize1=100,StartSize2=110)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)
	
	SelectAnimRate=1.250000
	PutDownAnimRate=1.250000
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=True
	Description="The GRS9 from Drake & Co. is used primarily by inner core planets for law enforcement purposes. The additional laser unit adds an alternative attack to the GRS9. The laser unit can be held down, for up to 3.5 seconds, releasing a searing beam upon enemies. This drains the rechargeable battery however, which must be left to replenish when empty."
	Priority=9
	HudColor=(B=25,G=25,R=200)
	InventoryGroup=3
	GroupOffset=3
	PickupClass=Class'BallisticProV55.GRS9Pickup'
	PlayerViewOffset=(X=10.000000,Y=3.000000,Z=-9.000000)
	AttachmentClass=Class'BallisticProV55.GRS9Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Glock.SmallIcon_Glock'
	IconCoords=(X2=127,Y2=31)
	ItemName="GRS-9 Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_GRS9'
	DrawScale=0.150000
	bFullVolume=True
	SoundRadius=128.000000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BW_Core_WeaponTex.Glock.Glock_Shiny'
}
