//=============================================================================
// T10Grenade.
//
// A handgrenade that emits a toxic gas. A special actor is spawned for the
// grenade and handles the actual clouds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class G28Grenade extends BallisticHandGrenade;

simulated function DoExplosionEffects()
{

}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	SetBoneScale (0, 1.0, GrenadeBone);
	SetBoneScale (1, 1.0, PinBone);
}

simulated function DoExplosion()
{
	if (Role == ROLE_Authority)
		CheckNoGrenades();
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
}

simulated function ClientStartReload(optional byte i)
{
	ClipReleaseTime = Level.TimeSeconds+0.2;
	SetTimer(FuseDelay + 0.2, false);

	SpawnSmoke();
	BFireMode[0].EjectBrass();
	class'BUtil'.static.PlayFullSound(self, ClipReleaseSound);

	if(!IsFiring())
		PlayAnim(ClipReleaseAnim, 1.0, 0.1);
}


simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == ClipReleaseAnim)
	{
		SetBoneRotation('MOACTop', rot(9192,0,0));
		IdleAnim = 'OpenIdle';
	}
	else if (Anim == FireMode[0].FireAnim || Anim == FireMode[1].FireAnim)
	{
		SetBoneScale (1, 1.0, PinBone);
		SetBoneScale (0, 1.0, GrenadeBone);
		CheckNoGrenades();
		IdleAnim='Idle';
	}
	else if (Anim == SelectAnim)
	{
		IdleAnim='Idle';
		PlayIdle();
	}
	else	
    		AnimEnded(Channel, anim, frame, rate);
}

defaultproperties
{
     FuseDelay=0.500000
     ClipReleaseSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-PinOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     GrenadeBone="G28"
     SmokeBone="G28"
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.G28.BigIcon_G28'
     BigIconCoords=(Y1=12,Y2=245)
     
     bWT_Splash=True
     bWT_Grenade=True
     bWT_Heal=True
     ManualLines(0)="Throws a G28 grenade overarm. Upon expiry of the 1 second fuse, emits clouds of healing G28 aerosol. Nearby organics, regardless of team affiliation, will be healed."
     ManualLines(1)="As primary, except the grenade is rolled underarm."
     ManualLines(2)="Like all grenades, the grenade can be cooked in the hand. However, due to the short fuse time, this is not useful for the G28."
     SpecialInfo(0)=(Info="0.0;0.0;0.0;-1.0;0.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway')
	 CurrentWeaponMode=2
	 ParamsClasses(0)=Class'G28WeaponParamsComp'
	 ParamsClasses(1)=Class'G28WeaponParamsClassic'
	 ParamsClasses(2)=Class'G28WeaponParamsClassic'
     ParamsClasses(3)=Class'G28WeaponParamsComp'
     FireModeClass(0)=Class'BWBP_SKC_Pro.G28PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.G28SecondaryFire'
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=255,G=255,R=255,A=128),Color2=(B=0,G=0,R=255,A=165),StartSize1=98,StartSize2=54)
     NDCrosshairInfo=(SpreadRatios=(Y2=0.500000),MaxScale=8.000000)
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="The FMD G28 Medicinal Aerosol is a lightweight smoke grenade filled with various healing compounds and nano-assemblers for quick wound repair on the fly. It is a medic's best friend, and has been used to save many soldiers' lives. It has unfortunately also been the cause of a few deaths, as the grenade itself is quite heavy and can cause concussions if thrown with sufficient velocity. Surgeon General's Warning: The G28 Medicinal Aerosol is a temporary healing agent, and should not be used in place of quality medical care."
     Priority=14
     HudColor=(B=210,G=210,R=75)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     GroupOffset=10
     PickupClass=Class'BWBP_SKC_Pro.G28Pickup'
     PlayerViewOffset=(X=16.000000,Z=-8.500000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BWBP_SKC_Pro.G28Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.G28.SmallIcon_G28'
     IconCoords=(X2=127,Y2=31)
     ItemName="FMD G28 Medicinal Aerosol"
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_G28'
     DrawScale=0.300000
}
