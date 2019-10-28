//=============================================================================
// M46Attachment.
//
// 3rd person weapon attachment for M46 Assault Rifle
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46Attachment extends BallisticAttachment;

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
	{
		C = GetBoneCoords('tip');
	}
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

defaultproperties
{
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
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=1.050000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims_25.OA-AR_3rd'
     DrawScale=0.275000
}
