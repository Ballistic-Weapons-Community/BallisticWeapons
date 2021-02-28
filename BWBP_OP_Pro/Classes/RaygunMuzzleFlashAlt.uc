class RaygunMuzzleFlashAlt extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         Opacity=0.600000
         FadeOutStartTime=0.116000
         FadeInEndTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=3.000000)
         StartSpinRange=(Z=(Min=0.230000,Max=0.270000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.130000,Max=0.180000),Z=(Min=0.130000,Max=0.170000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBP_OP_Pro.RaygunMuzzleFlashAlt.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.500000),Z=(Min=0.000000,Max=0.300000))
         Opacity=0.350000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.115000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=13.000000,Max=13.000000),Y=(Min=13.000000,Max=13.000000),Z=(Min=13.000000,Max=13.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BWBP_OP_Pro.RaygunMuzzleFlashAlt.SpriteEmitter31'

}
