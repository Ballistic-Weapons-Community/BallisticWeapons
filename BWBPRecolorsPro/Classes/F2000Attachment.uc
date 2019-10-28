//=============================================================================
// F2000Attachment.
//=============================================================================
class F2000Attachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var Vector		SpawnOffset;

simulated function Vector GetTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (F2000AssaultRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip').Origin;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}


function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBPRecolorsPro.MARSFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=0.250000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.MARS3_TP'
     DrawScale=1.000000
}
