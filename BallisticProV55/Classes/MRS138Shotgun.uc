//=============================================================================
// MRS138Shotgun.
//
// A combat shotgun with a Flashlight and Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138Shotgun extends BallisticProShotgun;

var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bLightsOn;
var vector		TorchOffset;
var() Sound		TorchOnSound;
var() Sound		TorchOffSound;

var Emitter		TazerEffect;
var MRS138TazerLineEffect TazerLineEffect;
var float		TazerTime;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

//// client only ////
simulated event ClientStartFire(int Mode)
{
    if (mode == 1)
    {
    	if (TazerEffect == None)
    		StartTazer();
    }
	super.ClientStartFire(Mode);
}

simulated function StartTazer()
{
   	TazerTime = 0;
	if (Role==ROLE_Authority)
		MRS138Attachment(ThirdPersonActor).bTazerOn = true;
	if (Instigator.IsLocallyControlled() && TazerEffect == None)
	{
		TazerEffect = Spawn(class'MRS138TazerEffect',self,,location);
		class'BallisticEmitter'.static.ScaleEmitter(TazerEffect, DrawScale);
		AttachToBone(TazerEffect, 'tip2');
	}
}

simulated function OnWeaponDisplaced()
{
	super.OnWeaponDisplaced();
	
	if (Role == ROLE_Authority && MRS138Attachment(ThirdPersonActor).bTazerOn)
	{
		MRS138Attachment(ThirdPersonActor).PlayerTazeEnd();
	}
}

simulated function KillTazer()
{
	if (TazerEffect != None)
		TazerEffect.Kill();
	if (Role==ROLE_Authority && ThirdPersonActor != None)
		MRS138Attachment(ThirdPersonActor).bTazerOn = false;
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (anim == FireMode[0].FireAnim || (anim == FireMode[1].FireAnim && !FireMode[1].IsFiring()))
		bPreventReload=false;
		
	if (MeleeFireMode != None && anim == MeleeFireMode.FireAnim)
	{
		if (MeleeState == MS_StrikePending)
			MeleeState = MS_Pending;
		else MeleeState = MS_None;
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		bPreventReload=false;
	}
		
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
			
		if (anim == BFireMode[0].AimedFireAnim || !BFireMode[1].IsFiring())
		{
			bPreventReload=False;
		}
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (!FireMode[1].IsFiring() && MeleeState < MS_Held)
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

exec simulated function WeaponSpecial(optional byte i)
{
	bLightsOn = !bLightsOn;
	ServerFlashLight(bLightsOn);
	if (bLightsOn)
	{
		PlaySound(TorchOnSound,,0.7,,32);
		if (FlashLightEmitter == None)
			FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
		class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
		StartProjector();
	}
	else
	{
		PlaySound(TorchOffSound,,0.7,,32);
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();
		KillProjector();
	}
}

function ServerFlashLight (bool bNew)
{
	bLightsOn = bNew;
	MRS138Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	GunLength = default.GunLength;
	if (Instigator != None && AIController(Instigator.Controller) != None && FRand() > 0.5)
		WeaponSpecial();
	else if (bLightsOn && Instigator.IsLocallyControlled())
	{
		bLightsOn=false;
		WeaponSpecial();
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillTazer();
		KillProjector();
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();
		return true;
	}
	return false;
}

simulated function Destroyed()
{
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	KillTazer();
	super.Destroyed();
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip2');
	FlashLightProj.SetRelativeLocation(TorchOffset);
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
		FlashLightProj.Destroy();
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (TazerTime != 0 && level.TimeSeconds > TazerTime + 5)
	{
		KillTazer();
		TazerTime = 0;
	}

	if (!bLightsOn || ClientState != WS_ReadyToFire)
		return;
	if (!Instigator.IsFirstPerson())
		KillProjector();
	else if (FlashLightProj == None)
		StartProjector();
}

simulated event RenderOverlays( Canvas Canvas )
{
	local Vector TazLoc;
	local Rotator TazRot;
	
	if (TazerLineEffect != None)
	{
		TazerLineEffect.bHidden = true;
		TazerLineEffect.SetLocation(ConvertFOVs(GetBoneCoords('tip2').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		Canvas.DrawActor(TazerLineEffect, false, false, Instigator.Controller.FovAngle);
	}
	
	super.RenderOverlays(Canvas);
	
	if (bLightsOn || TazerEffect!= None)
	{
		TazLoc = GetBoneCoords('tip2').Origin;
		TazRot = GetBoneRotation('tip2');
		if (TazerEffect != None)
		{
			TazerEffect.SetLocation(TazLoc);
			TazerEffect.SetRotation(TazRot);
			Canvas.DrawActor(TazerEffect, false, false, DisplayFOV);
		}
		if (FlashLightEmitter != None)
		{
			FlashLightEmitter.SetLocation(TazLoc);
			FlashLightEmitter.SetRotation(TazRot);
			Canvas.DrawActor(FlashLightEmitter, false, false, DisplayFOV);
		}
	}
	

}

simulated function WeaponTick (float DT)
{
	super.WeaponTick(DT);

	if (TazerLineEffect != None && !Instigator.IsFirstPerson() && AIController(Instigator.Controller) == None)
	{
		TazerLineEffect.bHidden = False;
		TazerLineEffect.SetLocation(BallisticAttachment(ThirdPersonActor).GetModeTipLocation());
	}
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

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 250)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(Instigator.Velocity) < 0.5))
		return 1;
	return Rand(2);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticProShotgunFire(BFireMode[0]).CutOffStartRange, BallisticProShotgunFire(BFireMode[0]).CutOffDistance); 
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
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

    return 0.3 - (B.Skill / 6) * (1-(Dist/3000));
}
// End AI Stuff =====

