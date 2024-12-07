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

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z;

	if (Instigator != None && Instigator.IsFirstPerson())
	{
		if (BallisticWeapon(Instigator.Weapon).bScopeView && BallisticWeapon(Instigator.Weapon).ZoomType != ZT_Irons)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			return Instigator.Weapon.GetEffectStart();
	}
	else
		return GetBoneCoords('tip').Origin;
}

defaultproperties
{
	WeaponClass=class'M46AssaultRifle'
	MuzzleFlashClass=class'M50FlashEmitter'
	AltMuzzleFlashClass=class'M50M900FlashEmitter'
	ImpactManager=class'IM_Bullet'
	AltFlashBone="tip2"
	BrassClass=class'Brass_M46AR'
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=class'TraceEmitter_Default'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	CockingAnim="Cock_RearPull"
	ReloadAnimRate=0.975000
	CockAnimRate=0.925000
	bRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.M46A1_TPm'
	DrawScale=0.275000
}
