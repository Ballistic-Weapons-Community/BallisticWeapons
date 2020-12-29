class SRS600Attachment extends SRS900Attachment;

simulated function Vector GetTipLocation()
{
	if (Instigator != None && Instigator.IsFirstPerson())
	{
		return Instigator.Weapon.GetEffectStart();
	}
	else
		return GetBoneCoords('tip').Origin;
}
defaultproperties
{
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.SRS600_TPm'
}
