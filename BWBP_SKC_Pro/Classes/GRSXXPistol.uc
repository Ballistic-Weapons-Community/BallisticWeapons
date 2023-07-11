//=============================================================================
// GRSXXPistol.
//
// Glock style low power, high capacity, low recoil, high accuracy light pistol
// with low power burning laser attachment.
//
// Realism GRSXX loses the laser and requires the amp to be installed.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRSXXPistol extends BallisticHandgun;

// Laser Vars
var(GRSXX)	bool		bLaserOn;
var(GRSXX)	LaserActor	Laser;
var(GRSXX)	Emitter		LaserBlast;
var(GRSXX)	Emitter		LaserDot;
var(GRSXX)	byte		CurrentWeaponMode2;
var(GRSXX)	Actor		GlowFX;// SightFX;
var(GRSXX)	float		LaserAmmo;
var(GRSXX)	bool		bBigLaser;

// Amp Vars
var(GRSXX)  bool		bAmped;						// ARE YOU AMPED? BECAUSE THIS GUN IS!
var(GRSXX)	name		AmplifierBone;				// Bone to use for hiding cool shit
var(GRSXX)	name		AmplifierOnAnim;			//
var(GRSXX)	name		AmplifierOffAnim;			//
var(GRSXX)	sound		AmplifierOnSound;			// 
var(GRSXX)	sound		AmplifierOffSound;			//
var(GRSXX)	sound		AmplifierPowerOnSound;		// Electrical noises?
var(GRSXX)	sound		AmplifierPowerOffSound;		//
var(GRSXX)	float		AmpCharge;					// Existing ampjuice
var(GRSXX)  float 		DrainRate;					// Rate that ampjuice leaks out
var(GRSXX)	bool		bShowCharge;				// Hides charge until the amp is on
var(GRSXX)	bool		bRemovableAmp;

var() array<Material> AmpMaterials; //We're using this for the amp

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchAmplifier;
	reliable if (Role == ROLE_Authority)
		bLaserOn, LaserAmmo, bRemovableAmp, ClientSetHeat;
}

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		FireModeClass[1]=Class'BWBP_SKC_Pro.GRSXXSecondaryAmpFire';
		BringUpSound.Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout';
	}
}
simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		bAmped=False;
		GRSXXPrimaryFire(FireMode[0]).bAmped = False;
		bRemovableAmp=True;
		GRSXXPrimaryFire(FireMode[0]).bRemovableAmp = True;
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
	
	if (AmpCharge > 0)
		AddHeat(-DrainRate * DT);
	
	if (GlowFX != None)
	{
		GRSXXAmbientFX(GlowFX).SetReadyIndicator (FireMode[1]!=None && !FireMode[1].IsFiring() && level.TimeSeconds - GRSXXSecondaryFire(FireMode[1]).StopFireTime >= 0.8 && LaserAmmo > 0);
		if (FireMode[1]!=None && FireMode[1].IsFiring())
		{
			GRSXXAmbientFX(GlowFX).SetRedIndicator (2);
			GRSXXAmbientFX(GlowFX).SetFireGlow(true);
		}
		else if (FireMode[1]!=None && LaserAmmo < default.LaserAmmo)
		{
			GRSXXAmbientFX(GlowFX).SetRedIndicator (1);
			GRSXXAmbientFX(GlowFX).SetFireGlow(false);
		}
		else
		{
			GRSXXAmbientFX(GlowFX).SetRedIndicator (0);
			GRSXXAmbientFX(GlowFX).SetFireGlow(false);
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

	if (ThirdPersonActor != None)
		GRSXXAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
		LaserDot = Spawn(class'IE_GRSXXLaserHit',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			GRSXXAttachment(ThirdPersonActor).bLaserOn = false;
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
		Scale3D.Y = 7;
		Scale3D.Z = 7;
	}
	else
	{
		Scale3D.Y = 3.5;
		Scale3D.Z = 3.5;
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
		Laser = Spawn(class'LaserActor_GRSXX');
	if (Instigator != None && LaserBlast == None && PlayerController(Instigator.Controller) != None)
	{
		LaserBlast = Spawn(class'GRSXXLaserOnFX');
		class'DGVEmitter'.static.ScaleEmitter(LaserBlast, DrawScale);
	}
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		AmplifierOnAnim = 'AMPApplyOpen';
		AmplifierOffAnim = 'AMPRemoveOpen';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		AmplifierOnAnim = 'AMPApply';
		AmplifierOffAnim = 'AMPRemove';
	}

	if (GlowFX != None)
		GlowFX.Destroy();
	if (SightFX != None)
		SightFX.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	GlowFX = None;
    	SightFX = None;

		GlowFX = Spawn(class'GRSXXAmbientFX');
		class'BallisticEmitter'.static.ScaleEmitter(Emitter(GlowFX), DrawScale);

		SightFX = Spawn(class'GRSXXSightLEDs');
		class'BallisticEmitter'.static.ScaleEmitter(Emitter(SightFX), DrawScale);

//		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'GRSXXAmbientFX', DrawScale, self, 'tip2');
//		class'BUtil'.static.InitMuzzleFlash (SightFX, class'GRSXXSightLEDs', DrawScale, self, 'SightBone');
		
        
        //if ((IsSlave() && Othergun.Hand >= 0) || (!IsSlave() && Hand < 0))
        if (Hand < 0)
		{
			GRSXXAmbientFX(GlowFX).InvertY();
			GRSXXSightLEDs(SightFX).InvertY();
//			GRSXXAmbientFX(GlowFX).InvertZ();
//			GRSXXSightLEDs(SightFX).InvertZ();
		}
	}
	
	if (bAmped)
	{
		SetBoneScale (0, 1.0, AmplifierBone);
	}		
	else
	{
		SetBoneScale (0, 0.0, AmplifierBone);
	}
	
}

