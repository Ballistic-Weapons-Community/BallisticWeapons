//=============================================================================
// MRocketLauncher.
//
// JL21-MRL 'Peacemaker'. A monstrous rocket launche  capable of firing its
// small, unpredictable rockets at ridiculously high fire rates.
// Its ammo is held in two separate magazines; one for the outer 12 barrels and
// another for the inner 6.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRocketLauncher extends BallisticWeapon;

var   byte							LoadedFrontBarrels;
var   byte							LoadedBackBarrels;
var   float							NextLoadTime;

var   int								BarrelIndex;

var   bool							bSmallReload;
var() Sound						ClipOutSoundSmall;
var() Sound						ClipInSoundSmall;

var   name							RocketCycleAnim;
var   bool							bPlayingFrontCycle;
var   bool							bPlayingBackCycle;

struct RocketState
{
	var name RocketName;
	var bool bHidden;
};
var   array<RocketState>	FrontRockets;
var   array<RocketState>	BackRockets;

var   int								BigMagAmmo;
var   MRLPrimaryFire				PrimaryFire;
var   MRLSecondaryFire		SecdaryFire;

var byte NetBarrels;
var byte NetBarrelIndex;

replication
{
	reliable if( bNetOwner && bNetDirty && (Role==ROLE_Authority) )
		BigMagAmmo, NetBarrels, NetBarrelIndex;
}

// RocketA0		Rocket in box
// RocketA8		Rocket at hatch

// RocketB1		Rocket in Box
// RocketB3		Closest to gun

// RocketCycle

// BWBP4-Sounds.MRL.MRL-SmallOn
// BWBP4-Sounds.MRL.MRL-SmallOff

// FrontVisibleRockets = MagAmmo - SmallAmmo - LoadedFrontBarrels
// BackVisibleRockets  = SmallAmmo - LoadedBackBarrels

// Cycle has 2 jobs: (1) Shove rocket into gun (2) draw rocket from box
// New rocket a ShowIndex must be shown at cycle end
// Rocket[0] must be hidden at cycle start if mag empty
// HideIndex must be advanced at cycle end
// Rocket at HideIndex must be hidden at cycle end
// anim must be reset to start at cycle end with no tween!

// HideIndex		: 5
// ShowIndex		: 2


// 0 [|\\|]>		Show
// 1 [|\\|]>		Show
// 2 [|\\|]>		Hide
// 3 [|\\|]>		Hide
// 4 [|\\|]>		Hide
// 5 [|\\|]>		Show
// 6 [|\\|]>		Show
// 7 [|\\|]>		Show
// 8 [|\\|]>		Show
simulated function PostNetReceive()
{
	super.PostNetReceive();
	if (level.NetMode == NM_Client && NetBarrels > 127)
	{
		LoadedBackBarrels = NetBarrels & 7;
		LoadedFrontBarrels = (NetBarrels>>3) & 15;
		BarrelIndex = NetBarrelIndex;
		NetBarrels = 0;
	}
}

function UpdateNetBarrels()
{
	NetBarrels = (LoadedBackBarrels & 7) | ((LoadedFrontBarrels & 15)<<3) | 128;
	NetBarrelIndex = BarrelIndex;
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	PrimaryFire = MRLPrimaryFire(FireMode[0]);
	SecdaryFire = MRLSecondaryFire(FireMode[1]);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	AnimBlendParams(1, 1.0, 0.0, 0.0, 'Feed');
	AnimBlendParams(2, 1.0, 0.0, 0.0, 'Feed2');
}

simulated function HideRocket (bool bFront, byte Index)
{
	if (bFront)
	{
		if (!FrontRockets[Index].bHidden)
		{
			SetBoneScale(Index+3, 0.0, FrontRockets[Index].RocketName);
			FrontRockets[Index].bHidden = true;
		}
	}
	else if (!BackRockets[Index].bHidden)
	{
		SetBoneScale(Index, 0.0, BackRockets[Index].RocketName);
		BackRockets[Index].bHidden = true;
	}
}

