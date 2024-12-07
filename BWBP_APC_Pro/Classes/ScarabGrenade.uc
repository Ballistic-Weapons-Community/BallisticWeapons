//=============================================================================
// ScarabGrenade.
//
// Little yellow hand grenade. Primary to throw far and bounce well, secondary
// to roll along ground and reload to release clip at any time. This gives the
// user a few seconds to get rid of the thing before it blows up in their hand.
// The pineapple is not too effective a weapon in the hands of the amatuer, but
// once the user masters the timing, it will become a very deadly toy.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ScarabGrenade extends BallisticHandGrenade;

var() BUtil.FullSound	PinPushSound;		//Sound to play for pin push

// AI Interface =====
function byte BestMode()
{
	local Bot B;
	local float Dist, Height, result;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	result = 0.5;

	if (Dist > 500)
		result -= 0.4;
	else
		result += 0.4;
	if (Abs(Height) > 32)
		result -= Height / Dist;
	if (result > 0.5)
		return 1;
	return 0;
}

// Anim Notify for pin pull
simulated function Notify_GrenadePinPush ()
{
    class'BUtil'.static.PlayFullSound(self, PinPushSound);
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.2;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}
// End AI Stuff =====

defaultproperties
{
     bCookable=False
     HeldDamage=150
     HeldRadius=350
     HeldMomentum=75000
     HeldDamageType=Class'BallisticProV55.DTNRP57Held'
     GrenadeSmokeClass=Class'BWBP_APC_Pro.ScarabTrail'
     ClipReleaseSound=(Sound=Sound'BWBP_APC_Sounds.CruGren.CruGren-Cock',Volume=1.000000,Radius=24.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BWBP_APC_Sounds.CruGren.CruGren-PullRingOut',Volume=0.076000,Radius=24.000000,Pitch=1.000000,bAtten=True)
     PinPushSound=(Sound=Sound'BWBP_APC_Sounds.CruGren.CruGren-PutRingIn',Volume=0.086000,Radius=24.000000,Pitch=1.000000,bAtten=True)
	 TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_APC_Tex.Grenade.BigIcon_CruGren'
     BigIconCoords=(Y1=16,Y2=245)
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     ManualLines(0)="Throws a grenade overarm. The grenade will explode after 3 seconds, dealing high damage in a moderate radius. Grenade Clusters are also released and explode within an impact radius, increasing the radius and damage dealt"
     ManualLines(1)="As primary, except the grenade is rolled underarm."
     ManualLines(2)="As with all grenades, Weapon Function or Reload can be used to release the clip and cook the grenade in the user's hand. Care must be taken not to overcook the grenade, lest the user be blown up. The NRX-82 grenade is effective on the move or against static positions."
     SpecialInfo(0)=(Info="60.0;5.0;0.25;30.0;0.0;0.0;0.4")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout',Volume=0.112000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway',Volume=0.111000)
     CurrentWeaponMode=1
     ParamsClasses(0)=Class'ScarabWeaponParams'
     ParamsClasses(1)=Class'ScarabWeaponParamsClassic'
     ParamsClasses(2)=Class'ScarabWeaponParamsRealistic'
     ParamsClasses(3)=Class'ScarabWeaponParamsTactical'
     FireModeClass(0)=Class'BWBP_APC_Pro.ScarabPrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.ScarabSecondaryFire'
	 
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.NRP57InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=119,R=128,A=192),Color2=(B=234,G=232,R=230,A=192),StartSize1=112,StartSize2=110)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.500000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=8.000000,CurrentScale=0.000000)

     SelectAnimRate=2.250000
     PutDownAnimRate=2.000000
     PutDownTime=0.700000
     BringUpTime=0.750000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.850000
     CurrentRating=0.850000
     Description="Black and Woods has been seeing massive success during the Skrith Wars, their weapons and devices being used across the galaxy to drive back the alien hordes and even against their fellow man in some cases.  They could rest on their laurels, but they're still going strong with a sidegrade to their long-standing hand grenade. Recently unveiled is the NRX-82 Cluster Grenade, known affectionately as the ''Scarab.'' It has earned that moniker thanks to the cluster bombs it spews out after the main explosion, wiping out small crowds of Skrith or anyone in the blast zone. While it hasn't been out in the field quite yet, they're getting painted yellow to match their older models, tricking Skrith into thinking they're pineapples just like before."
     Priority=7
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     PickupClass=Class'BWBP_APC_Pro.ScarabPickup'
     PlayerViewOffset=(X=3.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BWBP_APC_Pro.ScarabAttachment'
     IconMaterial=Texture'BWBP_APC_Tex.Grenade.SmallIcon_CruGren'
     IconCoords=(X2=127,Y2=31)
     ItemName="NRX-82 'Scarab' Cluster Grenade"
     Mesh=SkeletalMesh'BWBP_APC_Anim.CruGren_FPm'
     DrawScale=0.400000
}
