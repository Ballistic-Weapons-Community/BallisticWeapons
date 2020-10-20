//=============================================================================
// MRDRMachinePistol.
//
// Dual wieldable weapon with a nice spiked handguard for punching
// Small clip but very low recoil and chaos. Fairly accurate actually.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRDRMachinePistol extends BallisticHandgun;

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_MRDRClip';
}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return false;
	return super.CanAlternate(Mode);
}

simulated function float ChargeBar()
{
	return MeleeFatigue;
}

simulated event WeaponTick (Float DT)
{
	Super.WeaponTick (DT);
	
	if (LastFireTime < Level.TimeSeconds - RcComponent.DeclineDelay && MeleeFatigue > 0)
		MeleeFatigue = FMax(0, MeleeFatigue - DT/RcComponent.DeclineTime);
}

simulated function bool HasAmmoLoaded(byte Mode)
{
	if (Mode == 1)
		return true;
	if (bNoMag)
		return HasNonMagAmmo(Mode);
	else
		return HasMagAmmo(Mode);
}

//simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
//simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated state Lowering// extends DualAction
{
Begin:
	SafePlayAnim(PutDownAnim, 1.75, 0.1);
	FinishAnim();
	GotoState('Lowered');
}

simulated function Notify_MRDRMelee()
{
	if (Role == ROLE_Authority)
		MRDRSecondaryFire(BFireMode[1]).NotifiedDoFireEffect();
	PlayOwnedSound(BFireMode[1].BallisticFireSound.Sound,
		BFireMode[1].BallisticFireSound.Slot,
		BFireMode[1].BallisticFireSound.Volume,
		BFireMode[1].BallisticFireSound.bNoOverride,
		BFireMode[1].BallisticFireSound.Radius,
		BFireMode[1].BallisticFireSound.Pitch,
		BFireMode[1].BallisticFireSound.bAtten);
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

	if (!HasAmmoLoaded(0))
		return 1;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 200)
		return 0;
	if (Dist < FireMode[1].MaxRange())
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 1536); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =================================


simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

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

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

// =============================================

defaultproperties
{
	bShouldDualInLoadout=False
	HandgunGroup=2
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BallisticRecolors3TexPro.MRDR.BigIcon_MRDR'
	BigIconCoords=(X1=64,Y1=0,Y2=255)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic pistol fire. Good strength and low recoil."
	ManualLines(1)="Continuous melee attack. Lower DPS than dedicated melee weapons."
	ManualLines(2)="As a wrist-mounted weapon, it has no iron sights, but possesses superior hip accuracy.||Moderately effective at close range."
	SpecialInfo(0)=(Info="60.0;3.0;0.1;125.0;0.0;0.2;-999.0")
	BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
	MagAmmo=24
	CockSound=(Sound=Sound'PackageSounds4Pro.MRDR.MRDR-Cock',Volume=0.800000)
	ClipOutSound=(Sound=Sound'PackageSounds4Pro.MRDR.MRDR-ClipOut',Volume=0.700000)
	ClipInSound=(Sound=Sound'PackageSounds4Pro.MRDR.MRDR-ClipIn',Volume=0.700000)
	ClipInFrame=0.650000
	InventorySize=6
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Small Burst",Value=5.000000)
	bUseSights=False
	SightPivot=(Pitch=900,Roll=-800)
	SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
	SightDisplayFOV=40.000000
	GunLength=0.100000
	AimAdjustTime=0.450000
	AimSpread=16
	AIRating=0.6
	CurrentRating=0.6
	ChaosDeclineTime=0.450000
	ChaosAimSpread=256
	 
	Begin Object Class=RecoilParams Name=MRDRRecoilParams
		ViewBindFactor=0.5
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.200000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.550000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.800000
		DeclineDelay=0.350000
	End Object
	RecoilParamsList(0)=RecoilParams'MRDRRecoilParams'
	 
	FireModeClass(0)=Class'BWBPRecolorsPro.MRDRPrimaryFire'
	FireModeClass(1)=Class'BWBPRecolorsPro.MRDRSecondaryFire'
	PutDownTime=0.400000
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=True
	Description="This bull pup style weapon, made by UTC Defense Tech, features a ring magazine holding 36 rounds of 9mm ammunition that wraps around the forearm and has a spiked steel knuckle on it. Because the bulk of the weight sits on the forearm and not on the wrist, this weapon is very easy to use either single or in pairs. With the unique magazine, some users may find reloading this weapon to be challenging, UTC designed an entirely new feed system for this weapon and as such is still in its experimental stages. This DR88 model uses the same Krome muzzle flash system as the Fifty-9 for massive amounts of style."
	Priority=143
	HudColor=(B=150,G=150,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=5
	PickupClass=Class'BWBPRecolorsPro.MRDRPickup'
	PlayerViewOffset=(X=-8.000000,Y=8.000000,Z=-8.000000)
	AttachmentClass=Class'BWBPRecolorsPro.MRDRAttachment'
	IconMaterial=Texture'BallisticRecolors3TexPro.MRDR.SmallIcon_MRDR'
	IconCoords=(X2=127,Y2=31)
	ItemName="MR-DR88 Machine Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BallisticRecolors4AnimPro.KnuckleBuster'
	DrawScale=0.300000
}
