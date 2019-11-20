//=============================================================================
// FG50MachineGun.
//
// Yeah. Good luck aiming this thing. It weighs more than the X83 and that says
// something. Fires full length 50 cals instead of whatever the M925 fires, so
// it packs one hell of a punch.
//=============================================================================
class FG50MachineGun extends BallisticWeapon;

//aiming
var	Emitter		LaserDot;
var	LaserActor	Laser;
var() Sound		LaserOnSound;
var() Sound		LaserOffSound;
var	bool			bLaserOn;

//heat
var	FG50Heater		Heater;
var	float				HeatLevel;
var	float 				HeatDeclineDelay;
var() Sound			OverHeatSound;		// Sound to play when it overheats

var() name				ScopeBone;			// Bone to use for hiding scope
var name				BulletBone; 			//What it says on the tin

var	int	NumpadYOffset1; //Ammo tens
var	int	NumpadYOffset2; //Ammo ones
var() ScriptedTexture WeaponScreen;

var() Material	Screen;
var() Material	ScreenBaseX;
var() Material	ScreenBase1; //Norm
var() Material	ScreenBase2; //Stabilized
var() Material	ScreenBase3; //Empty
var() Material	ScreenBase4; //Stabilized + Empty
var() Material	ScreenRedBar; //Red crap for the heat bar
var() Material	Numbers;

var protected const color MyFontColor; //Why do I even need this?

replication
{
	reliable if (Role == ROLE_Authority)
		ClientScreenStart, bLaserOn;
}

simulated function PostNetBeginPlay()
{
	local Actor A;
	
	Super.PostNetBeginPlay();
	
	if (Heater == None || Heater.bDeleteMe)
	{
		class'BUtil'.static.InitMuzzleFlash (A, class'FG50Heater', DrawScale*BFireMode[0].FlashScaleFactor, self, 'tip3');
		Heater = FG50Heater(A);
		Heater.SetHeat(0.0);
	}
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		if (bLaserOn)
			AimAdjustTime = default.AimAdjustTime * 1.5;
		else
			AimAdjustTime = default.AimAdjustTime;
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

//========================== AMMO COUNTER NON-STATIC TEXTURE ============

simulated function ClientScreenStart()
{
	ScreenStart();
}

// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[3] = Screen; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated function Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	if (Heater != None)
		Heater.Destroy();
	Super.Destroyed();
	
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	Tex.DrawTile(0,0,256,128,0,0,256,128,ScreenBaseX, MyFontColor); //Basic screen

	Tex.DrawTile(0,45,70,70,45,NumpadYOffset1,50,50,Numbers, MyFontColor); //Ammo
	Tex.DrawTile(20,45,70,70,40,NumpadYOffset2,50,50,Numbers, MyFontColor);

	Tex.DrawTile(75,110,HeatLevel*12,10,5,5,10,10,ScreenRedBar, MyFontColor);//HEAT
}
	
simulated function UpdateScreen()
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;

	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}
	
// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load, bAmountNeededIsMax);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
	}
	UpdateScreen();
	return true;
}

//=====================================================================

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	if (ThirdPersonActor!=None)
		FG50Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
	{
		AimAdjustTime = default.AimAdjustTime * 1.5;
		AimSpread *= 0.4;
		ChaosAimSpread *= 0.4;
	}
	else
	{
		AimAdjustTime = default.AimAdjustTime;
		AimSpread = default.AimSpread;
		ChaosAimSpread = default.ChaosAimSpread;	
	}
    if (!Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
		AimSpread *= 0.4;
		ChaosAimSpread *= 0.4;
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
		AimSpread = default.AimSpread;
		ChaosAimSpread = default.ChaosAimSpread;	
	}
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
		LaserDot = Spawn(class'AH104LaserDot',,,Loc);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bot Accuracy++
	{
		AimSpread *= 0.30;
		ChaosAimSpread *= 0.20;
	}
	else if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}

	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'ReloadEmpty';
	}

	if ( ThirdPersonActor != None )
		FG50Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

