class CYLOFirestormFireControl extends RX22AFireControl;

// Purpose: Cause sprayed flame interaction, taking shotgun spread into consideration, has a rotator
// Actions: Spawn a projectile and register the delayed hit
// Sources: Flamer primary fire with traced hit info
simulated function FireShotRotated(vector Start, vector End, float Dist, bool bHit, vector HitNorm, Pawn InstigatedBy, actor HitActor, Rotator Dir)
{
	local CYLOFirestormFlameProjectile Proj;
	local int i;
	
	Proj = Spawn (class'CYLOFirestormFlameProjectile',InstigatedBy,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = InstigatedBy;
		Proj.FireControl = self;
		Proj.InitFlame(End);
	}
	if (bHit)
	{
		i = FlameHits.length;
		FlameHits.length = i + 1;
		FlameHits[i].Instigator = InstigatedBy;
		FlameHits[i].HitLoc = End;
		FlameHits[i].HitNorm = HitNorm;
		FlameHits[i].HitTime = level.TimeSeconds + Dist / 3600;
		FlameHits[i].HitActor = HitActor;
	}
}

// Purpose: Facilitate and limit conditions for causing wall fires, flame wall hit interaction
// Actions: Radius damage/singe, increment singe count for hit location, start wall fire, addfuel to existing fire
// Sources: Flame firemode hit detection or preordered hits
simulated function DoFlameHit(FlameHit Hit)
{
	local int i;
	local BW_FuelPatch Other;

	BurnRadius(4, 256, class'DT_CYLOFirestormShotgun', 0, Hit.HitLoc, Hit.Instigator);

	if (NearFire(Hit.HitLoc, Other))
		Other.AddFuel(0.5);
	else
	{
		for(i=0;i<SingeSpots.length;i++)
			if (VSize(SingeSpots[i].Loc-Hit.HitLoc) < 128)
			{
				SingeSpots[i].Hits++;
				if (SingeSpots[i].Hits > 3)
				{
					MakeNewFire(Hit.HitLoc + Hit.HitNorm * 32, Hit.HitNorm, Hit.Instigator, Hit.HitActor);
					SingeSpots.Remove(i, 1);
					return;
				}
				break;
			}

		if (i>=SingeSpots.length)
		{
			i = SingeSpots.length;
			SingeSpots.length = i + 1;
			SingeSpots[i].Loc = Hit.HitLoc;
			SingeSpots[i].Hits = 1;
			class'IM_RX22AScorch'.static.StartSpawn(Hit.HitLoc, Hit.HitNorm, 0, self);
		}
	}
}

function MakeNewFire (vector Loc, vector Norm, Pawn InstigatedBy, actor HitActor)
{
	GasNodes[GasNodes.length] = Spawn(class'CYLOFirestormSurfaceFire',InstigatedBy,,Loc, rotator(Norm));
	GroundFires[GroundFires.length] = RX22ASurfaceFire(GasNodes[GasNodes.length-1]);
	
	if (RX22ASurfaceFire(GasNodes[GasNodes.length-1]) != None)
	{
		RX22ASurfaceFire(GasNodes[GasNodes.length-1]).GasControl = self;
		if (HitActor != None)
			RX22ASurfaceFire(GasNodes[GasNodes.length-1]).SetBase(HitActor);
	}
}
function MakeNewBurner (Actor Other, int Fuel, Pawn InstigatedBy)
{
	local RX22AActorFire PF;

	PF = Spawn(class'CYLOFirestormActorFire',InstigatedBy,,Other.Location, Other.Rotation);
	PF.SetFuel(Fuel);
	PF.Initialize(Other);

	GasNodes[GasNodes.length] = PF;
	PF.GasControl = self;
}

defaultproperties
{
}
