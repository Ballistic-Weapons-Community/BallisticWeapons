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

     ParamsClass=Class'M46RDSWeaponParams'
     FireModeClass(0)=Class'BallisticProV55.M46PrimaryFireQS'
     FireModeClass(1)=Class'BallisticProV55.M46SecondaryFireQS'
     GroupOffset=2
     PickupClass=Class'BallisticProV55.M46PickupQS'
     AttachmentClass=Class'BallisticProV55.M46AttachmentQS'
     ItemName="M46 Red Dot Sight"
     Mesh=SkeletalMesh'BallisticProAnims.OA-AR-RDS'
}
