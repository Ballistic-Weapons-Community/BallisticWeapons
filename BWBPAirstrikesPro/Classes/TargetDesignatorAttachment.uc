class TargetDesignatorAttachment extends BallisticAttachment;

var LinkMuzFlashProj3rd MuzFlash;

simulated function Destroyed()
{
    if (MuzFlash != None)
        MuzFlash.Destroy();

    Super.Destroyed();
}

simulated event ThirdPersonEffects()
{
    local Rotator R;

    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
	{
        if ( FiringMode == 0 )
        {
            if (MuzFlash == None)
            {
            }
            if (MuzFlash != None)
            {
                MuzFlash.Trigger(self, None);
                R.Roll = Rand(65536);
                SetBoneRotation('bone flashA', R, 0, 1.0);
            }
        }
    }

    Super.ThirdPersonEffects();
}

defaultproperties
{
     Mesh=SkeletalMesh'BWBP_OP_Anim.Designator_TPm'
     RelativeLocation=(Y=-15.000000,Z=5.000000)
     RelativeRotation=(Pitch=-32768)
     DrawScale=0.150000
}
