//=============================================================================
// PugAttachment.
//
// 3rd person weapon attachment for the PUG-M2 Riot Cannon
//
// A shotgun attachment: the primary fire is a shotgun fire, which sends the attachment its aim and not a hit location.
// As a plain attachment it took that aim for a point in the world and shot a tracer off towards it.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class PugAttachment extends BallisticShotgunAttachment;
var() class<actor>			AltBrassClass1;			//Alternate Fire's brass
var() class<actor>			AltBrassClass2;			//Alternate Fire's brass (whole FRAG-12)

// Fling out shell casing
simulated function EjectBrass(byte Mode)
{
	local Rotator R;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (BrassMode == MU_None || (BrassMode == MU_Secondary && Mode == 0) || (BrassMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	if (Mode == 0)
		Spawn(BrassClass, self,, GetEjectorLocation(R), R);
	else if (Mode != 0)
		Spawn(AltBrassClass1, self,, GetEjectorLocation(R), R);
}

defaultproperties
{
	WeaponClass=class'PugAssaultCannon'
     AltBrassClass1=Class'BWBP_SKC_Pro.Brass_FRAGSpent'
     AltBrassClass2=Class'BWBP_SKC_Pro.Brass_FRAG'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.AH104FlashEmitter'
	FlashScale=0.050000
     AltMuzzleFlashClass=Class'BWBP_SKC_Pro.AH104FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     AltFlashBone="ejector"
     BrassClass=Class'BWBP_SKC_Pro.Brass_BOLT'
     BrassMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerChance=0.500000
     InstantMode=MU_Primary
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	CockingAnim="Cock_RearPull"
  	ReloadAnimRate=1.000000
	CockAnimRate=0.760000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.Pug_TPm'
     RelativeRotation=(Pitch=32768)
     DrawScale=1.000000
}
