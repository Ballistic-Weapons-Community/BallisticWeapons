class M46AttachmentQS extends M46Attachment;

simulated function PlayPawnFiring(byte Mode)
{
	if ( xPawn(Instigator) == None )
		return;
	if (TrackAnimMode == MU_Both || (TrackAnimMode == MU_Primary && Mode == 0) || (TrackAnimMode == MU_Secondary && Mode != 0))
		PlayPawnTrackAnim(Mode);
	else
	{
		if (FiringMode == 0)
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bRapidFire);
		}
		else 
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bAltRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bAltRapidFire);
		}
			SetTimer(WeaponLightTime, false);
	}
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return Instigator.Weapon.GetEffectStart();

	return GetBoneCoords('tip').Origin;
}

defaultproperties
{
     bHeavy=True
}
