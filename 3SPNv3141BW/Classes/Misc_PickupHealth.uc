class Misc_PickupHealth extends TournamentHealth
    notplaceable;

#exec OBJ LOAD FILE=Models\3SPNv3141BWspt.usx PACKAGE=3SPNv3141BW

static function StaticPrecache(LevelInfo L)
{
   L.AddPrecacheStaticMesh(StaticMesh'Question');
}

simulated function UpdatePrecacheStaticMeshes()
{
    Level.AddPrecacheStaticMesh(StaticMesh'Question');
    Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     HealingAmount=10
     bSuperHeal=True
     MaxDesireability=1.000000
     RespawnTime=33.000000
     PickupSound=Sound'PickupSounds.HealthPack'
     PickupForce="HealthPack"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'3SPNv3141BW.Question'
     CullDistance=6500.000000
     Physics=PHYS_Rotating
     ScaleGlow=0.600000
     Style=STY_AlphaZ
     TransientSoundVolume=0.350000
     RotationRate=(Yaw=35000)
}