simulated function PlayReload()
{
    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadEmpty';
    }
    else
    {
       ReloadAnim='Reload';
    }

	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			FG50Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
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
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
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

	if (CurrentWeaponMode == 0)
	{
		if (MagAmmo == 0)
			ScreenBaseX=ScreenBase4;
		else
			ScreenBaseX=ScreenBase2;
	}
	else
	{
		if (MagAmmo == 0)
			ScreenBaseX=ScreenBase3;
		else
			ScreenBaseX=ScreenBase1;
	}
	
	NumpadYOffset1=(5+(MagAmmo/10)*49);
	NumpadYOffset2=(5+(MagAmmo%10)*49);


	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;

	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}


function ServerUpdateLaser(bool bNewLaserOn)
{
	bUseNetAim = default.bUseNetAim || bScopeView || bNewLaserOn;
}

function ServerSwitchWeaponMode(byte NewMode)
{
	super.ServerSwitchWeaponMode(NewMode);
	
	if (CurrentWeaponMode==0)
	{
		if (SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		IdleAnimRate=0;
		bLaserOn=true;
	}
	else
	{
		IdleAnimRate=0.8;
		bLaserOn=false;
	}

	if (Role == ROLE_Authority)
		ServerSwitchLaser(bLaserOn);
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	ServerUpdateLaser(bLaserOn);
}

simulated function ClientSwitchWeaponModes (byte newMode)
{
	Super.ClientSwitchWeaponModes(newMode);
	UpdateScreen();
}

//Kaboodles' neat idle anim fix.
simulated function PlayIdle()
{
	if (BFireMode[0].IsFiring())
		return;
	if (bPendingSightUp)
		ScopeBackUp();
	else if (SightingState != SS_None)
	{
		if (SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	else if (bScopeView)
	{
		if(SafePlayAnim(ZoomOutAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	else
	    SafeLoopAnim(IdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

//heating

simulated event Tick (float DT)
{
	super.Tick(DT);
		
	if (HeatLevel > 0 && Level.TimeSeconds > LastFireTime + HeatDeclineDelay)
	{
		HeatLevel = FMax(0, HeatLevel - 7 * DT);
		if (Heater != None)
			Heater.SetHeat(HeatLevel/10);
	}
}

simulated function AddHeat(float Amount)
{
	HeatLevel += Amount;
	if (Heater != None)
		Heater.SetHeat(HeatLevel/10);
	
	if (HeatLevel >= 10)
	{
		HeatLevel = 10;
		PlaySound(OverHeatSound,,3.7,,32);
		class'BallisticDamageType'.static.GenericHurt (Instigator, 25, None, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTCYLOFirestormOverheat');
		return;
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

//turret

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}

simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock=false;
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(1,1.0,BulletBone);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 2)
		SetBoneScale(1,0.0,BulletBone);
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;
	PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo-MagAmmo;
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo = default.MagAmmo;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
	UpdateScreen();
}

function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local float Forward;

	if (Role < ROLE_Authority)
		return;
	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && T.bWorldGeometry && HitNorm.Z >= 0.7 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	HitLoc.Z += class'FG50Turret'.default.CollisionHeight - 9;

	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.

	if(Level.NetMode == NM_DedicatedServer)
	{
	CompressedEq = Instigator.Rotation;
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'FG50Turret', None,, HitLoc, CompressedEq);
	}

else Turret = Spawn(class'FG50Turret', None,, HitLoc, Instigator.Rotation);

    if (Turret != None)
    {
		Turret.InitDeployedTurretFor(self);
//		PlaySound(DeploySound, Slot_Interact, 0.7,,64,1,true);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for X82Rifle");
}



function ServerWeaponSpecial(optional byte i)
{
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.Skill > Rand(6))
	{
		if (Chaos < 0.1 || Chaos < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}
	else if (FRand() > 0.75)
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.2, Dist, 1024, 2048); 
}


// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.6;	}
// End AI Stuff =====

defaultproperties
{
     LaserOnSound=Sound'BallisticSounds2.M806.M806LSight'
     LaserOffSound=Sound'BallisticSounds2.M806.M806LSight'
     HeatDeclineDelay=0.400000
     OverheatSound=Sound'PackageSounds4Pro.CYLO.CYLO-OverHeat'
     ScopeBone="Holosight"
     BulletBone="Bullet"
     WeaponScreen=ScriptedTexture'BallisticRecolors3TexPro.FG50.FG50-ScriptLCD'
     screen=Shader'BallisticRecolors3TexPro.FG50.FG50-ScriptLCD-SD'
     ScreenBase1=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen'
     ScreenBase2=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen2'
     ScreenBase3=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen3'
     ScreenBase4=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen4'
     ScreenRedBar=Texture'BallisticRecolors3TexPro.M2020.M2020-ScreenOff'
     Numbers=Texture'BallisticRecolors3TexPro.PUMA.PUMA-Numbers'
     MyFontColor=(B=255,G=255,R=255,A=255)
     PlayerSpeedFactor=0.850000
     PlayerJumpFactor=0.800000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors3TexPro.FG50.BigIcon_FG50'
     BigIconCoords=(Y1=36,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Full Auto mode rapid-fires powerful explosive rounds. Upon impact with the enemy, these rounds explode, dealing heavy damage to nearby targets. Sustained DPS is massive. Has no penetration ability.|Controlled mode dramatically improves the hipfire at the cost of fire rate. A laser is projected which may give away the user's position."
     ManualLines(1)="Fires more rapidly, but overheats the weapon. An extremely powerful burst attack."
     ManualLines(2)="The FG50 is heavy and restricts movement. Takes a long time to aim. Effective at medium to long range."
     SpecialInfo(0)=(Info="320.0;35.0;1.0;100.0;0.8;0.5;0.1")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=40
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'PackageSounds4Pro.AS50.FG50-Cock',Volume=2.500000,Radius=32.000000)
     ClipOutSound=(Sound=Sound'PackageSounds4Pro.AS50.FG50-DrumOut',Volume=1.500000,Radius=32.000000)
     ClipInSound=(Sound=Sound'PackageSounds4Pro.AS50.FG50-DrumIn',Volume=1.500000,Radius=32.000000)
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Controlled")
     WeaponModes(1)=(bUnavailable=True)
     bNotifyModeSwitch=True
     FullZoomFOV=60.000000
     bNoCrosshairInScope=True
     SightOffset=(Y=25.000000,Z=10.300000)
     SightingTime=0.700000
     SprintOffSet=(Pitch=-3072,Yaw=-4096)
     JumpOffSet=(Pitch=-6000,Yaw=2000)
     AimSpread=128
     ChaosDeclineTime=1.750000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
     RecoilYCurve=(Points=(,(InVal=0.250000,OutVal=0.200000),(InVal=0.400000,OutVal=0.450000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.750000
     RecoilXFactor=0.300000
     RecoilYFactor=0.300000
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.FG50PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.FG50SecondaryFire'
     IdleAnimRate=0.600000
	 PutDownAnimRate=1.25
     PutDownTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     Description="The FG50 Heavy Machine Gun is a specialized .50 caliber weapon designed for use on automated weapons platforms and vehicles. Built under contract for the UTC, the NDTR FG50 is the primary weapon for many light assault vehicles and combat drones. An infantry version was developed for UTC's Sub-Orbital Insertion Troops as a high powered combat rifle, after complaints that the current M925 was too bulky to carry and store in Armored Insertion Pods and that the MG33 simply did not pack the punch required to stop a charging Skrith.||Hunter-killer SOIT teams swear by the FG50 now, and praise its ability to fire with precision and accuracy. However ask any veteran and you'll hear many stories about those who disrespected the power of the weapon and foolishly ended up with broken arms and damaged prides. The HMG is not a weapon to toy with."
     Priority=65
     HudColor=(B=25,G=25)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     GroupOffset=3
     PickupClass=Class'BWBPRecolorsPro.FG50Pickup'
     PlayerViewOffset=(X=5.000000,Y=-7.000000,Z=-8.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.FG50Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.FG50.SmallIcon_FG50'
     IconCoords=(X2=127,Y2=31)
     ItemName="FG50 Heavy Machinegun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.FG50_FP'
     DrawScale=0.500000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors3TexPro.FG50.FG50-Main'
     Skins(2)=Texture'BallisticRecolors3TexPro.FG50.FG50-Misc'
     Skins(3)=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen'
}
