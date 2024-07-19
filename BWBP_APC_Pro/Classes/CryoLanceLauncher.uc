//=============================================================================
// MARS-3 (i.e. F2000.)
//=============================================================================
class CryoLanceLauncher extends BallisticWeapon
	transient
	HideDropDown
	CacheExempt;

var   float ChargeRate;
var()     float Heat, CoolRate;
var   bool			bIsCharging;

replication
{
	reliable if (Role == ROLE_Authority)
		ChargeRate;
}

//=====================================================================
// AI INTERFACE CODE
//=====================================================================
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	if (Dist > 2048 || Rand(100) < 10)
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

	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 1536, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{ return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}

simulated function float ChargeBar()
{
	return BFireMode[0].HoldTime / BFireMode[0].MaxHoldTime;
}
// End AI Stuff =====

defaultproperties
{
	ChargeRate=2.400000
	CoolRate=1.0
    bShowChargingBar=True
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_CC_Tex.CryoCannon.BigIcon_Freeze'
	BigIconCoords=(X1=32,Y1=40,X2=475)
	bWT_Bullet=True
	ManualLines(0)=""
	ManualLines(1)=""
	ManualLines(2)=""
	SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.8;0.5;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	CockAnimRate=1.100000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-BoltPull',Volume=1.100000,Radius=32.000000)
	ReloadAnimRate=1.100000
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-MagFiddle',Volume=1.200000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-MagOut',Volume=1.200000,Radius=32.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-MagIn',Volume=1.200000,Radius=32.000000)
	ClipInFrame=0.650000
	bNonCocking=True
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Burst",Value=4.000000,bUnavailable=True)
	WeaponModes(2)=(ModeName="Auto")
	bNoCrosshairInScope=True
	SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
	ParamsClasses(0)=Class'CryoLanceWeaponParams'
	ParamsClasses(1)=Class'CryoLanceWeaponParamsClassic'
	ParamsClasses(2)=Class'CryoLanceWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_APC_Pro.CryoLancePrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.CryoLanceSecondaryFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=255,R=255,A=134),Color2=(B=0,G=0,R=255,A=255),StartSize1=50,StartSize2=51)
	PutDownTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.750000
	CurrentRating=0.750000
	Description=""
	Priority=65
	HudColor=(B=255,G=175,R=125)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	PickupClass=Class'BWBP_APC_Pro.CryoLanceLauncherPickup'
	PlayerViewOffset=(X=-5.500000,Y=12.000000,Z=-18.000000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_APC_Pro.CryoLanceLauncherAttatchment'
	IconMaterial=Texture'BWBP_CC_Tex.CryoCannon.SmallIcon_Freeze'
	IconCoords=(X2=127,Y2=31)
	ItemName="[B] Cryo Lance"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_CryoCannon'
	DrawScale=0.400000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
