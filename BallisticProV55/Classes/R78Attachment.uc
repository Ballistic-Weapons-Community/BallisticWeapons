//=============================================================================
// R78Attachment.
//
// 3rd person weapon attachment for R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R78Attachment extends BallisticAttachment;

simulated function Vector GetTipLocation()
{
    local Coords C;
    local Vector X, Y, Z;

	if (Instigator.IsFirstPerson())
	{
		if (R78Rifle(Instigator.Weapon).bScopeView)
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
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_BigBullet'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerChance=0.000000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     CockAnimRate=1.400000
     Mesh=SkeletalMesh'BallisticAnims2.Rifle-3rd'
     DrawScale=0.200000
}
