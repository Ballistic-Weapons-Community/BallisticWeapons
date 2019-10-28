class X82TW_PrimaryFire extends X82PrimaryFire;

simulated function ModeDoFire ()
{
	Super.ModeDoFire();
		if(Instigator != None  && class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
}

defaultproperties
{
     BrassOffset=(X=0.000000,Y=0.000000,Z=0.000000)
     VelocityRecoil=0.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.X82.X82-Fire4',Radius=750.000000)
     FireRate=0.530000
     aimerror=0.000000
}