defaultproperties
{
	bWT_Shotgun=True
	bShovelLoad=True
	bMeleeWeapon=True
	bCockOnEmpty=True
	bCanSkipReload=True
	WeaponModes(2)=(bUnavailable=True)
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(0)=(ModeName="Semi-Automatic")
	TorchOnSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	TorchOffset=(X=-330.000000,Y=-35.000000,Z=50.000000)
	TorchOffSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	StartShovelAnimRate=1.400000
	StartShovelAnim="PrepReload"
	SpecialInfo(0)=(Info="240.0;25.0;0.5;40.0;0.0;1.0;-999.0")
	SightOffset=(X=15,Z=21.500000)
	SightDisplayFOV=40
	ReloadAnimRate=1.500000
	ReloadAnim="ReloadLoop"
	PutDownTime=0.35
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
	PutDownAnimRate=1.5
	Priority=36
	PlayerViewOffset=(Y=10.000000,Z=-14.000000)
	PickupClass=Class'BallisticProV55.MRS138Pickup'
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_MRS'
	MeleeFireClass=Class'BallisticProV55.MRS138MeleeFire'
	ManualLines(2)="Has a melee attack. The damage of this attack increases to its maximum over 1.5 seconds of holding the altfire key. The attack inflicts more damage from behind. Inflicts a medium-duration blind upon enemies when impacting and knocks them away from the user.||Weapon Function engages a flashlight which illuminates dark areas.||This weapon is extremely effective at close range."
	ManualLines(1)="Launches a tazer. The user must hold down Altfire or the tazer will be retracted. Upon striking an enemy, transmits a current dealing low sustained damage but slowing the enemy movement."
	ManualLines(0)="10-gauge pump-action shotgun fire. Moderate spread, good damage and average fire rate. Good shoulder fire properties."
	LongGunPivot=(Pitch=4500,Yaw=-8000)
	LightType=LT_Pulse
	LightSaturation=150
	LightRadius=5.000000
	LightHue=25
	LightEffect=LE_NonIncidence
	LightBrightness=150.000000
	ItemName="MRS-138 Tactical Shotgun"
	InventoryGroup=7
	IconMaterial=Texture'BW_Core_WeaponTex.MRS138.SmallIcon_MRS138'
	IconCoords=(X2=127,Y2=31)
	HudColor=(B=255,G=150,R=100)
	GunLength=32.000000
	GroupOffset=3
	ParamsClasses(0)=Class'MRS138WeaponParams'
	ParamsClasses(1)=Class'MRS138WeaponParamsClassic'
	ParamsClasses(2)=Class'MRS138WeaponParamsRealistic'
	FireModeClass(1)=Class'BallisticProV55.MRS138SecondaryFire'
	FireModeClass(0)=Class'BallisticProV55.MRS138PrimaryFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,A=183),Color2=(B=8,G=67,R=29),StartSize1=108,StartSize2=109)

	EndShovelAnimRate=1.600000
	EndShovelAnim="EndReload"
	DrawScale=0.400000
	DisplayFOV=50.000000
	Description="Also from the first line of Drake & Co weaponry, the MRS138 Combat Shotgun is an excellent close-range weapon. It is outfitted with a tactical light and tazer attachment to increase its effectiveness as a crowd control and civilian weapon. The tazer is an effective tool for stunning enemies and inflicting slight damage, leaving them blinded and disoriented for a few seconds, while the flash light can be used for locating those which hide in the dark."
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	CurrentWeaponMode=0
	CurrentRating=0.800000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Cock',Volume=0.800000)
	CockAnimRate=1.200000
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-ShellIn')
	ClipInFrame=0.375000
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_MRS138'
	BigIconCoords=(Y1=36,Y2=230)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	AttachmentClass=Class'BallisticProV55.MRS138Attachment'
	AIRating=0.800000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BW_Core_WeaponTex.MRS138.MRS138Shiney'
	Skins(2)=Texture'BW_Core_WeaponTex.MRS138.MRS138HeatShield'
	Skins(3)=Texture'BW_Core_WeaponTex.MRS138.MRS138Shell'
}