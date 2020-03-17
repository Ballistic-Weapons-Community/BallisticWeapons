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
simulated function Vector GetTipLocation()
{
    local Coords C;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords('tip');
	else
		C = GetBoneCoords('tip');
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

defaultproperties
{
	 Mesh=SkeletalMesh'BallisticAnims_25.OA-AR-RDS_3rd'
     bHeavy=True
}
