//===========================================================================
// Akeron Warhead
// 
// Repurposed Redeemer code.
//===========================================================================
class AkeronWarheadFast extends AkeronWarhead;

defaultproperties
{
	 Health=25
	 HealthMax=25

	 LandMovementState="PlayerRocketing"
	 NetPriority=3.000000
	 bGameRelevant=True
	 bReplicateInstigator=True
	 bSimulateGravity=false
	 Physics=PHYS_Flying
     AirSpeed=6000.000000
	 AccelRate=25000.000000
	 	 
	 bStasis=False
	 bCanCrouch=false
	 bCanClimbLadders=false
	 bCanPickupInventory=false
	 bNoTeamBeacon=True
	 bNetNotify=True

	 BaseEyeHeight=0.000000
     EyeHeight=0.000000

	 DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticHardware_25.BOGP.BOGP_Grenade'
	 DrawScale=0.500000
	 AmbientGlow=96

     bNetInitialRotation=True
	 bSpecialHUD=True
     bHideRegularHUD=True
	 bCanUse=False
	 bDynamicLight=True
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
	 LightRadius=6.000000
	 
	 ForceType=FT_DragAlong
     ForceRadius=100.000000
	 ForceScale=5.000000

	 Damage=110.000000
     DamageRadius=300.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BWBPOtherPackPro.DTAkeronGuided'
	 OutwardDamageRadius=96.000000
     ImpactManager=Class'BWBPOtherPackPro.IM_Akeron'
	 ArmThreshold=0.150000

	 AmbientSound=Sound'BallisticSounds2.G5.G5-RocketFly'
     SoundRadius=100.000000

	 bCanTeleport=False
	 bDirectHitWall=True
	 bCollideActors=true
	 bCollideWorld=true
	 bBlockActors=False
	 CollisionRadius=24.000000
     CollisionHeight=12.000000

	 ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
	 
	 TransientSoundVolume=1.000000
	 TransientSoundRadius=5000.000000
	 
	 InnerScopeShader=Shader'2K4Hud.ZoomFX.RDM_InnerScopeShader'
     OuterScopeShader=Shader'2K4Hud.ZoomFX.RDM_OuterScopeShader'
     OuterEdgeShader=Shader'2K4Hud.ZoomFX.RDM_OuterEdgeShader'
	 AltitudeFinalBlend=FinalBlend'2K4Hud.ZoomFX.RDM_AltitudeFinal'
	 
	 YawToBankingRatio=60.000000
	 BankingResetRate=15.000000
	 BankingDamping=10
     MaxBanking=20000
     BankingToScopeRotationRatio=8.000000
     VelocityToAltitudePanRate=0.001750
     MaxAltitudePanRate=10.000000
     Fuel=12.000000
}
