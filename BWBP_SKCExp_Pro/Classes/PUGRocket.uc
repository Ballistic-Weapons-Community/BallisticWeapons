//=============================================================================
// PUGRocket.
//
// Tear gas 20mm slug
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUGRocket extends LS14Rocket;

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local PUGCloudControl C;
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    	if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if ( Role == ROLE_Authority )
	{
		C = Spawn(class'PUGCloudControl',self,,HitLocation-HitNormal*2);
		if (C!=None)
		{
			C.Instigator = Instigator;
		}
	}
	Destroy();
}

defaultproperties
{
     ImpactManager=Class'BWBP_SKCExp_Pro.IM_TearGasProj'
     AccelSpeed=50000.000000
     TrailClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
     MyRadiusDamageType=Class'BWBP_SKCExp_Pro.DTPugFRAGRadius'
     MotionBlurRadius=130.000000
     Speed=200.000000
     MaxSpeed=100000.000000
     Damage=90.000000
     DamageRadius=96.000000
     MomentumTransfer=00000.000000
     MyDamageType=Class'BWBP_SKCExp_Pro.DTPugFRAG'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
}
