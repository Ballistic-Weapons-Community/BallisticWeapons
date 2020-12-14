class LightningRifle extends BallisticWeapon;

var float		ChargePower, ChargeIndex, MaxCharge;	//Charge power of secondary fire - affects damage, ammo usage and conductivity

struct RevInfo
{
	var() name	BoneName;
};

simulated function float ChargeBar()
{
	return ChargePower / MaxCharge;
}

simulated function SetChargePower(float NewChargePower)
{
	ChargePower = NewChargePower;
	ChargeIndex = int(NewChargePower);
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
    MaxCharge=4
    ZoomType=ZT_Logarithmic
    ZoomInAnim="ZoomIn"
    ScopeViewTex=Texture'BWBP_OP_Tex.Arc.ARCRifleScope'
    ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
    ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
    FullZoomFOV=20.000000
    bNoMeshInScope=True
    bNoCrosshairInScope=True
    SightOffset=(Z=51.000000)
    MinZoom=2.000000
    MaxZoom=8.000000
    ZoomStages=4
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
    BigIconMaterial=Texture'BWBP_OP_Tex.Arc.BigIcon_LightningRifle'
    BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
    bWT_Bullet=True
    ManualLines(0)="Uncharged lightning bolt shot. Deals reasonable damage for a small ammo cost."
    ManualLines(1)="Charged lightning bolt. The rifle will fire when the fire key is released, or immediately upon becoming fully charged. Damage improves with charge, and more ammo is consumed."
    ManualLines(2)="Upon releasing a charged lightning bolt, the electricity will arc between nearby players. The number of conducting players, radius and damage dropoff depends on the charge."
    SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
    BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Pickup')
    PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Deselect')
    ReloadAnimRate=0.9
    ClipOutSound=(Sound=Sound'BWBP_SKC_SoundsExp.LAW.Law-TubeLock')
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Up')
    ClipInFrame=0.650000
    bNonCocking=True
    WeaponModes(0)=(ModeName="Semi")
    WeaponModes(1)=(bUnavailable=True)
    WeaponModes(2)=(bUnavailable=True)
    CurrentWeaponMode=0
    GunLength=60.000000
    BobDamping=0.800000
    ParamsClass=Class'LightningWeaponParams'
    FireModeClass(0)=Class'BWBPOtherPackPro.LightningPrimaryFire'
    FireModeClass(1)=Class'BWBPOtherPackPro.LightningSecondaryFire'
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
    PickupClass=Class'BWBPOtherPackPro.LightningPickup'
    PlayerViewOffset=(X=20.000000,Y=16.000000,Z=-30.000000)
    AttachmentClass=Class'BWBPOtherPackPro.LightningAttachment'
    IconMaterial=Texture'BWBP_OP_Tex.Arc.SmallIcon_LightningRifle'
    IconCoords=(X2=127,Y2=31)
    ItemName="ARC-79 Lightning Rifle"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=30
    LightSaturation=150
    LightBrightness=150.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_LightningRifle'
    DrawScale=0.800000
}
