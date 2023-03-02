//=============================================================================
// swat.
//
// Ballistic Shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sh_swat extends JunkShield;

function BlockDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DT)
{
	local class<BallisticDamageType> BDT;
	local float BlockFactor, ShieldDamage;
	
	// FIXME: Let damage do stuff if it gets blocked...

	BDT = class<BallisticDamageType>(DT);
	if (BDT!=None)
	{
		if (ClassIsChildOf(DT, class'DT_BWBullet'))   if (ClassIsChildOf(DT, class'DT_BWBullet') || ClassIsChildOf(DT, class'DT_BWShell'))
			ShieldDamage = Damage - 30;
		else if (!BDT.default.bCanBeBlocked || !BDT.static.IsDamage(",Blunt,") && !BDT.static.IsDamage(",Slash,") && !BDT.static.IsDamage(",Stab,") && !BDT.static.IsDamage(",Hack,"))
			return;
		ShieldDamage = BDT.default.ShieldDamage;
	}
	else if (ClassIsChildOf(DT, class'MeleeDamage') || Monster(InstigatedBy) != None)
		ShieldDamage = Damage*1.25;
	else if (ClassIsChildOf(DT, class'WeaponDamageType'))
		ShieldDamage = Damage*2;
	else
		return;
	
	if (ShieldDamage > HurtThreshold)
		Health -= ShieldDamage - HurtThreshold;
	if (ShieldDamage > MinProtection)
	{
		if (bBlockByHealth)
			BlockFactor = 1.0 - float(Health) / default.Health;
		else if (ShieldDamage >= MaxProtection)
			BlockFactor = 1.0;
		else
			BlockFactor = (ShieldDamage-MinProtection) / (MaxProtection-MinProtection);
	}
	Damage *= BlockFactor;
	Momentum *= BlockFactor;

}

defaultproperties
{
     DownDir=(Pitch=-4296,Yaw=-8592)
     UpDir=(Yaw=-3096)
     DownCoverage=100.000000
     BlockRate=0.050000
     rating=100.000000
     ShieldPropClass=Class'BWBP_JWC_Pro.JWVan_sh_swatProp'
     AttachOffset=(X=0.000000,Y=0.150000,Z=1.000000)
     AttachPivot=(Pitch=1024,Yaw=-16000,Roll=0)
     Health=15000
     HurtThreshold=10000
     MaxProtection=50000
     PickupClass=Class'BWBP_JWC_Pro.JWVan_sh_swatPickup'
     PlayerViewOffset=(X=-10.000000,Y=16.000000)
     AttachmentClass=Class'BWBP_JWC_Pro.JWVan_sh_swatAttachment'
     ItemName="Tactical Shield"
}
