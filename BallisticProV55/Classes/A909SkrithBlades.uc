//=============================================================================
// A909SkrithBlades.
//
// The A909 Skrith Wrist blades are rapid fire melee weapons with fair range,
// but without the useful, spread out swipe of other melee weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A909SkrithBlades extends BallisticMeleeWeapon;

simulated function bool HasAmmo()	{	return true;	}
simulated function bool ConsumeAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)	{ return true;	}

simulated function Notify_A909HackRight()
{
	A909PrimaryFire(FireMode[0]).bFireNotified=true;
	FireMode[0].ModeDoFire();
}
simulated function Notify_A909HackLeft()
{
	A909PrimaryFire(FireMode[0]).bFireNotified=true;
	FireMode[0].ModeDoFire();
}
// On the server, this adjusts anims, ammo and such. On clients it only adjusts anims.
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
    if (Anim == FireMode[0].FireAnim && FireMode[0].bIsFiring)
    	FireMode[0].PlayFiring();
	else
    	super.AnimEnd(Channel);
}

// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_A909'
     BigIconCoords=(X1=24,X2=432)
     
     ManualLines(0)="Thrusting attack with the blades. Good range, but requires accuracy to hit. The first strike requires twice as long to complete as subsequent strikes. This attack has the highest sustained damage output of all melee weapons."
     ManualLines(1)="Prepares a slash, which will be executed upon release. The damage of this slash increases the longer altfire is held, up to 1.5 seconds for maximum damage output. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key allows the player to block. Whilst blocking, no attacks are possible, but all melee damage striking the player frontally will be mitigated.||The A909s have extreme damage output at close range, but their short range makes realizing this potential difficult.||The player moves faster with the blades equipped."
     SpecialInfo(0)=(Info="120.0;2.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A909.A909Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A909.A909Putaway')
     GunLength=0.000000
     bAimDisabled=True
     NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.X3InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(R=0),Color2=(R=0),StartSize1=108,StartSize2=101)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)
	 ParamsClasses(0)=Class'A909WeaponParamsComp'
     ParamsClasses(1)=Class'A909WeaponParamsClassic'
     ParamsClasses(2)=Class'A909WeaponParamsRealistic'
     ParamsClasses(3)=Class'A909WeaponParamsTactical'
     FireModeClass(0)=Class'BallisticProV55.A909PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.A909SecondaryFire'
     PutDownAnimRate=2.200000
     PutDownTime=0.200000
     BringUpTime=0.200000
     SelectForce="SwitchToAssaultRifle"
     bMeleeWeapon=True
     Description="The A909 Skrith Blades are a common Skrith melee weapon. They were a terrible bane of the human armies during the first war. The Skrith used them ruthlessly and with great skill to viciously slice up their enemies. Though the blades are useless at range, they are capable of great harm if the user can sneak up on an opponent. All or most Skrith warriors seem to prefer melee battle, and as such hone their skill with close range weapons. The blades can be extremely deadly when close up, as they can jab and slice very fast."
     Priority=13
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=2
     PickupClass=Class'BallisticProV55.A909Pickup'
     PlayerViewOffset=(X=45.000000,Y=-3.240000,Z=-4.86)
     AttachmentClass=Class'BallisticProV55.A909Attachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_A909'
     IconCoords=(X2=127,Y2=31)
     ItemName="A909 Skrith Blades"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_A909'
     DrawScale=0.30
}
