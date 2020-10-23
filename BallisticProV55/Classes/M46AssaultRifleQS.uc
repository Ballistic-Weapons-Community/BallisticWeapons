//=============================================================================
// M46AssaultRifleQS.
// 
// Red dot M46.
//=============================================================================
class M46AssaultRifleQS extends M46AssaultRifle;

simulated event RenderOverlays (Canvas C)
{
	Super(BallisticWeapon).RenderOverlays(C);
}

defaultproperties
{
     SightMoveSpeedFactor=0.9
     ZoomType=ZT_Irons
     ZoomInAnim=
     ZoomOutAnim=
     ScopeViewTex=None
     ZoomInSound=(Sound=None,Volume=0.000000)
     ZoomOutSound=(Sound=None,Volume=0.000000)
     FullZoomFOV=80.000000
     bNoMeshInScope=False
     SightPivot=(Pitch=-300,Roll=0)
     SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
     SightDisplayFOV=25.000000
     SightingTime=0.350000

     Begin Object Class=AimParams Name=ArenaAimParams
          ADSMultiplier=0.200000
          SprintOffSet=(Pitch=-3000,Yaw=-4000)
          AimAdjustTime=0.550000
          AimSpread=(Min=24,Max=256)
          ChaosDeclineTime=1.250000
          ChaosSpeedThreshold=500.000000
     End Object
     AimParamsList(0)=AimParams'ArenaAimParams'

     FireModeClass(0)=Class'BallisticProV55.M46PrimaryFireQS'
     FireModeClass(1)=Class'BallisticProV55.M46SecondaryFireQS'
     GroupOffset=2
     PickupClass=Class'BallisticProV55.M46PickupQS'
     AttachmentClass=Class'BallisticProV55.M46AttachmentQS'
     ItemName="M46 Red Dot Sight"
     Mesh=SkeletalMesh'BallisticProAnims.OA-AR-RDS'
}