simulated function ShowRocket (bool bFront, byte Index)
{
	if (bFront)
	{
		if (FrontRockets[Index].bHidden)
		{
			SetBoneScale(Index+3, 1.0, FrontRockets[Index].RocketName);
			FrontRockets[Index].bHidden = false;
		}
	}
	else if (BackRockets[Index].bHidden)
	{
		SetBoneScale(Index, 1.0, BackRockets[Index].RocketName);
		BackRockets[Index].bHidden = false;
	}
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	local int i;

	if (anim == RocketCycleAnim)
	{
		if (Channel == 1)
		{
			for (i=8;i>0;i--)
			{
				if (FrontRockets[i-1].bHidden)
					HideRocket(true, i);
				else
					ShowRocket(true, i);
			}
			bPlayingFrontCycle=false;
			SafePlayAnim(IdleAnim, 1.0, , 1);
		}
		else if (Channel == 2)
		{
			for (i=2;i>0;i--)
			{
				if (BackRockets[i-1].bHidden)
					HideRocket(false, i);
				else
					ShowRocket(false, i);
			}
			bPlayingBackCycle=false;
			SafePlayAnim(IdleAnim, 1.0, , 2);
		}
	}
	else if (Anim == ZoomInAnim)
	{
		SightingState = SS_Active;
		ScopeUpAnimEnd();
		return;
	}
	else if (Anim == ZoomOutAnim)
	{
		SightingState = SS_None;
		ScopeDownAnimEnd();
		return;
	}

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim) )
		bPreventReload=false;

	// Modified stuff from Engine.Weapon
	if ((Channel == 0 || Anim == ReloadAnim || Anim == 'Reload1b' || Anim == 'Reload2' || Anim == 'Reload2b') && ClientState == WS_ReadyToFire && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) && MeleeState < MS_Held)
        {
			bPreventReload=false;
			PlayIdle();
        }
    }
	// End stuff from Engine.Weapon

	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		ReAim(0.05);
		return;
	}
}

simulated function PlayReload()
{
	if (MagAmmo < default.MagAmmo)
	{
		SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
		SafePlayAnim('Reload1b', ReloadAnimRate, , 2, "RELOAD");
		bSmallReload = true;
	}
	else
	{
		SafePlayAnim('Reload2', ReloadAnimRate, , 0, "RELOAD");
		SafePlayAnim('Reload2b', ReloadAnimRate, , 1, "RELOAD");
	}
}
function ServerStartReload (optional byte i)
{
	local int m;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (MagAmmo >= default.MagAmmo && BigMagAmmo >= default.BigMagAmmo)
		return;
	if (Ammo[0].AmmoAmount < 1)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	CommonStartReload(i);	//Server animation
	ClientStartReload(i);	//Client animation
}

