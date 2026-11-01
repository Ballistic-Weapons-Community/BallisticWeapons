class LavaVolume extends PhysicsVolume;

defaultproperties
{
	DamagePerSec=40
	DamageType=class'FellLava'
	bPainCausing=True
	bWaterVolume=false
	bDestructive=True
	bNoInventory=true
    ViewFog=(X=0.5859375,Y=0.1953125,Z=0.078125)
    FluidFriction=+00004.000000
	LocationName="in lava"
	KExtraLinearDamping=0.8
	KExtraAngularDamping=0.1
	RemoteRole=ROLE_None
	bNoDelete=true
}