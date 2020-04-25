class LightningRifle extends BallisticWeapon;

var int 	                  TransferCDamage;
var LightningSecondaryFire    AltMode;
var() name					  ScopeBone;	//Scope bone of R78 - Testing purposes

simulated function PostBeginPlay()
{
     Super.PostBeginPlay();
	 
	 SetBoneScale(1, 0.0, ScopeBone);	//Hides scope bone of R78, temporary
     AltMode = LightningSecondaryFire(FireMode[1]);
}

simulated function float ChargeBar()
{
     return AltMode.GetChargeFactor();
}

// AI Interface =====
function byte BestMode()	{	return 0;	}

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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.9;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.9;	}
// End AI Stuff =====

defaultproperties
{
	 //With Scope
	 
	 /*
	 ZoomType=ZT_Logarithmic
     ScopeXScale=1.333000
     ZoomInAnim="ZoomIn"
     ScopeViewTex=Texture'BallisticUI2.R78.RifleScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=20.000000
	 bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
     SightingTime=0.300000
	 MinZoom=2.000000
     MaxZoom=8.000000
     ZoomStages=4
	 */
	 
	 //Without Scope
	 
	 /*
	 ZoomType=ZT_Irons
	 bNoCrosshairInScope=False
	 SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
	 SightingTime=0.300000
	 */
	 
	 //Swap these out where necessary.
	 
	 ZoomType=ZT_Irons
	 bNoCrosshairInScope=False
	 SightOffset=(X=-10.000000,Y=-0.030000,Z=12.760000)
	 SightPivot=(Pitch=64)
	 SightingTime=0.300000
	 
	 ScopeBone="Scope"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_R78'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Uncharged lightning bolt shot. Deals reasonable damage for a small ammo cost."
     ManualLines(1)="Charged lightning bolt. The rifle will fire when the fire key is released, or immediately upon becoming fully charged. Damage improves with charge, and more ammo is consumed."
     ManualLines(2)="Upon releasing a charged lightning bolt, the electricity will arc between nearby players. The number of conducting players, radius and damage dropoff depends on the charge."
     SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway')
     MagAmmo=4
     CockAnim="CockQuick"
     CockAnimRate=1.400000
     CockSound=(Sound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-Cock')
     ReloadAnimRate=1.350000
     ClipHitSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Automatic")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
	 PlayerSpeedFactor=0.950000
     PlayerJumpFactor=0.950000
     GunLength=60.000000
     CrouchAimFactor=0.600000
     SightAimFactor=0.350000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=0.400000
     AimSpread=192
     ChaosSpeedThreshold=1200.000000
	 ChaosDeclineTime=0.750000
     ChaosAimSpread=1024
     RecoilYawFactor=0.100000
     RecoilXFactor=0.400000
     RecoilYFactor=0.800000
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BallisticJiffyPack.LightningPrimaryFire'
     FireModeClass(1)=Class'BallisticJiffyPack.LightningSecondaryFire'
     PutDownTime=0.700000
     BringUpTime=0.600000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     bSniping=True
	 bShowChargingBar=True
     Description="ARC-79 Lightning Rifle||Manufacturer: JAX Industrial Firm|Primary: Single lightning bolt|Secondary: Charged lightning bolt with arcing to nearby players"
     DisplayFOV=55.000000
     Priority=33
     HudColor=(B=50,G=50,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=2
     PickupClass=Class'BallisticJiffyPack.LightningPickup'
     PlayerViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
     AttachmentClass=Class'BallisticJiffyPack.LightningAttachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_R78'
     IconCoords=(X2=127,Y2=31)
     ItemName="ARC-79 Lightning Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticProAnims.R78A1Rifle'
     DrawScale=0.450000
}
