//-----------------------------------------------------------
//
//-----------------------------------------------------------
class DCTVThorTankMG extends ONSTankSecondaryTurret;

state InstantFireMode
{
    simulated function SpawnHitEffects(actor HitActor, vector HitLocation, vector HitNormal)
    {
		local PlayerController PC;

		PC = Level.GetLocalPlayerController();
		if (PC != None && ((Instigator != None && Instigator.Controller == PC) || VSize(PC.ViewTarget.Location - HitLocation) < 5000))
		{
			if (vehicle(hitactor)!=None)
				class'BallisticProV55.IM_BigBullet'.static.StartSpawn(HitLocation, HitNormal, 3, PC);
			else
				class'BallisticProV55.IM_BigBullet'.static.StartSpawn(HitLocation, HitNormal, 0, PC);
//			Spawn(class'HitEffect'.static.GetHitEffect(HitActor, HitLocation, HitNormal),,, HitLocation, Rotator(HitNormal));
			if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) )
			{
				// check for splash
				if ( Base != None )
				{
					Base.bTraceWater = true;
					HitActor = Base.Trace(HitLocation,HitNormal,HitLocation,Location + 200 * Normal(HitLocation - Location),true);
					Base.bTraceWater = false;
				}
				else
				{
					bTraceWater = true;
					HitActor = Trace(HitLocation,HitNormal,HitLocation,Location + 200 * Normal(HitLocation - Location),true);
					bTraceWater = false;
				}

				if ( (FluidSurfaceInfo(HitActor) != None) || ((PhysicsVolume(HitActor) != None) && PhysicsVolume(HitActor).bWaterVolume) )
					Spawn(class'BulletSplash',,,HitLocation,rot(16384,0,0));
			}
		}
    }
}

defaultproperties
{
     YawBone="MGStand"
     PitchBone="MG"
     WeaponFireAttachmentBone="MuzzleMG"
     WeaponFireOffset=0.000000
     DualFireOffset=0.000000
     RotationsPerSecond=1.000000
     bInstantRotation=False
     bAmbientFireSound=False
     RedSkin=Texture'BWBP_Vehicles_Tex.ThorTank.MG'
     BlueSkin=Texture'BWBP_Vehicles_Tex.ThorTank.MG'
     FireInterval=0.150000
     EffectEmitterClass=Class'BWBP_VPC_Pro.DCTVMGFlash'
     AmbientEffectEmitterClass=None
     FireSoundClass=Sound'BWBP_Vehicles_Sound.ThorTank.ThorTankMG'
     FireSoundVolume=512.000000
     DamageType=Class'BWBP_VPC_Pro.DT_ThorTankMG'
     DamageMin=30
     DamageMax=40
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.ThorTankMG'
}
