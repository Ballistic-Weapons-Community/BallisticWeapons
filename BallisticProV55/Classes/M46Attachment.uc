//=============================================================================
// M46Attachment.
//
// 3rd person weapon attachment for M46 Assault Rifle
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46Attachment extends BallisticAttachment;

var() vector		ScopedTracerOffset;

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Coords C;
	local vector TheVect;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (BallisticWeapon(Instigator.Weapon).bScopeView)
		{
			C = Instigator.Weapon.GetBoneCoords('tip');
			TheVect = C.XAxis + C.YAxis;
			C.Origin += (ScopedTracerOffset >> rotator(TheVect));
            return C.Origin;
		}
		else
			return Instigator.Weapon.GetEffectStart();
	}

	return GetBoneCoords('tip').Origin;
}

defaultproperties
{
	WeaponClass=class'M46AssaultRifle'
	ScopedTracerOffset=(Y=-14.000000,Z=-2.000000)
	MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
	AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
	ImpactManager=Class'BallisticProV55.IM_Bullet'
	AltFlashBone="tip2"
	BrassClass=Class'BallisticProV55.Brass_M46AR'
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=Class'BallisticProV55.TraceEmitter_Default'
	WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	CockingAnim="Cock_RearPull"
	ReloadAnimRate=1.400000
	CockAnimRate=1.050000
	bRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.M46A1_TPm'
	DrawScale=0.275000
}
