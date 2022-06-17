//=============================================================================
// AR23Attachment.
//
// 3rd person weapon attachment for AR23 Heavy Rifle
//
// by Marc "Sgt. Kelly" Moylan.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23Attachment extends BallisticAttachment;

var() vector		ScopedTracerOffset;

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;
	local vector TheVect;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator && BallisticWeapon(Instigator.Weapon).bScopeView)
	{
		C = Instigator.Weapon.GetBoneCoords('tip');
		TheVect = C.XAxis + C.YAxis;
		C.Origin += (ScopedTracerOffset >> rotator(TheVect));
	}
	else if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords('tip');
	else
		C = GetBoneCoords('tip');
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

defaultproperties
{
     ScopedTracerOffset=(Y=-14.000000,Z=-2.000000)
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_BigBullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_M46AR'
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.AR23_TPm'
	 FlashScale=0.4
     DrawScale=1.000000
	 Skins(0)=Shader'BWBP_SKC_Tex.AR23.AR23-MainShine'
	 Skins(1)=Shader'BWBP_SKC_Tex.AR23.AR23-MiscShine'
	 Skins(2)=Shader'BWBP_SKC_Tex.AR23.AR23-HoloShine'
	 Skins(3)=Texture'BWBP_SKC_Tex.AR23.Muzzle_2D_View'
}
