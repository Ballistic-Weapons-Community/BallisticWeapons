//=============================================================================
// MARSAttachment.
//
// Attachment for MARS Assault Carbine. Pancakes are so delicious.
// This gun is pretty.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MARSAttachment extends BallisticAttachment;

var Vector		SpawnOffset;


simulated function Vector GetTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (MARSAssaultRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetEffectStart();
	}
	else
		Loc = GetBoneCoords('tip').Origin;

    return Loc;
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=0.250000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.9000
	 CockingAnim="Cock_RearPull"
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.F2000_TPm'
     DrawScale=1.500000
}