simulated function bool MayNeedReload(byte Mode, float Load)
{
	if ((MagAmmo+BigMagAmmo) - Load < 1)
		return true;
	return bNeedReload;
}
simulated function Notify_ClipOut()
{
	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PreClipIn;

	if (bSmallReload)
		PlayOwnedSound(ClipOutSoundSmall,ClipOutSound.Slot,ClipOutSound.Volume,ClipOutSound.bNoOverride,ClipOutSound.Radius,ClipOutSound.Pitch,ClipOutSound.bAtten);
	else
		PlayOwnedSound(ClipOutSound.Sound,ClipOutSound.Slot,ClipOutSound.Volume,ClipOutSound.bNoOverride,ClipOutSound.Radius,ClipOutSound.Pitch,ClipOutSound.bAtten);
}
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	if (ReloadState == RS_None)
	{
		bSmallReload=false;
		return;
	}
	ReloadState = RS_PostClipIn;

	if (bSmallReload)
		PlayOwnedSound(ClipInSoundSmall,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	else
		PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (level.NetMode != NM_Client)
	{
		if (bSmallReload)
			AmmoNeeded = default.MagAmmo - MagAmmo;
		else
			AmmoNeeded = default.BigMagAmmo - BigMagAmmo;

		if (AmmoNeeded > Ammo[0].AmmoAmount)
			AmmoNeeded = Ammo[0].AmmoAmount;

		if (bSmallReload)
			MagAmmo += AmmoNeeded;
		else
			BigMagAmmo += AmmoNeeded;

		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
	bSmallReload=false;
}

simulated function Notify_ClipOutOfSight()
{
/*	local int i;

	if (!bSmallReload)
	{
		for (i=0;i<4;i++)
			if (Ammo[0].AmmoAmount > i)
				ShowRocket(true, i);
			else
				HideRocket(true, i);
	}
*/
}

simulated event WeaponTick(float DT)
{
	local bool bPlay;
	local int VisibleRockets;
	super.WeaponTick(DT);

	if (NextLoadTime <= Level.TimeSeconds && ReloadState == RS_None)
	{
		if (LoadedFrontBarrels < 12 && (BigMagAmmo-PrimaryFire.ConsumedLoadTwo-SecdaryFire.ConsumedLoadTwo) > LoadedFrontBarrels)
		{
			if (!FrontRockets[8].bHidden)
				LoadedFrontBarrels++;

			if (bPlayingFrontCycle)
				AnimEnded(1, RocketCycleAnim, 1.0, 1.0);
			VisibleRockets = (BigMagAmmo-PrimaryFire.ConsumedLoadTwo-SecdaryFire.ConsumedLoadTwo) - LoadedFrontBarrels;
			if (VisibleRockets > 7)
				ShowRocket(true, 0);
			else
				HideRocket(true, 0);
			if (FireMode[1].IsFiring())
				SafePlayAnim(RocketCycleAnim, 6.5, , 1);
			else
				SafePlayAnim(RocketCycleAnim, 0.9, , 1);
			bPlay=true;
			bPlayingFrontCycle = true;
		}
		if (LoadedBackBarrels < 6 && (MagAmmo-PrimaryFire.ConsumedLoad-SecdaryFire.ConsumedLoad) > LoadedBackBarrels)
		{
			if (!BackRockets[2].bHidden)
				LoadedBackBarrels++;

			if (bPlayingBackCycle)
				AnimEnded(2, RocketCycleAnim, 1.0, 1.0);
			VisibleRockets = (MagAmmo-PrimaryFire.ConsumedLoad-SecdaryFire.ConsumedLoad) - LoadedBackBarrels;
			if (VisibleRockets > 1)
				ShowRocket(false, 0);
			else
				HideRocket(false, 0);
			if (FireMode[1].IsFiring())
				SafePlayAnim(RocketCycleAnim, 6.0, , 2);
			else
				SafePlayAnim(RocketCycleAnim, 0.9, , 2);
			bPlay=true;
			bPlayingBackCycle = true;
		}
		if (bPlay)
		{
			if (FireMode[1].IsFiring())
				NextLoadTime = Level.TimeSeconds + 0.2;
//				NextLoadTime = Level.TimeSeconds + 0.0666;
			else
				NextLoadTime = Level.TimeSeconds + 0.3;
		}
	}
}

/*
simulated function SetScopeView(bool bNewValue)
{
	if (Level.NetMode == NM_Client)
		ServerSetScopeView(bNewValue);
	if (Role == ROLE_Authority)
	{
		BallisticAttachment(ThirdPersonActor).SetAimed(bNewValue);
		if (bNewValue)
			PlayerSpeedFactor = 0.6;
		else PlayerSpeedFactor = default.PlayerSpeedFactor;
		if (SprintControl.bSprinting)
			BallisticPawn(Instigator).CalcSpeedUp(1.35);
		else BallisticPawn(Instigator).CalcSpeedUp(1);	
	}
	bScopeView = bNewValue;
	SetScopeBehavior();
}
*/

simulated function bool ConsumeMRLAmmo(int Mode, float Load, float LoadB)
{
	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load+LoadB);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
		if (BigMagAmmo < LoadB)
			BigMagAmmo = 0;
		else
			BigMagAmmo -= LoadB;
	}
	return true;
}

simulated function GetAmmoCount(out float MaxAmmoPrimary, out float CurAmmoPrimary)
{
	if ( Ammo[0] == None )
		return;

	if (bNoMag)
	{
		MaxAmmoPrimary = Ammo[0].MaxAmmo;
		CurAmmoPrimary = Ammo[0].AmmoAmount;
	}
	else
	{
		MaxAmmoPrimary = default.MagAmmo + default.BigMagAmmo;
		CurAmmoPrimary = MagAmmo + BigMagAmmo;
	}
}

simulated function float ChargeBar()
{
	return (LoadedFrontBarrels + LoadedBackBarrels) / 18.0;
//	return LoadedBarrels / 18.0;
}

simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(32,16,0);
	Canvas.DrawText("BigMagAmmo: "$BigMagAmmo$", bSmallReload: "$bSmallReload$", BarrelIndex: "$BarrelIndex$", LoadedFrontBarrels: "$LoadedFrontBarrels$", LoadedBackBarrels: "$LoadedBackBarrels);
//	Canvas.DrawText("SmallAmmo: "$SmallAmmo$", bSmallReload: "$bSmallReload$", BarrelIndex: "$BarrelIndex$", LoadedFrontBarrels: "$LoadedFrontBarrels$", LoadedBackBarrels: "$LoadedBackBarrels);
    YPos += YL;
    Canvas.SetPos(4,YPos);
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
	
	if (Dist < 1024) // too close
		return 0.4;
		
	return class'BUtil'.static.DistanceAtten(Rating, 0.65, Dist, 4096, 4096); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}


