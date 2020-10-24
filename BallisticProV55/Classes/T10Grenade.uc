//=============================================================================
// T10Grenade.
//
// A handgrenade that emits a toxic gas. A special actor is spawned for the
// grenade and handles the actual clouds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class T10Grenade extends BallisticHandGrenade;

simulated function DoExplosionEffects()
{

}

simulated function DoExplosion()
{
	if (Role == ROLE_Authority)
	{
		CheckNoGrenades();
	}
}

simulated function ExplodeInHand()
{
	ClipReleaseTime=666;
	KillSmoke();
	SetBoneScale (2, 1.0, ClipBone);

	HandExplodeTime = Level.TimeSeconds;
	
	if (IsFiring())
	{
		FireMode[0].HoldTime = 0;
		FireMode[0].bIsFiring=false;
		FireMode[1].HoldTime = 0;
		FireMode[1].bIsFiring=false;
	}
	else
	{
		FireMode[0].HoldTime = 0;
		FireMode[0].ModeDoFire();
		FireMode[0].bIsFiring = false;
	}
	if (Role == Role_Authority)
	{
		DoExplosionEffects();
		MakeNoise(1.0);
	}
	SetTimer(0.1, false);

//	ClipReleaseTime = 0.0;
}

defaultproperties
{
     FuseDelay=2.000000
     ClipReleaseSound=(Sound=Sound'BallisticSounds3.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-PinOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_T10'
     BigIconCoords=(Y1=12,Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     ManualLines(0)="Throws a grenade overarm. Upon expiry of the 2 second fuse, the grenade emits clouds of toxic gas which linger for some time, inflicting good damage to nearby organic targets."
     ManualLines(1)="As primary, except the throw is underarm."
     ManualLines(2)="As with all grenades, Reload and Weapon Function keys will remove the pin. With the T10 this is important, as throwing a grenade when the fuse is about to expire leads to the grenade spreading gas as it travels in the air, granting greater coverage. Overcooking the grenade will result in the gassing of the user. Effective in corridors and against static positions."
     SpecialInfo(0)=(Info="0.0;0.0;0.0;-1.0;0.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Putaway')
     CurrentWeaponMode=1
     ParamsClass=Class'T10WeaponParams'
     FireModeClass(0)=Class'BallisticProV55.T10PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.T10SecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     Description="A recent addition to the Terran arsenal, the T10 toxin grenade was designed primarily for anti-Krao missions in underground facilities. When the clip is released, the grenade will start to release toxic fumes and dangerous gasses until depleted. The grenade can still roll or fly, whilst releasing toxic vapours. This becomes useful for clearing out passageways or small rooms and leaving no room for the enemy to breathe."
     Priority=3
     HudColor=(B=25,G=150,R=50)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     GroupOffset=6
     PickupClass=Class'BallisticProV55.T10Pickup'
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BallisticProV55.T10Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_T10'
     IconCoords=(X2=127,Y2=31)
     ItemName="T10 Toxic Grenade"
     Mesh=SkeletalMesh'BallisticAnims2.T10Grenade'
     DrawScale=0.400000
}
