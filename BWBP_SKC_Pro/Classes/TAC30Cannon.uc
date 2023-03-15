//=============================================================================
// TAC30Cannon
//
// A big funk-off 30mm cannon
// By the time you have finished reading this you will know it says nothing
//
// by Sarge, based on code by Runestorm
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TAC30Cannon extends BallisticWeapon
	transient
	HideDropDown
	CacheExempt;

var float		lastModeChangeTime;


var   bool			bLaserOn;

var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;

var   Emitter		LaserDot;

var() sound      	QuickCockSound;


/*replication
{
	reliable if(Role == ROLE_Authority)
		bLaserOn, ClientSwitchCannonMode;
}


function ServerSwitchWeaponMode (byte NewMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode(NewMode);
	if (!Instigator.IsLocallyControlled())
		TAC30PrimaryFire(FireMode[0]).SwitchCannonMode(CurrentWeaponMode);
	ClientSwitchCannonMode (CurrentWeaponMode);
}

simulated function ClientSwitchCannonMode (byte newMode)
{
	TAC30PrimaryFire(FireMode[0]).SwitchCannonMode(newMode);
}*/

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);
	GunLength = default.GunLength;


	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'BallisticProV55.LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;

}

simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,3.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,3.7,,32);
	}
	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'BWBP_SKC_Pro.TAC30LaserDot',,,Loc);
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
	if (bLaserOn != default.bLaserOn)
	{
		/*if (bLaserOn)
			AimAdjustTime = default.AimAdjustTime * 1.5;
		else
			AimAdjustTime = default.AimAdjustTime;*/
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}
function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	
	/*if (bLaserOn)
		AimAdjustTime = default.AimAdjustTime * 1.5;
	else
		AimAdjustTime = default.AimAdjustTime;*/
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
		
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
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

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && ((FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > -0.05) || (!FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > 0.1)))
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}




// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	Result += (Dist-1000) / 2000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

simulated function Notify_BrassOut()
{
//	BFireMode[0].EjectBrass();
}

simulated function Notify_ManualBrassOut()
{
	BFireMode[0].EjectBrass();
}


defaultproperties
{
     LaserOnSound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOn'
	 LaserOffSound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOff'
	 PlayerSpeedFactor=0.850000
     QuickCockSound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-CockQuick'

     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_TexExp.TAC30.BigIcon_TAC30'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     SpecialInfo(0)=(Info="360.0;30.0;0.9;120.0;0.0;3.0;0.0")
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Select')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
     PutDownTime=1.500000
     MagAmmo=10
     CockSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-CockQuick',Pitch=0.900000,Volume=1.000000)
     ReloadAnim="Reload"
     ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-ClipIn',Pitch=0.900000,Volume=2.000000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-ClipOut1',Pitch=0.900000,Volume=2.000000)
     ClipInFrame=0.650000
     IdleAnimRate=0.100000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Double Shot",ModeID="WM_Burst",Value=2.000000)
     WeaponModes(1)=(ModeName="Single Shot",ModeID="WM_FullAuto")
     CurrentWeaponMode=1
     SightPivot=(Pitch=1024,Roll=2048)
     SightOffset=(X=0.000000,Y=10.000000,Z=16.000000)
	 GunLength=32.000000
     FireModeClass(0)=Class'BWBP_SKC_Pro.TAC30PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.TAC30SecondaryFire'
     AIRating=0.600000
     CurrentRating=0.600000
     Description="TAC30 Autocannon||Manufacturer: UTC Defense Tech|Primary: 30mm HE Shell|Secondary: Tri-Barrel Blast||The SRAC-21/G 20mm Autocannon is the grenade launching variant of the SKAS-21 weapon system. It fires the highly potent FRAG-12 explosive round, which turns what is normally a close range suppression shotgun into a long range sniping cannon. It fires from the same electrically assisted, rotating triple-barrel system as the SKAS-21, which means that it can also be used with manual mode to further propel the generally low-impulse explosive charge. The explosive charges are designed to detonate on contact, which means the SRAC can be used in a similar fashion to a standard slug firing rifles. A laser sight is included on all SRACs due to a lack of back up iron sights. Handle with care, as this is one expensive gun."
     Priority=245
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBP_SKC_Pro.TAC30Pickup'
     PlayerViewOffset=(X=-4.000000,Y=8.000000,Z=-11.000000)
     BobDamping=1.700000
     AttachmentClass=Class'BWBP_SKC_Pro.TAC30Attachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.TAC30.SmallIcon_TAC30'
     IconCoords=(X2=127,Y2=30)
     ItemName="[B] TAC-30 Autocannon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_TAC30OLDUVs'
     DrawScale=0.260000
	 ParamsClasses(0)=Class'TAC30CannonWeaponParamsArena'
	 ParamsClasses(1)=Class'TAC30WeaponParamsClassic'
}
