// The red protection effect.
// ============================================================================
class ThawProtectionEmitterRed extends xEmitter;

defaultproperties
{
     mParticleType=PT_Mesh
     mStartParticles=0
     mMaxParticles=10
     mLifeRange(0)=1.000000
     mLifeRange(1)=1.000000
     mRegenRange(0)=3.000000
     mRegenRange(1)=3.000000
     mDirDev=(Z=5.000000)
     mSpeedRange(0)=6.000000
     mSpeedRange(1)=12.000000
     mPosRelative=True
     mAirResistance=0.000000
     mSizeRange(0)=0.600000
     mSizeRange(1)=0.800000
     mAttenKa=0.500000
     mAttenFunc=ATF_ExpInOut
     mMeshNodes(0)=StaticMesh'XEffects.TeleRing'
     bTrailerSameRotation=True
     Physics=PHYS_Trailer
     LifeSpan=0.100000
     Skins(0)=Shader'XGameShaders.BRShaders.BombIconRS'
     Style=STY_Additive
}
