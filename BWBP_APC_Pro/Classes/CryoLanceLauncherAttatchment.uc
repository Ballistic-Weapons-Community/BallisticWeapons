//=============================================================================
// CryoLanceLauncherAttatchment
//
// Attachment for Cryo Lance
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CryoLanceLauncherAttatchment extends BallisticAttachment;

var Vector		SpawnOffset;

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (CryoLanceLauncher(Instigator.Weapon).bScopeView)
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
	 WeaponClass=class'CryoLanceLauncher'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
     AltMuzzleFlashClass=class'M806FlashEmitter'
     ImpactManager=class'IM_Bullet'
     FlashScale=0.250000
     BrassClass=class'Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=class'TraceEmitter_Default'
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.9000
	 CockingAnim="Cock_RearPull"
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP_CC_Anim.CryoCannon_TPm'
	 RelativeLocation=(X=15)
     DrawScale=1.000000
}