defaultproperties
{
	ClipOutSoundSmall=Sound'BWBP4-Sounds.MRL.MRL-SmallOff'
	ClipInSoundSmall=Sound'BWBP4-Sounds.MRL.MRL-SmallOn'
	RocketCycleAnim="RocketCycle"
	FrontRockets(0)=(RocketName="RocketA0")
	FrontRockets(1)=(RocketName="RocketA1")
	FrontRockets(2)=(RocketName="RocketA2")
	FrontRockets(3)=(RocketName="RocketA3")
	FrontRockets(4)=(RocketName="RocketA4")
	FrontRockets(5)=(RocketName="RocketA5")
	FrontRockets(6)=(RocketName="RocketA6")
	FrontRockets(7)=(RocketName="RocketA7")
	FrontRockets(8)=(RocketName="RocketA8")
	BackRockets(0)=(RocketName="RocketB1")
	BackRockets(1)=(RocketName="RocketB2")
	BackRockets(2)=(RocketName="RocketB3")
	BigMagAmmo=72
	PlayerSpeedFactor=0.75
	PlayerJumpFactor=0.75
	BigIconMaterial=Texture'BWBP4-Tex.MRL.BigIcon_MRL'
	BigIconCoords=(Y1=30,Y2=225)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	InventorySize=12
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_RapidProj=True
	bWT_Projectile=True
	ManualLines(0)="Fires miniature explosive rockets at a modest rate. Moderate damage, good damage output and fast travel time. Capacity is extremely high due to the double-magazine setup. Recoil is almost non-existent as the weapon is a multiple rocket launcher. The rockets also deal radius damage."
	ManualLines(1)="As the primary fire, but the rate of fire is significantly increased. The rockets travel slowly at first, before launching at full speed."
	ManualLines(2)="Effective against groups and at medium range."
	SpecialInfo(0)=(Info="480.0;60.0;1.5;100.0;0.8;2.0;1.5")
	BringUpSound=(Sound=Sound'BallisticSounds2.G5.G5-Pullout')
	PutDownSound=(Sound=Sound'BallisticSounds2.G5.G5-Putaway')
	MagAmmo=36
	ReloadAnim="Reload1"
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOff')
	ClipInSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOn')
	ClipInFrame=0.700000
	bNonCocking=True
	WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	SightOffset=(X=-30.000000,Y=-10.000000,Z=15.000000)
	SightDisplayFOV=50.000000
	SightAimFactor=0.25
	SightingTime=0.65
	LongGunOffset=(X=8.000000,Y=-5.000000,Z=-3.000000)
	SprintOffSet=(Pitch=-7000,Yaw=-3000)
	OffsetAdjustTime=0.600000
	AimSpread=12
	ChaosDeclineTime=0.320000
	ChaosSpeedThreshold=500.000000
	ChaosAimSpread=2048
	 
	Begin Object Class=RecoilParams Name=MRLRecoilParams
		XRandFactor=0.000000
		YRandFactor=0.000000
 	End Object
 	RecoilParamsList(0)=RecoilParams'MRLRecoilParams'

	FireModeClass(0)=Class'BallisticProV55.MRLPrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.MRLSecondaryFire'
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.850000
	CurrentRating=0.850000
	bShowChargingBar=True
	Description="An experimental product of NDTR's ballistics wing, the JL21 missile launcher is yet another armament in a long line of anti-Krao weapons designed by the terrans. A powerful, heavy and highly volatile construct, the 'PeaceMaker' has thus far proved it's worth in field tests. The 18 barrelled monster, can fire small, short ranged missiles very quickly via several feed mechanisms supplied by 2 large ammunition containers. A very distinctive attribute of the MRL lies in it's missles flight paths, most often than not, following a drunk path and flying about in an apparently random manner. This has proved very efficient against hordes of Krao, yet not as effective against single opponents. The latest feature of the weapon, allows an even faster rate of fire, at the greatly increased cost of ammunition."
	Priority=39
	HudColor=(B=57,G=98,R=140)
	InventoryGroup=8
	GroupOffset=2
	PickupClass=Class'BallisticProV55.MRLPickup'
	PlayerViewOffset=(X=12.000000,Y=9.000000,Z=-12.000000)
	PlayerViewPivot=(Pitch=1024,Yaw=-512,Roll=1024)
	AttachmentClass=Class'BallisticProV55.MRLAttachment'
	IconMaterial=Texture'BWBP4-Tex.MRL.SmallIcon_MRL'
	IconCoords=(X2=127,Y2=31)
	ItemName="JL21-MRL PeaceMaker"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP4b-Anims.MRL'
	DrawScale=0.300000
}
