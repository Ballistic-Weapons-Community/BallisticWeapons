//=============================================================================
// VSKttachment.
//
// 3rd person weapon attachment for VSK Tranquilizer Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class VSKAttachment extends BallisticAttachment;

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Coords C;
    local Vector X, Y, Z;

	if (Instigator.IsFirstPerson())
	{
		if (VSKTranqRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			C = Instigator.Weapon.GetBoneCoords('tip');
	}
	else
		C = GetBoneCoords('tip');
    return C.Origin;
}

defaultproperties
{
	WeaponClass=class'VSKTranqRifle'
	RelativeRotation=(Pitch=32768)
	MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
	ImpactManager=Class'BWBP_SKC_Pro.IM_Tranq'
	FlashScale=0.300000
	BrassClass=Class'BWBP_SKC_Pro.Brass_Tranq'
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Tranq'
	TracerMix=0
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	bRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.VSKS_TPm'
	DrawScale=1.000000
}
