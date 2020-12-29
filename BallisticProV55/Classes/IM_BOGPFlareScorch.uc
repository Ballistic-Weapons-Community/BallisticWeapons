//=============================================================================
// IM_BOGPFlareScorch.
//
// ImpactManager subclass for RX22A Scorches. Uses Decal only
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BOGPFlareScorch extends BCImpactManager;

simulated function SpawnEffects (int HitSurfaceType, vector Norm, optional byte Flags)
{
	local Projector P;
	local IE_BOGPFlareImpact FizzleEffect;

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (HitSounds.Length > 0 && (Flags & HF_NoSounds) == 0)
	{
		if (HitSurfaceType >= HitSounds.Length)
			PlaySound(HitSounds[0], SLOT_Interact, HitSoundVolume,,HitSoundRadius,HitSoundPitch,true);
		else if (HitSounds[HitSurfaceType] != None)
			PlaySound(HitSounds[HitSurfaceType], SLOT_Interact, HitSoundVolume,,HitSoundRadius,HitSoundPitch,true);
	}
	if (HitEffects.Length > 0 && (Flags & HF_NoEffects) == 0)
	{
		if (HitSurfaceType >= HitEffects.Length)
		{
			FizzleEffect = IE_BOGPFlareImpact(Spawn (HitEffects[0], Owner,, Location+EffectBackOff*Norm, Rotation));
			if(Pawn(Owner) != None)
				FizzleEffect.SetupColor(Pawn(Owner).GetTeamNum());
			else if(Controller(Owner) != None)
				FizzleEffect.SetupColor(Controller(Owner).GetTeamNum());
		}
		else if (HitEffects[HitSurfaceType] != None)
		{
			FizzleEffect = IE_BOGPFlareImpact(Spawn (HitEffects[HitSurfaceType], Owner,, Location, Rotation));
			if(Pawn(Owner) != None)
				FizzleEffect.SetupColor(Pawn(Owner).GetTeamNum());
			else if(Controller(Owner) != None)
				FizzleEffect.SetupColor(Controller(Owner).GetTeamNum());
		}
	}
	if (HitDecals.Length > 0 && (Flags & HF_NoDecals) == 0)
	{
		if (HitSurfaceType >= HitDecals.Length)
			P = Spawn (HitDecals[0], Owner,, Location, Rotator(-Norm));
		else if (HitDecals[HitSurfaceType] != None)
			P = Spawn (HitDecals[HitSurfaceType], Owner,, Location, Rotator(-Norm));
		if (BallisticDecal(P) != None && BallisticDecal(P).bWaitForInit)
		{
			P.SetDrawScale(P.DrawScale*DecalScale);
			BallisticDecal(P).InitDecal();
		}
	}

	if (ShakeRadius > 0 && (Flags & HF_NoVShake) == 0 && (HitSurfaceType != 9 || bShakeOnWaterHit))
		DoViewShake();
}

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_BOGPFlareImpact'
     HitDecals(0)=Class'BallisticProV55.AD_RX22AScorch'
     HitSounds(0)=Sound'BW_Core_WeaponSound.BOGP.BOGP_FlareImpact'
     HitSoundVolume=3.000000
     HitSoundRadius=1024.000000
     EffectBackOff=96.000000
}