simulated event Timer()
{
	if (bBigLaser)
	{
		FireMode[1].StopFiring();
		bBigLaser=false;
		if (ThirdPersonActor != None)
			GRSXXAttachment(ThirdPersonActor).bBigLaser=false;
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
			AmplifierOnAnim = 'AMPApplyOpen';
			AmplifierOffAnim = 'AMPRemoveOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			AmplifierOnAnim = 'AMPApply';
			AmplifierOffAnim = 'AMPRemove';
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
	if (!FireMode[1].IsFiring() && level.TimeSeconds - GRSXXSecondaryFire(FireMode[1]).StopFireTime >= 0.8 && LaserAmmo == default.LaserAmmo/* && !IsInState('DualAction') && !IsInState('PendingDualAction')*/)
	{
		ClientWeaponSpecial(i);
		CommonWeaponSpecial(i);
	}
    /*
    else if (IsMaster() && GRSXXPistol(OtherGun)!=None)
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
		GRSXXAttachment(ThirdPersonActor).bBigLaser=true;

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
	if (!bRemovableAmp)
		return FClamp(LaserAmmo/default.LaserAmmo, 0, 1);
	else if (!bShowCharge)
		return 0;
	else
		return AmpCharge / 10;
}

//==============================================
// Amp Code
//==============================================

//mount or unmount amp
exec simulated function ToggleAmplifier(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;

	TemporaryScopeDown(0.5);

	bAmped = !bAmped;
	ServerSwitchAmplifier(bAmped);
	SwitchAmplifier(bAmped);
}

function ServerSwitchAmplifier(bool bNewValue)
{
	bAmped = bNewValue;
	
	SwitchAmplifier(bAmped);
	
	bServerReloading=True;
	ReloadState = RS_GearSwitch;

	if (bAmped)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		WeaponModes[3].bUnavailable=false;
		CurrentWeaponMode=3;
		ServerSwitchWeaponMode(3);
		AmpCharge=10;
		Skins[4]=AmpMaterials[0];
		Skins[5]=AmpMaterials[1];
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=true;
		CurrentWeaponMode=2;
		ServerSwitchWeaponMode(2);
		AmpCharge=0;
	}
}

simulated function SwitchAmplifier(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
		
	ReloadState = RS_GearSwitch;

	if (bNewValue)
	{
		PlayAnim(AmplifierOnAnim);
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		WeaponModes[3].bUnavailable=false;
		AmpCharge=10;
		Skins[4]=AmpMaterials[0];
		Skins[5]=AmpMaterials[1];
	}
	else
	{
		PlayAnim(AmplifierOffAnim);
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=true;
		AmpCharge=0;
	}
		
	//if (Role == ROLE_Authority)
	//	GRSXXAttachment(ThirdPersonActor).SetAmped(bNewValue);
}

function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		GRSXXPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
}
simulated function CommonSwitchWeaponMode (byte newMode)
{
	super.CommonSwitchWeaponMode(newMode);
	GRSXXPrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
}

simulated function Notify_AmplifierOn()	{		PlaySound(AmplifierOnSound,,0.5); }
simulated function Notify_AmplifierOff()	{	PlaySound(AmplifierOffSound,,0.5);	bShowCharge=false;}
simulated function Notify_AmplifierCharged()	{		PlaySound(AmplifierPowerOnSound,,1.6);	bShowCharge=true;}

simulated function Notify_AmplifierShow()
{	
	SetBoneScale (0, 1.0, AmplifierBone);	
}
simulated function Notify_AmplifierHide()
{	
	SetBoneScale (0, 0.0, AmplifierBone);	
}

simulated function AddHeat(float Amount)
{
	if (bBerserk)
		Amount *= 0.75;
		
	AmpCharge = FMax(0, AmpCharge + Amount);
	
	if (AmpCharge <= 0)
	{
		PlaySound(AmplifierPowerOffSound,,2.0,,32);
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=true;
		CurrentWeaponMode=2;
		ServerSwitchWeaponMode(2);
		Skins[4]=AmpMaterials[2];
		Skins[5]=AmpMaterials[3];
		//if (Role == ROLE_Authority)
		//	SX45Attachment(ThirdPersonActor).SetAmped(false);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	AmpCharge = NewHeat;
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

	if (LaserAmmo < 0.3 || level.TimeSeconds - GRSXXSecondaryFire(FireMode[1]).StopFireTime < 0.8)
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
	bAmped=True
	Skins[0]=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	AmpMaterials[0]=Shader'BWBP_SKC_Tex.Glock_Gold.GRSXX-AmpShine'
	AmpMaterials[1]=Shader'BWBP_SKC_Tex.Glock_Gold.GRSXX-AmpGlowShader'
	AmpMaterials[2]=Shader'BWBP_SKC_Tex.Glock_Gold.Amp-GoldDepleted-Shine'
	AmpMaterials[3]=Texture'ONSstructureTextures.CoreGroup.Invisible'
    AmplifierBone="AMP"
    AmplifierOnAnim="AMPApply"
    AmplifierOffAnim="AMPRemove"
    AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
    AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
    AmplifierPowerOnSound=Sound'BWBP_SKC_Sounds.GRSXX.GRSXX-Select'
    AmplifierPowerOffSound=Sound'BW_Core_WeaponSound.AMP.Amp-Depleted'
	DrainRate=0.1
	AIRating=0.6
	CurrentRating=0.6
	LaserAmmo=3.500000
	//bShouldDualInLoadout=False
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.Glock_Gold.BigIcon_GoldGlock'
	BigIconCoords=(Y1=30,Y2=230)
	SightFXBone="SightBone"
	ManualLines(0)="Automatic amplified fire. Short ranged, but has extremely high DPS. Recoil is moderate."
	ManualLines(1)="Projects a lethal laser beam. Does major damage and recharges over time."
	ManualLines(2)="The Weapon Function key causes a hitscan single-shot beam to be projected from the unit, dealing high damage. The GRS-XX is effective at close/mid range."
    SpecialInfo(0)=(Info="1200.0;65.0;4.0;150.0;2.0;2.0;1.0")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Glod.GRSXX-Select')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	CockSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Cock',Volume=0.600000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipHit',Volume=0.700000)
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Burst",ModeID="WM_Burst",Value=3.000000)
	WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
	WeaponModes(3)=(ModeName="Amplified: Hypermode",ModeID="WM_FullAuto",bUnavailable=True)
	bNoCrosshairInScope=True
	ParamsClasses(0)=Class'GRSXXPistolWeaponParamsArena'
	ParamsClasses(1)=Class'GRSXXWeaponParamsClassic'
	ParamsClasses(2)=Class'GRSXXWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SKC_Pro.GRSXXPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.GRSXXSecondaryFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806InA',USize2=256,VSize2=256,Color1=(B=12,G=108,R=157,A=163),Color2=(B=255),StartSize1=79,StartSize2=124)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)
	SelectAnimRate=1.250000
	PutDownAnimRate=1.250000
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=True
	Description="GRSXX Pistol||Manufacturer: Drake & Co Firearms|Primary: Accelerated 9mm Rounds|Secondary: Focused Beam Matrix|| The Golden GRSXX is a truly rare sight. With only thirty-two ever produced, prices range in the tens of millions. A much improved version of the GRS9, the GRSXX boasts an enhanced UTC Mk6 Power Coil and a Model 8 magnetic accelerator in the lining of the barrel. The power coil boosts the laser's power output while substantially decreasing battery drainage. At the cost of battery damage, the laser matrix generator can also fire a compact energy burst by overloading and detonating the Mk6 coils. [Barrel is made of 24-Karat gold with an underlying platinum-titanium casing.]"
	Priority=9
	HudColor=(G=200,R=200)
	InventoryGroup=3
	GroupOffset=3
	PickupClass=Class'BWBP_SKC_Pro.GRSXXPickup'

	PlayerViewOffset=(X=20.00,Y=6.00,Z=-17.00)
	SightOffset=(X=-20.00,Z=5.70)

	AttachmentClass=Class'BWBP_SKC_Pro.GRSXXAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.Glock_Gold.SmallIcon_GoldGlock'
	IconCoords=(X2=127,Y2=31)
	ItemName="GRS-XX Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_GRSXX'
	DrawScale=0.300000
	bFullVolume=True
	SoundRadius=128.000000
}
